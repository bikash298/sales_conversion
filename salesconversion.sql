#SALES CONVERSION ANALYSIS

USE salesconversion;

# Checking the table 
SELECT *
FROM kag_conversion_data
LIMIT 10;

# Checking the table for any null values
SELECT *
FROM kag_conversion_data
WHERE ad_id IS NULL
	OR xyz_campaign_id IS NULL
	OR fb_campaign_id IS NULL
    OR age IS NULL
    OR gender IS NULL
    OR interest IS NULL
    OR impressions IS NULL
    OR clicks IS NULL
	OR spent IS NULL
	OR total_conversion IS NULL
    OR approved_conversion IS NULL;
/* Obs: No null value in the data */

# Checking the nos. of distinct criteria
SELECT COUNT(DISTINCT ad_id), COUNT(DISTINCT xyz_campaign_id), COUNT(DISTINCT fb_campaign_id),
	COUNT(DISTINCT interest)
FROM kag_conversion_data;
/* Obs: Total of 1143 records of 691 FB ads belonging to 3 ad campaigns spanning 40 distinct interests. */

# Checking the trend of conversions by sex and age groups
SELECT age, gender, SUM(total_conversion), SUM(approved_conversion)
FROM kag_conversion_data
GROUP BY age, gender
ORDER BY age, gender;
/* Obs:
1. for age groups 30-34 and 35-39, males have more total conversions and approved conversions than females,
	but the trend is reversed for older age groups.
2. for both sexes, total conversions and approved conversions are highest for ages 30-34 and
	have lesser but almost constant values for the other age groups with a slight increase in 45-49.
*/

# Checking impressions and amount spent on ad by age and sex
SELECT age, gender, SUM(impressions), SUM(spent)
FROM kag_conversion_data
GROUP BY age, gender
#ORDER BY age, gender;
#ORDER BY 4 desc;
ORDER BY 3 desc;
/* Obs:
1. Females of each age group have more impressions than males, except for ages 30-34.
2. Impressions are highest for females in the ages 45-49, while 30-34 for males. No particular trend observed for other age groups.
*/

# Checking click to impression ratios and amount spent on ad spent by age and sex
SELECT age, gender, SUM(clicks)/SUM(impressions)*100 AS clicks_per_impression, SUM(spent)
FROM kag_conversion_data
GROUP BY age, gender
#ORDER BY age, gender;
#ORDER BY 3 DESC;
ORDER BY 4 DESC;
/*Obs:
1. The trends of click to impression ratio and amount spent by age-groups and sex do not align, which reveals that expenditure may be
spent more efficiently.
2. Females in the age groups 45-49, 40-44, 35-39 have the highest clickthrough rates.
3. Females aged 45-49, males aged 30-34 and females aged 30-34 have highest expenditure.
*/

# Checking click to impression ratio, total conversion, approved conversion by age
SELECT age,
	SUM(clicks)/SUM(impressions)*100 AS clicks_per_impression,
    SUM(total_conversion),
    SUM(approved_conversion)
FROM kag_conversion_data
GROUP BY age
ORDER BY 2 desc;
/*Obs:
1. Click to impression ratio increases with age.
2. However, total and approved conversions are highest in ages 30-34 by huge margins.
*/

# Checking click to impression ratio, total_conversions_per_person, and approved_conversions_per_person by sex
SELECT gender,
	SUM(clicks)/SUM(impressions)*100 AS clicks_per_impression,
    SUM(total_conversion)/COUNT(gender) AS total_conversions_per_person,
    SUM(approved_conversion)/COUNT(gender) AS approved_conversions_per_person
FROM kag_conversion_data
GROUP BY gender
ORDER BY 2 desc;
/*Obs:
1. Click to impression ratio is more in females.
2. However, approved conversions per person are higher in males.
3. Total conversions per person are almost same in both sexes.
*/

# Conversion trends for each company
SELECT xyz_campaign_id,
	SUM(total_conversion) AS total_conversion,
    SUM(approved_conversion) AS approved_conversion,
    SUM(approved_conversion)/SUM(total_conversion) AS percentage_of_total_conversions_approved
FROM kag_conversion_data
GROUP BY 1
ORDER BY 2 DESC;
/*Obs:
 1. Total, approved conversions are highest in companies 1178, followed by 936, then 916.
 2. However, the percentage of total conversions approved follows the opposite trend.
*/

# CLick to Impression ratio for each company
SELECT xyz_campaign_id,
	SUM(clicks)/SUM(impressions)*100 AS clicks_per_impression
FROM kag_conversion_data
GROUP BY 1
ORDER BY 2 DESC;
/*Obs:
 Click to impression ratio is highest in company 936, followed by 916, then 1178
*/

# Total Conversions per Click for each company
SELECT xyz_campaign_id,
    SUM(total_conversion)/SUM(clicks) AS total_conversions_per_click
FROM kag_conversion_data
GROUP BY 1
ORDER BY 2 DESC;
/*Obs:
 Click to impression ratio is highest in company 916, followed by 936, then 1178
*/

# CLick to Impression ratio by expenditure for each company
SELECT xyz_campaign_id,
	SUM(clicks)/(SUM(impressions)*SUM(spent))*100 AS clicks_to_impression_by_expenditure
FROM kag_conversion_data
GROUP BY 1
ORDER BY 2 DESC;
/*Obs:
 Click to impression ratio by expenditure is highest in company 916, followed by 936, then 1178
*/

# Total_conversion by expenditure for each company
SELECT xyz_campaign_id,
	SUM(total_conversion)/SUM(spent)*100 AS total_conversion_by_expenditure
FROM kag_conversion_data
GROUP BY 1
ORDER BY 2 DESC;
/*Obs:
 Total_conversion by expenditure is highest in company 916, followed by 936, then 1178
*/