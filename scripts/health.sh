#!/usr/bin/env bash
# health.sh — routine read-only checks for the website canister and its hosting.
#
#   scripts/health.sh            report only
#   scripts/health.sh --record   also append a line to .health/history.csv (for trends)
#
# Spends nothing: status, logs and balances are free reads. Needs icp, curl, openssl.
set -uo pipefail

cd "$(dirname "$0")/.."

ENV=ic
IDENTITY=ia-mainnet
CANISTER=website
DOMAINS=(industrial-automata.com www.industrial-automata.com)
WARN_DAYS=180       # warn when cycle runway drops below this
CERT_WARN_DAYS=21   # warn when a TLS certificate expires sooner than this

RECORD=0
[ "${1:-}" = "--record" ] && RECORD=1

warnings=()
num() { tr -d '_' <<<"$1"; }   # icp prints 3_442_575_452_892
field() { grep -m1 "^ *$1:" <<<"$STATUS" | sed 's/^[^:]*: *//'; }
tc() { awk -v n="$1" 'BEGIN { printf "%.3fT", n / 1e12 }'; }

echo "== Canister ($CANISTER on $ENV) =="
if ! STATUS="$(icp canister status "$CANISTER" -e "$ENV" --identity "$IDENTITY" 2>&1)"; then
  echo "$STATUS"; exit 1
fi
ID="$(field 'Canister Id')"
STATE="$(field 'Status')"
CYCLES="$(num "$(field 'Cycles')")"
BURN="$(num "$(field 'Idle cycles burned per day')")"
MEM="$(num "$(field 'Memory size')")"
CALLS="$(num "$(field 'Calls')")"
RES_BYTES="$(num "$(field 'Res payload bytes')")"
HASH="$(field 'Module hash')"
RUNWAY=$(( CYCLES / BURN ))

printf '  %-14s %s\n' "ID" "$ID" "Status" "$STATE" \
  "Cycles" "$(tc "$CYCLES")" "Burn/day" "$(awk -v n="$BURN" 'BEGIN { printf "%.2fB", n / 1e9 }') (idle)" \
  "Runway" "~$RUNWAY days (idle burn only)" \
  "Memory" "$(awk -v b="$MEM" 'BEGIN { printf "%.1f MB", b / 1e6 }')" \
  "Queries" "$CALLS served, $(awk -v b="$RES_BYTES" 'BEGIN { printf "%.1f MB", b / 1e6 }') sent (query stats lag ~1 day)" \
  "Module" "$HASH"
[ "$STATE" = "Running" ] || warnings+=("canister is $STATE, not Running")
[ "$RUNWAY" -ge "$WARN_DAYS" ] || warnings+=("runway under $WARN_DAYS days: top up")

LOGS="$(icp canister logs "$CANISTER" -e "$ENV" --identity "$IDENTITY" 2>&1)"
if [ -n "$LOGS" ]; then
  echo "  Logs (last 10):"; tail -n 10 <<<"$LOGS" | sed 's/^/    /'
else
  echo "  Logs           none"
fi

echo
echo "== Controller account ($IDENTITY) =="
printf '  %-14s %s\n' "Cycles" "$(icp cycles balance -e "$ENV" --identity "$IDENTITY" 2>&1 | sed 's/^Balance: //')" \
  "ICP" "$(icp token balance -e "$ENV" --identity "$IDENTITY" 2>&1 | sed 's/^Balance: //')"

echo
echo "== Web =="
for host in "$ID.icp0.io" "${DOMAINS[@]}"; do
  out="$(curl -s -o /dev/null -w '%{http_code} %{time_total}' --max-time 15 "https://$host/")"
  code="${out%% *}"
  printf '  %-36s HTTP %s  %ss\n' "$host" "$code" "${out#* }"
  [ "$code" = "200" ] || warnings+=("https://$host/ returned $code")
done
code="$(curl -s -o /dev/null -w '%{http_code}' --max-time 15 "https://${DOMAINS[0]}/no-such-page")"
printf '  %-36s HTTP %s (expect 404)\n' "/no-such-page" "$code"

for d in "${DOMAINS[@]}"; do
  end="$(echo | openssl s_client -connect "$d:443" -servername "$d" 2>/dev/null \
         | openssl x509 -noout -enddate 2>/dev/null | cut -d= -f2)"
  if [ -z "$end" ]; then
    warnings+=("could not read TLS certificate for $d"); continue
  fi
  days=$(( ( $(date -d "$end" +%s) - $(date +%s) ) / 86400 ))
  reg="$(curl -s --max-time 15 "https://icp.net/custom-domains/v1/$d" \
         | grep -o '"registration_status":"[^"]*"' | cut -d'"' -f4)"
  printf '  %-36s cert %d days left, domain %s\n' "$d" "$days" "${reg:-unknown}"
  [ "$days" -ge "$CERT_WARN_DAYS" ] || warnings+=("certificate for $d expires in $days days (should auto-renew)")
  [ "$reg" = "registered" ] || warnings+=("$d registration status: ${reg:-unknown}")
done

if [ "$RECORD" -eq 1 ]; then
  mkdir -p .health
  f=.health/history.csv
  [ -f "$f" ] || echo "date,cycles,burn_per_day,memory_bytes,query_calls,res_bytes" > "$f"
  echo "$(date -Iseconds),$CYCLES,$BURN,$MEM,$CALLS,$RES_BYTES" >> "$f"
  echo; echo "Recorded to $f ($(($(wc -l < "$f") - 1)) entries)"
  if [ "$(wc -l < "$f")" -ge 3 ]; then
    tail -n 2 "$f" | awk -F, 'NR==1 { t=$1; c=$2; q=$5 } NR==2 {
      cmd = "date -d " t " +%s"; cmd | getline t0; close(cmd)
      cmd = "date -d " $1 " +%s"; cmd | getline t1; close(cmd)
      d = (t1 - t0) / 86400
      if (d > 0) printf "Since last record (%.1f days): %.3fT cycles used (%.2fB/day), %d queries\n", d, (c - $2) / 1e12, (c - $2) / 1e9 / d, $5 - q }'
  fi
fi

echo
if [ ${#warnings[@]} -eq 0 ]; then
  echo "OK: no warnings"
else
  printf 'WARNING: %s\n' "${warnings[@]}"; exit 2
fi
