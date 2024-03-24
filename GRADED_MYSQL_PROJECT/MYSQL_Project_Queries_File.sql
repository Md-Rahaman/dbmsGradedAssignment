/*3) Display the total number of customers based on gender who have placed individual orders of worth at least Rs.3000.*/

SELECT c.CUS_GENDER, COUNT(*) AS Total_Customers_order
FROM order_ O
JOIN customer C ON O.CUS_ID = C.CUS_ID
WHERE O.ORD_AMOUNT >= 3000
GROUP BY c.CUS_GENDER;


/* 4) Display all the orders along with product name ordered by a customer having Customer_Id=2 */

select o.* ,p.PRO_NAME from
order_ o join supplier_pricing s on o.PRICING_ID=s.PRICING_ID 
join product p on s.PRO_ID=p.PRO_ID  where o.CUS_ID=2;


/* 5) Display the Supplier details who can supply more than one product. */

select * from supplier s join supplier_pricing sp on  s.SUPP_ID=sp.SUPP_ID
join product p on sp.PRO_ID=p.PRO_ID;



/*6) Create a view as lowest_expensive_product and display the least expensive product from each category and print the table
 with category id, name, product name and price of the product. */

CREATE VIEW lowest_expensive_product AS
SELECT CAT_ID, CAT_NAME, PRO_NAME, SUPP_PRICE
FROM (
    SELECT c.CAT_ID, c.CAT_NAME, p.PRO_NAME, sp.SUPP_PRICE,
           ROW_NUMBER() OVER(PARTITION BY c.CAT_ID ORDER BY sp.SUPP_PRICE) AS price_rank
    FROM category c
    JOIN product p ON c.CAT_ID = p.CAT_ID
    JOIN supplier_pricing sp ON p.PRO_ID = sp.PRO_ID
) AS ranked_products
WHERE price_rank = 1;

 drop view lowest_expensive_product;
 select * from lowest_expensive_product;
 
 
 
/* 7) Display the Id and Name of the Product ordered after “2021-10-05”. */

select p.PRO_ID ,p.PRO_NAME 
from product p
join supplier_pricing sp on p.PRO_ID=sp.PRO_ID
join order_ o on o.PRICING_ID=sp.PRICING_ID where o.ORD_DATE>'2021-10-05';


/* 8) Display customer name and gender whose names start or end with character 'A'. */

select CUS_NAME,CUS_GENDER from customer 
where CUS_NAME like 'A%' or CUS_NAME like '%A';


/* 9) Create a stored procedure to display supplier id, name, Rating(Average rating of all the products sold by every customer) and
Type_of_Service. For Type_of_Service, If rating =5, print “Excellent Service”,If rating >4 print “Good Service”, If rating >2 print
“Average Service” else print “Poor Service”. Note that there should be one rating per supplier.
*/

DELIMITER //

CREATE PROCEDURE display_supplier_ratings()
BEGIN
    SELECT s.SUPP_ID,
           s.SUPP_NAME,
           CASE
               WHEN AVG(r.RAT_RATSTARS) = 5 THEN 'Excellent Service'
               WHEN AVG(r.RAT_RATSTARS) > 4 THEN 'Good Service'
               WHEN AVG(r.RAT_RATSTARS) > 2 THEN 'Average Service'
               ELSE 'Poor Service'
           END AS Type_of_Service
    FROM supplier s
    JOIN supplier_pricing sp ON s.SUPP_ID = sp.SUPP_ID
    JOIN product p ON sp.PRO_ID = p.PRO_ID
    JOIN order_ o ON sp.PRICING_ID = o.PRICING_ID
    JOIN rating r ON o.ORD_ID = r.ORD_ID
    GROUP BY s.SUPP_ID, s.SUPP_NAME;
END //

DELIMITER ;


call display_supplier_ratings();
