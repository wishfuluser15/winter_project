# creating the database winter_car_project
create database if not exists winter_car_project;
use winter_car_project;

#drop table car;
#drop table car_model;

# creating the car table
create table car(id int primary key auto_increment,
make varchar(200),
model varchar(200));

# inserting values
insert into car(make, model)
values('Mitsubishi', 'Eclipse'),
	  ('Mitsubishi', 'Outlander'),
	  ('Hyundai', 'i30'),
      ('Ram', 1500),
      ('Ford', 'F150'),
      ('BMW', '335i'),
      ('BMW', '330i');
      
select * from car;

# creating 2nd table car_model
create table car_model(
id int primary key auto_increment,
model_name varchar(200));

# alter table car by adding model_id as a foreign key (primary key of car_model' id column)
alter table car
add column model_id int;

# checking \
select * from car;


# adding foreign key to model_id\
alter table car
add constraint fkey_model_id foreign key(model_id)
references car_model(id);

# update the values for model_id column of car table
update car
set model_id=
case 
when model='Eclipse' then 1
when model='Outlander' then 2
when model='i30' then 3
when model='1500' then 4
when model='F150' then 5
when model='335i' then 6
when model='330i' then 7
end;


# inserting values to the car_model table
insert into car_model(model_name)
select model
from car;

# cehcking car_model
select * from car_model;

select c.make, c.model, cm.model_name
from car c
inner join car_model cm
on c.model_id=cm.id;

#alter table car
#drop column model;

select * from car;
select * from car_model;

#********************************WCP3*******************

# alter table car_model with make id (primary key id of car table)
alter table car_model
add column make_id int;

# make make_id as foreign key\
alter table car_model
add constraint fk_make_id foreign key (make_id)
references car(id);

select * from car_model;

# imported the csv file car_new

use winter_car_project;
select * from car;

# inserting values form car_new values of make values in to car 
select * from car_new;
insert into car(make, model)
select distinct manufacturer, model   # may be remove distinct next time
from car_new
limit 2000;

# inserting values of model in to car_model from car_new

insert into car_model(model_name)
select  model
from car_new
limit 2000;

select * from car_model;

# using update statemnet adding values to make_id column of car_models
      update car_model cm
      inner join car c
      on cm.model_name=c.model
      set cm.make_id=c.id;
      
      select * from car;
      select * from car_model;
      select * from car_new;
      
      #lesson 11 analysing the data
      
      # Write a query to show all makes and their models
select * from car;
select * from car_model;

# Write a query to show all makes and the number of models for each make
select c.make, count(cm.model_name) as num_models
from car c INNER JOIN car_model cm
on c.id=cm.make_id
group by c.make, cm.model_name;

 # OR
#Write a query to show all makes and the number of models for each make
select make, count(model_id)as num_models
from car
group by make;

# showing all the makes and the models
select  c.make,
cm.model_name from car c
inner join car_model cm
on c.id=cm.id;
      
	# lesson 12(fixing data) we need two columns to be added to car_model table, so alter the table
    alter table car_model
    add column new_model_name varchar(200);
     
     
    alter table car_model
    add column variations varchar(200);
    
   # creating temp table to add values to the car_model
   create table temp(
      id INT primary key auto_increment,
      model_name varchar(200),
      new_model_name varchar(200),
      variations varchar(200));
      
      insert into temp(model_name, new_model_name, variations)
      select model,
      #substring_index(model, ' ', 1) as new_model_name,
      substr(model, 1, instr(model, ' ')),
      SUBSTR(model, INSTR(model, ' '))
      from car_new
      limit 2000;
      
      select * from temp;
      select * from car_model;
     
     # upadteing the values of the new_model_name and variations using the temp table values of new_model_name, and variations
      update car_model cm
      inner join temp t
      on cm.model_name=t.model_name
      set cm.new_model_name=t.new_model_name;
      
      update car_model cm
      inner join temp t
      on cm.model_name=t.model_name
      set cm.variations=t.variations;
      
      
      
    
    # inserting values for new_model_name, variations from car_model's model_name column
    insert into car_model(new_model_name, variations)
      select 
      #substring_index(model, ' ', 1) as new_model_name,
      substr(model_name, 1, instr(model_name, ' ')),
      SUBSTR(model_name, INSTR(model_name, ' '))
      from car_model
      limit 2000;
      
      select * from car_model;
     
    #**************************************
    # string function to split the string values
      select model,
      #substring_index(model, ' ', 1) as new_model_name,
      substr(model, 1, instr(model, ' ')) as new_model_name,
      SUBSTR(model, INSTR(model, ' ')) as variations
      from car_new
      limit 2000;
      
      select * from car_model;    # here add 'base' for modle_name and variations which are empty (use update )
      #************************************
