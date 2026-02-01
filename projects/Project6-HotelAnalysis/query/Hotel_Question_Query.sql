-- Part 1: Customer Trends & Demographics


-- 1. What is the distribution of customers by top 10 origin country and market segment?
WITH base_data AS(
	SELECT sales_id, market_segment, dcc.country 
	FROM fact_bookings fb
	INNER JOIN dim_customers dc ON fb.customer_id = dc.id
	INNER JOIN dim_country_codes dcc ON dc.country = dcc.id
    WHERE reservation_status = 'Check-Out'
),
top_countries AS(
	SELECT country, COUNT(*) AS tot_bookings 
    FROM base_data
    GROUP BY country
    ORDER BY tot_bookings DESC
    LIMIT 10
),
segment_ranking AS(
	SELECT market_segment, tc.country, 
		   COUNT(*) AS seg_bookings,
		   ROUND(COUNT(*)*100/SUM(COUNT(*)) OVER(PARTITION BY country),2) AS booking_pct,
           ROW_NUMBER() OVER(PARTITION BY country ORDER BY COUNT(*) DESC) AS ranking
	FROM base_data bd
	INNER JOIN top_countries tc ON bd.country = tc.country
	GROUP BY market_segment, country
)
SELECT * FROM segment_ranking
WHERE ranking <=3
ORDER BY country;

-- 2. Which customer demographics or origins contribute most to total revenue and average daily rate (ADR)?
WITH base_data AS(
SELECT (daily_meal_cost + adr_booking)*(nightStays_weekend + nightStays_weekday) AS revenue,
	   dcc.country, adr_booking*(nightStays_weekend + nightStays_weekday) AS sum_adr,
       rooms*(nightStays_weekend + nightStays_weekday) AS tot_rooms
FROM fact_bookings fb
INNER JOIN vw_booking_meal_cost vw ON fb.sales_id = vw.sales_id
INNER JOIN dim_customers dc ON fb.customer_id = dc.id
INNER JOIN dim_country_codes dcc ON dc.country = dcc.id
WHERE reservation_status = 'Check-Out'
)
SELECT country, 
	   ROUND(SUM(revenue)*100/(SUM(SUM(revenue)) OVER()),2) AS revenue_pct, 
       ROUND(SUM(sum_adr)/SUM(tot_rooms),2) AS avg_ADR FROM base_data
GROUP BY country
ORDER BY revenue_pct DESC
LIMIT 10;

-- 3. How many customer accounts have high frequency vs low frequency guests, and how does their average spend and ADR differ?
WITH base_data AS(
SELECT (daily_meal_cost + adr_booking)*(nightStays_weekend + nightStays_weekday) AS revenue,
	   dcc.country, adr_booking*(nightStays_weekend + nightStays_weekday) AS adr_total,
       rooms*(nightStays_weekend + nightStays_weekday) AS rooms,
       customer_id
FROM fact_bookings fb
INNER JOIN vw_booking_meal_cost vw ON fb.sales_id = vw.sales_id
INNER JOIN dim_customers dc ON fb.customer_id = dc.id
INNER JOIN dim_country_codes dcc ON dc.country = dcc.id
WHERE reservation_status = 'Check-Out'
),
customer_frequency AS(
	SELECT customer_id, COUNT(*) AS tot_bookings, NTILE(4) OVER(ORDER BY COUNT(*) DESC) AS 3rdTile
    FROM base_data
    GROUP BY customer_id
),
customer_type AS(
	SELECT customer_id, tot_bookings,
		   CASE
				WHEN 3rdTile = 1 THEN 'Very High'
                WHEN 3rdTile = 2 THEN 'High'
                WHEN 3rdTile = 3 THEN 'Medium'
                ELSE 'Low'
		   END AS customer_type
	FROM customer_frequency
)
SELECT customer_type,
	   ROUND(COUNT(*)*100/SUM(COUNT(*)) OVER(),2) AS bookings_pct,
       ROUND(SUM(revenue)*100/(SUM(SUM(revenue)) OVER()),2) AS revenue_pct, 
       ROUND(SUM(adr_total)/SUM(rooms),2) AS avg_ADR
