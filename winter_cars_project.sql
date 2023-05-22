create database if not exists winter_cars;
use winter_cars;
create table cars(make varchar(50), model varchar(20));
insert into cars(model, make)
values('Mitsubishi', 'Eclipse'),
	  ('Mitsubishi', 'Outlander'),
	  ('Hyundai', 'i30'),
      ('Ram', 1500),
      ('Ford', 'F150'),
      ('BMW', '335i'),
      ('BMW', '330i');
      
      select model, make 
      from cars;
