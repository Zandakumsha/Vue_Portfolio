# Zanda K. — Developer Portfolio

An elegant, responsive portfolio built with Vue 3 and Vite. This is a **frontend-only project**: portfolio content is managed in Vue files, with no Express server, API, database or backend environment variables.

## Tech stack

- Vue 3
- Vite
- JavaScript, HTML and CSS
- Responsive layout, accessible navigation and a light/dark theme

## Run locally

Install the frontend dependencies from the repository root:

```bash
npm run setup
```

Start the development server:

```bash
npm run dev
```

Vite prints the local URL (usually http://localhost:5173). Keep the terminal open while developing.

Build the static site for deployment:

```bash
npm run build
```

Preview the production build locally:

```bash
npm run preview
```

## Where to edit content

- `frontend/src/App.vue` — project cards, skills, journey, journal and credential content.
- `frontend/src/components/` — reusable hero, about, navigation and project-card components.
- `frontend/src/assets/portfolio.css` — site styling and theme colors.
- `frontend/public/` — static images and public assets.

Projects are defined locally in `App.vue`; update the relevant project object to change descriptions, tags, links or case-study content. Journal and credential sections intentionally show an empty state until verified content is added. Do not publish unverified credentials or placeholder writing.

## Contact

The portfolio does not submit or store contact messages. Visitors can connect through the linked GitHub profile or another social link you choose to add.

## Deployment

Run `npm run build` and deploy the generated `frontend/dist/` directory to any static hosting provider, such as GitHub Pages, Netlify or Vercel. No backend service or database is required.