FROM customer_type ct
INNER JOIN base_data bd ON ct.customer_id = bd.customer_id
GROUP BY customer_type
ORDER BY bookings_pct DESC;

-- 4. Who are the top B2B client types by revenue, and how do they differ between resort vs. city hotels?
WITH b2b_revenue AS(
SELECT dh.type AS hotel_type, da.type AS b2b_client_type,
	   ROUND(SUM((adr_booking + daily_meal_cost)*(nightStays_weekend + nightStays_weekday))/1000,2) AS `revenue(in Thousand)`
FROM fact_bookings fb
INNER JOIN vw_booking_meal_cost bmc ON fb.sales_id = bmc.sales_id
INNER JOIN dim_agent da ON da.agent_id = fb.agent_id
INNER JOIN dim_hotel dh ON fb.hotel_id = dh.id 
WHERE reservation_status = 'Check-Out' AND client_name <> 'Nil'
GROUP BY dh.type, da.type
)
SELECT hotel_type, b2b_client_type,
	   `revenue(in Thousand)`,
       ROUND(`revenue(in Thousand)`*100/SUM(`revenue(in Thousand)`) OVER(PARTITION BY hotel_type),2) revenue_share_pct
FROM b2b_revenue;

-- 5. Which customer segments deliver the most stable and operationally efficient revenue(low cancellations, shorter lead times, fewer booking changes?
WITH overall_bookings AS(
	SELECT market_segment,
		   COUNT(*) AS tot_bookings,
           SUM(is_cancelled) AS sum_cancelled,
           SUM(booking_changes) AS sum_booking_changes
	FROM fact_bookings
    GROUP BY market_segment
),
completed_bookings AS(
	SELECT market_segment, 
		   COUNT(*) AS checkOut_bookings,
		   SUM((daily_meal_cost + adr_booking)*(nightStays_weekend + nightStays_weekday)) AS revenue,
           SUM(lead_time) AS sum_lead_time
	FROM fact_bookings fb 
    INNER JOIN vw_booking_meal_cost vw ON fb.sales_id = vw.sales_id
    WHERE reservation_status = 'Check-Out'
    GROUP BY market_segment
)
SELECT cb.market_segment,
	   ROUND(revenue*100/SUM(revenue) OVER(),2) AS revenue_pct,
       COALESCE(ROUND(sum_cancelled*100/NULLIF(tot_bookings,0),2),0) AS cancellation_rate,
       COALESCE(ROUND(sum_lead_time/NULLIF(checkOut_bookings,0),2),0) AS avg_lead_time,
       COALESCE(ROUND(sum_booking_changes/NULLIF(tot_bookings,0),2),0) AS avg_booking_changes
FROM overall_bookings ob
INNER JOIN completed_bookings cb ON ob.market_segment = cb.market_segment
ORDER BY revenue_pct DESC;


-- Part 2: Booking Patterns & Behaviour


-- 1. What are the monthly booking and revenue trends across years?
WITH monthly_stats AS
(
	SELECT YEAR(arrival_date) AS year, MONTH(arrival_date) month, MONTHNAME(arrival_date) AS month_Name,
		   COUNT(*) AS tot_bookings,
           SUM((adr_booking + daily_meal_cost)*(nightStays_weekend + nightStays_weekday)) AS tot_rev
	FROM fact_bookings fb
	JOIN vw_booking_meal_cost bmc ON fb.sales_id = bmc.sales_id
	WHERE reservation_status = 'Check-Out'
	GROUP BY YEAR(arrival_date), MONTH(arrival_date), MONTHNAME(arrival_date)
),
growth_stats AS
(
	SELECT year, month, month_name, tot_bookings, tot_rev,
    LAG(tot_bookings, 1) OVER(ORDER BY year, month) AS prev_month_bookings,
    LAG(tot_bookings, 1) OVER(PARTITION BY month ORDER BY year) AS prev_year_bookings,
    LAG(tot_rev, 1) OVER(ORDER BY year, month) AS prev_month_rev,
    LAG(tot_rev, 1) OVER(PARTITION BY month ORDER BY year) AS prev_year_rev
    FROM monthly_stats
)
SELECT year, month_name,
	   tot_bookings, 
	   COALESCE(ROUND((tot_bookings - prev_month_bookings)*100/NULLIF(prev_month_bookings, 0), 2),0) AS bookings_MoM,
	   COALESCE(ROUND((tot_bookings - prev_year_bookings)*100/NULLIF(prev_year_bookings,0), 2),0) AS bookings_YoY,
	   tot_rev,
	   COALESCE(ROUND((tot_rev - prev_month_rev)*100/NULLIF(prev_month_rev,0), 2),0) AS revenue_MoM,
	   COALESCE(ROUND((tot_rev - prev_year_rev)*100/NULLIF(prev_year_rev,0), 2),0) AS revenue_YoY
FROM growth_stats
ORDER BY year, month;

-- 2. How do lead time, deposit type, distribution channel and booking changes affect cancellation likelihood?
WITH enriched_bookings AS(
	SELECT deposit_type, distribution_channel, is_cancelled,
		   CASE
			WHEN lead_time <= 30 THEN 'Low'
            WHEN lead_time <= 120 THEN 'Medium'
            ELSE 'High'
		   END AS lead_time_bucket,
           CASE 
			WHEN booking_changes = 0 THEN 'No Changes'
            WHEN booking_changes BETWEEN 1 AND 3 THEN 'Few Changes'
            ELSE 'Many Changes'
		   END AS booking_changes_bucket
	FROM fact_bookings
)
SELECT deposit_type, distribution_channel,
	   lead_time_bucket, booking_changes_bucket,
       COUNT(*) AS tot_bookings,
       SUM(is_cancelled) AS tot_cancelled,
       ROUND(SUM(is_cancelled)*100/NULLIF(COUNT(*),0),2) AS cancellation_rate
FROM enriched_bookings
GROUP BY deposit_type, distribution_channel,
		 lead_time_bucket, booking_changes_bucket
ORDER BY tot_bookings DESC, cancellation_rate;

-- 3. Which distribution channels and market segments generate the highest ADR and occupancy?
WITH RECURSIVE dates AS
(
	SELECT MIN(arrival_date) AS dat FROM fact_bookings
    
    UNION ALL
    
    SELECT ADDDATE(dat, 1) 
    FROM dates 
    WHERE ADDDATE(dat, 1) <= (SELECT MAX(ADDDATE(arrival_date, GREATEST(nightStays_weekend + nightStays_weekday - 1, 0))) FROM fact_bookings) 
),
bookings AS
(
	SELECT dat, hotel_id, rooms, adr_booking, distribution_channel, market_segment, nightStays_weekend, nightStays_weekday
    FROM fact_bookings fb
    LEFT JOIN dates d ON
    dat BETWEEN arrival_date AND ADDDATE(arrival_date, GREATEST(nightStays_weekend + nightStays_weekday - 1, 0))
    WHERE reservation_status = 'Check-Out'
),
occupied_stats AS
(
	SELECT dat, hotel_id, distribution_channel, market_segment,
		   SUM(b.rooms) AS used_rooms, 
           SUM(adr_booking) AS adr 
	FROM bookings b
	JOIN dim_hotel dh ON b.hotel_id = dh.id
    WHERE nightStays_weekend + nightStays_weekday <> 0
	GROUP BY dat, hotel_id, distribution_channel, market_segment
),
available_status AS(
	SELECT dat, hotel_id, MAX(dh.rooms) AS available 
    FROM bookings b
    JOIN dim_hotel dh ON b.hotel_id = dh.id
    GROUP BY dat, hotel_id
)
SELECT distribution_channel, market_segment, 
	   ROUND(SUM(used_rooms)*100/(SELECT SUM(available) FROM available_status),4) AS occupancy_rate, -- Add potential distinct(dates) * rooms
       ROUND(SUM(adr)/SUM(used_rooms),2) AS avg_adr
FROM occupied_stats
GROUP BY distribution_channel, market_segment
ORDER BY distribution_channel, occupancy_rate DESC;

-- 4. Which customer types drive revenue within each booking channel?
SELECT distribution_channel, customer_type,
    SUM((adr_booking + daily_meal_cost)*(nightStays_weekend + nightStays_weekday)) AS revenue,
    ROUND(
        SUM((adr_booking + daily_meal_cost)*(nightStays_weekend + nightStays_weekday))* 100.0
        / SUM(SUM((adr_booking + daily_meal_cost)*(nightStays_weekend + nightStays_weekday))) OVER (PARTITION BY distribution_channel),
        2
    ) AS revenue_share_pct
FROM fact_bookings fb
JOIN vw_booking_meal_cost bmc ON fb.sales_id = bmc.sales_id
WHERE reservation_status = 'Check-Out'
GROUP BY distribution_channel, customer_type
ORDER BY distribution_channel, revenue DESC;

-- 5. What are the top 10 booking agents by number of bookings, ADR, and cancellation rate?
WITH RECURSIVE agent_data AS(
	SELECT agent_id,
		   SUM(is_cancelled)*100/COUNT(*) AS cancellation_rate,
           COUNT(CASE WHEN reservation_status = 'Check-Out' THEN sales_id END) AS completed_bookings,
		   SUM(CASE WHEN reservation_status = 'Check-Out' THEN (nightStays_weekend + nightStays_weekday)*adr_booking END)/
		   SUM(CASE WHEN reservation_status = 'Check-Out' THEN (nightStays_weekend + nightStays_weekday)*rooms END)
           AS avg_ADR
	FROM fact_bookings
    WHERE agent_id <> 31 -- Agent 31 is considered direct booking without use of agent
	GROUP BY agent_id
),
rankings AS
(
	SELECT agent_id,
		   ROW_NUMBER() OVER(ORDER BY completed_bookings DESC) AS booking_rank,
           ROW_NUMBER() OVER(ORDER BY avg_adr DESC) AS adr_rank,
           ROW_NUMBER() OVER(ORDER BY cancellation_rate) AS cancellationRate_rank
	FROM agent_data
),
rank_table(n, booking_agent_id, adr_agent_id, cancellationRate_agent_id) AS
(
	SELECT 1 AS n, 
    (SELECT agent_id FROM rankings WHERE booking_rank = 1),
    (SELECT agent_id FROM rankings WHERE adr_rank = 1),
    (SELECT agent_id FROM rankings WHERE cancellationRate_rank = 1)
    
    UNION ALL
    
    SELECT n + 1, 
    (SELECT agent_id FROM rankings WHERE booking_rank = n + 1),
    (SELECT agent_id FROM rankings WHERE adr_rank = n + 1),
    (SELECT agent_id FROM rankings WHERE cancellationRate_rank = n + 1)
    FROM rank_table
    WHERE n +1 <= 10
)
SELECT n AS ranks, daB.first_name AS name_booking, daA.first_name AS name_adr, daC.first_name AS name_cancellationRt FROM rank_table rt
JOIN dim_agent daB ON rt.booking_agent_id = daB.agent_id
JOIN dim_agent daA ON rt.adr_agent_id = daA.agent_id
JOIN dim_agent daC ON rt.cancellationRate_agent_id = daC.agent_id;


-- Part 3 - Popularity, Market Positioning & Revenue Performance


-- 1. Which hotels consistently rank highest in total revenue, ADR, and number of bookings?
WITH year_months_hotel_metrics AS(
	SELECT hotel_id, DATE_FORMAT(arrival_date, '%Y-%m') AS year_months,
	       COUNT(*) AS tot_bookings,
           ROUND(
				SUM(adr_booking*(nightStays_weekend + nightStays_weekday))/
				NULLIF(SUM(rooms*(nightStays_weekend + nightStays_weekday)),0) 
           ,2) AS avg_adr,
           SUM((adr_booking + daily_meal_cost)*(nightStays_weekend + nightStays_weekday)) AS total_revenue
	FROM fact_bookings fb
	JOIN vw_booking_meal_cost bmc ON fb.sales_id = bmc.sales_id
	WHERE reservation_status = 'Check-Out'
	GROUP BY hotel_id, year_months
),
year_months_hotels_rankings AS(
	SELECT hotel_id,
		   RANK() OVER (PARTITION BY year_months ORDER BY tot_bookings DESC) AS bookings_rank,
           RANK() OVER (PARTITION BY year_months ORDER BY avg_adr DESC) AS adr_rank,
           RANK() OVER (PARTITION BY year_months ORDER BY total_revenue DESC) AS revenue_rank
	FROM year_months_hotel_metrics
)
SELECT hotel,
	   ROUND(SUM(CASE WHEN bookings_rank <= 3 THEN 1 ELSE 0 END)*100/COUNT(*),2) AS top3_pct_bookings,
       ROUND(SUM(CASE WHEN adr_rank <= 3 THEN 1 ELSE 0 END)*100/COUNT(*),2) AS top3_pct_adr,
       ROUND(SUM(CASE WHEN revenue_rank <= 3 THEN 1 ELSE 0 END)*100/COUNT(*),2) AS top3_pct_revenue,
       ROUND((1/AVG(bookings_rank))*0.4 + (1/AVG(adr_rank))*0.2 + (1/AVG(revenue_rank))*0.4,2) AS consistency_score
FROM year_months_hotels_rankings hr
INNER JOIN dim_hotel dh ON hr.hotel_id = dh.id 
GROUP BY hotel_id
ORDER BY consistency_score DESC, top3_pct_revenue DESC;

-- 2. How does a hotel’s global revenue rank differ from its rank within each market segment?
WITH hotel_revenue AS(
	SELECT hotel_id, market_segment,
		   SUM((adr_booking + daily_meal_cost)*(nightStays_weekend + nightStays_weekday)) AS revenue
	FROM fact_bookings fb
    JOIN vw_booking_meal_cost bmc ON fb.sales_id = bmc.sales_id
    JOIN dim_hotel dh ON fb.hotel_id = dh.id
    WHERE reservation_status = 'Check-Out'
    GROUP BY hotel_id, market_segment
),
global_ranking AS (
    SELECT 
        hotel_id,
        SUM(revenue) AS global_revenue,
        RANK() OVER (ORDER BY SUM(revenue) DESC) AS global_rank
    FROM hotel_revenue
    GROUP BY hotel_id
),
market_ranking AS(
	SELECT hotel_id, market_segment,
		   SUM(revenue) AS tot_revenue,
           RANK() OVER(PARTITION BY market_segment ORDER BY SUM(revenue) DESC) AS market_segment_rank
	FROM hotel_revenue
    GROUP BY hotel_id, market_segment
)
SELECT gr.hotel_id, hotel, 
	   market_segment,
       global_rank,
       market_segment_rank,
       CAST(market_segment_rank AS SIGNED) - CAST(global_rank AS SIGNED) AS market_segment_rank_shift
FROM market_ranking mr 
INNER JOIN global_ranking gr ON gr.hotel_id = mr.hotel_id
INNER JOIN dim_hotel dh ON dh.id = gr.hotel_id;

-- 3. Which hotels show the highest YoY growth in ADR and completed bookings?
WITH hotel_data AS(
	SELECT hotel_id, YEAR(arrival_date) AS years,
		   COUNT(*) AS completed_bookings,
		   SUM(adr_booking*(nightStays_weekend + nightStays_weekday))/
           SUM(rooms*(nightStays_weekend + nightStays_weekday)) AS avg_adr
	FROM fact_bookings
    WHERE reservation_status = 'Check-Out'
    GROUP BY hotel_id, years
),
hotel_compare AS(
	SELECT hotel_id, years,
		   completed_bookings, 
           LAG(completed_bookings, 1) OVER(PARTITION BY hotel_id ORDER BY years) AS prev_bookings,
           avg_adr, LAG(avg_adr, 1) OVER(PARTITION BY hotel_id ORDER BY years) AS prev_adr
	FROM hotel_data
),
hotel_YoY AS(
	SELECT hotel_id, years,
		   completed_bookings, (completed_bookings - prev_bookings)/NULLIF(prev_bookings,0) AS bookings_YoY,
		   ROUND(avg_adr,2) AS adr, (avg_adr - prev_adr)/NULLIF(prev_adr,0) AS adr_YoY
	FROM hotel_compare
	WHERE years <> (SELECT MIN(years) FROM hotel_data)
)
SELECT hotel, 
	   ROUND(AVG(bookings_YoY)*100,2) AS avg_bookings_yoy_pct,
       ROUND(AVG(adr_YoY)*100,2) AS avg_adr_yoy_pct,
       ROUND(0.6 * AVG(bookings_yoy) + 0.4 * AVG(adr_yoy), 2) AS growth_score,
       RANK() OVER(ORDER BY ROUND(0.6 * AVG(bookings_yoy) + 0.4 * AVG(adr_yoy), 2) DESC) AS growth_rank
FROM hotel_YoY hy
INNER JOIN dim_hotel dh ON dh.id = hy.hotel_id
GROUP BY hotel_id order by hotel_id;

-- 4. How does each hotel’s revenue based market share contribution evolve across years?
WITH hotel_revenue AS(
	SELECT hotel_id, YEAR(arrival_date) AS years,
           SUM((adr_booking + daily_meal_cost)*(nightStays_weekend + nightStays_weekday)) AS revenue
    FROM fact_bookings fb
    JOIN vw_booking_meal_cost bmc ON fb.sales_id = bmc.sales_id
    JOIN dim_hotel dh ON fb.hotel_id = dh.id
    WHERE reservation_status = 'Check-Out'
    GROUP BY hotel_id, years
),
hotel_mktShare AS(
	SELECT hotel_id, years, revenue,
		   revenue/NULLIF(SUM(revenue) OVER(PARTITION BY years), 0) AS mkt_share
	FROM hotel_revenue
),
hotel_compare AS(
	SELECT *,
		   LAG(mkt_share) OVER(PARTITION BY hotel_id ORDER BY years) AS prev_mkt_share
	FROM hotel_mktShare
)
select hotel, years,
	   ROUND(mkt_share*100,2) AS mkt_share_pct,
	   ROUND((mkt_share - prev_mkt_share)*100/NULLIF(prev_mkt_share,0),2) AS share_change
FROM hotel_compare hc
JOIN dim_hotel dh ON hc.hotel_id = dh.id
WHERE prev_mkt_share IS NOT NULL
ORDER BY hotel, years;

-- 5. What are the top-performing(revenue, adr, bookings) room types for each hotel segment
WITH room_data AS(
	SELECT assigned_room_id, dh.type,
		   COUNT(*) AS bookings,
		   SUM((adr_booking + daily_meal_cost)*(nightStays_weekend + nightStays_weekday)) AS revenue,
           SUM(adr_booking*(nightStays_weekend + nightStays_weekday))/
           SUM(fb.rooms*(nightStays_weekend + nightStays_weekday)) AS avg_adr
	FROM fact_bookings fb 
    JOIN vw_booking_meal_cost bmc ON fb.sales_id = bmc.sales_id
    JOIN dim_hotel dh ON fb.hotel_id = dh.id
    WHERE reservation_status = 'Check-Out'
    GROUP BY assigned_room_id, dh.type
),
room_rankings AS(
	SELECT type, assigned_room_id, 
		   bookings, RANK() OVER(PARTITION BY type ORDER BY bookings DESC) AS bookings_rank,
		   revenue, RANK() OVER(PARTITION BY type ORDER BY revenue DESC) AS revenue_rank,
		   avg_adr, RANK() OVER(PARTITION BY type ORDER BY avg_adr DESC) AS adr_rank
	FROM room_data
),
performance_rankings AS(
	SELECT type, assigned_room_id,
		   bookings, revenue, avg_adr, bookings_rank, revenue_rank, adr_rank,
		   ((1/bookings_rank)*0.4) + ((1/revenue_rank)*0.4) + ((1/adr_rank)*0.2) AS performance_rating,
		   RANK() OVER(PARTITION BY type 
				ORDER BY (1/bookings_rank)*0.4 + (1/revenue_rank)*0.4 + (1/adr_rank)*0.2 DESC) AS performance_rank
FROM room_rankings
)
SELECT code, category, type, performance_rank,
	   bookings, revenue, avg_adr
FROM performance_rankings pr
INNER JOIN dim_rooms dr ON pr.assigned_room_id = dr.id
WHERE performance_rank <= 5
ORDER BY type, performance_rank;
