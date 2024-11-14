SELECT * FROM projects;

-- 1. CONVERSION OF EPOCH DATE TO NATURAL DATE --
ALTER TABLE projects ADD COLUMN created_date DATE;
SET SQL_SAFE_UPDATES=0;
UPDATE projects
SET created_date = FROM_UNIXTIME(created_at, '%Y-%m-%d');
SELECT * FROM projects;

# SUCESSFUL DATE #
ALTER TABLE projects ADD COLUMN successful_date DATE;
SET SQL_SAFE_UPDATES=0;
UPDATE your_table
SET successful_date = IFNULL(FROM_UNIXTIME(successful_date), '0');

-- CREATE CALANDER TABLE --
CREATE TABLE calendar (
    project_id INT,
    created_date DATE
);

INSERT INTO calendar (project_id, created_date)
SELECT p.ProjectID, p.created_date
FROM projects p
JOIN calendar c ON p.ProjectID = c.project_id;

SELECT * FROM calendar;
INSERT INTO calendar (project_id, created_date)
SELECT ProjectID,created_date 
FROM projects;	

-- YEAR --
ALTER TABLE calendar
ADD COLUMN cr_Year INT;
UPDATE calendar
SET cr_Year = YEAR(created_date);

-- MONTH NUMBER -- 
ALTER TABLE calendar
ADD COLUMN cr_MonthNumber INT;
UPDATE calendar
SET cr_MonthNumber = MONTH(created_date);

-- MONTH NAME -- 
ALTER TABLE calendar
ADD COLUMN cr_MonthName VARCHAR(50);
UPDATE calendar
SET cr_MonthName = monthname(created_date);

-- QUARTER --
ALTER TABLE calendar
ADD COLUMN cr_Quarter VARCHAR(50);
UPDATE calendar
SET cr_Quarter = concat('Q',QUARTER(created_date));
SELECT * FROM calendar;

-- YEAR-MONTH -- 
ALTER TABLE calendar
ADD COLUMN cr_YearMonth VARCHAR(50);
UPDATE calendar
SET cr_YearMonth = concat(YEAR(created_date),"-",MONTHNAME(created_date));
SELECT * FROM calendar;

-- WEEKDAY NUMBER -- 
ALTER TABLE calendar
ADD COLUMN cr_WeekdayNumber INT;
UPDATE calendar
SET cr_WeekdayNumber = DAYOFWEEK(created_date);

-- WEEKDAY NAME -- 
ALTER TABLE calendar
ADD COLUMN cr_WeekdayName VARCHAR(50);
UPDATE calendar
SET cr_WeekdayName = DAYNAME(created_date);

-- FINANCIAL MONTH -- 
ALTER TABLE calendar
ADD COLUMN Financial_month VARCHAR(50);

UPDATE calendar
SET Financial_month = CONCAT('FM-',
CASE
 WHEN MONTH(created_date)>=4 THEN MONTH(created_date) -3
 ELSE MONTH(created_date)+9
 END);
SELECT * FROM calendar;

-- FINANCIAL QUARTER -- 
ALTER TABLE calendar
ADD COLUMN Financial_quarter VARCHAR(50);

UPDATE calendar
SET Financial_quarter = CASE 
        WHEN MONTH(created_date) IN (4, 5, 6) THEN 'FQ1'
        WHEN MONTH(created_date) IN (7, 8, 9) THEN 'FQ2'
        WHEN MONTH(created_date) IN (10, 11, 12) THEN 'FQ3'
        WHEN MONTH(created_date) IN (1, 2, 3) THEN 'FQ4'
    END;

