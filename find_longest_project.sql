SELECT "name", month_count 
FROM (SELECT *, 
	CASE 
		WHEN finish_date IS NULL THEN (EXTRACT(YEAR FROM AGE(CURRENT_DATE, start_date)) * 12 + 
			  EXTRACT(MONTH FROM AGE(CURRENT_DATE, start_date))) 
	    ELSE (EXTRACT(YEAR FROM AGE(finish_date, start_date)) * 12 + 
			  EXTRACT(MONTH FROM AGE(finish_date, start_date)))
	    END month_count
	FROM project) 
WHERE month_count = (
	SELECT MAX(month_count) 
	FROM (SELECT  
		CASE 
			WHEN finish_date IS NULL THEN (EXTRACT(YEAR FROM AGE(CURRENT_DATE, start_date)) * 12 + 
				  EXTRACT(MONTH FROM AGE(CURRENT_DATE, start_date))) 
		    ELSE (EXTRACT(YEAR FROM AGE(finish_date, start_date)) * 12 + 
				  EXTRACT(MONTH FROM AGE(finish_date, start_date)))
		    END month_count
		FROM project));