import { Router } from 'express';
import { pool } from '../config/db.js';

const router = Router();

router.post('/', async (req, res, next) => {
  const name = typeof req.body.name === 'string' ? req.body.name.trim() : '';
  const email = typeof req.body.email === 'string' ? req.body.email.trim() : '';
  const subject = typeof req.body.subject === 'string' ? req.body.subject.trim() : '';
  const message = typeof req.body.message === 'string' ? req.body.message.trim() : '';
  // Honeypot field: bots often fill hidden fields; accept without storing.
  const website = typeof req.body.website === 'string' ? req.body.website.trim() : '';

  if (website) return res.status(200).json({ message: 'Thank you for reaching out.' });
  if (name.length < 2 || name.length > 100) return res.status(400).json({ message: 'Please enter a name between 2 and 100 characters.' });
  if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email) || email.length > 254) return res.status(400).json({ message: 'Please enter a valid email address.' });
  if (subject.length > 150) return res.status(400).json({ message: 'Subject must be 150 characters or fewer.' });
  if (message.length < 10 || message.length > 5000) return res.status(400).json({ message: 'Your message must be between 10 and 5,000 characters.' });

  try {
    await pool.execute(
      'INSERT INTO contact_messages (name, email, subject, message, status) VALUES (?, ?, ?, ?, ?)',
      [name, email, subject || null, message, 'new'],
    );
    return res.status(201).json({ message: 'Thank you — your message has been received.' });
  } catch (error) { return next(error); }
});

export default router;
