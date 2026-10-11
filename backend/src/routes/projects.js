import { Router } from 'express';
import { pool } from '../config/db.js';

const router = Router();

router.get('/', async (_req, res, next) => {
  try {
    const [rows] = await pool.execute(
      'SELECT project_id, project_number, initials, theme, project_type, name, description, tags, focus, challenge, approach, learning, contribution_note AS contributionNote, url, link_label AS label FROM projects WHERE is_published = 1 ORDER BY sort_order, project_id',
    );
    res.json(rows.map((project) => ({
      ...project,
      number: String(project.project_number).padStart(2, '0'),
      type: project.project_type,
      tags: typeof project.tags === 'string' ? JSON.parse(project.tags) : project.tags,
    })));
  } catch (error) { next(error); }
});

export default router;
