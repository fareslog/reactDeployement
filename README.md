# React + Vite

This template provides a minimal setup to get React working in Vite with **HMR** and some **ESLint** rules.

Currently, two official plugins are available:

- [`@vitejs/plugin-react`](https://github.com/vitejs/vite/tree/main/packages/plugin-react) — uses **Babel** for Fast Refresh.  
- [`@vitejs/plugin-react-swc`](https://github.com/vitejs/vite-plugin-react-swc) — uses **SWC** for Fast Refresh.

---

## Expanding the ESLint Configuration

If you are developing a production application, we recommend using **TypeScript** with type-aware lint rules enabled.  
Check out the [TS template](https://vitejs.dev/guide/) for information on how to integrate TypeScript and `typescript-eslint` in your project.

---

## CI/CD Pipeline

This project uses a **GitHub Actions CI/CD pipeline** to automate testing, building, and deployment.  
The pipeline is defined in `.github/workflows/ci-cd.yml` and performs the following tasks:

### 🔄 Triggers
- Runs on `push` or `pull_request` to the **main** branch.

### 🛠 Build and Test
- Uses **Node.js 20** to install dependencies (`npm ci`), run linting (`npm run lint`), and build the application (`npm run build`).  
- Builds a **Docker image** for testing (without pushing).  
- Caches Docker layers to speed up builds.  
- Uploads the `dist` folder as an artifact for deployment.

### 📦 Docker Push
- Builds and pushes a Docker image to Docker Hub (`fares548/react-cicd-github`) with tags for the **commit SHA** and `latest`.  
- Requires `DOCKERHUB_USERNAME` and `DOCKERHUB_TOKEN` secrets in the GitHub repository settings.

### 🚀 Deploy to GitHub Pages
- Deploys the `dist` folder to **GitHub Pages** using [`peaceiris/actions-gh-pages`](https://github.com/peaceiris/actions-gh-pages).  
- Creates a `404.html` file to support single-page application (SPA) routing.  
- Requires the `GITHUB_TOKEN` secret (automatically provided by GitHub).

---

## Docker Setup

The project is containerized using **Docker** for consistent builds and deployment.  
The `Dockerfile` defines a **multi-stage build process**:

### 🏗 Build Stage
- Uses `node:20-alpine` as the base image.  
- Installs dependencies with `npm ci` for reproducibility.  
- Copies the application code and builds it with:
  ```bash
  npm run build -- --base=/
