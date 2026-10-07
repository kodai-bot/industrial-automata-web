// Site-wide details. Change them here once; every page reads from this file.
export const SITE = {
  name: 'Industrial Automata',
  tagline: 'Independent technical advice. Building toward robotics for archaeology.',
  description:
    'Industrial Automata is an Irish systems consultancy developing maintainable, interoperable technology, with archaeological robotics as its long-term research direction.',
  email: 'industrialautomata@proton.me',
  github: 'https://github.com/kodai-bot',
  // ICP ledger account identifier for payments (NNS account "IA_Account"). Checksum verified 2026-10-07.
  icpAccount: '17388037a149b3303838f0ee2f961c7a78c0669bbacfe83188f9b94930416925',
  // Mainnet canister serving this site; the footer links to its public IC dashboard page.
  canisterId: 'ocf4n-cyaaa-aaaag-azdua-cai',
  location: 'Ireland',
  registration: 'Registered business name in Ireland', // TODO: add RBN number if wanted
};

export const NAV = [
  { href: '/about/', label: 'About' },
  { href: '/consulting/', label: 'Consulting' },
  { href: '/principles/', label: 'Principles' },
  { href: '/research/', label: 'Research' },
  { href: '/notes/', label: 'Notes' },
  { href: '/contact/', label: 'Contact' },
];
