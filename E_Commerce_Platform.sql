
/* Business model Customer to Customer (C2C) allows customers to do business with each other. 
This model is growing fast with e-commerce platforms where sellers may be required to pay some amount and buyer can buy 
it without paying anything. E-Commerce website brings the seller and buyer to the same platform. Analyzing the user's database 
will lead to understanding the business perspective. Behavior of the users can be traced in terms of business with exploration
 of the user’s database. 

Dataset: One .csv file with name users_data with 98913 rows and 27 columns
*/
-- Tasks to be performed

-- 1.  Create new schema as ecommerce.
create database ecommerce;

-- 2.  Import .csv file users_data into MySQL. 
/*    
		-- After creating a database.
		-- Import the csv file into Database.
		-- click the right hand of the mouse and click the Table_Data_Import_Wizard
        -- After that select the file path
        -- Then follow few steps to import csv file data.
		-- Importing process was done and use the database.
*/
use ecommerce;
show tables;


-- 3. Run SQL command to see the structure of table.
use ecommerce;
desc users_data;


-- 4. Run SQL command to select first 100 rows of the database.
use ecommerse;
select * from users_data;  ## for all rows
select * from users_data limit 100;  ## for 100 rows


-- 5. How many distinct values exist in table for field country and language.
use ecommerce;
SELECT 
    COUNT(DISTINCT country) No_of_Countries,
    COUNT(DISTINCT language) No_of_Languages
FROM
    users_data;


-- 6. Check whether male users are having maximum followers or female users.
use ecommerce;
SELECT 
    gender, MAX(socialNbFollowers)
FROM
    users_data
GROUP BY gender;

/*
-- 7. Calculate the total users those
		a.Uses Profile Picture in their Profile
		b.Uses Application for Ecommerce platform
		c.Uses Android app
		d.Uses ios app
*/
-- Solution --
use ecommerce;
SELECT COUNT(hasProfilePicture) as Total_users_uses_Profile_Picture FROM users_data WHERE hasProfilePicture = 'true';    
select count(hasAnyApp) as Total_Users_having_Ecommerce_Application from users_data where hasAnyApp = 'true';
select count(hasAndroidApp) as Total_Users_using_Android_App from users_data where hasAndroidApp = 'true';
select count(hasIosApp) as Total_Users_using_Ios_App from users_data where hasIosApp = 'true';


-- 8. Calculate the total number of buyers for each country and sort the result in descending order of total number of buyers.
use ecommerce;
SELECT 
    COUNT(productsbought) as products_bought, country
FROM
    users_data
WHERE
    productsbought != 0
GROUP BY country
ORDER BY COUNT(productsbought) DESC;


-- 9. Calculate the average number of sellers for each country and sort the result in ascending order of total number of sellers.
use ecommerce;
SELECT 
    AVG(productssold), country
FROM
    users_data
WHERE
    productssold != 0
GROUP BY country
ORDER BY COUNT(productssold) ASC;


-- 10. Display name of top 10 countries having maximum products pass rate.
use ecommerce;
SELECT DISTINCT
    (country) country, MAX(productspassrate)
FROM
    users_data
GROUP BY country
ORDER BY MAX(productspassrate) DESC
LIMIT 10;


-- 11. Calculate the number of users on an ecommerce platform for different language choices.
use ecommerce;
SELECT 
    language, COUNT(hasAnyApp) AS no_of_users
FROM
    users_data
WHERE
    hasAnyApp = 'true'
GROUP BY language;

-- 12. Check the choice of female users about putting the product in a wishlist or to like socially on an ecommerce platform.
-- Solution--
use ecommerce;
select * from users_data;
SELECT 
    SUM(productsWished), SUM(socialProductsLiked)
FROM
    users_data
WHERE
    gender = 'F' AND hasanyapp = 'true';


-- 13. Check the choice of male users about being seller or buyer.
-- Solution--
SELECT 
    COUNT(productssold) Products_Sold
FROM
    users_data
WHERE
    gender = 'M' AND productsSold != 0 
UNION SELECT 
    COUNT(productsBought) productsbought
FROM
    users_data
WHERE
    gender = 'M' AND productsBought != 0;
    
    
-- 14. Which country is having maximum number of buyers?
-- Solution-- 
use ecommerce;
SELECT 
    productsbought, country
FROM
    users_data
WHERE
    productsbought = (SELECT 
            MAX(productsbought)
        FROM
            users_data)
GROUP BY country;


-- 15. List the name of 10 countries having zero number of sellers.
-- Solution--
use ecommerce;
SELECT DISTINCT
    (country), productsSold
FROM
    users_data
WHERE
    productsSold = 0
LIMIT 10;


-- 16. Display record of top 110 users who have used ecommerce platform recently.
-- Solution--
use ecommerce;
SELECT 
    *
FROM
    users_data
WHERE
    hasanyapp = 'true'
ORDER BY seniority DESC
LIMIT 110; 


-- 17. Calculate the number of female users those who have not logged in since last 100 days.
-- Solution--
use ecommerse;
SELECT 
    COUNT(type) AS No_of_Female_Users
FROM
    users_data
WHERE
    gender = 'f'
        AND daysSinceLastLogin >= 100;


-- 18. Display the number of female users of each country at ecommerce platform.
-- Solution--
use ecommerce;
SELECT 
    COUNT(type) Female_Users, country
FROM
    users_data
WHERE
    gender = 'f' AND hasAnyApp = 'true'
GROUP BY country;


-- 19. Display the number of male users of each country at ecommerce platform.
-- Solution--
use ecommerce;
SELECT 
    COUNT(type) Male_Users, country
FROM
    users_data
WHERE
    gender = 'm' AND hasAnyApp = 'true'
GROUP BY country;



-- 20. Calculate the average number of products sold and bought on ecommerce platform by male users for each country.
-- Solution--
use ecommerce;
SELECT 
    country, AVG(productsSold) Avg_Products_Sold, AVG(productsBought) Avg_Products_Bought
FROM
    users_data
WHERE
    gender = 'M' AND hasanyapp = 'true'
GROUP BY country;


------------------------------              			  ****  END ****						---------------------------------









