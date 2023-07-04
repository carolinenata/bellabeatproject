#To see basic analysis of one file

#This is an overview for the customer data from the activity table. 
#We are looking at their activity date, total steps, total active minutes and their activity level.
SELECT customer_id, activity_date, total_steps, total_active_minutes, activity_level
FROM daily_activity
ORDER BY customer_id asc;

#This query shows how much each customer uses the Bellabeat app. Customer 81 uses the most frequently and
#customer 2912 uses the least. 
SELECT customer_id, COUNT(customer_id) as "usage_frequency"
FROM daily_activity
GROUP BY customer_id;
 
#This query shows the individual data of each customer. At the moment, I am querying results for customer 81.
#Customer 81 is a very active user
SELECT customer_id, total_steps, total_distance, total_active_minutes, activity_level
FROM daily_activity
WHERE customer_id = 81;

#Now, I'm going to query customer 2912
SELECT customer_id, total_steps, total_distance, total_active_minutes, activity_level
FROM daily_activity
WHERE customer_id = 2912;
 
##Now, I'm going to query to count distinct to see the number of unique ID of customer to see the 
#number of customers. There are 32 customers using Bellabeat in this data.
SELECT COUNT(DISTINCT customer_id) AS customer_count
FROM daily_activity;


##Find out who is the active customers
SELECT DISTINCT customer_id, activity_level, total_active_minutes
FROM daily_activity
WHERE activity_level='Active'
ORDER BY total_active_minutes DESC;

#Looking at the most active customers. Customer 81 has the most steps and the most distance. However,
#customer 9391 has the highest total active minutes - 1440 consistent every usage. 
#Customer 9665 is shown to have the least active minutes, total distance, total steps. 
SELECT customer_id,total_active_minutes, total_distance, total_steps, activity_level
FROM daily_activity
WHERE activity_level = "Not Active"
ORDER BY total_steps ASC, total_active_minutes ASC, total_steps ASC;

##Average Total steps for Active/Not Active/Very Active users
SELECT  AVG(total_active_minutes) as 'Average Total Active Minutes for Very Active', activity_level
FROM daily_activity
WHERE activity_level='Very Active'
GROUP BY activity_level;

SELECT  AVG(total_active_minutes) as 'Average Total Active Minutes for Very Active', activity_level
FROM daily_activity
WHERE activity_level='Active'
GROUP BY activity_level;

SELECT  AVG(total_active_minutes) as 'Average Total Active Minutes for Very Active', activity_level
FROM daily_activity
WHERE activity_level='Not Active'
GROUP BY activity_level;

#looking at the active,moderate and light distance
SELECT customer_id, activity_date, very_active_distance, moderately_active_distance, light_active_distance,
activity_level
FROM daily_activity
WHERE activity_level='Not Active'
ORDER BY activity_date;


##Check how many customer records are there. there are 940 customer records.
SELECT COUNT(customer_id)
FROM daily_activity;

##Check how many active records are there. There are 209 records 
SELECT COUNT(activity_level) as 'active_count', activity_level
FROM daily_activity
WHERE activity_level='Active';

##Check how many not active records are there. There are 254 records 
SELECT COUNT(activity_level) as 'not_active_count', activity_level
FROM daily_activity
WHERE activity_level='Not Active';

##Check how many very active records are there. There are 477 records 
SELECT COUNT(activity_level) as 'very_active_count', activity_level
FROM daily_activity
WHERE activity_level='Very Active';

#To see combined data including total steps, distance, activity level and the BMI
SELECT da.customer_id, da.total_steps, da.total_distance, da.total_active_minutes, da.activity_level, wl.weight_kg, 
wl.BMI, wl.bmi_condition, da.days_of_week
FROM daily_activity da
JOIN weight_log wl
 ON da.customer_id = wl.customer_id;

#using this joined table, I want to sort it out to find more analysis. This shows that
#overweight customers tend to be ver active while normal weight customers tend to be moderately or less active.
SELECT da.customer_id, da.total_steps, da.total_distance, da.total_active_minutes, da.activity_level, wl.weight_kg, 
wl.BMI, wl.bmi_condition
FROM daily_activity da
JOIN weight_log wl
 ON da.customer_id = wl.customer_id
ORDER BY wl.weight_kg DESC;
 
 #using more advance WHERE statement with IN, AND, OR
SELECT da.customer_id, da.total_steps, da.total_distance, da.total_active_minutes, da.activity_level, wl.weight_kg, 
wl.BMI, wl.bmi_condition, da.days_of_week
FROM daily_activity da
JOIN weight_log wl
 ON da.customer_id = wl.customer_id
 WHERE activity_level IN ('Very Active' , 'Active');
 
SELECT da.customer_id, da.total_steps, da.total_distance, da.total_active_minutes, da.activity_level, wl.weight_kg, 
wl.BMI, wl.bmi_condition
FROM daily_activity da
JOIN weight_log wl
 ON da.customer_id = wl.customer_id
 WHERE BMI <=25 AND activity_level='Active';
 
