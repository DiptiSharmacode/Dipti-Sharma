SELECT gender, count(*) AS count
FROM hr
WHERE age >=18 AND termdate = '0000-00-00'
GROUP BY gender;
SELECT race, count(*) AS count
FROM hr
WHERE age >=18 AND termdate = '0000-00-00'
GROUP BY race
ORDER BY count(*) DESC;

-- AGE distribution of employees
SELECT
min(age) AS youngest,
max(age) AS OLDEST
FROM hr
WHERE age >=18 AND termdate = '0000-00-00';

SELECT
   CASE
     WHEN age >=18 AND age <=24 THEN '18-14'
	 WHEN age >=25 AND age <=34 THEN '25-34'    
     WHEN age >=35 AND age <=44 THEN '35-44'
     WHEN age >=45 AND age <=54 THEN '45-54'
     WHEN age >=55 AND age <=64 THEN '55-64'
     ELSE '65+'
  END AS age_group,
  count(*) AS count
FROM hr
WHERE age >=18 AND termdate = '0000-00-00'
GROUP BY age_group
ORDER BY age_group;

SELECT
   CASE
     WHEN age >=18 AND age <=24 THEN '18-14'
	 WHEN age >=25 AND age <=34 THEN '25-34'    
     WHEN age >=35 AND age <=44 THEN '35-44'
     WHEN age >=45 AND age <=54 THEN '45-54'
     WHEN age >=55 AND age <=64 THEN '55-64'
     ELSE '65+'
  END AS age_group, gender,
  count(*) AS count
FROM hr
WHERE age >=18 AND termdate = '0000-00-00'
GROUP BY age_group, gender
ORDER BY age_group, gender;

-- how many employees work at headquarters vs. loctions?
SELECT location, count(*) AS count
FROM hr
WHERE age >=18 AND termdate = '0000-00-00'
GROUP BY location;

-- 5. What is the average length of employees who have been terminated?
SELECT 
 round(avg(datediff(termdate, hire_date))/365,0) AS avg_length_employment
 FROM hr
 WHERE termdate <= curdate() AND termdate <> '0000-00-00' AND age >=18;
 
 -- how does the gender distribution vary across departments and job titles
 
 SELECT department, gender, COUNT(*) AS count
 FROM hr
 WHERE age >=18 AND termdate = '0000-00-00'
 GROUP BY department, gender
 ORDER BY department;
 
 -- distribution of job titles cross the company
 SELECT jobtitle, count(*) AS count
 FROM hr
 WHERE age >=18 AND termdate = '0000-00-00'
 GROUP BY jobtitle
 ORDER BY jobtitle DESC;
 
 -- which deprtment has the highest turnover
 SELECT department,
   total_count,
   terminated_count,
   terminated_count/total_count AS termination_rate
FROM (
   SELECT department, 
   COUNT(*) AS total_count,
   SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= curdate() THEN 1 ELSE 0 END) AS terminated_count
   FROM hr
   WHERE age >=18
   GROUP BY department
   ) AS subquery
   ORDER BY termination_rate DESC;
   
   -- distribution of employees across locations by city n state
   SELECT location_state, COUNT(*) AS count
   FROM hr
   WHERE age >=18 AND termdate = '0000-00-00'
   GROUP BY location_state
   ORDER BY count DESC;
   
   -- how has the company's employee ount changed over time based on hire and term dates?
   SELECT
     year,
     hires,
     terminations,
     hires - terminations AS net_change,
     round((hires - terminations)/hires * 100,2) AS net_change_percent
	FROM(
      SELECT 
        YEAR(HIRE_DATE) AS year,
        count(*) AS hires,
        SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= curdate() THEN 1 ELSE 0 END) AS terminations
        FROM hr
        WHERE age >=18
        GROUP BY YEAR(hire_date)
        ) AS subquery
ORDER BY year ASC;

-- tenure distribution for each department

SELECT department, round(avg(datediff(termdate, hire_date)/365),0) AS avg_tenure
FROM hr
WHERE termdate <= curdate() AND termdate<> '0000-00-00' AND age>= 18
GROUP BY department;
   
   
 
