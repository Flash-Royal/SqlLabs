DROP DATABASE IF EXISTS name2;
CREATE DATABASE name2;
USE name2;

create table docs (
name Varchar(20),
id smallint auto_increment primary key
)
Engine = InnoDB
Default Char Set = utf8;

create table pats (
id smallint auto_increment primary key,
name1 Varchar(20),
docId smallint,
key did_1 (docId),
constraint did foreign key (docId) references docs (id)
on delete cascade on update cascade
)
Engine = InnoDB
Default Char Set = utf8;

create table info (
id smallint auto_increment primary key,
patId smallint,
docId smallint,
infoDate DATETIME DEFAULT NULL,
key did1_1 (docId),
constraint did1 foreign key (docId) references pats (docId)
on delete cascade on update cascade,
key pid_1 (patId),
constraint pid foreign key (patId) references pats (id)
on delete cascade on update cascade
)
Engine = InnoDB
Default Char Set = utf8;

insert into docs (name)
values 
('Аветкин И. И.'),
('Кравцев А. В.'),
('Прохоров А. А.'),
('Прохоров В. А.');

insert into pats (name1, docId)
values 
('Попов В. А.', 1),
('Попов В. А.', 2),
('Попов В. А.', 4),
('Пудовинников П. М.', 2),
('Пудовинников П. М.', 3),
('Малинин М.', 4),
('Малинин М.', 2);

insert into info (patId,docId,infoDate)
values
('2','1','2019-11-23 15:00:05'),
('2','2','2019-12-05 17:32:22'),
('3','2','2019-12-03 12:14:53'),
('3','3','2019-08-15 21:20:24'),
('6','2','2019-12-01 12:14:53'),
('6','4','2019-12-04 12:14:53'),
('2','4','2019-12-02 12:14:53');

use name2;
create view doc as
select docs.name, pats.name1
from docs 
left join pats on docs.id = pats.docId
order by docs.id;

create view info1 as
select docs.name, pats.name1, info.infoDate
from info
left join pats on pats.id = info.patId
left join docs on info.docId = docs.id
where date_add(info.infoDate, interval 7 day) > curdate();

create view doc1 as 
select name, count(info.id)
from docs
left join info on docs.id = info.docId
where date_add(info.infoDate, interval 31 day) > curdate()
group by docs.id;





