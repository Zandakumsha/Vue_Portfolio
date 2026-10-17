-- Remove draft contribution prompts from existing databases.
-- Only clears known placeholder text; any real, customised contribution notes remain untouched.
UPDATE projects
SET contribution_note = NULL
WHERE (name = 'WeConnect' AND contribution_note LIKE 'Team project — describe the exact screens%')
   OR (name = 'Modern Tech' AND contribution_note LIKE 'Personalise this section with the pages%')
   OR (name = 'Lightning News' AND contribution_note LIKE 'Team project — specify the scraper%');
-- This migration intentionally does not change achievement dates or statuses.
