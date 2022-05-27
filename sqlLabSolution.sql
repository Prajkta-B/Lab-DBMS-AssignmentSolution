use db;
/*q1 creating the tables */
CREATE TABLE supplier (SUPP_ID int primary key,SUPP_NAME varchar(50) NOT NULL,
SUPP_CITY varchar(50) NOT NULL,SUPP_PHONE varchar(50) NOT NULL);

CREATE TABLE customer (CUS_ID int primary key,CUS_NAME varchar(20)NOT NULL,
CUS_PHONE varchar(10)NOT NULL,CUS_CITY varchar(30) NOT NULL, CUS_GENDER char);

CREATE TABLE category (CAT_ID int primary key,CAT_NAME varchar(20)NOT NULL);

CREATE TABLE product (PRO_ID int primary key,PRO_NAME varchar(20)default("Dummy")NOT NULL,
PRO_DESC varchar(60),CAT_ID int,
foreign key(CAT_ID) references category(CAT_ID)
);

CREATE TABLE supplier_pricing (PRICING_ID int primary key,PRO_ID int,SUPP_ID int,SUPP_PRICE int default(0),
foreign key(PRO_ID)references product(PRO_ID),
foreign key(SUPP_ID) references supplier(SUPP_ID));

CREATE TABLE Orders (ORD_ID int primary key,
ORD_AMOUNT int NOT NULL,
ORD_DATE date NOT NULL,
CUS_ID int,PRICING_ID int,
foreign key(CUS_ID) references customer(CUS_ID),
foreign key(PRICING_ID) references supplier_pricing(PRICING_ID));

CREATE TABLE rating (RAT_ID int primary key,ORD_ID int,RAT_RATSTARS int NOT NULL,
foreign key(ORD_ID) references Orders(ORD_ID));

/*q2 inserting values*/
insert into supplier
values
(1,"Rajesh Retails","Delhi",1234567890),
(2,"Appario Ltd.","Mumbai",2589631470),
(3,"Knome products","Banglore",9185462315),
(4,"Bansal Retails","Kochi",8975463285),
(5,"Mittal Ltd.","Lucknow",7898456532);

insert into customer
values
(1,"AAKASH",9999999999,"DELHI","M"),
(2,"AMAN",9785463215,"NOIDA","M"),
(3,"NEHA",9999999999,"MUMBAI","F"),
(4,"MEGHA",9994562399,"KOLKATA","F"),
(5,"PULKIT",7895999999,"LUCKNOW","M");

insert into category
values
(1,"BOOKS"),
(2,"GAMES"),
(3,"GROCERIES"),
(4,"ELECTRONICS"),
(5,"CLOTHES");

insert into product
values
(1, "GTA V", "Windows 7 and above with i5 processor and 8GB RAM", 2),
(2, "TSHIRT", "SIZE-L with Black, Blue and White variations", 5),
(3, "ROG LAPTOP" ,"Windows 10 with 15inch screen, i7 processor, 1TB SSD", 4),
(4, "OATS" ,"Highly Nutritious from Nestle", 3),
(5, "HARRY POTTER","Best Collection of all time by J.K Rowling", 1),
(6, "MILK" ,"1L Toned MIlk" ,3),
(7, "Boat Earphones", "1.5Meter long Dolby Atmos" ,4),
(8, "Jeans", "Stretchable Denim Jeans with various sizes and color", 5),
(9, "Project IGI", "compatible with windows 7 and above", 2),
(10, "Hoodie", "Black GUCCI for 13 yrs and above", 5),
(11, "Rich Dad Poor Dad", "Written by RObert Kiyosaki", 1),
(12, "Train Your Brain", "By Shireen Stephen", 1);

insert into supplier_pricing
values
(1,1,2,1500),
(2,3,5,30000),
(3,5,1,3000),
(4,2,3,2500),
(5,4,1,1000);

SET FOREIGN_KEY_CHECKS=0;
insert into orders
values
(101, 1500, "2021-10-06", 2, 1),
(102, 1000, "2021-10-12", 3, 5),
(103, 30000, "2021-09-16", 5, 2),
(104, 1500, "2021-10-05", 1, 1),
(105, 3000, "2021-08-16", 4, 3),
(106, 1450, "2021-08-18", 1, 9),
(107, 789, "2021-09-01", 3, 7),
(108, 780, "2021-09-07", 5, 6),
(109, 3000, "2021-00-10", 5, 3),
(110, 2500, "2021-09-10", 2, 4),
(111, 1000, "2021-09-15", 4, 5),
(112, 789, "2021-09-16", 4, 7),
(113, 31000, "2021-09-16", 1, 8),
(114, 1000, "2021-09-16", 3, 5),
(115, 3000, "2021-09-16", 5, 3),
(116, 99, "2021-09-17", 2, 14);

insert into rating
values
(1, 101, 4),
(2, 102, 3),
(3, 103, 1),
(4, 104, 2),
(5, 105, 4),
(6, 106, 3),
(7, 107, 4),
(8, 108, 4),
(9, 109, 3),
(10, 110, 5),
(11, 111, 3),
(12, 112, 4),
(13, 113, 2),
(14, 114, 1),
(15, 115, 1),
(16, 116, 0);

SET FOREIGN_KEY_CHECKS=1;

/*q3*/
select Count(C.CUS_ID) as Count, C.CUS_GENDER
from customer C
inner join orders O on C.CUS_ID = O.CUS_ID
where O.ORD_AMOUNT>=3000
group by C.CUS_GENDER;

/*q4*/
select O.*, P.PRO_NAME 
from orders O 
inner join supplier_pricing SP on O.PRICING_ID= SP.PRICING_ID
inner join product P on SP.PRO_ID = P.PRO_ID 
where o.CUS_ID=2;
/*Will not display order with pricing id 14 hence the output will have 2 rows*/

/*q5*/
select s.* from supplier s 
inner join supplier_pricing sp on s.SUPP_ID = sp.SUPP_ID
group by sp.SUPP_ID
having count(sp.SUPP_ID)>1;

/*q6*/
select MIN(supplier_pricing.SUPP_PRICE), category.CAT_ID, CAT_NAME, product.PRO_NAME from category
inner join product on category.CAT_ID = product.CAT_ID
inner join supplier_pricing on supplier_pricing.PRO_ID = product.PRO_ID group by category.CAT_ID;

/*q7*/
select ORD_DATE, product.PRO_ID, PRO_NAME from product
inner join supplier_pricing on product.PRO_ID = supplier_pricing.PRO_ID
inner join orders on orders.PRICING_ID = supplier_pricing.PRICING_ID
where ORD_DATE > "2021-10-05";

/*q8*/
select CUS_NAME, CUS_GENDER from customer
where CUS_NAME like "A%" or CUS_NAME like "%A";

/*q9*/
DELIMITER //
create procedure Review()
begin
select s.SUPP_ID, s.SUPP_NAME,rt.RAT_RATSTARS,
case
when rt.RAT_RATSTARS = 5 then "Excellent Service"
when rt.RAT_RATSTARS = 4 then "Good Service"
	when rt.RAT_RATSTARS >2 then "Average Service"
else "Poor Service"
end as Type_of_Service
from rating rt
inner join orders o ON rt.ORD_ID = o.ORD_ID
inner join supplier_pricing sp on sp.PRICING_ID = o.PRICING_ID
inner join supplier s on s.SUPP_ID = sp.SUPP_ID;
END //
DELIMITER ;
call Review();
