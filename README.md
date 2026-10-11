# Zanda K. — Developer Portfolio

An elegant, responsive Vue 3 portfolio with an Express API and MySQL storage for projects, blog posts, achievements and contact messages.

## Repository structure

- `frontend/` — Vue 3 + Vite portfolio and existing design.
- `backend/` — Express API, MySQL connection and API routes.
- `backend/database/schema.sql` — database tables and sample project/blog content.

## Run locally

### 1. Create the MySQL database

Run `backend/database/schema.sql` in MySQL Workbench or your hosted MySQL console. It creates the `portfolio` database and its tables. It seeds the existing portfolio projects and example blog posts. Add only verified achievements to the `achievements` table.

### 2. Configure and start the backend

Open a terminal:

```bash
cd backend
npm install
```

Copy `.env.example` to `.env` and set your MySQL host, port, username, password and database. Never commit `.env`.

```bash
npm run dev
```

The API defaults to `http://localhost:5000`.

### 3. Start the Vue frontend

In a second terminal:

```bash
cd frontend
npm install
npm run dev
```

Open the URL Vite prints (usually `http://localhost:5173`). Vite proxies `/api` requests to the local Express server. You can also set `VITE_API_BASE_URL` to a deployed API base URL.

## API endpoints

- `GET /api/health` — check API and database connectivity.
- `GET /api/projects` — published projects.
- `GET /api/blog` and `GET /api/blog/:slug` — published blog posts.
- `GET /api/achievements` — published achievements.
- `POST /api/contact` — validates and stores a contact message in MySQL.

The contact endpoint is rate-limited, validates fields on the server and uses parameterized SQL. There is deliberately no public endpoint for reading stored messages.

## Before publishing

- Use a hosted MySQL database and set backend environment variables in your hosting provider.
- Set `FRONTEND_URL` to the deployed frontend origin in the backend environment.
- Set `VITE_API_BASE_URL` to the deployed API URL if frontend and backend are hosted separately.
- Add the exact title, date and credential URL for each achievement; do not publish placeholders.
- Replace the demo CV data and placeholder contact email in `frontend/src/App.vue` with your real details.
- Run `npm run build` from `frontend/` before deploying.
