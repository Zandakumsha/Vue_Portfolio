# Zanda K. — Developer Portfolio

An elegant, responsive Vue 3 portfolio with an Express API and MySQL storage for projects, blog posts, achievements and contact messages.

## Repository structure

- `frontend/` — Vue 3 + Vite portfolio and existing design.
- `backend/` — Express API, MySQL connection and API routes.
- `backend/database/schema.sql` — database tables and sample project/blog content.
- `backend/database/migrations/` — incremental schema and credential updates for existing databases.

## Run locally

### 1. Install dependencies

From the repository root:

```bash
npm run setup
```

This installs the root development runner and dependencies for both the backend and frontend.

### 2. Create and configure the database

Run `backend/database/schema.sql` in MySQL Workbench or your hosted MySQL console. It creates the `portfolio` database and its tables, and seeds the portfolio projects, example blog posts and supplied Cisco credential. Existing databases should run each applicable SQL migration in `backend/database/migrations/` once; back up the database first and review each migration before applying it. The 2026-10-17 migrations hide seeded example journal entries and keep the supplied Cisco credential unpublished while its completion date is in the future.

Create your backend environment file by copying the example:

```bash
# macOS / Linux / Git Bash
cp backend/.env.example backend/.env

# Windows PowerShell alternative
Copy-Item backend/.env.example backend/.env
```

Edit `backend/.env` with your actual MySQL host, port, username, password and database. For local MySQL, the defaults in the example can be used where they match your installation. For a managed database such as Aiven, use its connection details and configure `DB_SSL_CA` to the actual CA certificate path when required.

**Never commit `backend/.env`, database passwords, or private keys/certificates.**

### 3. Start both servers together

From the repository root:

```bash
npm run dev
```

This starts the Express API and Vue/Vite frontend in one terminal. The API defaults to `http://localhost:5000`; Vite usually runs at `http://localhost:5173`. Keep the terminal open while developing.

If you prefer separate terminals, run `npm run dev:backend` and `npm run dev:frontend` from the repository root.

### 4. Verify the API

Open `http://localhost:5000/api/health`. A healthy setup returns JSON with `"status":"ok"` and `"database":"connected"`. If the database is unavailable, check that the schema has been imported and the values in `backend/.env` are correct.

## API endpoints

- `GET /api/health` — check API and database connectivity.
- `GET /api/projects` — published projects.
- `GET /api/blog` and `GET /api/blog/:slug` — published blog posts.
- `GET /api/achievements` — published achievements.
- `POST /api/contact` — validates and stores a contact message in MySQL.

The contact endpoint is rate-limited, validates fields on the server and uses parameterized SQL. There is deliberately no public endpoint for reading stored messages. Backend startup stops with a clear message when `DB_HOST`, `DB_USER` or `DB_PASSWORD` is missing.

## Before publishing

- Use a hosted MySQL database and set backend environment variables in your hosting provider.
- Set `FRONTEND_URL` to the deployed frontend origin in the backend environment.
- Set `VITE_API_BASE_URL` to the deployed API URL if frontend and backend are hosted separately.
- Add the exact title, date and credential URL for each achievement; do not publish placeholders. The seeded journal entries are unpublished examples; publish only after replacing them with writing you approve.
- Replace the demo CV data and placeholder contact email in `frontend/src/App.vue` with your real details.
- Run `npm run build` from the repository root before deploying.
