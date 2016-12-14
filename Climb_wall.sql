

SET FOREIGN_KEY_CHECKS=0; #so we can drop all the tables!
drop table if exists Diff_is;
drop table if exists Climb_set;
drop table if exists Climbed;
drop table if exists Difficulty;
drop table if exists Route;
drop table if exists Wall;
drop table if exists Climber;
drop table if exists Gym;

 -- GENERATING TALBES #4/5
CREATE TABLE Gym
(
  name varchar(256) NOT NULL,
  street_num varchar(256) NOT NULL,
  zip varchar(9) NOT NULL,
  GYM_ID int auto_increment ,
  street_name varchar(256) NOT NULL,
  state varchar(2) NOT NULL,
  PRIMARY KEY (GYM_ID),
  UNIQUE (name)	#gym name
);


CREATE TABLE Climber
(
  email varchar(256) NOT NULL,
  first varchar(256) NOT NULL,
  last varchar(256) NOT NULL,
  CLIMB_ID INT auto_increment,
  PRIMARY KEY (CLIMB_ID),
  UNIQUE (email)
);

CREATE TABLE Wall
(
  wall_numb INT,
  style varchar(256) NOT NULL,
  height INT NOT NULL,#in feet
  WALL_ID INT auto_increment,
  GYM_ID INT NOT NULL,
  PRIMARY KEY (WALL_ID),
  FOREIGN KEY (GYM_ID) REFERENCES Gym(GYM_ID)
);


CREATE TABLE Route
(
  primary_color varchar(256) NOT NULL, #route/tape color
  date_set date,	#date route set
  date_cleared date,#date route was cleard, if it was cleared
  name varchar(256),#if the route has a name
  ROUTE_ID INT auto_increment,
  is_boulder bool NOT NULL,
  is_lead bool NOT NULL,
  is_top_rope bool NOT NULL,
  WALL_ID INT NOT NULL,
  PRIMARY KEY (ROUTE_ID),
  FOREIGN KEY (WALL_ID) REFERENCES Wall(WALL_ID) on delete cascade
);


CREATE TABLE Difficulty
(
  Diff_ID INT NOT NULL, #weighted score
  v_number varchar(4) NOT NULL, #IE V10,V3+ or Vfun
  five_point varchar(25) NOT NULL, #IE 5.10a, 5.6, 5.9+
  PRIMARY KEY (Diff_ID)
);


CREATE TABLE Climbed
(
  attempts_to_complete INT NOT NULL,
  completed int NOT NULL,
  difficulty_adjust INT NOT NULL, # 0 is base, -1 is easier than rated, +1 is harder than rated
  rating int NOT NULL, #out of 5
  CLIMB_ID INT NOT NULL,
  ROUTE_ID INT NOT NULL,
  PRIMARY KEY (CLIMB_ID, ROUTE_ID),
  FOREIGN KEY (CLIMB_ID) REFERENCES Climber(CLIMB_ID) on delete cascade,
  FOREIGN KEY (ROUTE_ID) REFERENCES Route(ROUTE_ID) on delete cascade
);


CREATE TABLE Climb_set
(
  CLIMB_ID INT NOT NULL,
  ROUTE_ID INT NOT NULL,
  PRIMARY KEY (CLIMB_ID, ROUTE_ID),
  FOREIGN KEY (CLIMB_ID) REFERENCES Climber(CLIMB_ID) on delete cascade,
  FOREIGN KEY (ROUTE_ID) REFERENCES Route(ROUTE_ID) on delete cascade
);


CREATE TABLE Diff_is
(
  ROUTE_ID INT NOT NULL,
  Diff_ID INT NOT NULL,
  PRIMARY KEY (ROUTE_ID, Diff_ID),
  FOREIGN KEY (ROUTE_ID) REFERENCES Route(ROUTE_ID) on delete cascade,
  FOREIGN KEY (Diff_ID) REFERENCES Difficulty(Diff_ID) on delete cascade
);
 --
 
 -- INSRERTING DATA #6
