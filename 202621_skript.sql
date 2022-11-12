create database MI_Pohorelsky_Michal_projekt;

use MI_Pohorelsky_Michal_projekt;
CREATE TABLE pozice(
id_pozice int identity (1,1) primary key,
nazev varchar(30) not null
);


CREATE TABLE zamestnanci(
ID int identity (1,1) primary key,
id_pozice int foreign key references pozice(id_pozice),
Jmeno varchar(20) not null,
Prijmeni varchar(50) not null
);



CREATE TABLE studijni_program(
Id_program int identity (1,1) primary key,
nazev varchar(100) not null,
profil_absolventa varchar(256) not null,
fakulta varchar(60) not null,
ID int foreign key references zamestnanci(ID),

);


CREATE TABLE obor(
Id_obor int identity (1,1) primary key,
nazev varchar(100) not null,
profil_absolventa varchar(256) not null,
fakulta varchar(60) not null,
delka tinyint not null,
celkovy_pocet_kreditu tinyint not null,
id_program int foreign key references studijni_program(id_program),

);





CREATE TABLE prihlaska(
Id_prihlasky int identity (1,1) primary key,
Jmeno varchar(20) not null,
Prijmeni varchar(50) not null,
Rodne_cislo varchar(11) not null,
mesto varchar(60) not null,
ulice varchar(50) not null,
psc varchar(5) not null,
predchozi_vzdelani varchar(10) not null,
datum datetime,
potvrzeno bit,
id_program int foreign key references studijni_program(id_program),
Id_obor int foreign key references obor(id_obor)
);


CREATE TABLE karta_predmetu_eng(
id_kartyENG int identity (1,1) primary key,
obsah_predmetu text ,
cil_predmetu text,
kriteria text
);

CREATE TABLE karta_predmetu_CZ(
id_kartyCZ int identity (1,1) primary key,
obsah_predmetu text ,
cil_predmetu text,
kriteria text
);

CREATE TABLE predmet(
zkratka varchar(10) primary key,
nazev varchar(100) not null,
povinost varchar(2) not null,
pocet_kreditu tinyint not null,
semestr varchar(2) not null,
rocnik tinyint not null,
fakulta varchar(30),
ukonceni varchar(30),
id_kartyCZ int foreign key references karta_predmetu_cz(id_kartyCZ),
id_kartyENG int foreign key references karta_predmetu_eng(id_kartyENG),
ID int foreign key references zamestnanci(ID)
);


CREATE TABLE obor_predmet(
zkratka varchar(10) foreign key references predmet(zkratka),
id_obor int foreign key references obor(id_obor)
Primary key(zkratka,id_obor)
);

CREATE TABLE termin(
id_termin int identity (1,1) primary key,
datum datetime not null,
druh varchar(30) not null,
zkratka varchar(10) foreign key references predmet(zkratka),
ID int foreign key references zamestnanci(ID)
);

CREATE TABLE zaverecna_prace(
id_zav_prace int identity (1,1) primary key,
tema text not null,
);



CREATE TABLE student(
login int identity (1,1) primary key,
Jmeno varchar(20) not null,
Prijmeni varchar(50) not null,
Rodne_cislo varchar(11) not null,
mesto varchar(60) not null,
ulice varchar(50) not null,
psc varchar(5) not null,
potvrzenoZS1 bit,
potvrzenoZS2 bit,
potvrzenoLS1 bit,
potvrzenoLS2 bit,
rocnik tinyint not null,
kredity tinyint,
studium bit,
id_program int foreign key references studijni_program(id_program),
Id_obor int foreign key references obor(id_obor)
);

CREATE TABLE platby_semestr(
id_platby int identity (1,1) primary key,
semestr varchar(2) not null,
termin datetime not null,
castka smallmoney not null,
ID int foreign key references zamestnanci(ID)
);


CREATE TABLE student_platby(
zaplaceno datetime,
login int foreign key references student(login),
id_platby int foreign key references platby_semestr(id_platby),
Primary key(login,id_platby)
);