#lesson 13 creating the variations table
create table variation1(
id int primary key auto_increment,
variation_name varchar(200),
model_id int);

# alter the column model_id of variation1 to foreign key
alter table variation1
add constraint fk_var foreign key(model_id)
references car_model(id);

# inserting the model_id and variations of the car_model table to variation1 table
insert into variation1(model_id, variation_name)
select id, variations
from car_model;

select * from variation1;

#Verifying
SELECT
cm.model_name,
cm.new_model_name,
cm.variations AS model_variation,
v.variation_name
FROM car_model cm
INNER JOIN variation1 v ON cm.id = v.model_id;

# dropping the variations column from car_model table
alter table car_model
drop column variations;

select * from car_model;

#Lesson 14 Identify the rows that contain duplicate models
#Remove the duplicate models, ensuring that one row for each model remains
#Update the related variations to link to the model record that still exists,
# ensuring that there are no variations that don’t have a related model.

select distinct model_name, new_model_name, make_id
      from car_model
      where id IN (select model_id
      from variation1);
      
select * from car_model;

#**********************
    # lesson 15 importing the sales data
    
select * from sales_data;

# creating the table customer from sales_date
create table customer(
id int primary key auto_increment,
customer_name varchar(100));

# inserting the values 
insert into customer(customer_name)
select customer_name
from sales_data;

use winter_car_project;
select * from sales_data;
select * from customer;

# altering the table sales_date with customer_id as foreign key
alter table sales_data
add column customer_id int;

alter table sales_data
add constraint fk_cust_id foreign key(customer_id)
references customer(id);

update sales_data s
inner join customer c
on s.customer_name=c.customer_name
set s.customer_id=c.id;

select * from sales_data;

# creating the table sales_person from sales_data
create table sales_person(
id int primary key auto_increment,
salesp_name varchar(100));

# inserting the values 
insert into sales_person(salesp_name)
select salesperson
from sales_data;

use winter_car_project;
select * from sales_data;
select * from customer;

# altering the table sales_date with sales_person_id as foreign key
alter table sales_data
add column sales_person_id int;

alter table sales_data
add constraint fk_sp_id foreign key(sales_person_id)
references sales_person(id);

update sales_data s
inner join sales_person sp
on s.salesperson=sp.salesp_name
set s.sales_person_id=sp.id;

select * from sales_data;

alter table sales_data
add column variation_id int;

alter table variation1
add column car_model_name varchar(200);

insert into variation1(car_model_name)
select model_name
from temp;

alter table sales_data
add constraint fk_vari_id foreign key(variation_id)
references variation1(id);

update sales_data s
inner join variation1 v
on s.car_model_name=v.car_model_name 
set s.variation_id=v.id;

#OR 
insert into sales_data(variation_id)
select id from variation1;            

select * from sales_data;
select * from temp;
select * from variation1;

# lesson 17 creatimg date column
alter table sales_data
add column date_of_sales date;

update sales_data
set date_of_sales=str_to_date(sale_date, '%d/%m/%y');  # this didnt work because you cant update the same table 

# here same table is used with diff table names to set the values
update sales_data s1
inner join sales_data s
on s1.customer_id=s.customer_id
SET s1.date_of_sales=str_to_date(s.sale_date, '%d/%m/%Y');

select * from sales_data;

# The total value of sales (the sum of the sales price for all cars)
select car_model_name, sum(sale_price) as total_price
from sales_data
group by car_model_name;

select sum(sale_price)
from sales_data;

select * from sales_data;

#The number of sales and value of sales for each month
select count(*) as no_of_sales, 
sum(sale_price) as total_value,
month(date_of_sales) as month 
from sales_data
group by month;

select * from variation1;
#The number of sales and value of sales for each make, model, and variation of car
select cm.model_name,
c.make, v.variation_name,
count(*) as num_of_sales,
s.sale_price
from sales_data s
inner join variation1 v
on s.variation_id=v.id
inner join car_model cm
on cm.id=v.model_id
inner join car c
on c.id=cm.make_id
group by c.make, v.variation_name, cm.model_name, s.sale_price;

#The number of sales for each make and model
select * from sales_data;
select count(*), c.make, cm.model_name
from car c
inner join car_model cm
on c.id=cm.make_id
group by c.make, cm.model_name;

# The number of sales and value of sales for each salesperson
select count(*) as no_of_sales, 
sum(sale_price) as total_value,
salesperson
from sales_data
group by salesperson;
