# Zanda Portfolio API

Express + MySQL API for portfolio projects, blog posts, achievements and contact messages.

## Setup

1. Install Node.js 22.18+ (or 24.12+).
2. From this folder, run `npm install`.
3. Create a MySQL database using `database/schema.sql` in MySQL Workbench or your hosted MySQL console.
4. Copy `.env.example` to `.env` and fill in your connection details. Never commit `.env`.
5. Start the API with `npm run dev`.

The API runs at `http://localhost:5000` by default.

## Endpoints

- `GET /api/health` — API/database health
- `GET /api/projects` — published portfolio projects
- `GET /api/blog` and `GET /api/blog/:slug` — published blog posts
- `GET /api/achievements` — published achievements
- `POST /api/contact` — validates and stores a message

The contact endpoint is rate-limited and uses parameterized SQL. Configure `FRONTEND_URL` for your frontend origin. For hosted MySQL requiring a CA, set `DB_SSL_CA` to the certificate path. Keep all secrets in environment variables.
