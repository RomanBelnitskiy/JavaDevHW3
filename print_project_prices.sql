SELECT p."name", 
  SUM(
    CASE 
      WHEN p.finish_date IS NULL THEN ((extract(year from AGE(current_date, p.start_date)) * 12 + 
			extract(month from AGE(current_date, p.start_date))) * w.salary) 
      ELSE ((extract(year from AGE(p.finish_date, p.start_date)) * 12 + 
			extract(month from AGE(p.finish_date, p.start_date))) * w.salary)
    END
  ) price 
FROM project p
JOIN project_worker pw ON pw.project_id=p.id 
JOIN worker w ON w.id=pw.worker_id
GROUP BY p."name" 
ORDER BY price DESC;
