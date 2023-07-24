
USE fit_base_data;

#1. Counting the number of customers in daily_act file. There are 32 customers. 
SELECT COUNT(DISTINCT customer_id)
FROM daily_act;

#2. Counting customers in weight_log. There are 8 customers.
SELECT COUNT(DISTINCT customer_id)
FROM weight_log;

#3. Counting customers in sleep_day. There are 24 customers
SELECT COUNT(DISTINCT customer_id)
FROM sleep_day;

#Counting percentages for types of distances/total distances. (For example: very_active_distance/total_distance*100)
#From this query,Very Active Distance has the highest percentages (78% out of total distance).
SELECT very_active_distance/total_distance*100 AS 'Very Active Distance%', moderately_active_distance/total_distance*100 AS 'Moderately Active Distance%',
light_active_distance/total_distance*100 AS 'Light Active Distance%', sedentary_active_distance/total_distance*100 AS 'Sedentary Distance%'
FROM daily_act;

#Counting percentages for types of minutes/total minutes. (For example: very_active_minutes/total_minutes.
#From this query, Sedentary Minutes is the most minutes. (70% of total minutes).
SELECT very_active_minutes/total_minutes*100 AS 'Very Active Minutes%', fairly_active_minutes/total_minutes*100 AS 'Fairly Active Minutes%',
lightly_active_minutes/total_minutes*100 AS 'Light Active Minutes%', sedentary_minutes/total_minutes*100 AS 'Sedentary Minutes%'
FROM daily_act
LIMIT 10;


#Finding the day with the most record. Currently, Tuesday has the most record 152. 
SELECT COUNT(days_of_week), days_of_week
FROM daily_act
GROUP BY days_of_week
ORDER BY COUNT(days_of_week) DESC;

#Which day has the highest total steps and total minutes. turns out it's Tuesday
SELECT SUM(total_steps), SUM(total_minutes),days_of_week
FROM daily_act
GROUP BY 3
ORDER BY 2 DESC;

#Display average calories, average total minutes and count calories/minutes ratio
SELECT customer_id, avg(calories), avg(total_minutes), calories/total_minutes AS calories_minutes_ratio
FROM daily_act
GROUP BY customer_id, calories/total_minutes
ORDER BY calories/total_minutes DESC;

#Converting String to Date in the daily_act table. 
UPDATE daily_act
SET activity_date = STR_TO_DATE(activity_date, '%m/%d/%y');

#Finding the total minutes for first 15 days and next 15 days. I want to make their statistics stand side by side, 
#so I'm using the temporary table to join two statistics together. First, I'm going to make
#a temporary table for the first half (12 April - 27 April). Then, I will join it with the 
#daily act table querying the second half the month (28 April - 12 May).
CREATE TEMPORARY TABLE first_half
SELECT customer_id, SUM(total_minutes) AS 'totalminutes_first_half'
FROM daily_act
WHERE activity_date BETWEEN '2016-04-12' and '2016-04-27'
GROUP BY 1;

#Joining the temporary tables now
SELECT da.customer_id, SUM(total_minutes) AS 'totalminutes_second_half', fh.totalminutes_first_half
FROM daily_act  da
JOIN first_half fh
ON fh.customer_id=da.customer_id
WHERE da.activity_date BETWEEN '2016-04-28' and '2016-05-12'
GROUP BY 1,3;


#Looking at the top 10 customers who uses Fitbit. We are going to look at their habits! User 81 is the highest with
#61 usages, way more than the rest. 
SELECT customer_id, COUNT(customer_id) as "usage_frequency"
FROM daily_act
GROUP BY customer_id
ORDER BY COUNT(customer_id) DESC
LIMIT 10;

#Statistical Count for daily_act to find some patterns. 
SELECT avg(total_minutes), min(total_minutes), max(total_minutes), STDDEV(total_minutes), avg(total_steps),
min(total_steps), max(total_steps), STDDEV(total_steps), avg(total_distance), min(total_distance), max(total_distance),
STDDEV(total_distance),avg(calories), min(calories), max(calories), STDDEV(calories)
FROM daily_act;

#Weight Log files

#Count how many customers are overweight/normal weight. Normal Weight: 3 Overweight:5
SELECT COUNT(distinct customer_id), bmi_condition
FROM weight_log
GROUP BY 2;

#Checking the total minutes and total distance for customers in Weight Log by
#joining table with daily_act. 
SELECT da.customer_id, avg(BMI), bmi_condition, AVG(weight_kg), avg(total_minutes), avg(total_distance), avg(total_steps)
FROM daily_act da
LEFT JOIN weight_log wl
ON wl.customer_id=da.customer_id
WHERE wl.bmi_condition IS NOT NULL
GROUP BY 1,3
ORDER BY avg(total_steps) DESC;

#Sleep Day Log

#Changing the str to datetime in sleep_day
UPDATE sleep_day
SET sleep_day = STR_TO_DATE(sleep_day, '%m/%d/%y');

#Like the previous temporary tables, I'm doing the same for sleeping hours for the first half
#(12 April - 27 April) and join it with the second half (28 April - 12 May) to see their statistics side by side.

#Total Sleeping Hours for 12-30 April
CREATE TEMPORARY TABLE firsthalf_sleep
SELECT customer_id, sum(hours_asleep) as 'first_half_total'
FROM sleep_day
WHERE sleep_day BETWEEN '2016-04-12' AND '2016-04-27'
GROUP BY 1; 

#Total Sleeping hours for 1-12 May
SELECT sd.customer_id, sum(hours_asleep) as 'second_half_total', fhs.first_half_total
FROM sleep_day sd
INNER JOIN firsthalf_sleep fhs
ON fhs.customer_id = sd.customer_id
WHERE sleep_day BETWEEN '2016-04-28' AND '2016-05-12'
GROUP BY 1,3; 

#Checking the ratio of sum of total steps and total hours
SELECT da.customer_id, SUM(total_steps), SUM(hours_total), SUM(hours_total)/SUM(total_steps)
FROM daily_act da
INNER JOIN sleep_day sd
ON sd.customer_id=da.customer_id
GROUP BY 1
ORDER BY SUM(hours_total)/SUM(total_steps) DESC;

#Same like above but now joining the weight log too
SELECT da.customer_id, SUM(total_steps), SUM(hours_total), SUM(hours_total)/SUM(total_steps), AVG(weight_kg), bmi_condition
FROM daily_act da
INNER JOIN sleep_day sd
ON sd.customer_id=da.customer_id
INNER JOIN weight_log wl
ON wl.customer_id= sd.customer_id
GROUP BY 1,6
ORDER BY SUM(hours_total)/SUM(total_steps) DESC;







