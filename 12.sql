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
Engine = InnoDB
Default Char Set = utf8;

CREATE TABLE books (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
authorId SMALLINT DEFAULT NULL,
title VARCHAR(255) DEFAULT NULL,
ISBN VARCHAR(15) DEFAULT NULL,
cnt TINYINT DEFAULT NULL,
key aid_1 (authorId),
constraint aid foreign key (authorId) references authors (id)
on delete cascade on update cascade
)
Engine = InnoDB
Default Char Set = utf8;

CREATE TABLE readers (
id MEDIUMINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50) DEFAULT NULL,
address VARCHAR(255) DEFAULT NULL,
phone VARCHAR(11) DEFAULT NULL
)
Engine = InnoDB
Default Char Set = utf8;

CREATE TABLE orders (
id MEDIUMINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
bookId INT DEFAULT NULL,
readerId MEDIUMINT DEFAULT NULL,
orderDate DATETIME DEFAULT NULL,
duration INT DEFAULT NULL,
key rid_1 (readerId),
constraint rid foreign key (readerId) references readers (id)
on delete cascade on update cascade,
key bid_1 (bookId),
constraint bid foreign key (bookId) references books (id)
on delete cascade on update cascade
)
Engine = InnoDB
Default Char Set = utf8;

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
('4','Собачее Сердце','5312',21),
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
('7','1','2020-01-14 17:32:22',9),
('5','2','2020-01-14 12:14:53',5),
('10','3','2020-01-17 21:20:24',5),
('6','4','2020-01-17 20:23:45',10),
('1','5','2020-01-13 10:12:41',7),
('2','5','2019-11-26 10:12:41',10),
('3','6','2018-12-07 10-45-12',4),
('11','6','2018-12-07 10-45-12',7);

create view name123 as
select Date(orders.orderDate), count(Date(orders.orderDate)) as count
from orders
group by orders.orderDate
order by orders.orderDate desc


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          