CREATE TABLE platby_prihlaska(
id_platby_prihlaska int identity (1,1) primary key,
termin datetime not null,
zaplaceno datetime,
castka smallmoney not null,
ID int foreign key references zamestnanci(ID),
id_prihlasky int foreign key references prihlaska(id_prihlasky),
);

CREATE TABLE registrace_zav_prace(
login int foreign key references student(login),
id_zav_prace int foreign key references zaverecna_prace(id_zav_prace),
Primary key(id_zav_prace,login)
);

CREATE TABLE registrace_termin(
login int foreign key references student(login),
id_termin int foreign key references termin(id_termin),
Primary key(login,id_termin)
);


CREATE TABLE student_predmet(
splneno bit,
znamka varchar(1),
zkratka varchar(10) foreign key references predmet(zkratka),
login int foreign key references student(login),
Primary key(login,zkratka)
);

CREATE TABLE hodnoceni(
id_hodnoceni int identity (1,1) primary key,
body tinyint not null,
ID int foreign key references zamestnanci(ID),
id_termin int foreign key references termin(id_termin),
login int foreign key references student(login)
);

CREATE TABLE hodnoceni_zav_prace(
id_hodnoceni_zav_prace int identity (1,1) primary key,
body tinyint not null,
splneno bit,
ID int foreign key references zamestnanci(ID),
id__zav_prace int foreign key references zaverecna_prace(id_zav_prace),
login int foreign key references student(login)
);


CREATE PROCEDURE prihlaska_vyplneni
(
@jmeno varchar(20),
@prijmeni varchar(50),
@Rodne_cislo varchar(11),
@mesto varchar(60) ,
@ulice varchar(50) ,
@psc varchar(5) ,
@predchozi_vzdelani varchar(10) ,

@id_program int ,
@Id_obor int,
@id_student int output
)
AS
BEGIN
  SET @id_student = (SELECT TOP 1 login
	FROM student
	WHERE jmeno = @jmeno AND prijmeni = @prijmeni)
  IF (@id_student IS NULL)
    BEGIN
	 INSERT INTO prihlaska (jmeno, prijmeni,Rodne_cislo,mesto,ulice,psc,predchozi_vzdelani,datum,id_program,Id_obor)
	 VALUES (@jmeno, @prijmeni,@Rodne_cislo,@mesto,@ulice,@psc,@predchozi_vzdelani,GETDATE(),@id_program,@Id_obor)
	 SET @id_student = @@IDENTITY
	END
   END
   go

   declare @id_student int;
   
   execute prihlaska_vyplneni Michal, Pohorelsky , 11111111111, šumperk, zahradni, 78701, BC,1,1,@id_student;

Create trigger platby_za_prihlasku on prihlaska
after insert
as 
begin
declare 
	@id_prihlasky int,
	@castka smallmoney,
	@id int
	
set @id_prihlasky=(SELECT TOP 1 id_prihlasky FROM prihlaska ORDER BY id_prihlasky DESC)
set @castka=400
set @id=(select top 1 id from zamestnanci where id=9)
insert into platby_prihlaska (id_prihlasky,ID,castka)
values (@id_prihlasky,@id,@castka)
end

declare @id_student int;
   
   execute prihlaska_vyplneni Michalm, Pohorelskm , 11111111111, šumperk, zahradni, 78701, BC,1,3,@id_student;

   select * from platby_prihlaska;


CREATE VIEW studijni_referentka_prihlaska  
AS  
SELECT e.Id_prihlasky, e.Prijmeni, e.potvrzeno,p.zaplaceno,p.castka
FROM prihlaska e  
inner join platby_prihlaska p  
ON p.id_prihlasky = e.Id_prihlasky 
  

go

CREATE VIEW studijni_referentka_platby 
AS  
SELECT e.login, e.Prijmeni,p.id_platby,l.termin,l.castka,l.semestr,p.zaplaceno
FROM student e  
inner join student_platby p
ON p.login = e.login
inner join platby_semestr l
ON l.id_platby=p.id_platby


go

