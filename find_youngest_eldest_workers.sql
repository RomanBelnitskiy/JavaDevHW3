SELECT
    CASE 
      WHEN w.birthday = (SELECT MAX(birthday) FROM worker)
      THEN 'YOUNGEST'
      ELSE 'ELDEST'
    END "type",
    w."name", 
    w.birthday 
	FROM worker w
	WHERE w.birthday = (SELECT MAX(birthday) FROM worker)
	OR w.birthday = (SELECT MIN(birthday) FROM worker);