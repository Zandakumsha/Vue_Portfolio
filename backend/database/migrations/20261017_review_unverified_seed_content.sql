-- Seeded journal entries are examples, not confirmed personal writing.
UPDATE blog_posts
SET is_published = FALSE
WHERE slug IN (
  'learning-to-debug-with-confidence',
  'connecting-the-frontend-and-backend'
);

-- Keep the supplied Cisco credential hidden while its supplied completion date is in the future.
-- The supplied status and date are deliberately preserved; verify the public Credly record,
-- then publish it manually when appropriate.
UPDATE achievements
SET is_published = FALSE
WHERE credential_url = 'https://www.credly.com/badges/f0b44bf4-8edf-4190-8070-e1c7e6486a22/public_url'
  AND achieved_on > CURRENT_DATE
  AND status = 'completed';
