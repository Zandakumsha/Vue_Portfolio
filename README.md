# Zanda K. — Developer Portfolio

An elegant, responsive portfolio built with Vue 3 and Vite. This is a **frontend-only project**. Portfolio content lives in Vue components, and the contact form submits directly to Formspree. There is no custom backend server, API, or database.

## Tech stack

- Vue 3 and Vite
- JavaScript, HTML and CSS
- Responsive layout, accessible navigation and light/dark theme
- Formspree for contact form submissions

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

## Contact form

The contact form is connected directly to Formspree at `https://formspree.io/f/xdearnka`. No custom backend is required. Ensure your Formspree account is active and complete any email verification it requests. Test the live form after deploying.

## Deployment

Run `npm run build` and deploy the generated `frontend/dist/` directory to a static hosting provider, such as GitHub Pages, Netlify or Vercel. No backend service or database is required.
