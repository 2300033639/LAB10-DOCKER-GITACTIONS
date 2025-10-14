import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  // This is the base path for your deployed application on Tomcat
  base: '/airline-frontend/', 
  server: {
    // This proxy is for development only
    proxy: {
      '/customerapi': {
        target: 'http://localhost:2030/airlinemanagement',
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/customerapi/, '/customerapi'),
      }
    }
  }
})