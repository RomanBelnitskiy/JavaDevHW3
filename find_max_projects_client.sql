SELECT c."name", COUNT(p.id) project_count 
	FROM project p 
	JOIN client c ON c.id=p.client_id
	GROUP BY c."name" 
	HAVING COUNT(p.id)=(
    SELECT MAX(project_count) 
    FROM (SELECT p.client_id, COUNT(p.id) project_count FROM project p GROUP BY p.client_id));