create procedure vytvoreni_studenta
(
@id_prihlasky int,
@potvrzeno bit)
as
begin
declare 
@rocnik1 int,
@jmeno varchar(20),
@prijmeni varchar(50),
@Rodne_cislo varchar(11),
@mesto varchar(60) ,
@ulice varchar(50) ,
@psc varchar(5) ,
@id_program int,
@id_obor int,
@studium bit

set @rocnik1=1
set @prijmeni=(select prijmeni from prihlaska where Id_prihlasky=@id_prihlasky)
set @jmeno=(select Jmeno from prihlaska where Id_prihlasky=@id_prihlasky)
set @rodne_cislo=(select Rodne_cislo from prihlaska where Id_prihlasky=@id_prihlasky) 
set @mesto=(select mesto from prihlaska where Id_prihlasky=@id_prihlasky)
set @ulice =(select ulice from prihlaska where Id_prihlasky=@id_prihlasky)
set @psc=(select psc from prihlaska where Id_prihlasky=@id_prihlasky)
set @id_program =(select id_program from prihlaska where Id_prihlasky=@id_prihlasky)
set @id_obor=(select id_obor from prihlaska where Id_prihlasky=@id_prihlasky)

if @potvrzeno='true' begin
set @studium='true'
UPDATE prihlaska  
SET potvrzeno = @potvrzeno  
WHERE Id_prihlasky = @id_prihlasky;
insert into student(Prijmeni,Jmeno,Rodne_cislo,mesto,ulice,psc,id_program,Id_obor,rocnik,studium)
values( @Prijmeni,@Jmeno,@Rodne_cislo,@mesto,@ulice,@psc,@id_program,@Id_obor,@rocnik1,@studium ) 
end
else

print 'student nebyl vytvoren';
end;

exec vytvoreni_studenta 12,'true';

select * from prihlaska;
select* from student;

 DECLARE list_neplaticu_prihlaska CURSOR for select a.jmeno,a.prijmeni from prihlaska a,platby_prihlaska b where a.id_prihlasky=b.id_prihlasky and b.potvrzeno='false'

   declare @jmeno varchar(50),@prijmeni varchar (50)
   
   
   open list_neplaticu_prihlaska
   FETCH list_neplaticu_prihlaska INTO @jmeno,@prijmeni 
   
   while @@FETCH_STATUS=0
   begin
	print @jmeno+' '+@prijmeni
	fetch list_neplaticu_prihlaska INTO @jmeno,@prijmeni 
	end
	close list_neplaticu_prihlaska


  insert into student_predmet(zkratka,login)
   values('SapC',21),
   ('SbiC',21),
   ('ScicC',21),
('ScpC',21),
('SdC',21),
('Sel1C',21),
('Sel2C',21),
('SemC',21),
('SfaC',21),
('SictmC',21),
('SisC',21),
('SmaC',21),
('SmC',21),
('Sorc',21),
('SpmC',21),
('SqmC',21),
('SrmC',21),
('SsaC',21),
('SsmC',21),
('SstmC',21),
('SubeC',21)

insert into student_predmet(zkratka,login)
   values('SapC',22),
   ('SbiC',22),
   ('ScicC',22),
('ScpC',22),
('SdC',22),
('Sel1C',22),
('Sel2C',22),
('SemC',22),
('SfaC',22),
('SictmC',22),
('SisC',22),
('SmaC',22),
('SmC',22),
('Sorc',22),
('SpmC',22),
('SqmC',22),
('SrmC',22),
('SsaC',22),
('SsmC',22),
('SstmC',22),
('SubeC',22)

insert into student_predmet(zkratka,login)
   values('SapC',23),
   ('SbiC',23),
   ('ScicC',23),
('ScpC',23),
('SdC',23),
('Sel1C',23),
('Sel2C',23),
('SemC',23),
('SfaC',23),
('SictmC',23),
('SisC',23),
('SmaC',23),
('SmC',23),
('Sorc',23),
('SpmC',23),
('SqmC',23),
('SrmC',23),
('SsaC',23),
('SsmC',23),
('SstmC',23),
('SubeC',23)

insert into student_predmet(zkratka,login)
   values('SapC',24),
   ('SbiC',24),
   ('ScicC',24),
