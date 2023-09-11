# **Fitness Smartwatch Exploratory Analysis**

This is the final project from the course I took from Coursera (Google Data Analytics Course). For this project, I was assigned to be a data analyst for a fitness smartwatch company, Bellabeat.

## Background

Bellabeat is a a tech company focusing on health products like smartwatch for women since 2013. Bellabeat has a huge potential to become a large player in the global smart device market. As a junior data analyst in this company, I am required to analyze Bellabeat’s fitness tracker app to find opportunities to grow. I am required to look into insights, trends and correlations on how the customers are using the app in order to improve Bellabeat’s marketing strategy.

## Steps

Here are the six steps we do prior our data analysis:

1. Ask

2. Prepare

3. Process

4. Analyze

5. Share

6. Act

## Ask

These are the questions we ask prior our analysis:

* What are some trends in the smart device usage?

* How could these trends applied to Bellabeat customers?

* How could these trends influence Bellabeat’s marketing strategy?

## Prepare

1. The data is available for public in Kaggle:Fitbit Fitness Tracker Data and includes 18 CSV files.

2. The respondents are survey takers from Amazon Mechanical Turk between 12 March - 12 May in year 2016.

3. There are around 30 respondents in this survey.

4. Data includes collecting physical activity recorded in minutes, heart rate, sleep monitoring, daily activity and steps.

### Is the Data ROCCC?

According to the theory we learned in Google Analytics Capstone Project, a good data source is ROCCC, which stands for: Reliable, Original, Comprehensive, Current, Cited. So, is the data obtained ROCCC? Here’s my analysis:

* Reliable: LOW, because it only has around 30 respondents

* Original: LOW,  because the data is provided by the third party (Amazon Mechanical Turk), not conducted by Bellabeat itself.

* Comprehensive: MEDIUM, because most parameters match most of Bellabeat product’s parameters.

* Current: LOW,  because the data is recorded 7 years ago. The customer’s habits may have changed since then.

* Cited: LOW, The data is gathered from the Third Party and we do not know how they gather the data.

### Data selection

For this analysis,  we are going to use three CSV files. You can find the three CSV files here.  The three files we are going to use are:

* dailyActivity_merged.csv

* weightLogInfo_merged.csv

* sleepDay_merged.csv

* hourlyCalories_merged.csv

### Tools
The tools we are using for this data analysis are:

* Microsoft Excel (Data cleaning and manipulation)

* MYSQL (Query and analysis)

* Tableau (Data visualization)

## Process

1. Three three files had id. They have 10 integers and are supposed to indicate a unique customer id for one customer. To shorten the id, I use the RIGHT(=RIGHT(B2,4)) function to only take the last 4 integers to make the id more simple and concise.  I also renamed the field from id to customer_id. I applied them to all the three CSV files including id.

2. I use the comma function to round up all the number into two decimal places to make them less complicated to read. I applied them to all CSV files including numerical values.

3. All three CSV files used dash (-) to indicate null or missing values. I replaced dash (-) with zero (0) to indicate the null values. To replace them all, I use the filter options to all columns with null values. I unchecked everything but dash (-) and replace them with zero (0). Afterwards, I checked all the values to return all values including the new missing values (where dash has been replaced with zero). I applied this to all CSV files. 

4. For dailyActitivity_merged. csv, I make a new column called total_minutes and SUM all the values from Lightly Active Minutes, Moderately Active Minutes, Very Active Minutes and Sedentary Active Minutes). We use the sum function =SUM(K2,L2,M2,N2). 

5. For dailyActitivity_merged. csv,  I use the IF function to indicate whether each user is Active or Not Active. We use the data from Total Minutes for this indicator. If the Total Minutes is less than 1000, then that user is not Active. We use the =IF(E2<1000,"Not Active","Active") function. 

6. For dailyActivity_merged.csv, I use the date values from column B and convert it to days of the week(Monday, Tuesday, etc) by using  =TEXT(C2,”dddd”) function. 

7. For WeightLogInfo_merged, I add the column bmi_status to indicate customer's bmi whether they are normal weight or overweight. . If the BMI is smaller than 25, it means the customer has normal weight. If not, the customer is overweight. I use the =IF(F2<25, "Normal Weight","Overweight") function. 

8. For SleepDay_merged, I converted the numerical values for minutes_asleep and minutes_total into hours_asleep and hours_total. I divided the minutes to 60(1 hour= 60 minutes) to convert them into hour values. I also get rid of Total_Sleep_Record and convert the date to 'short date' to get rid of the time. 