#I realized that not all customers from 'daily_activity' data are not recorded in the weight log. I want
#to see how many customers are recorded in the weight log while joining the tables. There is only 8 customers 
#tracked in weight log!
SELECT COUNT(DISTINCT wl.customer_id)
FROM weight_log wl;

SELECT da.customer_id, da.total_steps, da.total_distance, da.total_active_minutes, da.activity_level, wl.weight_kg, 
wl.BMI, wl.bmi_condition
FROM daily_activity da
JOIN weight_log wl
 ON da.customer_id = wl.customer_id
 WHERE bmi_condition='Normal Weight';
 
 #I want to see the number of customers with normal/overweight. So far 3 customers have normal weight (366,
 #2765, 1067
 SELECT customer_id, weight_kg, BMI, bmi_condition
 FROM weight_log
 WHERE bmi_condition='Normal Weight';
 
#5 customers are overweight. Let's try to see if I'm correct by using the count statement
SELECT customer_id, weight_kg, BMI, bmi_condition
 FROM weight_log
 WHERE bmi_condition='Overweight';
 
SELECT COUNT(DISTINCT customer_id), bmi_condition
FROM weight_log
WHERE bmi_condition='Overweight';
 
SELECT COUNT(DISTINCT customer_id), bmi_condition
FROM weight_log
WHERE bmi_condition='Normal Weight';

SELECT da.customer_id, da.total_steps, da.total_distance, da.total_active_minutes, da.activity_level, wl.weight_kg, 
wl.BMI, wl.bmi_condition
FROM daily_activity da
JOIN weight_log wl
 ON da.customer_id = wl.customer_id;
 
#There are 67 records in weight log
SELECT COUNT(customer_id)
FROM weight_log;

#Count number of rows, mean, std, min/max, percentiles, limiting data, sorting data, finding patterns,
#aggregating, filtering

#How many unique customer_id in each database
#daily activity table: 32 
SELECT COUNT(DISTINCT customer_id) AS customer_count
FROM daily_activity;



#weight log: 8
SELECT COUNT(DISTINCT customer_id)
FROM weight_log;

#How many records in each table. 
#daily activity: 936 records
SELECT COUNT(customer_id)
FROM daily_activity;

#weight log: 67 
SELECT COUNT(customer_id)
FROM weight_log;



#average, min, max, std



#average, min,max,min,std of total steps for each customer ID, 
SELECT  customer_id, avg(total_steps), min(total_steps), max(total_steps), STDDEV(total_steps)
FROM daily_activity
GROUP BY customer_id
ORDER BY avg(total_steps) DESC;

#average, mean,max,min,std of total distance for each customer ID
SELECT  customer_id, avg(total_distance), max(total_distance), min(total_distance), STDDEV(total_distance)
FROM daily_activity
GROUP BY customer_id
ORDER BY avg(total_distance) DESC;

#average mean,max, min,std of total active minutes for each customer ID
SELECT  customer_id, avg(total_active_minutes), MAX(total_active_minutes), MIN(total_active_minutes),STDDEV(total_active_minutes)
FROM daily_activity
GROUP BY customer_id
ORDER BY avg(total_active_minutes) DESC;

#Filtering Data. Filtering 'Active' Customers with 'Normal Weight' as BMI
SELECT da.customer_id, da.total_steps, da.total_distance, da.total_active_minutes, da.activity_level, wl.weight_kg, 
wl.BMI, wl.bmi_condition
FROM daily_activity da
JOIN weight_log wl
 ON da.customer_id = wl.customer_id
WHERE activity_level='Active' AND bmi_condition='Normal Weight';

#Fiiltering data. filtering active customers with VERY ACTIVE and overweight
SELECT da.customer_id, da.total_steps, da.total_distance, da.total_active_minutes, da.activity_level, wl.weight_kg, 
wl.BMI, wl.bmi_condition
FROM daily_activity da
JOIN weight_log wl
 ON da.customer_id = wl.customer_id
WHERE activity_level= 'Very Active' AND bmi_condition='Overweight';

#Limiting customers
SELECT customer_id, weight_kg, BMI, bmi_condition
FROM weight_log
WHERE bmi_condition='Normal Weight'
LIMIT 10;

#Patterns I found. Overweight people tend to be more active in using the Bellabeat app while the normal weight 
#people tend to take it easy

#Finding out which days of the week is the most popular for customers to be active
#Active
#11 Sunday, 16 Monday, 16 Tuesday,16 Wednesday, 17 Thursday, 18 Friday, 17 Saturday, 11 Sunday

#Very Active
#21 Sunday, 20 Saturday, 22 Friday, 21 Thursday, 21 Wednesday, 21 Tuesday, 21 Monday

#Not Active
#12 Monday, 15 Tuesday, 18 Wednesday, 24 Thursday, 12 Friday, 15 Saturday, 16 Sundays

#Conclusion
#Monday: Very Active, Tuesday: Very Active, Wednesday: Very Active, Thursday: not active,
#Friday: Very Active, Saturday: Very Active, Sunday: Very Active

SELECT COUNT(DISTINCT customer_id), activity_level, days_of_week, customer_id
FROM daily_activity
WHERE activity_level='Active' AND days_of_week='Monday'
GROUP BY customer_id;



