import 'dotenv/config';
import express from 'express';
import cors from 'cors';
import helmet from 'helmet';
import rateLimit from 'express-rate-limit';
import { pool } from './config/db.js';
import projectsRouter from './routes/projects.js';
import blogRouter from './routes/blog.js';
import achievementsRouter from './routes/achievements.js';
import contactRouter from './routes/contact.js';

const app = express();
const port = Number(process.env.PORT || 5000);
const allowedOrigins = (process.env.FRONTEND_URL || 'http://localhost:5173')
  .split(',')
  .map((origin) => origin.trim())
  .filter(Boolean);

app.disable('x-powered-by');
app.use(helmet());
app.use(cors({
  origin(origin, callback) {
    // Permit server-to-server calls and same-origin production deployments.
    if (!origin || allowedOrigins.includes(origin)) return callback(null, true);
    return callback(new Error('Origin is not allowed by CORS'));
  },
}));
app.use(express.json({ limit: '20kb' }));

app.get('/api/health', async (_req, res) => {
  try {
    await pool.query('SELECT 1');
    res.json({ status: 'ok', database: 'connected' });
  } catch {
    res.status(503).json({ status: 'degraded', database: 'unavailable' });
  }
});

app.use('/api/projects', projectsRouter);
app.use('/api/blog', blogRouter);
app.use('/api/achievements', achievementsRouter);
app.use('/api/contact', rateLimit({
  windowMs: 15 * 60 * 1000,
  limit: 5,
  standardHeaders: 'draft-8',
  legacyHeaders: false,
  message: { message: 'Too many messages submitted. Please try again later.' },
}), contactRouter);

app.use((err, _req, res, _next) => {
  if (err.message === 'Origin is not allowed by CORS') {
    return res.status(403).json({ message: 'This origin is not allowed.' });
  }
  console.error(err);
  return res.status(500).json({ message: 'Something went wrong. Please try again later.' });
});

app.listen(port, () => {
  console.log(`Portfolio API listening on http://localhost:${port}`);
});
