import { Router } from 'express';
import { pool } from '../config/db.js';

const router = Router();

router.get('/', async (_req, res, next) => {
  try {
    const [posts] = await pool.execute(
      'SELECT post_id, slug, title, excerpt, content, category, published_at AS publishedAt, reading_minutes AS readingMinutes, url FROM blog_posts WHERE is_published = 1 AND published_at <= CURRENT_TIMESTAMP ORDER BY published_at DESC',
    );
    res.json(posts);
  } catch (error) { next(error); }
});

router.get('/:slug', async (req, res, next) => {
  try {
    const [posts] = await pool.execute(
      'SELECT post_id, slug, title, excerpt, content, category, published_at AS publishedAt, reading_minutes AS readingMinutes, url FROM blog_posts WHERE slug = ? AND is_published = 1 AND published_at <= CURRENT_TIMESTAMP LIMIT 1',
      [req.params.slug],
    );
    if (!posts.length) return res.status(404).json({ message: 'Post not found.' });
    return res.json(posts[0]);
  } catch (error) { return next(error); }
});

export default router;
