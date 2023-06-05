create database if not exists winter_cars;
use winter_cars;
#drop table cars;

create table cars(car_id INT, make varchar(50), model varchar(20));
insert into cars(car_id, make, model)
values(1, 'Mitsubishi', 'Eclipse'),
	  (2, 'Mitsubishi', 'Outlander'),
	  (3, 'Hyundai', 'i30'),
      (4, 'Ram', 1500),
      (5, 'Ford', 'F150'),
      (6, 'BMW', '335i'),
      (7, 'BMW', '330i');
      
      select *
      from cars;
      #drop table cars
      
      alter table cars
      ADD CONSTRAINT pk_car PRIMARY KEY(car_id);
      
      select * from cars;
      
      
      
      
      
      create table car_models(model varchar(200));
      insert into car_models(model)
      values('Eclipse'),
	  ( 'Outlander'),
	  ( 'i30'),
      (1500),
      ('F150'),
      ('335i'),
      ('330i');
      
 select * from car_models; 
 
 alter table car_models
 ADD column model_id int;
 
 update car_models
 set model_id=1
 where model='Outlander';

update car_models
 set model_id=2
 where model='Eclipse';

update car_models
 set model_id=3
 where model='1500';

update car_models
 set model_id=4
 where model='i30';

update car_models
 set model_id=5
 where model='F150';

update car_models
 set model_id=6
 where model='330i';

update car_models
 set model_id=7
 where model='335i';
 
 
 
 select * from car_models;
 alter table car_models
 ADD constraint pk_model PRIMARY KEY(model_id);
 
 select * from cars;
alter table cars
ADD column model_id INT;

alter table cars
drop column model;

select * from car_models;

    select * from cars;  
      update cars
      set model_id=1
      where car_id=1;
      
      update cars
      set model_id=2
      where car_id=2;
      
      update cars
      set model_id=3
      where car_id=3;
      
      update cars
      set model_id=4
      where car_id=4;
      
      update cars
      set model_id=5
      where car_id=5;
      
      update cars
      set model_id=6
      where car_id=6;
      
      update cars
      set model_id=7
      where car_id=7;
      
      select * from cars;
      select * from car_models;
      alter table cars
      add constraint fk_make FOREIGN KEY(model_id)
      references car_models(model_id);