insert into Difficulty(diff_id,v_number,five_point)# estimated litieral difficulty, maybe fix to interprited difficulty
#but Vx scale and 5.x scale should not be directly compared.
 values
	(0,'VB','5.6'),
	(1,'VB','5.7'),
    (2,'V0-','5.8'),
    (3,'V0','5.9'),
    (4,'V0+','5.10a/b'),
    (5,'V1','5,10c/d'),
    (6,'V2','5.11a/b'),
    (7,'V3','5.11c/d'),
    (8,'V4','5.11d/5.12a'),
    (9,'V5','5.12a/b'),
    (10,'V6','5.12c/d'),
    (11,'V7','5.13a/b'),
    (12,'V8','5.13b/c'),
    (13,'V9','5.13c/d'),
    (14,'V10','5.14a'),
    (15,'V11','5,14b'),
    (16,'V12','5.14c'),
    (17,'V13','5.14d'),
    (18,'v14','5.15a');
    
    Select * from Difficulty;
    
insert into Gym(name,street_num,street_name,state,zip)
  values
    ('Planet Granite','100','El Camino Real','CA','94002'),
    ('Evo Rock & Fitness','65','Warren Ave','ME','04103'),
    ('VERTEX climbing center','3358','Coffey Ln A', 'CA','95403'),
    ('The Sudio Climbing','396','1st St','CA','95113'),
    ('Rock City Climbing','5100','E La Palma Ave #108','CA','92807'),
	('Campus Recreation Climbing Wall: Sonoma State University','1801','E Cotati Ave','CA','94928');
    
	Select * from Gym;
    
insert into Wall(GYM_ID,wall_numb,style,height)
  values #THESE VALUES ARE NOT ACCURATE, this is just dummy data
	(1,1,'slab',40),
	(1,2,'boulder',15),
	(1,3,'flat/crack',45),
	(2,6,'slab',45),
	(2,5,'overhang',35),
	(2,4,'crack',35),
	(2,3,'slab/crack',40),
	(2,2,'overhang',45),
	(2,1,'flat/highwall',60),
	(3,1,'buble',40),
	(3,2,'slab/flat',50),
	(3,3,'overhang',50),
	(4,1,'cornerwall',60),
	(4,3,'boulder',10),
	(4,2,'crack',50),
	(5,1,'boulder',25),
	(6,2,'overhang',35),
	(6,2,'highwall',60);
  
	select * from Wall;
  
insert into Climber(email,first,last)
  values
	('JaneDoe@example.com','Jane','Doe'),
    ('jesus@heaven.com','Rodrigo','Garcia'),
    ('wired@yahoo.com','Button','Can'),
    ('is@carrot.com','Rob','Schnider');

	select * from Climber;
        
insert into Route(primary_color,secondary_color,date_set,date_cleared,name,is_boulder,is_lead,is_top_rope,WALL_ID)
  values
	('red','2015-10-05','2015-11-20','This is only a test',true,false,false,1),
	('blue','2016-09-05',null,'IM BLUE',false,false,true,1),
	('green','2016-11-05',null,null,false,true,true,1),
	('yellow','2016-10-19','2016-10-20','dodge',true,false,false,2),
	('red','2016-02-11',null,'blood',true,false,false,2),
	('red','2016-10-11','2016-10-12',null,true,false,false,2),
	('pink','2016-11-02',null,null,true,false,false,2),
	('white','2016-01-01','2016-05-05',null,true,false,false,2),
	('black','2015-12-15',null,null,true,false,true,3),
	('yellow','2016-10-10',null,'pink lemonade',false,false,true,3),
	('purple','2010-10-01',null,null,false,false,true,3),
	('white','1999-06-03',null,'1932',false,false,true,3),
	('brown','2015-11-05',null,'shit',true,false,false,4),
	('yellow','2015-06-11',null,'melloyello',true,false,false,4),
	('blue','2015-10-16',null,null,false,true,true,4),
	('red','2014-12-05',null,null,true,true,true,4),
	('green','2016-03-03',null,'This is only a route',false,true,false,5),
	('orange','1999-12-31',null,'This is only a test',false,true,false,5),
	('red','2011-11-11',null,'tset a ylno si sihT',false,false,true,6),
	('orange','2016-04-15',null,null,true,false,false,7),
	('lime green','2016-05-23',null,null,false,true,true,7),
	('caution tape','1995-06-12',null,null,false,true,true,8),
	('white','2011-01-13',null,'over it',false,true,true,9),
	('red','2015-10-15',null,'so',true,false,false,10),
	('black','2016-11-05',null,'over it',true,false,false,10),
	('green','2016-05-24',null,null,false,true,true,11),
	('red','2016-10-05',null,null,false,true,false,12),
	('red','2016-11-01',null,null,false,true,true,13),
	('blue','2014-10-25','2015-10-25','give up',false,true,false,13),
	('pink','2016-09-24',null,'its not worth it',true,false,false,14),
	('red','2016-11-01',null,null,true,false,false,14),
	('green','2016-11-06',null,null,true,false,false,15),
	('red','2001-01-01',null,null,true,false,false,16),
	('white','2010-10-10',null,'10/10',true,false,false,16),
	('black','2016-11-02',null,'last!',true,false,false,18),
	('cautiont tape','2016-5-15',null,'jk',false,true,false,18);
    
    select * from Route;
    
