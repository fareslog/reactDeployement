import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],
  base: '/reactDeployement/',
  build: {
    outDir: 'dist',
    sourcemap: false, // Disable source maps
    minify: 'esbuild', // Use esbuild for faster minification
    chunkSizeWarningLimit: 500,  
  },
  server: {
    open: true,
    port: 3001,
  },
})
