import preactRefresh from '@prefresh/vite'
import { defineConfig } from 'vite'

// https://vitejs.dev/config/
export default defineConfig({
  esbuild: {
    jsxFactory: 'h',
    jsxFragment: 'Fragment'
  },
  build: {
    manifest: true,
    outDir: "../priv/static", //<- Phoenix expects our files here
    emptyOutDir: true, // cleanup previous builds
    polyfillDynamicImport: true, // this might be redundant, because we manually included `vite/dynamic-import-polyfill` in our main.tsx
    sourcemap: true, // we want to debug our code in production
    rollupOptions: {
      // overwrite default .html entry
      input: {
        main: "src/main.tsx",
      }
    },
  },
  plugins: [preactRefresh()]
})
