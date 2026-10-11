import { Router } from 'express';
import { pool } from '../config/db.js';

const router = Router();

router.get('/', async (_req, res, next) => {
  try {
    const [rows] = await pool.execute(
      'SELECT achievement_id, title, issuer, description, credential_url AS credentialUrl, achieved_on AS achievedOn, category, status, image_url AS imageUrl FROM achievements WHERE is_published = 1 ORDER BY CASE status WHEN \'completed\' THEN 0 WHEN \'in_progress\' THEN 1 ELSE 2 END, achieved_on DESC, achievement_id DESC',
    );
    res.json(rows);
  } catch (error) { next(error); }
});

export default router;
