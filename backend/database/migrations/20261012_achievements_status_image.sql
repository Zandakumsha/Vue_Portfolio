USE portfolio;

-- Run this migration once on an existing portfolio database before deploying
-- the updated achievements API. Do not run it more than once.
ALTER TABLE achievements
  ADD COLUMN image_url VARCHAR(2048) NULL AFTER credential_url,
  ADD COLUMN status ENUM('completed', 'in_progress', 'planned')
    NOT NULL DEFAULT 'completed' AFTER achieved_on;

-- Existing rows are treated as completed by default. Review each row and set
-- status only after confirming whether the credential is completed or in progress.
