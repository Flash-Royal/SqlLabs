DROP DATABASE IF EXISTS name1;
CREATE DATABASE name1;
USE name1;
CREATE TABLE authors (
id SMALLINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
lastName Varchar(20) DEFAULT NULL,
firstName Varchar(20) DEFAULT NULL,
midName Varchar(20) DEFAULT NULL,
birthDate DATE NOT NULL
)
Engine = MyISAM
Default Char Set = utf8;

CREATE TABLE books (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
authorId SMALLINT DEFAULT NULL,
title VARCHAR(255) DEFAULT NULL,
ISBN VARCHAR(15) DEFAULT NULL,
cnt TINYINT DEFAULT NULL
)
Engine = MyISAM
Default Char Set = utf8;
CREATE TABLE readers (
id MEDIUMINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50) DEFAULT NULL,
address VARCHAR(255) DEFAULT NULL,
phone VARCHAR(11) DEFAULT NULL
)
Engine = MyISAM
Default Char Set = utf8;

CREATE TABLE orders (
id MEDIUMINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
bookId INT DEFAULT NULL,
readerId MEDIUMINT DEFAULT NULL,
orderDate DATETIME DEFAULT NULL,
duration TINYINT DEFAULT NULL
)
Engine = MyISAM
Default Char Set = utf8;

DELIMITER |
DROP TRIGGER IF EXISTS authors_after_delete |
use name1 |
CREATE DEFINER = 'root'@'localhost' TRIGGER authors_after_delete
after delete on authors for each row
begin
	delete from books
		where books.authorId = old.id;
end|

DROP TRIGGER IF EXISTS authors_after_update |
Create definer = 'root'@'localhost' trigger author_after_update
after update on authors for each row
begin 
	update books
	set books.authorsId = new.id
		where authors.id = old.id;
end |

DROP TRIGGER IF EXISTS books_after_delete |
Create definer = 'root'@'localhost' trigger books_after_delete
after delete on books for each row
begin
	delete from orders
		where orders.bookId = old.id;
end | 


DROP TRIGGER IF EXISTS readers_after_delete |
Create definer = 'root'@'localhost' trigger readers_after_delete
after delete on readers for each row
begin
	delete from orders
		where orders.readerId = old.id;
end | 

DROP TRIGGER IF EXISTS readers_after_update |
Create definer = 'root'@'localhost' trigger readers_after_update
after update on readers for each row
begin
	update orders
	set orders.bookId = new.id
		where readers.id = old.id;
end |

DROP TRIGGER IF EXISTS orders_after_delete |
use name1|
Create definer = 'root'@'localhost' trigger orders_after_delete
after delete on orders for each row
begin
	update books
	set cnt = cnt + 1
		where id = old.bookId;
end |

DROP TRIGGER IF EXISTS orders_before_insert |
use name1|
Create definer = 'root'@'localhost' trigger orders_before_insert
before insert on orders for each row 
begin 
	if (new.duration > 14) and (select cnt from books where cnt > 0) then
    signal sqlstate '45000';
    end if;
	update books
	set cnt = cnt - 1
		where (id = new.bookId);
end |

Delimiter ;

use name1;

INSERT authors (firstname,lastname,midname,birthdate)
VALUES
('Кравцев', 'А', 'Б', '1890-10-12'),
('Пушкин', 'А', 'С', '1799-06-06'),
('Астрономов', 'В', 'Л', '1918-02-03'),
('Булгаков', 'Л', 'А', '1817-10-23'),
('Черных', 'В', 'Д', '1956-04-15'),
('Шариков', 'П', 'П', '1897-07-19'),
('Захарыч', 'Э', 'П', '1989-09-23');

INSERT books (authorId,title, ISBN, cnt)
VALUES
('1', 'Осеннее лето','9123',3),
('1','Холодная листва','9231',2),
('2','Евгений Онегин','1245',5),
('2','Руслан и Людмила','3124',3),
('3','Искусство звезд','3234',2),
('4','Мастер и маргарита','1634',1),
('4','Собачее Сердце','5312',2),
('5','Красная свеча','6453',1),
('6','Правила общения с белыми','8647',20),
('7','Исскуство самогоноварения','5244',3),
('7','Философская жизнь','3442',2);

INSERT readers (name,address,phone)
VALUES
('Пудовинников П. М.', 'г. Нижний Новгород', '89243245456'),
('Попов В. А.', 'г. Нижний Новгород', '89245445765'),
('Кузеев Ю. Р.','д. Давлеканово', '89173243243'),
('Карачурин А. М.','г Салават','89173442435'),
('Попова В. А.','г Салават','89173453554'),
('Малинин М.','г. Нижний Новгород','89245345093');

INSERT orders (bookId, readerId, orderDate,duration)
values
('9','1','2019-11-23 15:00:05',10),
('7','1','2019-11-25 17:32:22',7),
('5','2','2019-11-18 12:14:53',14),
('10','3','2019-08-15 21:20:24',5),
('6','4','2019-11-21 20:23:45',10),
('1','5','2019-11-26 10:12:41',7),
('2','5','2019-11-26 10:12:41',3),
('3','6','2018-12-23 10-45-12',4),
('11','6','2018-12-23 10-45-12',7);

Select name 
from readers 
where address = 'г. Нижний Новгород';

Select concat(" ",authors.firstname," ",authors.lastname," ",authors.midname) as fullname, books.title, books.ISBN, books.cnt  
	from authors,books 
	where authors.id = books.authorId 
	order by fullname;
    
select readers.name, count(*) as a1 
	from readers, orders 
    where readers.id = orders.readerId 
	group by orders.readerId
    order by a1 desc;
    
    select readers.name
    from readers,orders
    where (readers.id = orders.readerId) and (orders.duration > (select avg(duration) from orders))
    order by name;
    
    select concat(" ",authors.firstname," ",authors.lastname," ",authors.midname) as fullname 
    from orders,authors,books
	where (orders.bookId = books.id) and (books.authorId = authors.id) and (Year(authors.birthdate) < 1917)
    group by fullname;
    
select concat(" ",authors.firstname," ",authors.lastname," ",authors.midname) as fullname, count(*) 
from orders,authors,books
where (orders.bookId = books.id) and (books.authorId = authors.id)
group by books.authorId
order by fullname desc;

select readers.name , date_add(orders.orderDate, interval orders.duration day) as a1
from orders,readers
where (readers.id = orders.readerId) and (datediff(date_add(orders.orderDate, interval orders.duration day), curdate()) <0)
order by a1;










    






