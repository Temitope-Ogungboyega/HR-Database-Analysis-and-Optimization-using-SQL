-- View Table
select * from hr limit 5;

-- remove safe updste mode 
SET sql_safe_updates = 0;

-- Check data types of all columns
DESCRIBE hr;

-- Change ID to INT
ALTER TABLE hr
MODIFY COLUMN id INT;

-- Change birthdate values to date
UPDATE hr
SET birthdate = CASE
  WHEN birthdate LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
  WHEN birthdate LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(birthdate, '%m-%d-%y'), '%Y-%m-%d')
  ELSE NULL
END;

ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

-- Convert hire_date values to date
UPDATE hr
SET hire_date = CASE
  WHEN hire_date LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
  WHEN hire_date LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(hire_date, '%m-%d-%y'), '%Y-%m-%d')
  ELSE NULL
END;

ALTER TABLE hr
MODIFY COLUMN hire_date DATE;


select termdate from hr limit 5;
-- Convert termdate values to date and remove time
UPDATE hr
SET termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate is not null and termdate != '';

UPDATE hr
SET termdate = NULL
WHERE termdate = '';

ALTER TABLE hr
MODIFY COLUMN termdate DATE;


-- Add Age column
ALTER TABLE hr ADD COLUMN age INT;
UPDATE hr SET age = TIMESTAMPDIFF(YEAR, birthdate, CURDATE());


