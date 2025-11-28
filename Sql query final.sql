create database retail_sales;
use retail_sales;

select * from brands;
select * from categories;
select * from customers;
select * from order_items;
select * from orders;
select * from products;
select * from staffs;
select * from stocks;
select * from stores;

/*UPDATE orders
SET required_date= STR_TO_DATE(required_date, '%d-%m-%Y');*/

alter table order_items
add constraint fk_order_id
foreign key (order_id)
references orders(order_id);

alter table order_items
add constraint fk_product_id
foreign key (product_id)
references products (product_id);

alter table orders
add constraint fk_customer_id
foreign key (customer_id)
references customers(customer_id);

alter table orders
add constraint fk_staff_id
foreign key (staff_id)
references staffs(staff_id);

alter table orders
add constraint fk_store_id
foreign key (store_id)
references stores(store_id);

alter table staffs
add constraint fk_storeid
foreign key (store_id)
references stores(store_id);

alter table stocks
add constraint fk_ss_id
foreign key (store_id)
references stores(store_id);

alter table products
add constraint fk_categoryid
foreign key (category_id)
references categories(category_id);

alter table products
add constraint fk_brand_id
foreign key (brand_id)
references brands(brand_id);

alter table stocks
add constraint fk_productid
foreign key (product_id)
references products (product_id);

-- 3 -----------------------------------------
select * from orders as o
inner join order_items as oi on o.order_id = oi.order_id
inner join products as p on oi.product_id = p.product_id;

-- 4 -----------------------------------------
select o.store_id, sum(oi.total_price) as Total_sales from order_items as oi
inner join orders as o on oi.order_id = o.order_id
group by o.store_id;

-- 5 ------------------------------------------
select p.product_name,sum(oi.quantity) as sum_qty from order_items as oi
inner join products as p on oi.product_id = p.product_id
group by p.product_name
order by sum_qty desc
limit 5;

-- 6 -------------------------------------------
select o.customer_id, count(oi.order_id) as total_orders, count(oi.item_id) as total_items, sum(oi.total_price) as total_revenue from order_items as oi
inner join orders as o on oi.order_id = o.order_id
group by o.customer_id;

-- 7 -------------------------------------------
select o.customer_id, c.first_name, sum(oi.total_price) as total_spending,
case
	when sum(oi.total_price) >= 15000 then "High"
    when sum(oi.total_price) between 8000 and 15000 then "Medium"
    else "Low"
end as Spending_brackets
from order_items as oi
inner join orders as o on oi.order_id = o.order_id
inner join customers as c on o.customer_id = c.customer_id
group by o.customer_id, c.first_name;

-- 8 ---------------------------------------------
select o.staff_id, s.first_name, count(oi.order_id) as handled_orders, sum(oi.total_price) as total_revenue from order_items as oi
inner join orders as o on oi.order_id = o.order_id
inner join staffs as s on o.staff_id = s.staff_id
group by o.staff_id, s.first_name;

-- 9 ---------------------------------------------
select s.store_id, s.store_name, sum(sk.quantity) as total_quantity, p.product_name from stores as s
inner join stocks as sk on s.store_id = sk.store_id
inner join products as p on p.product_id = sk.product_id
group by s.store_id, s.store_name, p.product_name
having sum(sk.quantity) > 10;

-- 10 --------------------------------------------
select * from customer_segment;