insert into Climb_set(CLIMB_ID,ROUTE_ID)
	values

		(3,2),
		(3,3),
		(2,4),
		(1,5),
		(3,6),
		(2,7),
		(3,8),
		(3,9),
		(2,10),
		(3,12),
		(2,13),
		(2,14),
		(2,15),
		(2,16),
		(2,17),
		(3,18),
		(2,19),
		(3,20),
		(2,21),
		(2,22),
		(2,23),
		(1,23),
		(3,24),
		(2,25),
		(1,26),
		(1,27),
		(2,28),
		(2,29),
		(2,30),
		(3,31),
		(3,32),
		(1,33),
		(3,34),
		(1,35),
		(1,36),
		(2,36);
    
    select * from Climb_set;
    

insert into Diff_is(ROUTE_ID,DIFF_ID)
	values
		(1,1),
		(2,2),
		(3,3),
		(4,4),
		(5,5),
		(6,6),
		(7,7),
		(8,8),
		(9,9),
		(10,10),
		(11,11),
		(12,12),
		(13,13),
		(14,5),
		(15,6),
		(16,3),
		(17,2),
		(18,5),
		(19,3),
		(20,7),
		(21,14),
		(22,5),
		(23,15),
		(24,18),
		(25,12),
		(26,3),
		(27,4),
		(28,2),
		(29,3),
		(30,5),
		(31,6),
		(32,17),
		(33,16),
		(34,2),
		(35,3),
		(36,4);
    
		select * from Diff_is;
    
