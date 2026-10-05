// @ts-check
import { defineConfig } from 'astro/config';

// https://astro.build/config
export default defineConfig({
  // TODO: set to the real domain before going live (used for canonical URLs/sitemaps).
  // site: 'https://example.ie',
  build: {
    // Keep all CSS in files so the CSP in public/_headers can forbid inline styles.
    inlineStylesheets: 'never',
  },
});
