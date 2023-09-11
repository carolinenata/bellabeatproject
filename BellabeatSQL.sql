#Counting customers in daily_act. There are 32 customers
SELECT COUNT(DISTINCT customer_id)
FROM daily_act;

#Counting customers in weight_log. There are 8 customers
SELECT COUNT(DISTINCT customer_id)
FROM weight_log;

#Counting customers in sleep_day. There are 24 customers
SELECT COUNT(DISTINCT customer_id)
FROM sleep_day;


#Counting customers in hourly calories. There are 32 customers.
SELECT COUNT(DISTINCT customer_id)
FROM hourly_calories;

-- -- -- -- -- -- -- -- 


#Customers from daily_act. SUM OF total distance of each customer and the rest of the distance types. 
SELECT customer_id, SUM(total_distance), SUM(very_active_distance), SUM(moderately_active_distance), SUM(light_active_distance), SUM(sedentary_active_distance)
FROM daily_act
GROUP BY 1;

#Customers from daily act. The percentages of types of distance to total distance.
SELECT customer_id, SUM(very_active_distance)/SUM(total_distance)*100 as "% very active", SUM(moderately_active_distance)/SUM(total_distance)*100 as "% moderately_active", SUM(light_active_distance)/SUM(total_distance)*100 as '% light active'
, SUM(sedentary_active_distance)/SUM(total_distance)*100 as "% sedentary"
FROM daily_act
GROUP BY 1;

#Customers from daily_act.SUM  Total minutes of each customers.
SELECT customer_id, SUM(total_minutes), SUM(very_active_minutes), SUM(fairly_active_minutes), SUM(lightly_active_minutes),  SUM(sedentary_minutes)
FROM daily_act
GROUP BY 1;

#Customers from daily act. The percentages of types of minutes to total minutes.
SELECT customer_id, SUM(very_active_minutes)/SUM(total_minutes)*100 as "% very active", SUM(fairly_active_minutes)/SUM(total_minutes)*100 as "% fairly_active", SUM(lightly_active_minutes)/SUM(total_minutes)*100 as '% lightly active'
, SUM(sedentary_minutes)/SUM(total_minutes)*100 as "% sedentary"
FROM daily_act
GROUP BY 1;

#Customers from daily act. Their average total distance, total, minutes, calories and activity level
SELECT customer_id, avg(total_minutes), avg(total_distance), avg(calories), max(activity_level)
FROM daily_act
GROUP BY 1;

#Most popular day among users. Tuesday is the most popular. 
SELECT COUNT(days_of_week), days_of_week
FROM daily_act
GROUP BY days_of_week
ORDER BY COUNT(days_of_week) DESC;

#Days of week according to total distance and total minutes. 
SELECT days_of_week, sum(total_minutes), sum(total_distance), sum(very_active_minutes), sum(sedentary_minutes), sum(very_active_distance), sum(sedentary_active_distance)
FROM daily_act
GROUP BY 1;

SELECT days_of_week, sum(very_active_minutes), sum(fairly_active_minutes), sum(lightly_active_minutes),sum(sedentary_minutes),
 sum(very_active_distance), sum(moderately_active_distance), sum(light_active_distance), sum(sedentary_active_distance)
FROM daily_act
GROUP BY 1;


#Converting String to Date
UPDATE daily_act
SET activity_date = STR_TO_DATE(activity_date, '%m/%d/%y');

#Finding the total minutes APRIL VS MAY. This is April
SELECT customer_id, SUM(total_minutes)
FROM daily_act
WHERE activity_date BETWEEN '2016-04-12' and '2016-04-30'
GROUP BY 1;

#This is May
SELECT customer_id, SUM(total_minutes)
FROM daily_act
WHERE activity_date BETWEEN '2016-05-1' and '2016-05-12'
GROUP BY 1;

#Looking at the top 10 customers who uses Fitbit. We are going to look at their habits!
SELECT customer_id, COUNT(customer_id) as "usage_frequency"
FROM daily_act
GROUP BY customer_id
ORDER BY COUNT(customer_id) DESC
LIMIT 10;


#Statistical Count
SELECT avg(total_minutes), min(total_minutes), max(total_minutes), STDDEV(total_minutes), avg(total_steps),
min(total_steps), max(total_steps), STDDEV(total_steps), avg(total_distance), min(total_distance), max(total_distance),
STDDEV(total_distance),avg(calories), min(calories), max(calories), STDDEV(calories)
FROM daily_act;

-- -- -- -- -- --

#Count how many customers are overweight/normal weight. Normal Weight 3, Overweight 5
SELECT COUNT(distinct customer_id), bmi_condition
FROM weight_log
GROUP BY 2;

#Checking the total minutes and total distance for customers in Weight Log
SELECT da.customer_id, avg(BMI), bmi_condition, AVG(weight_kg), sum(total_minutes), sum(total_distance), sum(total_steps)
FROM daily_act da
LEFT JOIN weight_log wl
ON wl.customer_id=da.customer_id
WHERE wl.bmi_condition IS NOT NULL
GROUP BY 1,3;

-- -- -- -- -- -- 
#Sleep Day Log


UPDATE sleep_day
SET sleep_day = STR_TO_DATE(sleep_day, '%m/%d/%y');

#Total Sleeping Hours for 12-30 April
SELECT customer_id, sum(hours_asleep)
FROM sleep_day
WHERE sleep_day BETWEEN '2016-04-12' AND '2016-04-30'
GROUP BY 1; 

#Total Sleeping hours for 1-12 May
SELECT customer_id, sum(hours_asleep)
FROM sleep_day
WHERE sleep_day BETWEEN '2016-05-1' AND '2016-05-12'
GROUP BY 1; 

#Checking Sleep hours and total steps. Convert Total Minutes to Hours
SELECT da.customer_id, SUM(total_steps), SUM(hours_total), SUM(hours_total)/SUM(total_steps)
FROM daily_act da
INNER JOIN sleep_day sd
ON sd.customer_id=da.customer_id
GROUP BY 1
ORDER BY SUM(hours_total)/SUM(total_steps) DESC;

#Same like above but now joining the weight log too


UPDATE hourly_calories
SET activity_date = STR_TO_DATE(activity_date,'%m/%d/%y');

UPDATE hourly_calories
SET time_column = STR_TO_DATE(time_column, '%H:%i:%s');

SELECT DISTINCT customer_id, avg(calories), avg(time_column)
FROM hourly_calories
GROUP BY 1;

SELECT time_column ,sum(calories)
FROM hourly_calories
GROUP BY 1;

SELECT sum(calories), days_of_week
FROM hourly_calories
GROUP BY 2;

SELECT DISTINCT(da.customer_id), sum(da.calories), total_steps, total_minutes, activity_level
FROM hourly_calories hc
INNER JOIN daily_act da
ON hc.customer_id=da.customer_id
GROUP BY 1,3,4,5;

SELECT hc.customer_id, sum(hc.calories), time_column, weight_kg, BMI, bmi_condition
FROM hourly_calories hc
INNER JOIN weight_log wl
ON wl.customer_id= hc.customer_id
GROUP BY 1,3,4,5,6