insert into Climbed(CLIMB_ID,ROUTE_ID,attempts_to_complete,completed,difficulty_adjust,rating)
	values
		(1,1,1,true,0,5),
        (2,1,2,true,-1,4),
        (3,1,1,true,-1,3),
        (4,1,5,false,-2,1),
		(1,2,1,true,0,5),
        (2,2,2,true,1,4),
        (3,2,1,true,-1,3),
        (4,2,5,false,-2,1),
		(1,3,1,true,0,5),
        (2,3,2,true,1,4),
        (3,3,17,true,-1,3),
        (4,3,8,false,0,1),
		(1,4,1,true,0,5),
        (2,5,3,true,0,4),
        (3,6,1,true,-1,3),
        (4,7,5,false,-2,1),
		(1,7,14,true,0,5),
        (2,8,2,true,1,4),
        (3,9,1,true,0,3),
        (4,10,5,false,-2,1),
		(1,11,1,true,0,5),
        (2,12,35,true,1,4),
        (3,13,1,true,0,3),
        (4,14,3,false,1,4),
		(1,15,1,true,0,5),
        (2,16,16,true,1,4),
        (3,17,1,true,-1,3),
        (4,18,8,false,-2,1),
		(1,19,9,true,0,5),
        (2,20,2,true,1,4),
        (3,21,10,true,0,3),
        (4,22,5,true,0,5),
		(1,22,1,true,0,5),
        (2,22,23,true,1,4),
        (3,30,1,true,0,3),
        (4,30,6,true,-2,1),
		(1,30,13,true,0,5),
        (2,30,2,true,1,4),
        (3,29,4,true,-1,3),
        (4,33,7,true,-2,1),
		(1,27,1,true,0,5),
        (2,31,7,false,1,4),
        (3,27,11,true,0,3),
        (4,25,5,false,0,1);
        
        select * from Climbed;
 -- END DATA ENTREY
 
 -- START QUREY WRITTING
 
 #ALL BOULDER ROUTES UP BY GYM #7
 select g.name as Gym_name, wall_numb, r.name as Route_name, v_number, primary_color, secondary_color, style
 from Gym g
 join Wall w on w.GYM_ID = g.GYM_ID
 join Route r on r.WALL_ID = w.WALL_ID
 join Diff_is di on di.ROUTE_ID = r.ROUTE_ID
 join Difficulty d on d.DIFF_ID = di.DIFF_ID
 where is_boulder = true 
 group by r.ROUTE_ID;
 
 
 # AVG v3+ at Cali GYM's #9
 select g.name as Gym_name
 from Gym g
 join Wall w on w.GYM_ID = g.GYM_ID
 join Route r on r.WALL_ID = w.WALL_ID
 join Diff_is di on di.ROUTE_ID = r.ROUTE_ID
 join Difficulty d on d.DIFF_ID = di.DIFF_ID
 where is_boulder = true 
 group by g.GYM_ID
 having AVG(d.DIFF_ID) > 6;
 
 
 #UNION gym name and climbers first name? #11
 select g.name as name
 from Gym g
 union 
 select c.first as name
 from Climber c;
 
 
 #distinct state #12
 select distinct state
 from Gym
 order by state;
 
 
 #"non-trivial" if someone completed the first route, they help set it #13
 insert into Climb_set
 select c.CLIMB_ID,r.ROUTE_ID
 from Route r
 join Climbed cb on r.ROUTE_ID = cb.ROUTE_ID
 join Climber c on cb.CLIMB_ID = c.CLIMB_ID
 where completed = true and r.ROUTE_ID = 1
 group by cb.CLIMB_ID;
 
 select * from Climb_set where ROUTE_ID = 1;
 
 #"non-trivial" View, not used above Gives all of the stats of a setter #14
 create or replace view setter_stats as
 select c.first as setter_name, Avg(cb.rating) as Avg_rate, count(cb.route_id) as Routes_set,
		sum(cb.completed) as people_completed_routes,sum(cb.attempts_to_complete) as total_attempts_across_routes
 from Climber c
 left join Climb_set cs on c.CLIMB_ID = cs.CLIMB_ID
 join Route r on cs.ROUTE_ID = r.ROUTE_ID
 join Climbed cb on r.ROUTE_ID = cb.ROUTE_ID
 group by c.CLIMB_ID;
 
 select setter_name, Avg_rate, people_completed_routes from setter_stats where Setter_name = 'Jane';
 
 
 #Stored Function  very rough aprox Number of vertical feet climbed #15
DROP FUNCTION IF EXISTS aporx_feet_climbed;
    
DELIMITER //
CREATE FUNCTION aporx_feet_climbed(_email varchar(255)) RETURNS int
    BEGIN
    DECLARE feet_climbed int;
    
    Select sum(height) INTO feet_climbed
    FROM Wall w
    join Route r on w.WALL_ID = r.ROUTE_ID
    join Climbed cb on r.ROUTE_ID = cb.ROUTE_ID
    join Climber c on cb.CLIMB_ID = c.CLIMB_ID
    where c.email = _email;
    RETURN feet_climbed;
    
   END//
DELIMITER ;

select aporx_feet_climbed(email) from Climber;

 #Stored Procedure #16
 DROP PROCEDURE IF EXISTS climbers_at_gym;
 
 DELIMITER //
	CREATE PROCEDURE climbers_at_gym(_name varchar(256))
    BEGIN
    SELECT c.first,c.last 
    from Gym g
    join Wall w on g.GYM_ID = w.GYM_ID
    join Route r on w.WALL_ID = r.WALL_ID
    join Climbed cb on r.ROUTE_ID = cb.ROUTE_ID
    join Climber c on cb.CLIMB_ID = c.CLIMB_ID
    where g.name = _name
    group by c.CLIMB_ID;
    END //
DELIMITER ;
    
    CALL climbers_at_gym('Planet Granite');