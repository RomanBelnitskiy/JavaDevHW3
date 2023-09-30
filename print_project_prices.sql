SELECT p."name", 
  SUM(
    CASE 
      WHEN p.finish_date IS NULL THEN ((current_date - p.start_date) / 30 * w.salary) 
      ELSE ((p.finish_date - p.start_date) / 30 * w.salary)
    END
  ) price 
	FROM project p
	JOIN project_worker pw ON pw.project_id=p.id 
	JOIN worker w ON w.id=pw.worker_id
	GROUP BY p."name" 
	ORDER BY price DESC;