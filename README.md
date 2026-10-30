# Zanda K. — Developer Portfolio

This repository contains my personal developer portfolio. I built it with Vue 3 and Vite to present my projects, technical toolkit, learning journey, field journal, achievements and contact details.

The application is a frontend-only single-page website. It does not use a custom backend, API or database. The contact form sends submissions directly to Formspree.

## Technology

- Vue 3 with Composition API and Single File Components
- Vite for local development and production builds
- JavaScript, HTML and CSS
- Pinia is installed and registered for state management
- Vue Router is installed; the current portfolio is rendered as a single home view
- Formspree for contact form submissions
- Oxfmt for formatting the frontend source

## Repository structure

```text
Vue_Portfolio/
├── README.md
├── package.json
├── package-lock.json
└── frontend/
    ├── README.md
    ├── package.json
    ├── index.html
    ├── vite.config.js
    ├── public/
    │   └── portfolio images and static assets
    └── src/
        ├── App.vue
        ├── main.js
        ├── assets/
        │   └── portfolio.css
        ├── components/
        │   ├── AboutSection.vue
        │   ├── CursorGlow.vue
        │   ├── DigitalStudio.vue
        │   ├── HeroSection.vue
        │   ├── ProjectCard.vue
        │   ├── SiteHeader.vue
        │   └── ToolkitSlider.vue
        ├── router/
        │   └── index.js
        ├── stores/
        │   └── counter.js
        └── views/
            └── HomeView.vue
```

## Application structure

- `frontend/src/main.js` creates the Vue application, registers Pinia and mounts the root component.
- `frontend/src/App.vue` is the lightweight root component. It renders `HomeView.vue`.
- `frontend/src/views/HomeView.vue` composes the portfolio page, manages page-level content and interactions, and imports the global stylesheet.
- `frontend/src/components/` contains reusable page sections and interface components.
- `frontend/src/assets/portfolio.css` contains the global layout, colour palette, responsive rules, theme styles and interaction states.
- `frontend/public/` stores static images and assets referenced by public paths.
- `frontend/src/router/index.js` contains the Vue Router configuration. The current site uses a single home view rather than multiple routed pages.
- `frontend/src/stores/` contains Pinia stores.

## Run the project locally

### Requirements

- Node.js 22.18.0 or a compatible supported Node 24 release
- npm

### Install dependencies

Run these commands from the repository root:

```bash
npm run setup
```

### Start the development server

```bash
npm run dev
```

Vite displays the local development URL in the terminal, usually `http://localhost:5173`.

### Create a production build

```bash
npm run build
```

The generated static site is placed in `frontend/dist/`.

### Preview the production build

```bash
npm run preview
```

### Format the frontend source

```bash
npm run format
```

## Updating portfolio content

- **Hero and introduction:** edit `frontend/src/components/HeroSection.vue`.
- **About section:** edit `frontend/src/components/AboutSection.vue`.
- **Project descriptions, filters, journey, journal, achievements and contact form:** edit the corresponding data and page composition in `frontend/src/views/HomeView.vue`.
- **Project cards and case studies:** edit `frontend/src/components/ProjectCard.vue`.
- **Navigation and theme controls:** edit `frontend/src/components/SiteHeader.vue`.
- **Toolkit carousel:** edit `frontend/src/components/ToolkitSlider.vue`.
- **Digital studio interaction:** edit `frontend/src/components/DigitalStudio.vue`.
- **Global styling and theme colours:** edit `frontend/src/assets/portfolio.css`.
- **Static images:** add or replace files in `frontend/public/` and update the matching image paths in the relevant component or view.

## Contact form

The contact form posts directly to the Formspree endpoint configured in `HomeView.vue`. The current endpoint is `https://formspree.io/f/xdearnka`. The form displays sending, success and error feedback in the interface.

The Formspree form must remain active for submissions to be delivered. Verify the form with a real test submission after deployment.

## Theme and accessibility

The site includes light and dark themes, responsive layouts, keyboard focus styles, accessible labels for interactive controls and reduced-motion handling for supported animations. Check both themes and keyboard navigation when making interface changes.

## Deployment

Build the site with `npm run build` and deploy the contents of `frontend/dist/` to a static hosting provider such as GitHub Pages, Netlify or Vercel. No separate backend service or database is needed.

For deployment, configure the hosting provider to publish the `frontend/dist/` directory and follow its instructions for single-page application routing if the site later adds routed pages.
