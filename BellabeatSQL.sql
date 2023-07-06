#Counting the number of distinct customer_id, aka the number of customers
SELECT COUNT(DISTINCT customer_id)
FROM daily_act;

#Looking at total mins (very active minutes, lightly active minutes and fairly active minutes)
SELECT total_minutes, very_active_minutes, fairly_active_minutes, lightly_active_minutes, sedentary_minutes
FROM daily_act;

SELECT SUM(very_active_minutes) as 'Sum Active Minutes', SUM(fairly_active_minutes) as 'Sum Fairly Active Minutes',
SUM(lightly_active_minutes) AS 'Sum Lightly Active Minutes', SUM(sedentary_minutes) AS 'Sum Sedentary Minutes'
FROM daily_act;

#Looking at total mins (very active minutes, lightly active minutes and fairly active minutes) BUT percentage
SELECT very_active_minutes/total_minutes*100 as 'Very Active Ratio%', lightly_active_minutes/total_minutes*100 AS 'Lightly Active%',
fairly_active_minutes/total_minutes*100 AS 'Fairly Active%', sedentary_minutes/total_minutes*100 AS 'Sedentary Active%'
FROM daily_act
LIMIT 10;

#Looking at total distances percentages with very active, moderately active, light active, sedentary distance
SELECT very_active_distance/total_distance*100 as 'Very Active Distance%', moderately_active_distance/total_distance*100 AS 'Moderately Active Distance%',
light_active_distance/total_distance*100 AS 'Light Active Distance%', sedentary_active_distance/total_distance*100 AS 'Sedentary Distance%'
FROM daily_act
LIMIT 10;

#Looking at the top 10 customers who uses Fitbit. We are going to look at their habits!
SELECT customer_id, COUNT(customer_id) as "usage_frequency"
FROM daily_act
GROUP BY customer_id
LIMIT 10;



#Looking at the top total minutes of each customer
SELECT customer_id, MAX(total_minutes) as 'Most Active Minutes'
FROM daily_act
GROUP BY customer_id;

#Look at the most active day for working out - Wednesday
SELECT customer_id, MAX(days_of_week) as 'Most Active Days'
FROM daily_act
GROUP BY customer_id;

#Look for the least active day for working out - Friday
SELECT customer_id, MIN(days_of_week) as 'Least Active Days'
FROM daily_act
GROUP BY customer_id;

#Find the days of the week with the highest total minutes
SELECT SUM(total_minutes), days_of_week
FROM daily_act
GROUP BY days_of_week
ORDER BY SUM(total_minutes) DESC;

SELECT customer_id, AVG(calories) AS 'Average Calories Burned'
FROM daily_act
GROUP BY customer_id;

SELECT customer_id, AVG(calories) AS 'Average Calories Burned'
FROM daily_act
GROUP BY customer_id;

#CHECKING THE MOST ACTIVE CUSTOMER
SELECT customer_id, MAX(activity_level)
FROM daily_act
GROUP BY customer_id;

#Trial dont touch
SELECT avg(total_minutes), min(total_minutes), max(total_minutes), STDDEV(total_minutes), avg(total_steps),
min(total_steps), max(total_steps), STDDEV(total_steps), avg(total_distance), min(total_distance), max(total_distance),
STDDEV(total_distance),avg(calories), min(calories), max(calories), STDDEV(calories)
FROM daily_act;






