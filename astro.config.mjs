// @ts-check
import { defineConfig } from 'astro/config';

// https://astro.build/config
export default defineConfig({
  site: 'https://industrial-automata.com',
  build: {
    // Keep all CSS in files so the CSP in public/_headers can forbid inline styles.
    inlineStylesheets: 'never',
  },
});
