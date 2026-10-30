# Portfolio Frontend

This folder contains the Vue 3 and Vite application for my developer portfolio. The site presents my introduction, about section, selected projects, toolkit, learning journey, journal, achievements and contact form.

The current application is frontend-only. It does not require a custom backend or database.

## Requirements

- Node.js 22.18.0 or a compatible supported Node 24 release
- npm

## Install and run

From this folder:

```bash
npm install
npm run dev
```

Vite prints the local URL, usually `http://localhost:5173`.

## Available scripts

| Command | Purpose |
| --- | --- |
| `npm run dev` | Starts the Vite development server. |
| `npm run build` | Builds the static production site in `dist/`. |
| `npm run preview` | Previews the production build locally. |
| `npm run format` | Formats files in `src/` with Oxfmt. |

## Source structure

```text
src/
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

### Root application files

- `src/main.js` creates and mounts the Vue application and registers Pinia.
- `src/App.vue` is the root component and renders `HomeView.vue`.
- `src/views/HomeView.vue` assembles the main portfolio page, holds page-level content and interactions, and imports the global stylesheet.

### Components

- `AboutSection.vue` presents the introduction and personal approach.
- `HeroSection.vue` contains the opening headline, introduction and primary links.
- `ProjectCard.vue` displays project summaries and detailed case-study dialogs.
- `SiteHeader.vue` contains the navigation and theme controls.
- `ToolkitSlider.vue` presents the technologies and tools carousel.
- `DigitalStudio.vue` provides the interactive digital-studio section.
- `CursorGlow.vue` provides the cursor visual effect.

### Assets and supporting folders

- `src/assets/portfolio.css` contains global styles, responsive layouts, colour tokens, theme rules and interaction states.
- `public/` stores static images and other assets served from the site root.
- `src/router/index.js` contains the router configuration. The current portfolio is rendered through one home view.
- `src/stores/` contains Pinia stores.

## Where to update content

- Update the hero copy in `src/components/HeroSection.vue`.
- Update the about copy and portrait in `src/components/AboutSection.vue`.
- Update project data, filters, journey entries, journal posts, achievements and contact form handling in `src/views/HomeView.vue`.
- Update case-study presentation in `src/components/ProjectCard.vue`.
- Update toolkit items in `src/components/ToolkitSlider.vue`.
- Update shared visual styling in `src/assets/portfolio.css`.
- Replace static images in `public/` and keep their referenced paths in sync.

## Contact form

The form in `HomeView.vue` submits directly to the configured Formspree endpoint. It displays sending, success and error messages. The Formspree form must be active for submissions to be received; verify it with a test submission after deployment.

## Build and deployment

Run:

```bash
npm run build
npm run preview
```

Deploy the generated `dist/` directory to a static hosting provider. The application does not need a separate API server or database.
