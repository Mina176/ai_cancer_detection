# cancer_ai_detection

Flutter app for AI-assisted cancer detection workflows.

## Run locally

1. Ensure Flutter `3.41.2` is installed.
2. Ensure `gp_backend_client` exists at:
   - `/home/runner/work/ai_cancer_detection/ai_cancer_detection/gp/gp_backend/gp_backend_client`
3. Install dependencies:
   - `flutter pub get`
4. Run app:
   - `flutter run`

## Auto-deploy to GitHub Pages

This repo includes a workflow at:

- `.github/workflows/deploy-pages.yml`

It runs on every push to `main` and:

- checks out this repo
- checks out the backend repo expected to contain `gp_backend_client`
- runs `flutter analyze`
- runs `flutter test`
- builds web with:
  - `--base-href "/ai_cancer_detection/"`
  - `--dart-define=SERVER_URL=...`
- deploys `build/web` to GitHub Pages

### Required GitHub setup

1. In repository settings, set **Pages → Build and deployment → Source** to **GitHub Actions**.
2. Configure repository variables:
   - `SERVER_URL` (optional, defaults to `https://gp-api.lasheen.dev/`)
   - `GP_BACKEND_REPOSITORY` (optional, defaults to `Mina176/gp`)
3. If backend repo is private, configure repository secret:
   - `GP_REPO_TOKEN` with read access to that repo.

### First deployment

1. Push to `main`.
2. Open **Actions** and verify `Deploy Flutter Web to GitHub Pages` passes.
3. Open the published URL:
   - `https://mina176.github.io/ai_cancer_detection/`
