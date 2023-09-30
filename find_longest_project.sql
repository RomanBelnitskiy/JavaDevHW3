ALTER TABLE project ADD COLUMN "name" VARCHAR(255);

UPDATE project SET "name" = CONCAT('Project ', UPPER(to_hex(id))) WHERE "name" IS NULL;

ALTER TABLE project ALTER COLUMN "name" SET NOT NULL;

SELECT p."name", ((p.finish_date - p.start_date) / 30) month_count 
  FROM project p 
	WHERE p.finish_date notnull AND ((p.finish_date - p.start_date) / 30) = (
		SELECT Max(month_count) 
		FROM (SELECT ((p.finish_date - p.start_date) / 30) month_count FROM project p));