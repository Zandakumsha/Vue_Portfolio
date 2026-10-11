USE portfolio;

-- Run after 20261012_achievements_status_image.sql on an existing database.
-- Safe to re-run: the public credential URL is used to prevent duplicate rows.
INSERT INTO achievements
(title, issuer, description, credential_url, image_url, achieved_on, status, category, is_published)
SELECT
  'Introduction to Cybersecurity',
  'Cisco',
  'I learned how to protect personal information, devices, networks and organisational data using security practices such as strong passwords, encryption and firewalls. I also learned about cybersecurity ethics, online privacy and career opportunities in the cybersecurity industry, providing a foundation for further learning in IT security.',
  'https://www.credly.com/badges/f0b44bf4-8edf-4190-8070-e1c7e6486a22/public_url',
  NULL,
  '2026-10-29',
  'completed',
  'Learning',
  TRUE
WHERE NOT EXISTS (
  SELECT 1
  FROM achievements
  WHERE credential_url = 'https://www.credly.com/badges/f0b44bf4-8edf-4190-8070-e1c7e6486a22/public_url'
);
