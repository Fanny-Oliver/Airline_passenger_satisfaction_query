-- to clean the data, Check for duplicate id: no duplicates
SELECT DISTINCT ID
FROM `my-maven-projects.Airline_data.Passenger_satisfaction` 

--to get the number of male and female customers
SELECT 
 Gender,
 COUNT (Gender) AS count_of_gender
FROM `my-maven-projects.Airline_data.Passenger_satisfaction`
GROUP BY Gender

--to find the percentage of customers that are satisfied:
SELECT COUNT(Satisfaction) AS total_satisfaction_number, 
  (
    (SELECT COUNT (Satisfaction)
    FROM `my-maven-projects.Airline_data.Passenger_satisfaction`  
    WHERE Satisfaction = "Satisfied")
  ) 
  AS satisfied_num,
ROUND ((SELECT COUNT (Satisfaction) FROM `my-maven-projects.Airline_data.Passenger_satisfaction` WHERE Satisfaction = "Satisfied")/COUNT(Satisfaction)*100, 2) AS satisfied_percentage
FROM `my-maven-projects.Airline_data.Passenger_satisfaction` 

--create temporary tables and join the tables to find the percentage of returning and first-time customers that are satisfied
WITH
satifaction_level AS
(
SELECT 
Customer_Type,
Satisfaction,
COUNT (Customer_Type) AS count_of_customer_type
FROM `my-maven-projects.Airline_data.Passenger_satisfaction` 
GROUP BY Customer_Type, Satisfaction
),
 Total_satisfaction AS -- this second temp table is needed to get the total of each customer according to their type
(
SELECT Customer_Type,
COUNT (Customer_Type) AS total_count_of_customers,
FROM `my-maven-projects.Airline_data.Passenger_satisfaction`
GROUP BY Customer_Type
) 
SELECT satifaction_level.Customer_Type,
satifaction_level.count_of_customer_type AS total_satisfied_customers,
Total_satisfaction.total_count_of_customers,
ROUND ((satifaction_level.count_of_customer_type/Total_satisfaction.total_count_of_customers)*100, 2) AS percentage
FROM Total_satisfaction
FULL OUTER JOIN satifaction_level ON satifaction_level.Customer_Type =  Total_satisfaction.Customer_Type
WHERE satisfaction = 'Satisfied'

--create temporary tables and join the tables to find the percentage of customer satisfaction based ON travel_type
WITH
satifaction_level AS
(
SELECT 
Type_of_Travel,
Satisfaction,
COUNT (Type_of_Travel) AS count_of_type_of_travel
FROM `my-maven-projects.Airline_data.Passenger_satisfaction` 
GROUP BY Type_of_Travel, Satisfaction
),
 Total_satisfaction AS -- this 2nd temp table is needed to get the total of each travel type
(
SELECT Type_of_Travel,
COUNT (Type_of_Travel) AS total_count_of_travel_type,
FROM `my-maven-projects.Airline_data.Passenger_satisfaction`
GROUP BY Type_of_Travel
) 
SELECT satifaction_level.Type_of_Travel,
satifaction_level.count_of_type_of_travel AS total_satisfied_cusomers,

Total_satisfaction.total_count_of_travel_type, -- i used the temp table to then find the percentages
ROUND((satifaction_level.count_of_type_of_travel/Total_satisfaction.total_count_of_travel_type)*100, 2) AS percentage
FROM Total_satisfaction
FULL OUTER JOIN satifaction_level ON satifaction_level.Type_of_Travel =  Total_satisfaction.Type_of_Travel
WHERE satisfaction = 'Satisfied'

--to find the customer profile of a repeating airline passenger
SELECT Gender, Type_of_Travel AS travel_type, Class AS class_type,
MIN(Age) AS min_age,
MAX(Age) AS max_age
FROM `my-maven-projects.Airline_data.Passenger_satisfaction`
WHERE Customer_Type = 'Returning'
GROUP BY Gender, Type_of_Travel, Class
ORDER BY Gender

--to calculate the average of every service offered by the flight service:
SELECT AVG(Departure_and_Arrival_Time_Convenience) AS avg_departure_and_arival_time_convenience,
AVG(Ease_of_Online_Booking) AS avg_ease_of_online_booking,
AVG(Check_in_Service) AS avg_check_in_service,
AVG(Online_Boarding) AS avg_online_boarding,
AVG(Gate_Location) AS avg_gate_location,
AVG(On_board_Service) AS avg_onboard_service,
AVG(Seat_Comfort) AS avg_seat_handling,
AVG(Leg_Room_Service) AS avg_leg_room_service,
AVG(Cleanliness) AS avg_cleanliness,
AVG(Food_and_Drink) AS avg_food_and_drink,
AVG(In_flight_Service) AS avg_inflight_service,
AVG(In_flight_Wifi_Service) AS avg_inflight_wifi_service,
AVG(In_flight_Entertainment) AS avg_inflight_entertainment,
AVG(Baggage_Handling) AS avg_baggage_handling
FROM `my-maven-projects.Airline_data.Passenger_satisfaction`

--calculate the percentage of people according to gender;
SELECT  
 Gender AS distinct_gender,
 COUNT (Gender) AS count_of_gender,
 (
   SELECT COUNT (ID) FROM `my-maven-projects.Airline_data.Passenger_satisfaction`
 ) AS total_customer,
 ROUND ((COUNT (Gender)/(SELECT COUNT (ID) FROM `my-maven-projects.Airline_data.Passenger_satisfaction`))*100,0) AS percentage
FROM `my-maven-projects.Airline_data.Passenger_satisfaction`
GROUP BY Gender

--calculate the percentage of people according to travel type;
SELECT  
 Type_of_Travel,
 COUNT (Type_of_Travel) AS count_type_of_travel,
 (
   SELECT COUNT (ID) FROM `my-maven-projects.Airline_data.Passenger_satisfaction`
 ) AS total_customers,
 ROUND ((COUNT (Type_of_Travel)/(SELECT COUNT (ID) FROM `my-maven-projects.Airline_data.Passenger_satisfaction`))*100,0) AS percentage
FROM `my-maven-projects.Airline_data.Passenger_satisfaction`
GROUP BY Type_of_Travel

--calculate the percentage of people according class type;
SELECT  
 Class,
 COUNT (Class) AS count_of_class,
 (
   SELECT COUNT (ID) FROM `my-maven-projects.Airline_data.Passenger_satisfaction`
 ) AS total_customers,
ROUND((COUNT (Class)/(SELECT COUNT (ID) FROM `my-maven-projects.Airline_data.Passenger_satisfaction`)) *100,0) AS percentage
FROM `my-maven-projects.Airline_data.Passenger_satisfaction`
GROUP BY Class

--calculate the percentage of people according to age group; use case to divide the ages
--start by making a temp table where we can define the age groups
WITH age_group_table AS (
SELECT 
CASE
WHEN Age >7 and Age <=12 THEN "Child"
WHEN Age >=13 and Age <=17 THEN "Teenager"
WHEN Age >=18 and Age <=50 THEN "Adult"
ELSE "Senior citizen"
END AS age_group,
FROM `my-maven-projects.Airline_data.Passenger_satisfaction`
)

SELECT age_group, COUNT(age_group) AS count_of_each_age_group,
(
  SELECT COUNT (ID) FROM `my-maven-projects.Airline_data.Passenger_satisfaction`
) AS total_age,
ROUND((COUNT (age_group)/(SELECT COUNT (ID) FROM `my-maven-projects.Airline_data.Passenger_satisfaction`)) *100,0) AS percentage
FROM age_group_table
GROUP BY age_group