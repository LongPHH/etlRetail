
  
    

    create or replace table `personal-419821`.`retail`.`dim_customer`
    
    

    OPTIONS()
    as (
      -- Dimension table for customer
WITH customer_cte AS (
	SELECT DISTINCT
	    to_hex(md5(cast(coalesce(cast(CustomerID as STRING), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(Country as STRING), '_dbt_utils_surrogate_key_null_') as STRING))) as customer_id,
	    Country AS country
	FROM `personal-419821`.`retail`.`raw_invoices`
	WHERE CustomerID IS NOT NULL
)
SELECT
    t.*,
	cm.iso
FROM customer_cte t
LEFT JOIN `personal-419821`.`retail`.`country` cm ON t.country = cm.nicename
    );
  