('ScpC',24),
('SdC',24),
('Sel1C',24),
('Sel2C',24),
('SemC',24),
('SfaC',24),
('SictmC',24),
('SisC',24),
('SmaC',24),
('SmC',24),
('Sorc',24),
('SpmC',24),
('SqmC',24),
('SrmC',24),
('SsaC',24),
('SsmC',24),
('SstmC',24),
('SubeC',24)

 insert into student_predmet(zkratka,login)
   values('SapC',25),
   ('SbiC',25),
   ('ScicC',25),
('ScpC',25),
('SdC',25),
('Sel1C',25),
('Sel2C',25),
('SemC',25),
('SfaC',25),
('SictmC',25),
('SisC',25),
('SmaC',25),
('SmC',25),
('Sorc',25),
('SpmC',25),
('SqmC',25),
('SrmC',25),
('SsaC',25),
('SsmC',25),
('SstmC',25),
('SubeC',25)

  insert into student_predmet(zkratka,login)
   values('SapC',26),
   ('SbiC',26),
   ('ScicC',26),
('ScpC',26),
('SdC',26),
('Sel1C',26),
('Sel2C',26),
('SemC',26),
('SfaC',26),
('SictmC',26),
('SisC',26),
('SmaC',26),
('SmC',26),
('Sorc',26),
('SpmC',26),
('SqmC',26),
('SrmC',26),
('SsaC',26),
('SsmC',26),
('SstmC',26),
('SubeC',26)

 insert into student_predmet(zkratka,login)
   values('SapC',27),
   ('SbiC',27),
   ('ScicC',27),
('ScpC',27),
('SdC',27),
('Sel1C',27),
('Sel2C',27),
('SemC',27),
('SfaC',27),
('SictmC',27),
('SisC',27),
('SmaC',27),
('SmC',27),
('Sorc',27),
('SpmC',27),
('SqmC',27),
('SrmC',27),
('SsaC',27),
('SsmC',27),
('SstmC',27),
('SubeC',27)


  insert into student_predmet(zkratka,login)
   values('SapC',28),
   ('SbiC',28),
   ('ScicC',28),
('ScpC',28),
('SdC',28),
('Sel1C',28),
('Sel2C',28),
('SemC',28),
('SfaC',28),
('SictmC',28),
('SisC',28),
('SmaC',28),
('SmC',28),
('Sorc',28),
('SpmC',28),
('SqmC',28),
('SrmC',28),
('SsaC',28),
('SsmC',28),
('SstmC',28),
('SubeC',28)

insert into student_predmet(zkratka,login)
   values('SapC',29),
   ('SbiC',29),
   ('ScicC',29),
('ScpC',29),
('SdC',29),
('Sel1C',29),
('Sel2C',29),
('SemC',29),
('SfaC',29),
('SictmC',29),
('SisC',29),
('SmaC',29),
('SmC',29),
('Sorc',29),
('SpmC',29),
('SqmC',29),
('SrmC',29),
('SsaC',29),
('SsmC',29),
('SstmC',29),
('SubeC',29)



create view student_obecne 
as
select * from student;

create view student_hodnoceni 
as
select student.login,hodnoceni.id_termin,hodnoceni.body,hodnoceni.ID,student_predmet.zkratka from student,hodnoceni,student_predmet,termin where student.login=hodnoceni.login and student_predmet.login=student.login and student_predmet.zkratka=termin.zkratka ;

CREATE PROCEDURE vyplneni_hodnoceni
(
@login int,
@id_termin int,
@ID int,
@body int,
@znamka varchar output
)
AS
BEGIN
  
    BEGIN
	 INSERT INTO hodnoceni (body,id,id_termin,login)
	 VALUES (@body,@ID, @id_termin,@login)
	
	if(@body<50)
	set @znamka = 'F'
	else if (@body<60)
	set @znamka = 'E'
	else if (@body<70)
	set @znamka = 'D'
	else if (@body<80)
	set @znamka = 'C'
	else if (@body<90)
	set @znamka = 'B'
	else
	set @znamka = 'A'
	END
   END
   go
