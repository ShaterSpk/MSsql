USE [MI_Pohorelsky_Michal_projekt]
GO
/****** Object:  User [garant]    Script Date: 2.12.2018 21:59:12 ******/
CREATE USER [garant] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[db_datawriter]
GO
/****** Object:  User [programme academic board]    Script Date: 2.12.2018 21:59:12 ******/
CREATE USER [programme academic board] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[db_ddladmin]
GO
/****** Object:  User [rocnikovy_ucitel1]    Script Date: 2.12.2018 21:59:12 ******/
CREATE USER [rocnikovy_ucitel1] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[db_datawriter]
GO
/****** Object:  User [student]    Script Date: 2.12.2018 21:59:12 ******/
CREATE USER [student] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[db_datareader]
GO
/****** Object:  User [studijni_referentka]    Script Date: 2.12.2018 21:59:12 ******/
CREATE USER [studijni_referentka] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[db_datawriter]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [garant]
GO
ALTER ROLE [db_owner] ADD MEMBER [programme academic board]
GO
ALTER ROLE [db_denydatawriter] ADD MEMBER [rocnikovy_ucitel1]
GO
ALTER ROLE [db_datareader] ADD MEMBER [student]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [studijni_referentka]
GO
/****** Object:  Table [dbo].[prihlaska]    Script Date: 2.12.2018 21:59:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[prihlaska](
	[Id_prihlasky] [int] IDENTITY(1,1) NOT NULL,
	[Jmeno] [varchar](20) NOT NULL,
	[Prijmeni] [varchar](50) NOT NULL,
	[Rodne_cislo] [varchar](11) NOT NULL,
	[mesto] [varchar](60) NOT NULL,
	[ulice] [varchar](50) NOT NULL,
	[psc] [varchar](5) NOT NULL,
	[predchozi_vzdelani] [varchar](10) NOT NULL,
	[datum] [datetime] NULL,
	[potvrzeno] [bit] NULL,
	[id_program] [int] NULL,
	[Id_obor] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_prihlasky] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[platby_prihlaska]    Script Date: 2.12.2018 21:59:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[platby_prihlaska](
	[id_platby_prihlaska] [int] IDENTITY(1,1) NOT NULL,
	[zaplaceno] [datetime] NULL,
	[castka] [smallmoney] NOT NULL,
	[ID] [int] NULL,
	[id_prihlasky] [int] NULL,
	[potvrzeno] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_platby_prihlaska] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[studijni_referentka_prihlaska]    Script Date: 2.12.2018 21:59:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[studijni_referentka_prihlaska]  
AS  
SELECT e.Id_prihlasky, e.Prijmeni, e.potvrzeno,p.zaplaceno,p.castka
FROM prihlaska e  
inner join platby_prihlaska p  
ON p.id_prihlasky = e.Id_prihlasky 
  

GO
/****** Object:  Table [dbo].[student]    Script Date: 2.12.2018 21:59:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[student](
	[login] [int] IDENTITY(1,1) NOT NULL,
	[Jmeno] [varchar](20) NOT NULL,
	[Prijmeni] [varchar](50) NOT NULL,
	[Rodne_cislo] [varchar](11) NOT NULL,
	[mesto] [varchar](60) NOT NULL,
	[ulice] [varchar](50) NOT NULL,
	[psc] [varchar](5) NOT NULL,
	[potvrzenoZS1] [bit] NULL,
	[potvrzenoZS2] [bit] NULL,
	[potvrzenoLS1] [bit] NULL,
	[potvrzenoLS2] [bit] NULL,
	[rocnik] [tinyint] NOT NULL,
	[kredity] [tinyint] NULL,
	[studium] [bit] NULL,
	[id_program] [int] NULL,
	[Id_obor] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[login] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[platby_semestr]    Script Date: 2.12.2018 21:59:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[platby_semestr](
	[id_platby] [int] IDENTITY(1,1) NOT NULL,
	[semestr] [varchar](2) NOT NULL,
	[termin] [datetime] NOT NULL,
	[castka] [smallmoney] NOT NULL,
	[ID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_platby] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[student_platby]    Script Date: 2.12.2018 21:59:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[student_platby](
	[zaplaceno] [datetime] NULL,
	[login] [int] NOT NULL,
	[id_platby] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[login] ASC,
	[id_platby] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[studijni_referentka_platby]    Script Date: 2.12.2018 21:59:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[studijni_referentka_platby] 
AS  
SELECT e.login, e.Prijmeni,p.id_platby,l.termin,l.castka,l.semestr,p.zaplaceno
FROM student e  
inner join student_platby p
ON p.login = e.login
inner join platby_semestr l
ON l.id_platby=p.id_platby


GO
/****** Object:  View [dbo].[student_obecne]    Script Date: 2.12.2018 21:59:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[student_obecne] 
as
select * from student;
GO
/****** Object:  Table [dbo].[hodnoceni]    Script Date: 2.12.2018 21:59:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[hodnoceni](
	[id_hodnoceni] [int] IDENTITY(1,1) NOT NULL,
	[body] [tinyint] NOT NULL,
	[ID] [int] NULL,
	[id_termin] [int] NULL,
	[login] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_hodnoceni] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[hodnoceni_zav_prace]    Script Date: 2.12.2018 21:59:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[hodnoceni_zav_prace](
	[id_hodnoceni_zav_prace] [int] IDENTITY(1,1) NOT NULL,
	[body] [tinyint] NOT NULL,
	[splneno] [bit] NULL,
	[ID] [int] NULL,
	[id__zav_prace] [int] NULL,
	[login] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_hodnoceni_zav_prace] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[karta_predmetu_CZ]    Script Date: 2.12.2018 21:59:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[karta_predmetu_CZ](
	[id_kartyCZ] [int] IDENTITY(1,1) NOT NULL,
	[obsah_predmetu] [text] NULL,
	[cil_predmetu] [text] NULL,
	[kriteria] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_kartyCZ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[karta_predmetu_eng]    Script Date: 2.12.2018 21:59:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[karta_predmetu_eng](
	[id_kartyENG] [int] IDENTITY(1,1) NOT NULL,
	[obsah_predmetu] [text] NULL,
	[cil_predmetu] [text] NULL,
	[kriteria] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_kartyENG] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[obor]    Script Date: 2.12.2018 21:59:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[obor](
	[Id_obor] [int] IDENTITY(1,1) NOT NULL,
	[nazev] [varchar](100) NOT NULL,
	[profil_absolventa] [varchar](256) NOT NULL,
	[fakulta] [varchar](60) NOT NULL,
	[delka] [tinyint] NOT NULL,
	[celkovy_pocet_kreditu] [tinyint] NOT NULL,
	[id_program] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_obor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[obor_predmet]    Script Date: 2.12.2018 21:59:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[obor_predmet](
	[zkratka] [varchar](10) NOT NULL,
	[id_obor] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[zkratka] ASC,
	[id_obor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pozice]    Script Date: 2.12.2018 21:59:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pozice](
	[id_pozice] [int] IDENTITY(1,1) NOT NULL,
	[nazev] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_pozice] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[predmet]    Script Date: 2.12.2018 21:59:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[predmet](
	[zkratka] [varchar](10) NOT NULL,
	[nazev] [varchar](100) NULL,
	[povinost] [varchar](2) NOT NULL,
	[pocet_kreditu] [tinyint] NOT NULL,
	[semestr] [varchar](2) NOT NULL,
	[rocnik] [tinyint] NOT NULL,
	[fakulta] [varchar](30) NULL,
	[ukonceni] [varchar](30) NULL,
	[id_kartyCZ] [int] NULL,
	[id_kartyENG] [int] NULL,
	[ID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[zkratka] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[registrace_termin]    Script Date: 2.12.2018 21:59:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[registrace_termin](
	[login] [int] NOT NULL,
	[id_termin] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[login] ASC,
	[id_termin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[registrace_zav_prace]    Script Date: 2.12.2018 21:59:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[registrace_zav_prace](
	[login] [int] NOT NULL,
	[id_zav_prace] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_zav_prace] ASC,
	[login] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[student_predmet]    Script Date: 2.12.2018 21:59:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[student_predmet](
	[splneno] [bit] NULL,
	[znamka] [varchar](1) NULL,
	[zkratka] [varchar](10) NOT NULL,
	[login] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[login] ASC,
	[zkratka] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[studijni_program]    Script Date: 2.12.2018 21:59:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[studijni_program](
	[Id_program] [int] IDENTITY(1,1) NOT NULL,
	[nazev] [varchar](100) NOT NULL,
	[profil_absolventa] [varchar](256) NOT NULL,
	[fakulta] [varchar](60) NOT NULL,
	[ID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_program] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[termin]    Script Date: 2.12.2018 21:59:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[termin](
	[id_termin] [int] IDENTITY(1,1) NOT NULL,
	[datum] [datetime] NOT NULL,
	[druh] [varchar](30) NOT NULL,
	[ID] [int] NULL,
	[zkratka] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_termin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[zamestnanci]    Script Date: 2.12.2018 21:59:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[zamestnanci](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[id_pozice] [int] NULL,
	[Jmeno] [varchar](20) NOT NULL,
	[Prijmeni] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[zaverecna_prace]    Script Date: 2.12.2018 21:59:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[zaverecna_prace](
	[id_zav_prace] [int] IDENTITY(1,1) NOT NULL,
	[tema] [text] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_zav_prace] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[hodnoceni]  WITH CHECK ADD FOREIGN KEY([ID])
REFERENCES [dbo].[zamestnanci] ([ID])
GO
ALTER TABLE [dbo].[hodnoceni]  WITH CHECK ADD FOREIGN KEY([id_termin])
REFERENCES [dbo].[termin] ([id_termin])
GO
ALTER TABLE [dbo].[hodnoceni]  WITH CHECK ADD FOREIGN KEY([login])
REFERENCES [dbo].[student] ([login])
GO
ALTER TABLE [dbo].[hodnoceni_zav_prace]  WITH CHECK ADD FOREIGN KEY([id__zav_prace])
REFERENCES [dbo].[zaverecna_prace] ([id_zav_prace])
GO
ALTER TABLE [dbo].[hodnoceni_zav_prace]  WITH CHECK ADD FOREIGN KEY([login])
REFERENCES [dbo].[student] ([login])
GO
ALTER TABLE [dbo].[hodnoceni_zav_prace]  WITH CHECK ADD FOREIGN KEY([ID])
REFERENCES [dbo].[zamestnanci] ([ID])
GO
ALTER TABLE [dbo].[obor]  WITH CHECK ADD FOREIGN KEY([id_program])
REFERENCES [dbo].[studijni_program] ([Id_program])
GO
ALTER TABLE [dbo].[obor_predmet]  WITH CHECK ADD FOREIGN KEY([id_obor])
REFERENCES [dbo].[obor] ([Id_obor])
GO
ALTER TABLE [dbo].[obor_predmet]  WITH CHECK ADD FOREIGN KEY([zkratka])
REFERENCES [dbo].[predmet] ([zkratka])
GO
ALTER TABLE [dbo].[platby_prihlaska]  WITH CHECK ADD FOREIGN KEY([id_prihlasky])
REFERENCES [dbo].[prihlaska] ([Id_prihlasky])
GO
ALTER TABLE [dbo].[platby_prihlaska]  WITH CHECK ADD FOREIGN KEY([ID])
REFERENCES [dbo].[zamestnanci] ([ID])
GO
ALTER TABLE [dbo].[platby_semestr]  WITH CHECK ADD FOREIGN KEY([ID])
REFERENCES [dbo].[zamestnanci] ([ID])
GO
ALTER TABLE [dbo].[predmet]  WITH CHECK ADD FOREIGN KEY([ID])
REFERENCES [dbo].[zamestnanci] ([ID])
GO
ALTER TABLE [dbo].[predmet]  WITH CHECK ADD FOREIGN KEY([id_kartyCZ])
REFERENCES [dbo].[karta_predmetu_CZ] ([id_kartyCZ])
GO
ALTER TABLE [dbo].[predmet]  WITH CHECK ADD FOREIGN KEY([id_kartyENG])
REFERENCES [dbo].[karta_predmetu_eng] ([id_kartyENG])
GO
ALTER TABLE [dbo].[prihlaska]  WITH CHECK ADD FOREIGN KEY([Id_obor])
REFERENCES [dbo].[obor] ([Id_obor])
GO
ALTER TABLE [dbo].[prihlaska]  WITH CHECK ADD FOREIGN KEY([id_program])
REFERENCES [dbo].[studijni_program] ([Id_program])
GO
ALTER TABLE [dbo].[registrace_termin]  WITH CHECK ADD FOREIGN KEY([id_termin])
REFERENCES [dbo].[termin] ([id_termin])
GO
ALTER TABLE [dbo].[registrace_termin]  WITH CHECK ADD FOREIGN KEY([login])
REFERENCES [dbo].[student] ([login])
GO
ALTER TABLE [dbo].[registrace_zav_prace]  WITH CHECK ADD FOREIGN KEY([id_zav_prace])
REFERENCES [dbo].[zaverecna_prace] ([id_zav_prace])
GO
ALTER TABLE [dbo].[registrace_zav_prace]  WITH CHECK ADD FOREIGN KEY([login])
REFERENCES [dbo].[student] ([login])
GO
ALTER TABLE [dbo].[student]  WITH CHECK ADD FOREIGN KEY([Id_obor])
REFERENCES [dbo].[obor] ([Id_obor])
GO
ALTER TABLE [dbo].[student]  WITH CHECK ADD FOREIGN KEY([id_program])
REFERENCES [dbo].[studijni_program] ([Id_program])
GO
ALTER TABLE [dbo].[student_platby]  WITH CHECK ADD FOREIGN KEY([id_platby])
REFERENCES [dbo].[platby_semestr] ([id_platby])
GO
ALTER TABLE [dbo].[student_platby]  WITH CHECK ADD FOREIGN KEY([login])
REFERENCES [dbo].[student] ([login])
GO
ALTER TABLE [dbo].[student_predmet]  WITH CHECK ADD FOREIGN KEY([login])
REFERENCES [dbo].[student] ([login])
GO
ALTER TABLE [dbo].[student_predmet]  WITH CHECK ADD FOREIGN KEY([zkratka])
REFERENCES [dbo].[predmet] ([zkratka])
GO
ALTER TABLE [dbo].[studijni_program]  WITH CHECK ADD FOREIGN KEY([ID])
REFERENCES [dbo].[zamestnanci] ([ID])
GO
ALTER TABLE [dbo].[termin]  WITH CHECK ADD FOREIGN KEY([ID])
REFERENCES [dbo].[zamestnanci] ([ID])
GO
ALTER TABLE [dbo].[termin]  WITH CHECK ADD FOREIGN KEY([zkratka])
REFERENCES [dbo].[predmet] ([zkratka])
GO
ALTER TABLE [dbo].[zamestnanci]  WITH CHECK ADD FOREIGN KEY([id_pozice])
REFERENCES [dbo].[pozice] ([id_pozice])
GO
/****** Object:  StoredProcedure [dbo].[prihlaska_vyplneni]    Script Date: 2.12.2018 21:59:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[prihlaska_vyplneni]
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
GO
/****** Object:  StoredProcedure [dbo].[vytvoreni_studenta]    Script Date: 2.12.2018 21:59:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[vytvoreni_studenta]
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
GO

SET IDENTITY_INSERT [dbo].[pozice] ON 

INSERT [dbo].[pozice] ([id_pozice], [nazev]) VALUES (1, N'garant')
INSERT [dbo].[pozice] ([id_pozice], [nazev]) VALUES (2, N'učitel')
INSERT [dbo].[pozice] ([id_pozice], [nazev]) VALUES (3, N'programme academic board')
INSERT [dbo].[pozice] ([id_pozice], [nazev]) VALUES (4, N'studijni referentka')
INSERT [dbo].[pozice] ([id_pozice], [nazev]) VALUES (5, N'rocnikovy ucitel')
SET IDENTITY_INSERT [dbo].[pozice] OFF
SET IDENTITY_INSERT [dbo].[zamestnanci] ON 

INSERT [dbo].[zamestnanci] ([ID], [id_pozice], [Jmeno], [Prijmeni]) VALUES (1, 1, N'Miloš', N'Koch')
INSERT [dbo].[zamestnanci] ([ID], [id_pozice], [Jmeno], [Prijmeni]) VALUES (2, 2, N'Michal', N'Pohořelský')
INSERT [dbo].[zamestnanci] ([ID], [id_pozice], [Jmeno], [Prijmeni]) VALUES (3, 2, N'Jan', N'Hujíček')
INSERT [dbo].[zamestnanci] ([ID], [id_pozice], [Jmeno], [Prijmeni]) VALUES (4, 2, N'Pavel', N'Skopal')
INSERT [dbo].[zamestnanci] ([ID], [id_pozice], [Jmeno], [Prijmeni]) VALUES (5, 3, N'Alena', N'Kocmanová')
INSERT [dbo].[zamestnanci] ([ID], [id_pozice], [Jmeno], [Prijmeni]) VALUES (6, 3, N'Jiří', N'Kříž')
INSERT [dbo].[zamestnanci] ([ID], [id_pozice], [Jmeno], [Prijmeni]) VALUES (7, 3, N'Tomáš', N'Purkert')
INSERT [dbo].[zamestnanci] ([ID], [id_pozice], [Jmeno], [Prijmeni]) VALUES (8, 3, N'David', N'Čejka')
INSERT [dbo].[zamestnanci] ([ID], [id_pozice], [Jmeno], [Prijmeni]) VALUES (9, 4, N'Monika', N'Kubelková')
SET IDENTITY_INSERT [dbo].[zamestnanci] OFF
SET IDENTITY_INSERT [dbo].[zaverecna_prace] ON 

INSERT [dbo].[zaverecna_prace] ([id_zav_prace], [tema]) VALUES (1, N'programování')
INSERT [dbo].[zaverecna_prace] ([id_zav_prace], [tema]) VALUES (2, N'bussiness intelligence')
INSERT [dbo].[zaverecna_prace] ([id_zav_prace], [tema]) VALUES (3, N'ICT managemet')
SET IDENTITY_INSERT [dbo].[zaverecna_prace] OFF
SET IDENTITY_INSERT [dbo].[studijni_program] ON 

INSERT [dbo].[studijni_program] ([Id_program], [nazev], [profil_absolventa], [fakulta], [ID]) VALUES (1, N'MSc. In Bussiness an Informatics', N'sdsds', N'Podnikatelská', 1)
SET IDENTITY_INSERT [dbo].[studijni_program] OFF
SET IDENTITY_INSERT [dbo].[obor] ON 

INSERT [dbo].[obor] ([Id_obor], [nazev], [profil_absolventa], [fakulta], [delka], [celkovy_pocet_kreditu], [id_program]) VALUES (3, N'Bussiness and Informatics', N'asdasdasd', N'Podnikatelská', 2, 180, 1)
SET IDENTITY_INSERT [dbo].[obor] OFF
SET IDENTITY_INSERT [dbo].[student] ON 

INSERT [dbo].[student] ([login], [Jmeno], [Prijmeni], [Rodne_cislo], [mesto], [ulice], [psc], [potvrzenoZS1], [potvrzenoZS2], [potvrzenoLS1], [potvrzenoLS2], [rocnik], [kredity], [studium], [id_program], [Id_obor]) VALUES (20, N'Michalm', N'Pohorelskm', N'11111111111', N'šumperk', N'zahradni', N'78701', NULL, NULL, NULL, NULL, 1, NULL, 1, 1, 3)
INSERT [dbo].[student] ([login], [Jmeno], [Prijmeni], [Rodne_cislo], [mesto], [ulice], [psc], [potvrzenoZS1], [potvrzenoZS2], [potvrzenoLS1], [potvrzenoLS2], [rocnik], [kredity], [studium], [id_program], [Id_obor]) VALUES (21, N'Michalm', N'Pohorelskm', N'11111111111', N'šumperk', N'zahradni', N'78701', NULL, NULL, NULL, NULL, 1, NULL, 1, 1, 3)
INSERT [dbo].[student] ([login], [Jmeno], [Prijmeni], [Rodne_cislo], [mesto], [ulice], [psc], [potvrzenoZS1], [potvrzenoZS2], [potvrzenoLS1], [potvrzenoLS2], [rocnik], [kredity], [studium], [id_program], [Id_obor]) VALUES (22, N'Michal', N'Pohorelsk', N'11111111111', N'šumperk', N'zahradni', N'78701', NULL, NULL, NULL, NULL, 1, NULL, 1, 1, 3)
INSERT [dbo].[student] ([login], [Jmeno], [Prijmeni], [Rodne_cislo], [mesto], [ulice], [psc], [potvrzenoZS1], [potvrzenoZS2], [potvrzenoLS1], [potvrzenoLS2], [rocnik], [kredity], [studium], [id_program], [Id_obor]) VALUES (23, N'Michala', N'Pohorelska', N'11111111111', N'šumperk', N'zahradni', N'78701', NULL, NULL, NULL, NULL, 1, NULL, 1, 1, 3)
INSERT [dbo].[student] ([login], [Jmeno], [Prijmeni], [Rodne_cislo], [mesto], [ulice], [psc], [potvrzenoZS1], [potvrzenoZS2], [potvrzenoLS1], [potvrzenoLS2], [rocnik], [kredity], [studium], [id_program], [Id_obor]) VALUES (24, N'Pavel', N'Novák', N'222222', N'šumperk', N'finska', N'78701', NULL, NULL, NULL, NULL, 1, NULL, 1, 1, 3)
INSERT [dbo].[student] ([login], [Jmeno], [Prijmeni], [Rodne_cislo], [mesto], [ulice], [psc], [potvrzenoZS1], [potvrzenoZS2], [potvrzenoLS1], [potvrzenoLS2], [rocnik], [kredity], [studium], [id_program], [Id_obor]) VALUES (25, N'Tomáš', N'Purkert', N'3333', N'šumperk', N'podsenovou', N'78701', NULL, NULL, NULL, NULL, 1, NULL, 1, 1, 3)
INSERT [dbo].[student] ([login], [Jmeno], [Prijmeni], [Rodne_cislo], [mesto], [ulice], [psc], [potvrzenoZS1], [potvrzenoZS2], [potvrzenoLS1], [potvrzenoLS2], [rocnik], [kredity], [studium], [id_program], [Id_obor]) VALUES (26, N'Josef', N'Kuba', N'44444444', N'rapotin', N'podsenovou', N'78701', NULL, NULL, NULL, NULL, 1, NULL, 1, 1, 3)
INSERT [dbo].[student] ([login], [Jmeno], [Prijmeni], [Rodne_cislo], [mesto], [ulice], [psc], [potvrzenoZS1], [potvrzenoZS2], [potvrzenoLS1], [potvrzenoLS2], [rocnik], [kredity], [studium], [id_program], [Id_obor]) VALUES (28, N'Andrea', N'Pokojová', N'55555', N'sumperk', N'podsenovou', N'78701', NULL, NULL, NULL, NULL, 1, NULL, 1, 1, 3)
INSERT [dbo].[student] ([login], [Jmeno], [Prijmeni], [Rodne_cislo], [mesto], [ulice], [psc], [potvrzenoZS1], [potvrzenoZS2], [potvrzenoLS1], [potvrzenoLS2], [rocnik], [kredity], [studium], [id_program], [Id_obor]) VALUES (29, N'Michala', N'Pokojová', N'66666666', N'sumperk', N'finska', N'78701', NULL, NULL, NULL, NULL, 1, NULL, 1, 1, 3)
SET IDENTITY_INSERT [dbo].[student] OFF
SET IDENTITY_INSERT [dbo].[hodnoceni_zav_prace] ON 

INSERT [dbo].[hodnoceni_zav_prace] ([id_hodnoceni_zav_prace], [body], [splneno], [ID], [id__zav_prace], [login]) VALUES (1, 100, 1, 1, 2, 20)
SET IDENTITY_INSERT [dbo].[hodnoceni_zav_prace] OFF
INSERT [dbo].[predmet] ([zkratka], [nazev], [povinost], [pocet_kreditu], [semestr], [rocnik], [fakulta], [ukonceni], [id_kartyCZ], [id_kartyENG], [ID]) VALUES (N'SapC', N'Advanced Programmin', N'P', 10, N'ZS', 1, N'Podnikatelská', N'z,zk', NULL, NULL, 2)
INSERT [dbo].[predmet] ([zkratka], [nazev], [povinost], [pocet_kreditu], [semestr], [rocnik], [fakulta], [ukonceni], [id_kartyCZ], [id_kartyENG], [ID]) VALUES (N'SbiC', N'Bussiness Inteligence', N'p', 10, N'LS', 1, N'Podnikatelská', N'z,zk', NULL, NULL, NULL)
INSERT [dbo].[predmet] ([zkratka], [nazev], [povinost], [pocet_kreditu], [semestr], [rocnik], [fakulta], [ukonceni], [id_kartyCZ], [id_kartyENG], [ID]) VALUES (N'ScicC', N'Competitve Intelligence', N'p', 10, N'LS', 2, N'Podnikatelská', N'z,zk', NULL, NULL, NULL)
INSERT [dbo].[predmet] ([zkratka], [nazev], [povinost], [pocet_kreditu], [semestr], [rocnik], [fakulta], [ukonceni], [id_kartyCZ], [id_kartyENG], [ID]) VALUES (N'ScpC', N'Consultancy Project', N'p', 20, N'ZS', 2, N'Podnikatelská', N'kz', NULL, NULL, NULL)
INSERT [dbo].[predmet] ([zkratka], [nazev], [povinost], [pocet_kreditu], [semestr], [rocnik], [fakulta], [ukonceni], [id_kartyCZ], [id_kartyENG], [ID]) VALUES (N'SdC', N'Dissertation', N'p', 40, N'LS', 2, N'Podnikatelská', N'kz', NULL, NULL, NULL)
INSERT [dbo].[predmet] ([zkratka], [nazev], [povinost], [pocet_kreditu], [semestr], [rocnik], [fakulta], [ukonceni], [id_kartyCZ], [id_kartyENG], [ID]) VALUES (N'Sel1C', N'English Language', N'P', 0, N'ZS', 1, N'Podnikatelská', N'z', NULL, NULL, NULL)
INSERT [dbo].[predmet] ([zkratka], [nazev], [povinost], [pocet_kreditu], [semestr], [rocnik], [fakulta], [ukonceni], [id_kartyCZ], [id_kartyENG], [ID]) VALUES (N'Sel2C', N'English language', N'p', 10, N'LS', 1, N'Podnikatelská', N'z,zk', NULL, NULL, NULL)
INSERT [dbo].[predmet] ([zkratka], [nazev], [povinost], [pocet_kreditu], [semestr], [rocnik], [fakulta], [ukonceni], [id_kartyCZ], [id_kartyENG], [ID]) VALUES (N'SemC', N'Econometrics Models', N'p', 5, N'LS', 1, N'Podnikatelská', N'z,zk', NULL, NULL, NULL)
INSERT [dbo].[predmet] ([zkratka], [nazev], [povinost], [pocet_kreditu], [semestr], [rocnik], [fakulta], [ukonceni], [id_kartyCZ], [id_kartyENG], [ID]) VALUES (N'SfaC', N'Financial Analysis', N'p', 5, N'ZS', 2, N'Podnikatelská', N'z,zk', NULL, NULL, NULL)
INSERT [dbo].[predmet] ([zkratka], [nazev], [povinost], [pocet_kreditu], [semestr], [rocnik], [fakulta], [ukonceni], [id_kartyCZ], [id_kartyENG], [ID]) VALUES (N'SictmC', N'ICT Management', N'p', 5, N'ZS', 2, N'Podnikatelská', N'z,zk', NULL, NULL, NULL)
INSERT [dbo].[predmet] ([zkratka], [nazev], [povinost], [pocet_kreditu], [semestr], [rocnik], [fakulta], [ukonceni], [id_kartyCZ], [id_kartyENG], [ID]) VALUES (N'SisC', N'Information Systems', N'p', 5, N'ZS', 2, N'Podnikatelská', N'z,zk', NULL, NULL, NULL)
INSERT [dbo].[predmet] ([zkratka], [nazev], [povinost], [pocet_kreditu], [semestr], [rocnik], [fakulta], [ukonceni], [id_kartyCZ], [id_kartyENG], [ID]) VALUES (N'SmaC', N'Managerial Accounting', N'p', 5, N'ZS', 2, N'Podnikatelská', N'z,zk', NULL, NULL, NULL)
INSERT [dbo].[predmet] ([zkratka], [nazev], [povinost], [pocet_kreditu], [semestr], [rocnik], [fakulta], [ukonceni], [id_kartyCZ], [id_kartyENG], [ID]) VALUES (N'SmC', N'Marketing', N'p', 5, N'ZS', 1, N'Podnikatelská', N'z,zk', NULL, NULL, 2)
INSERT [dbo].[predmet] ([zkratka], [nazev], [povinost], [pocet_kreditu], [semestr], [rocnik], [fakulta], [ukonceni], [id_kartyCZ], [id_kartyENG], [ID]) VALUES (N'Sorc', N'Operational Research', N'p', 5, N'LS', 1, N'Podnikatelská', N'z,zk', NULL, NULL, NULL)
INSERT [dbo].[predmet] ([zkratka], [nazev], [povinost], [pocet_kreditu], [semestr], [rocnik], [fakulta], [ukonceni], [id_kartyCZ], [id_kartyENG], [ID]) VALUES (N'SpmC', N'Project Management', N'p', 5, N'ZS', 1, N'Podnikatelská', N'z,zk', NULL, NULL, 2)
INSERT [dbo].[predmet] ([zkratka], [nazev], [povinost], [pocet_kreditu], [semestr], [rocnik], [fakulta], [ukonceni], [id_kartyCZ], [id_kartyENG], [ID]) VALUES (N'SqmC', N'Quality Management', N'P', 5, N'ZS', 1, N'Podnikatelská', N'z,zk', NULL, NULL, NULL)
INSERT [dbo].[predmet] ([zkratka], [nazev], [povinost], [pocet_kreditu], [semestr], [rocnik], [fakulta], [ukonceni], [id_kartyCZ], [id_kartyENG], [ID]) VALUES (N'SrmC', N'Risk Management', N'p', 10, N'LS', 2, N'Podnikatelská', N'z,zk', NULL, NULL, NULL)
INSERT [dbo].[predmet] ([zkratka], [nazev], [povinost], [pocet_kreditu], [semestr], [rocnik], [fakulta], [ukonceni], [id_kartyCZ], [id_kartyENG], [ID]) VALUES (N'SsaC', N'Simulation analysis', N'p', 5, N'LS', 1, N'Podnikatelská', N'z,zk', NULL, NULL, NULL)
INSERT [dbo].[predmet] ([zkratka], [nazev], [povinost], [pocet_kreditu], [semestr], [rocnik], [fakulta], [ukonceni], [id_kartyCZ], [id_kartyENG], [ID]) VALUES (N'SsmC', N'Statics Models', N'p', 5, N'LS', 1, N'Podnikatelská', N'z,zk', NULL, NULL, NULL)
INSERT [dbo].[predmet] ([zkratka], [nazev], [povinost], [pocet_kreditu], [semestr], [rocnik], [fakulta], [ukonceni], [id_kartyCZ], [id_kartyENG], [ID]) VALUES (N'SstmC', N'Strategic Management', N'p', 10, N'LS', 2, N'Podnikatelská', N'z,zk', NULL, NULL, NULL)
INSERT [dbo].[predmet] ([zkratka], [nazev], [povinost], [pocet_kreditu], [semestr], [rocnik], [fakulta], [ukonceni], [id_kartyCZ], [id_kartyENG], [ID]) VALUES (N'SubeC', N'Understanding Bussiness Environment', N'p', 5, N'ZS', 1, N'Podnikatelská', N'z,zk', NULL, NULL, 2)
SET IDENTITY_INSERT [dbo].[termin] ON 

INSERT [dbo].[termin] ([id_termin], [datum], [druh], [ID], [zkratka]) VALUES (3, CAST(N'2018-12-12T00:00:00.000' AS DateTime), N'zapocet', 2, N'Sapc')
INSERT [dbo].[termin] ([id_termin], [datum], [druh], [ID], [zkratka]) VALUES (4, CAST(N'2019-01-04T00:00:00.000' AS DateTime), N'zk', 2, N'Sapc')
SET IDENTITY_INSERT [dbo].[termin] OFF
SET IDENTITY_INSERT [dbo].[prihlaska] ON 

INSERT [dbo].[prihlaska] ([Id_prihlasky], [Jmeno], [Prijmeni], [Rodne_cislo], [mesto], [ulice], [psc], [predchozi_vzdelani], [datum], [potvrzeno], [id_program], [Id_obor]) VALUES (21, N'Michalm', N'Pohorelskm', N'11111111111', N'šumperk', N'zahradni', N'78701', N'BC', CAST(N'2018-12-02T13:45:11.530' AS DateTime), 1, 1, 3)
INSERT [dbo].[prihlaska] ([Id_prihlasky], [Jmeno], [Prijmeni], [Rodne_cislo], [mesto], [ulice], [psc], [predchozi_vzdelani], [datum], [potvrzeno], [id_program], [Id_obor]) VALUES (22, N'Michal', N'Pohorelsk', N'11111111111', N'šumperk', N'zahradni', N'78701', N'BC', CAST(N'2018-12-02T14:09:18.287' AS DateTime), 1, 1, 3)
INSERT [dbo].[prihlaska] ([Id_prihlasky], [Jmeno], [Prijmeni], [Rodne_cislo], [mesto], [ulice], [psc], [predchozi_vzdelani], [datum], [potvrzeno], [id_program], [Id_obor]) VALUES (23, N'Michala', N'Pohorelska', N'11111111111', N'šumperk', N'zahradni', N'78701', N'BC', CAST(N'2018-12-02T14:12:49.063' AS DateTime), 1, 1, 3)
INSERT [dbo].[prihlaska] ([Id_prihlasky], [Jmeno], [Prijmeni], [Rodne_cislo], [mesto], [ulice], [psc], [predchozi_vzdelani], [datum], [potvrzeno], [id_program], [Id_obor]) VALUES (24, N'Pavel', N'Novák', N'222222', N'šumperk', N'finska', N'78701', N'BC', CAST(N'2018-12-02T16:07:04.000' AS DateTime), 1, 1, 3)
INSERT [dbo].[prihlaska] ([Id_prihlasky], [Jmeno], [Prijmeni], [Rodne_cislo], [mesto], [ulice], [psc], [predchozi_vzdelani], [datum], [potvrzeno], [id_program], [Id_obor]) VALUES (25, N'Tomáš', N'Purkert', N'3333', N'šumperk', N'podsenovou', N'78701', N'BC', CAST(N'2018-12-02T16:07:37.330' AS DateTime), 1, 1, 3)
INSERT [dbo].[prihlaska] ([Id_prihlasky], [Jmeno], [Prijmeni], [Rodne_cislo], [mesto], [ulice], [psc], [predchozi_vzdelani], [datum], [potvrzeno], [id_program], [Id_obor]) VALUES (26, N'Josef', N'Kuba', N'44444444', N'rapotin', N'podsenovou', N'78701', N'BC', CAST(N'2018-12-02T16:08:06.940' AS DateTime), 1, 1, 3)
INSERT [dbo].[prihlaska] ([Id_prihlasky], [Jmeno], [Prijmeni], [Rodne_cislo], [mesto], [ulice], [psc], [predchozi_vzdelani], [datum], [potvrzeno], [id_program], [Id_obor]) VALUES (27, N'Andrea', N'Pokojová', N'55555', N'sumperk', N'podsenovou', N'78701', N'BC', CAST(N'2018-12-02T16:09:34.023' AS DateTime), 1, 1, 3)
INSERT [dbo].[prihlaska] ([Id_prihlasky], [Jmeno], [Prijmeni], [Rodne_cislo], [mesto], [ulice], [psc], [predchozi_vzdelani], [datum], [potvrzeno], [id_program], [Id_obor]) VALUES (28, N'Michala', N'Pokojová', N'66666666', N'sumperk', N'finska', N'78701', N'BC', CAST(N'2018-12-02T16:10:14.457' AS DateTime), 1, 1, 3)
INSERT [dbo].[prihlaska] ([Id_prihlasky], [Jmeno], [Prijmeni], [Rodne_cislo], [mesto], [ulice], [psc], [predchozi_vzdelani], [datum], [potvrzeno], [id_program], [Id_obor]) VALUES (29, N'Elena', N'Hrozová', N'66666666', N'sumperk', N'finska', N'78701', N'BC', CAST(N'2018-12-02T16:10:49.843' AS DateTime), NULL, 1, 3)
SET IDENTITY_INSERT [dbo].[prihlaska] OFF
SET IDENTITY_INSERT [dbo].[platby_prihlaska] ON 

INSERT [dbo].[platby_prihlaska] ([id_platby_prihlaska], [zaplaceno], [castka], [ID], [id_prihlasky], [potvrzeno]) VALUES (8, NULL, 400.0000, 9, 21, NULL)
INSERT [dbo].[platby_prihlaska] ([id_platby_prihlaska], [zaplaceno], [castka], [ID], [id_prihlasky], [potvrzeno]) VALUES (9, CAST(N'2018-12-12T00:00:00.000' AS DateTime), 400.0000, 9, 22, NULL)
INSERT [dbo].[platby_prihlaska] ([id_platby_prihlaska], [zaplaceno], [castka], [ID], [id_prihlasky], [potvrzeno]) VALUES (10, NULL, 400.0000, 9, 23, 0)
INSERT [dbo].[platby_prihlaska] ([id_platby_prihlaska], [zaplaceno], [castka], [ID], [id_prihlasky], [potvrzeno]) VALUES (11, NULL, 400.0000, 9, 24, NULL)
INSERT [dbo].[platby_prihlaska] ([id_platby_prihlaska], [zaplaceno], [castka], [ID], [id_prihlasky], [potvrzeno]) VALUES (12, NULL, 400.0000, 9, 25, NULL)
INSERT [dbo].[platby_prihlaska] ([id_platby_prihlaska], [zaplaceno], [castka], [ID], [id_prihlasky], [potvrzeno]) VALUES (13, NULL, 400.0000, 9, 26, NULL)
INSERT [dbo].[platby_prihlaska] ([id_platby_prihlaska], [zaplaceno], [castka], [ID], [id_prihlasky], [potvrzeno]) VALUES (14, NULL, 400.0000, 9, 27, NULL)
INSERT [dbo].[platby_prihlaska] ([id_platby_prihlaska], [zaplaceno], [castka], [ID], [id_prihlasky], [potvrzeno]) VALUES (15, NULL, 400.0000, 9, 28, NULL)
INSERT [dbo].[platby_prihlaska] ([id_platby_prihlaska], [zaplaceno], [castka], [ID], [id_prihlasky], [potvrzeno]) VALUES (16, NULL, 400.0000, 9, 29, NULL)
SET IDENTITY_INSERT [dbo].[platby_prihlaska] OFF
SET IDENTITY_INSERT [dbo].[hodnoceni] ON 

INSERT [dbo].[hodnoceni] ([id_hodnoceni], [body], [ID], [id_termin], [login]) VALUES (1, 80, 1, 3, 21)
SET IDENTITY_INSERT [dbo].[hodnoceni] OFF
INSERT [dbo].[obor_predmet] ([zkratka], [id_obor]) VALUES (N'Sapc', 3)
INSERT [dbo].[obor_predmet] ([zkratka], [id_obor]) VALUES (N'SbiC', 3)
INSERT [dbo].[obor_predmet] ([zkratka], [id_obor]) VALUES (N'Scpc', 3)
INSERT [dbo].[obor_predmet] ([zkratka], [id_obor]) VALUES (N'SdC', 3)
INSERT [dbo].[obor_predmet] ([zkratka], [id_obor]) VALUES (N'Sel1C', 3)
INSERT [dbo].[obor_predmet] ([zkratka], [id_obor]) VALUES (N'Sel2C', 3)
INSERT [dbo].[obor_predmet] ([zkratka], [id_obor]) VALUES (N'Semc', 3)
INSERT [dbo].[obor_predmet] ([zkratka], [id_obor]) VALUES (N'SfaC', 3)
INSERT [dbo].[obor_predmet] ([zkratka], [id_obor]) VALUES (N'SictmC', 3)
INSERT [dbo].[obor_predmet] ([zkratka], [id_obor]) VALUES (N'SisC', 3)
INSERT [dbo].[obor_predmet] ([zkratka], [id_obor]) VALUES (N'Smac', 3)
INSERT [dbo].[obor_predmet] ([zkratka], [id_obor]) VALUES (N'SmC', 3)
INSERT [dbo].[obor_predmet] ([zkratka], [id_obor]) VALUES (N'SorC', 3)
INSERT [dbo].[obor_predmet] ([zkratka], [id_obor]) VALUES (N'SpmC', 3)
INSERT [dbo].[obor_predmet] ([zkratka], [id_obor]) VALUES (N'SqmC', 3)
INSERT [dbo].[obor_predmet] ([zkratka], [id_obor]) VALUES (N'SrmC', 3)
INSERT [dbo].[obor_predmet] ([zkratka], [id_obor]) VALUES (N'SsaC', 3)
INSERT [dbo].[obor_predmet] ([zkratka], [id_obor]) VALUES (N'Ssmc', 3)
INSERT [dbo].[obor_predmet] ([zkratka], [id_obor]) VALUES (N'SstmC', 3)
INSERT [dbo].[obor_predmet] ([zkratka], [id_obor]) VALUES (N'Subec', 3)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SapC', 21)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SbiC', 21)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'ScicC', 21)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'ScpC', 21)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SdC', 21)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'Sel1C', 21)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'Sel2C', 21)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SemC', 21)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SfaC', 21)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SictmC', 21)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SisC', 21)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SmaC', 21)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SmC', 21)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'Sorc', 21)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SpmC', 21)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SqmC', 21)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SrmC', 21)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SsaC', 21)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SsmC', 21)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SstmC', 21)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SubeC', 21)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SapC', 22)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SbiC', 22)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'ScicC', 22)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'ScpC', 22)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SdC', 22)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'Sel1C', 22)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'Sel2C', 22)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SemC', 22)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SfaC', 22)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SictmC', 22)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SisC', 22)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SmaC', 22)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SmC', 22)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'Sorc', 22)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SpmC', 22)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SqmC', 22)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SrmC', 22)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SsaC', 22)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SsmC', 22)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SstmC', 22)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SubeC', 22)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SapC', 23)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SbiC', 23)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'ScicC', 23)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'ScpC', 23)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SdC', 23)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'Sel1C', 23)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'Sel2C', 23)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SemC', 23)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SfaC', 23)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SictmC', 23)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SisC', 23)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SmaC', 23)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SmC', 23)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'Sorc', 23)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SpmC', 23)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SqmC', 23)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SrmC', 23)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SsaC', 23)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SsmC', 23)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SstmC', 23)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SubeC', 23)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SapC', 24)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SbiC', 24)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'ScicC', 24)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'ScpC', 24)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SdC', 24)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'Sel1C', 24)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'Sel2C', 24)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SemC', 24)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SfaC', 24)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SictmC', 24)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SisC', 24)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SmaC', 24)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SmC', 24)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'Sorc', 24)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SpmC', 24)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SqmC', 24)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SrmC', 24)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SsaC', 24)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SsmC', 24)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SstmC', 24)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SubeC', 24)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SapC', 25)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SbiC', 25)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'ScicC', 25)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'ScpC', 25)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SdC', 25)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'Sel1C', 25)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'Sel2C', 25)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SemC', 25)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SfaC', 25)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SictmC', 25)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SisC', 25)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SmaC', 25)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SmC', 25)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'Sorc', 25)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SpmC', 25)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SqmC', 25)
GO
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SrmC', 25)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SsaC', 25)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SsmC', 25)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SstmC', 25)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SubeC', 25)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SapC', 26)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SbiC', 26)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'ScicC', 26)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'ScpC', 26)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SdC', 26)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'Sel1C', 26)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'Sel2C', 26)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SemC', 26)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SfaC', 26)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SictmC', 26)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SisC', 26)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SmaC', 26)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SmC', 26)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'Sorc', 26)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SpmC', 26)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SqmC', 26)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SrmC', 26)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SsaC', 26)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SsmC', 26)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SstmC', 26)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SubeC', 26)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SapC', 28)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SbiC', 28)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'ScicC', 28)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'ScpC', 28)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SdC', 28)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'Sel1C', 28)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'Sel2C', 28)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SemC', 28)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SfaC', 28)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SictmC', 28)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SisC', 28)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SmaC', 28)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SmC', 28)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'Sorc', 28)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SpmC', 28)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SqmC', 28)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SrmC', 28)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SsaC', 28)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SsmC', 28)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SstmC', 28)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SubeC', 28)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SapC', 29)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SbiC', 29)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'ScicC', 29)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'ScpC', 29)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SdC', 29)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'Sel1C', 29)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'Sel2C', 29)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SemC', 29)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SfaC', 29)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SictmC', 29)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SisC', 29)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SmaC', 29)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SmC', 29)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'Sorc', 29)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SpmC', 29)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SqmC', 29)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SrmC', 29)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SsaC', 29)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SsmC', 29)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SstmC', 29)
INSERT [dbo].[student_predmet] ([splneno], [znamka], [zkratka], [login]) VALUES (NULL, NULL, N'SubeC', 29)
INSERT [dbo].[registrace_termin] ([login], [id_termin]) VALUES (21, 3)
INSERT [dbo].[registrace_zav_prace] ([login], [id_zav_prace]) VALUES (20, 2)
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