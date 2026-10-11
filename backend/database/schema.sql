CREATE DATABASE IF NOT EXISTS portfolio
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE portfolio;

CREATE TABLE IF NOT EXISTS projects (
  project_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  project_number TINYINT UNSIGNED NOT NULL,
  initials VARCHAR(8) NOT NULL,
  theme ENUM('rose', 'lavender', 'sage') NOT NULL DEFAULT 'rose',
  project_type VARCHAR(120) NOT NULL,
  name VARCHAR(120) NOT NULL,
  description VARCHAR(1000) NOT NULL,
  tags JSON NOT NULL,
  focus TEXT NOT NULL,
  challenge TEXT NOT NULL,
  approach TEXT NOT NULL,
  learning TEXT NOT NULL,
  contribution_note VARCHAR(1000) NULL,
  url VARCHAR(2048) NOT NULL,
  link_label VARCHAR(80) NOT NULL DEFAULT 'Explore project',
  sort_order INT NOT NULL DEFAULT 0,
  is_published BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY uq_projects_name (name)
);

CREATE TABLE IF NOT EXISTS blog_posts (
  post_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  slug VARCHAR(180) NOT NULL UNIQUE,
  title VARCHAR(200) NOT NULL,
  excerpt VARCHAR(600) NOT NULL,
  content MEDIUMTEXT NOT NULL,
  category VARCHAR(80) NOT NULL DEFAULT 'Development',
  published_at DATETIME NOT NULL,
  reading_minutes TINYINT UNSIGNED NOT NULL DEFAULT 3,
  url VARCHAR(2048) NULL,
  is_published BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS achievements (
  achievement_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(180) NOT NULL,
  issuer VARCHAR(180) NOT NULL,
  description VARCHAR(600) NOT NULL,
  credential_url VARCHAR(2048) NULL,
  image_url VARCHAR(2048) NULL,
  achieved_on DATE NULL,
  status ENUM('completed', 'in_progress', 'planned') NOT NULL DEFAULT 'completed',
  category VARCHAR(80) NOT NULL DEFAULT 'Learning',
  is_published BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Existing databases need a one-time migration before the updated API is deployed:
-- run backend/database/migrations/20261012_achievements_status_image.sql

CREATE TABLE IF NOT EXISTS contact_messages (
  message_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(254) NOT NULL,
  subject VARCHAR(150) NULL,
  message TEXT NOT NULL,
  status ENUM('new', 'read', 'replied', 'archived') NOT NULL DEFAULT 'new',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_contact_created_at (created_at),
  INDEX idx_contact_status (status)
);

INSERT INTO projects
(project_number, initials, theme, project_type, name, description, tags, focus, challenge, approach, learning, contribution_note, url, link_label, sort_order)
VALUES
(1, 'WC', 'rose', 'FULL-STACK · VUE / NODE / MYSQL', 'WeConnect',
 'A supplier network experience bringing buyers, suppliers and everyday business operations into one clear workspace.',
 JSON_ARRAY('Vue.js', 'Express', 'MySQL'),
 'A supplier marketplace connecting product discovery and business workflows in one workspace.',
 'Keeping the frontend, API and relational data model aligned as supplier and buyer features evolve.',
 'Vue.js provides the interface, Express handles server-side routes, and MySQL stores structured application data.',
 'Full-stack integration, relational data, reusable UI patterns and collaborative Git workflows.',
 'Team project — describe the exact screens, components, endpoints or database work you personally completed.',
 'https://github.com/zahraamoerat/Project-3-E-Commerce1', 'Explore project', 1),
(2, 'MT', 'lavender', 'HR TECHNOLOGY · WEB APPLICATION', 'Modern Tech',
 'An HR management experience for employee profiles, leave requests and calendars, with thoughtful workflows at its core.',
 JSON_ARRAY('JavaScript', 'Node.js', 'MySQL'),
 'A central place for employee information and everyday HR workflows such as leave requests and calendar events.',
 'Making sure employee-specific information and protected workflows stay connected to the correct database records.',
 'The application combines employee-facing pages with Node.js and Express routes backed by MySQL data.',
 'Connecting UI states to backend logic, thinking through authentication and data relationships, and debugging API/database issues.',
 'Personalise this section with the pages, routes, authentication or database features you personally implemented.',
 'https://github.com/Zandakumsha/Modern_Tech_2', 'Explore project', 2),
(3, 'LN', 'sage', 'DATA · WEB SCRAPING · ANALYTICS', 'Lightning News',
 'A news analytics dashboard that brings scraped stories together with search, filtering and export-friendly views.',
 JSON_ARRAY('Python', 'Flask', 'Vue.js'),
 'A dashboard that gathers stories from multiple news sources and makes them easier to search and explore.',
 'News sites can structure their pages differently, so scraped content needs to be parsed and presented consistently.',
 'BeautifulSoup supports HTML parsing, Flask exposes backend functionality, and Vue.js powers the interactive dashboard.',
 'Data extraction, handling inconsistent source markup, and joining backend scraping with frontend search and filtering.',
 'Team project — specify the scraper, API routes, dashboard components or export features you personally worked on.',
 'https://lightning-news.netlify.app/', 'View live demo', 3)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  tags = VALUES(tags),
  url = VALUES(url);

INSERT INTO blog_posts (slug, title, excerpt, content, category, published_at, reading_minutes)
VALUES
('learning-to-debug-with-confidence', 'Learning to debug with confidence',
 'My first steps as a developer taught me that problem-solving is less about knowing every answer and more about asking better questions.',
 'Debugging has become one of the most valuable parts of my learning journey. I start by reproducing the issue, reading the error carefully, narrowing down the cause and testing one change at a time. It can be challenging, but every resolved bug helps me understand the system more deeply.',
 'Learning', '2026-10-01 09:00:00', 3),
('connecting-the-frontend-and-backend', 'Connecting the frontend to the backend',
 'A practical reflection on how APIs, databases and thoughtful UI states work together to make an application feel complete.',
 'A frontend becomes much more powerful when it can work with real data. Fetching data from an API, handling loading and error states, validating user input and storing information safely are all part of the experience. I am learning to treat the frontend and backend as two parts of one product.',
 'Full-stack', '2026-10-05 09:00:00', 4)
ON DUPLICATE KEY UPDATE
  title = VALUES(title),
  excerpt = VALUES(excerpt),
  content = VALUES(content);

-- Add verified achievements and credentials here once their exact titles and URLs are confirmed.
