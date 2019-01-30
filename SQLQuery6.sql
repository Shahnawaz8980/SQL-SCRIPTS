create table CustomerLogin (
	CustomerLoginId INT PRIMARY KEY IDENTITY(2000,1),
	LoginName varchar(20) UNIQUE NOT NULL,
	[Password] VARBINARY(300) NOT NULL,
	CustomerId BIGINT CONSTRAINT fk89 FOREIGN KEY REFERENCES Customer(CustomerId),
	IsLocked BIT DEFAULT 0 NOT NULL,
	ModifiedTimestamp DATETIME2 (7)
)
ALTER TABLE CustomerLogin RENAME CONSTRAINT fk TO test_pk;
drop table CustomerLogin;
create table Branch (
	BranchId TINYINT PRIMARY KEY IDENTITY(1,1),
	IFSC VARCHAR(11) UNIQUE NOT NULL,
	BranchName varchar(50) NOT NULL,
	BranchCode VARCHAR(6) UNIQUE NOT NULL
)
drop table Branch;

create table Account (
	AccountId INT PRIMARY KEY IDENTITY(4000,1),
	AccountNumber varchar(15) UNIQUE NOT NULL,
	BranchId TINYINT CONSTRAINT fk2 REFERENCES Branch(BranchId) NOT NULL,
	Balance MONEY NOT NULL CHECK(Balance >= 0) Default 0,
	LockedBalance MONEY,
	IsActive BIT Default 1 NOT NULL,
	CreatedTimeStamp DATETIME2(7) DEFAULT GetDate(),
	CreatedBy TINYINT CONSTRAINT fk3 REFERENCES Teller(TellerId) NOT NULL,
	ModifiedTimeStamp Datetime2(7),
	ModifiedBy TinyInt CONSTRAINT fk4 REFERENCES Teller(TellerId)

)
drop table Account
Create table AccountCustomerMapping(

	AccountCustomerMappingId INT PRIMARY KEY IDENTITY(5000,1),
	AccountNumber varchar(15) CONSTRAINT fk5 REFERENCES Account(AccountNumber) NOT NULL,
	CustomerId BIGINT CONSTRAINT fk6 REFERENCES Customer(CustomerId) NOT NULL,
	IsActive BIT DEFAULT 1,
	CONSTRAINT com_uniq UNIQUE(AccountNumber,CustomerId)
)
drop table AccountCustomerMapping;
Create table DebitCard(
	DebitCardId INT PRIMARY KEY IDENTITY(6000,1),
	DebitCardNumber VARCHAR(16) UNIQUE,
	AccountCustomerMappingId INT CONSTRAINT fk78 REFERENCES AccountCustomerMapping(AccountCustomerMappingId) NOT NULL,
	CVV VARBINARY(300) NOT NULL,
	ValidFrom SMALLDATETIME DEFAULT GetDate() NOT NULL,
	ValidThru SMALLDATETIME DEFAULT GetDate() + 10 NOT NULL,
	PIN VARBINARY(300) NOT NULL,
	IsLocked BIT DEFAULT 0 NOT NULL,
	IsActive BIT DEFAULT 1 NOT NULL,
	CreatedTimeStamp DATETIME2(7) NOT NULL DEFAULT GetDate(),
	CreatedBy TinyInt CONSTRAINT fk8 REFERENCES Teller(TellerId) NOT NULL,
	ModifiedTimeStamp DATETIME2(7)
)
drop table DebitCard
create table [Transaction](
	Transactionid BIGINT PRIMARY KEY IDENTITY(9000000001,1),
	AccountNumber varchar(15) CONSTRAINT fk9 REFERENCES Account(AccountNumber) NOT NULL,
	Amount MONEY CHECK(Amount >0) NOT NULL,
	TransactionDateTime SMALLDATETIME DEFAULT GetDate() NOT NULL,
	Type BIT NOT NULL,
	Mode VARCHAR(20) NOT NULL,
	Remarks varchar(30) ,
	Info VARCHAR(200) NOT NULL,
	CreatedBy varchar(50) NOT NULL
)
drop table [Transaction]

CREATE TABLE Customer 
(
    CustomerId BIGINT CONSTRAINT pk_Customer_CustomerId PRIMARY KEY NOT NULL IDENTITY(1000000001,1),
    EmailId VARCHAR(255) NOT NULL CONSTRAINT uq__Customer_EmailId UNIQUE,
    Name VARCHAR(100) NOT NULL,
    DateOfBirth DATE NOT NULL CONSTRAINT chk_Customer_DateOfBirth CHECK (DATEDIFF(day,DateOfBirth,GETDATE())/(365.25)>=(18)),
    CreatedTimestamp DATETIME2(7) CONSTRAINT df_Customer_CreatedTimeStamp DEFAULT GETDATE() NOT NULL,
    CreatedBy TINYINT NOT NULL CONSTRAINT fk_Customer_CreatedBy FOREIGN KEY (CreatedBy) REFERENCES Teller(TellerId),
    ModifiedTimestamp DATETIME2(7),
    ModifiedBy TINYINT CONSTRAINT fk_Customer_ModifiedBy FOREIGN KEY (ModifiedBy) REFERENCES Teller(TellerId)
)

drop table Customer;

drop table Teller;

CREATE TABLE Teller 
(
    TellerId TINYINT CONSTRAINT pk_Teller_TellerId PRIMARY KEY IDENTITY(1,1),
    LoginName VARCHAR(5) CONSTRAINT uq__Teller_LoginName UNIQUE NOT NULL CONSTRAINT ck_Teller_LoginName CHECK(LoginName like 'T____'),
    [Password] VARBINARY(300) NOT NULL
)


--Insert SCRIPTS

-----------Teller Table

INSERT INTO Teller (LoginName, Password) VALUES ('T1001',CAST('Indy!123' AS VARBINARY))
INSERT INTO Teller (LoginName, Password) VALUES ('T1002',CAST('Indy!123' AS VARBINARY))
INSERT INTO Teller (LoginName, Password) VALUES ('T1003',CAST('Indy!123' AS VARBINARY))
INSERT INTO Teller (LoginName, Password) VALUES ('T1004',CAST('Indy!123' AS VARBINARY))
INSERT INTO Teller (LoginName, Password) VALUES ('T1005',CAST('Indy!123' AS VARBINARY))
INSERT INTO Teller (LoginName, Password) VALUES ('T1006',CAST('Indy!123' AS VARBINARY))
INSERT INTO Teller (LoginName, Password) VALUES ('T1007',CAST('Indy!123' AS VARBINARY))
INSERT INTO Teller (LoginName, Password) VALUES ('T1008',CAST('Indy!123' AS VARBINARY))
INSERT INTO Teller (LoginName, Password) VALUES ('T1009',CAST('Indy!123' AS VARBINARY))
INSERT INTO Teller (LoginName, Password) VALUES ('T1010',CAST('Indy!123' AS VARBINARY))

-----------Customer Table
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('mvanyashkin0@fastcompany.com' , 'Melanie Vanyashkin' , '1993/09/01' , 1 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('rstraun1@nydailynews.com' , 'Ranique Straun' , '1992/08/08' , 1 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('pkahler2@ameblo.jp' , 'Patten Kahler' , '1994/03/13' , 1 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('fhorsewood3@reverbnation.com' , 'Florenza Horsewood' , '1990/02/17' , 1 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('tgeerdts4@arizona.edu' , 'Trescha Geerdts' , '1990/02/06' , 1 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('tvacher5@odnoklassniki.ru' , 'Tyne Vacher' , '1993/08/13' , 1 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('gyarnley6@uiuc.edu' , 'Granville Yarnley' , '1988/12/04' , 1 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('cminer7@slideshare.net' , 'Conny Miner' , '1990/01/07' , 1 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('kvan8@washington.edu' , 'Karyn Van der Kruijs' , '1991/09/08' , 1 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('tgrossier9@domainmarket.com' , 'Teodoor Grossier' , '1990/12/07' , 1 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('apurslowa@thetimes.co.uk' , 'Auria Purslow' , '1988/07/26' , 2 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('adayb@ameblo.jp' , 'Andy Day' , '1990/03/17' , 2 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('dkaysorc@woothemes.com' , 'Doyle Kaysor' , '1990/06/14' , 2 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('pspatad@bloglovin.com' , 'Porty Spata' , '1988/07/10' , 2 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('ddee@google.es' , 'Dell De Cruz' , '1989/06/29' , 2 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('lconfaitf@japanpost.jp' , 'Lawrence Confait' , '1988/11/17' , 2 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('cdearyg@epa.gov' , 'Caria Deary' , '1989/04/10' , 2 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('cwindramh@t.co' , 'Claudette Windram' , '1989/10/14' , 3 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('dcoultishi@google.co.uk' , 'Dottie Coultish' , '1994/01/02' , 4 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('lavesonj@yandex.ru' , 'Lauralee Aveson' , '1993/08/16' , 3 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('btavenerk@bing.com' , 'Bryon Tavener' , '1992/09/17' , 3 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('jbullinl@hao123.com' , 'Jammal Bullin' , '1991/06/26' , 3 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('bcapplemanm@boston.com' , 'Brendon Cappleman' , '1990/01/27' , 3 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('cfilippazzon@twitter.com' , 'Christen Filippazzo' , '1994/04/06' , 3 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('rdarrelo@arizona.edu' , 'Reagan Darrel' , '1992/06/19' , 4 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('gspinksp@barnesandnoble.com' , 'Gib Spinks' , '1994/03/12' , 4 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('rmcilrathq@fastcompany.com' , 'Roseline McIlrath' , '1989/07/29' , 4 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('rmcguggyr@mapy.cz' , 'Rosina McGuggy' , '1990/05/04' , 4 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('dflewins@google.com.au' , 'Doro Flewin' , '1993/04/05' , 4 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('mdivallt@cyberchimps.com' , 'Magda Divall' , '1991/07/22' , 4 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('nstandenu@vk.com' , 'Noella Standen' , '1990/11/27' , 4 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('mcovellv@microsoft.com' , 'Michele Covell' , '1993/08/29' , 4 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('bgoutcherw@virginia.edu' , 'Benedikta Goutcher' , '1990/03/27' , 4 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('rtarrantx@ehow.com' , 'Randy Tarrant' , '1994/05/19' , 4 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('asmeey@symantec.com' , 'Aron Smee' , '1993/08/07' , 4 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('amacqueenz@sfgate.com' , 'Abey MacQueen' , '1989/08/27' , 4 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('jduckerin10@sciencedaily.com' , 'Jami Duckerin' , '1992/06/14' , 4 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('mthorburn11@moonfruit.com' , 'Mitchael Thorburn' , '1990/07/12' , 4 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('fswabey12@kickstarter.com' , 'Fiorenze Swabey' , '1990/07/23' , 4 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('ccomi13@webnode.com' , 'Christoph Comi' , '1993/03/13' , 4 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('kengland14@apple.com' , 'Kincaid England' , '1990/07/12' , 4 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('ckenningham15@yahoo.co.jp' , 'Carolynn Kenningham' , '1989/07/19' , 4 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('jbarnsdale16@timesonline.co.uk' , 'Jonell Barnsdale' , '1990/07/10' , 4 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('cpetrescu17@mozilla.org' , 'Cora Petrescu' , '1994/03/24' , 5 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('ebrasted18@webnode.com' , 'Eve Brasted' , '1990/11/28' , 5 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('egatchel19@amazon.co.uk' , 'Elbert Gatchel' , '1992/04/05' , 5 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('mfairbourn1a@forbes.com' , 'Morgen Fairbourn' , '1992/10/29' , 5 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('ttucknutt1b@freewebs.com' , 'Tillie Tucknutt' , '1993/10/16' , 5 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('blisciandro1c@dyndns.org' , 'Bartram Lisciandro' , '1993/02/05' , 5 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('ndanielli1d@senate.gov' , 'Nessy Danielli' , '1990/06/05' , 5 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('abearne1e@reddit.com' , 'Anjela Bearne' , '1988/09/28' , 5 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('lmorshead1f@sitemeter.com' , 'Linnie Morshead' , '1993/08/10' , 5 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('dwarters1g@meetup.com' , 'Darya Warters' , '1990/12/10' , 5 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('cbartolomieu1h@wired.com' , 'Colette Bartolomieu' , '1988/12/27' , 5 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('wjanoschek1i@squarespace.com' , 'Wat Janoschek' , '1989/02/26' , 5 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('bgirardez1j@telegraph.co.uk' , 'Bennie Girardez' , '1991/03/26' , 1 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('srobelow1k@nytimes.com' , 'Say Robelow' , '1989/06/19' , 1 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('hablitt1l@cocolog-nifty.com' , 'Hedvige Ablitt' , '1991/04/19' , 1 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('gbuckeridge1m@un.org' , 'Glyn Buckeridge' , '1990/01/21' , 1 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('eleece1n@phoca.cz' , 'Ericha Leece' , '1993/05/10' , 1 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('cmacneilly1o@mashable.com' , 'Catina MacNeilly' , '1993/05/11' , 1 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('mmacconchie1p@sfgate.com' , 'Milka MacConchie' , '1993/06/28' , 1 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('sbrewitt1q@arizona.edu' , 'Sherry Brewitt' , '1989/04/06' , 1 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('bheditch1r@hc360.com' , 'Bronson Heditch' , '1989/11/24' , 1 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('tfallon1s@oracle.com' , 'Tandy Fallon' , '1992/04/26' , 2 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('csherborn1t@seattletimes.com' , 'Cole Sherborn' , '1994/04/03' , 2 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('ldonoher1u@cornell.edu' , 'Lissa Donoher' , '1989/12/25' , 2 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('pblenkinsop1v@timesonline.co.uk' , 'Peder Blenkinsop' , '1990/10/10' , 2 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('smarciek1w@zimbio.com' , 'Sebastian Marciek' , '1992/01/19' , 2 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('epleaden1x@pbs.org' , 'Erminie Pleaden' , '1991/08/12' , 2 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('woddie1y@simplemachines.org' , 'Wallace Oddie' , '1989/11/11' , 2 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('dbeaton1z@tuttocitta.it' , 'Dorothee Beaton' , '1991/04/24' , 3 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('dtreeby20@utexas.edu' , 'Dyna Treeby' , '1988/08/21' , 4 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('yjeannard21@phpbb.com' , 'Yovonnda Jeannard' , '1989/09/25' , 3 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('ffobidge22@gmpg.org' , 'Fernandina Fobidge' , '1989/12/21' , 3 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('dkorous23@tmall.com' , 'Danny Korous' , '1989/03/29' , 3 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('rdanslow24@oaic.gov.au' , 'Rolf Danslow' , '1988/12/13' , 3 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('tnorcop25@so-net.ne.jp' , 'Tito Norcop' , '1993/09/23' , 3 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('johogertie26@china.com.cn' , 'Jourdan O Hogertie' , '1992/09/25' , 4 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('hgrece27@blinklist.com' , 'Hewitt Grece' , '1990/07/15' , 4 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('kseaking28@purevolume.com' , 'Kristoforo Seaking' , '1993/10/05' , 4 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('aweildish29@upenn.edu' , 'Annadiana Weildish' , '1993/08/02' , 4 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('pdemead2a@hatena.ne.jp' , 'Prentice Demead' , '1993/02/23' , 4 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('mlavall2b@blogger.com' , 'Mireielle Lavall' , '1989/03/25' , 4 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('mkorb2c@sakura.ne.jp' , 'Mic Korb' , '1989/04/18' , 4 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('alitchmore2d@europa.eu' , 'Anne Litchmore' , '1994/02/11' , 4 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('gsainteau2e@behance.net' , 'Gwenny Sainteau' , '1993/04/27' , 4 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('lnarramore2f@wix.com' , 'Lyndy Narramore' , '1990/02/02' , 4 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('anode2g@vkontakte.ru' , 'Agosto Node' , '1988/06/13' , 4 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('tshuxsmith2h@symantec.com' , 'Thain Shuxsmith' , '1993/12/29' , 4 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('foakwell2i@dot.gov' , 'Faun Oakwell' , '1990/01/27' , 4 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('gemps2j@home.pl' , 'Giffy Emps' , '1994/02/18' , 4 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('haizikov2k@timesonline.co.uk' , 'Holli Aizikov' , '1994/03/02' , 4 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('reberlein2l@mediafire.com' , 'Rafaello Eberlein' , '1994/04/09' , 4 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('ksaffe2m@uiuc.edu' , 'Kelsey Saffe' , '1988/07/30' , 4 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('owyness2n@google.fr' , 'Osborn Wyness' , '1993/02/27' , 4 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('edevote2o@webeden.co.uk' , 'Ernestus Devote' , '1990/01/08' , 4 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('ivenn2p@hao123.com' , 'Idalia Venn' , '1990/01/17' , 5 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('bpalphramand2q@thetimes.co.uk' , 'Bar Palphramand' , '1991/12/15' , 5 , NULL, NULL)
INSERT INTO Customer (EmailId, Name, DateOfBirth, CreatedBy, ModifiedTimestamp, ModifiedBy) VALUES ('yspearman2r@mapquest.com' , 'Yvonne Spearman' , '1988/08/15' , 5 , NULL, NULL)


-----------CustomerLogin Table
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('MelanieV' , CAST('9QXWzY!Bm0J'  AS VARBINARY),1000000001,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('RaniqueS' , CAST( 'ZM70s!CnZr5K'  AS VARBINARY),1000000002,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('PattenK' , CAST( 'i5hVdO*gcQef'  AS VARBINARY),1000000003,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('FlorenzaH' , CAST( 'OXCA&bEeOd4'  AS VARBINARY),1000000004,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('TreschaG' , CAST( 'OLcPC^Q9ft7I'  AS VARBINARY),1000000005,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('TyneV' , CAST( 'QcgK%I6I4sn'  AS VARBINARY),1000000006,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('GranvilleY' , CAST( '9B2T5$jmJu'  AS VARBINARY),1000000007,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('ConnyM' , CAST( 'IW297o#awWo2'  AS VARBINARY),1000000008,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('KarynV' , CAST( '5guW!pBS'  AS VARBINARY),1000000009,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('TeodoorG' , CAST( 'ljhJ4*eIwZr'  AS VARBINARY),1000000010,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('AuriaP' , CAST( 'N44qO&e0AKqR'  AS VARBINARY),1000000011,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('AndyD' , CAST( '25FPgG^WlNEH'  AS VARBINARY),1000000012,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('DoyleK' , CAST( 'cOx%877We'  AS VARBINARY),1000000013,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('PortyS' , CAST( 'soma$Uiz5'  AS VARBINARY),1000000014,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('DellD' , CAST( '9I5YM#pOZT8'  AS VARBINARY),1000000015,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('LawrenceC' , CAST( 'cwG!u8BA7'  AS VARBINARY),1000000016,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('CariaD' , CAST( 'aGg7&IOij'  AS VARBINARY),1000000017,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('ClaudetteW' , CAST( 'Frx^sPa09'  AS VARBINARY),1000000018,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('DottieC' , CAST( 'anepl%9EqVJ8'  AS VARBINARY),1000000019,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('LauraleeA' , CAST( '4xd$7vFif'  AS VARBINARY),1000000020,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('BryonT' , CAST( 'gr1#Sidx'  AS VARBINARY),1000000021,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('JammalB' , CAST( 'IJj!m56Hi'  AS VARBINARY),1000000022,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('BrendonC' , CAST( 'hLtx*sHuH9'  AS VARBINARY),1000000023,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('ChristenF' , CAST( 'g1zc&4ZHt'  AS VARBINARY),1000000024,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('ReaganD' , CAST( 'K6nE^RjI'  AS VARBINARY),1000000025,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('GibS' , CAST( 'FCpaI%c9tGW'  AS VARBINARY),1000000026,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('RoselineM' , CAST( '76bI$Qecq'  AS VARBINARY),1000000027,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('RosinaM' , CAST( 'TTvw1#NZiEbMm'  AS VARBINARY),1000000028,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('DoroF' , CAST( 'B4rT!spdE'  AS VARBINARY),1000000029,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('MagdaD' , CAST( 'yTL*uYW6t'  AS VARBINARY),1000000030,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('NoellaS' , CAST( 'A12y&qVL'  AS VARBINARY),1000000031,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('MicheleC' , CAST( 'NbuV^QF14f0V'  AS VARBINARY),1000000032,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('BenediktaG' , CAST( 'uXl$XO7pl'  AS VARBINARY),1000000033,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('RandyT' , CAST( 'D7pJ%zqzdrJm9'  AS VARBINARY),1000000034,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('AronS' , CAST( 'SlEGY$XddX6RX'  AS VARBINARY),1000000035,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('AbeyM' , CAST( '5Ta1#LFio'  AS VARBINARY),1000000036,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('JamiD' , CAST( 'm8S33!ng9Mo2'  AS VARBINARY),1000000037,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('MitchaelT' , CAST( 'xiN8FV*CEv0qc'  AS VARBINARY),1000000038,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('FiorenzeS' , CAST( '1CqI&prTYB34'  AS VARBINARY),1000000039,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('ChristophC' , CAST( 'jKY^Tne9lu0'  AS VARBINARY),1000000040,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('KincaidE' , CAST( 'oWH9%Gryt'  AS VARBINARY),1000000041,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('CarolynnK' , CAST( 'tNxaf$ag0INcG'  AS VARBINARY),1000000042,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('JonellB' , CAST( '1cty#MqaOm'  AS VARBINARY),1000000043,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('CoraP' , CAST( 'A2m!A5Fui'  AS VARBINARY),1000000044,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('EveB' , CAST( 'gnXN)mp7'  AS VARBINARY),1000000045,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('ElbertG' , CAST( 'DfOo(Zv1BoQex'  AS VARBINARY),1000000046,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('MorgenF' , CAST( 'sEsC*Ep5IgZtQ'  AS VARBINARY),1000000047,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('TillieT' , CAST( '2Top&kI8u'  AS VARBINARY),1000000048,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('BartramL' , CAST( 'Ljmc^ASr7fw'  AS VARBINARY),1000000049,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('NessyD' , CAST( '1cnz%NmRv8'  AS VARBINARY),1000000050,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('AnjelaB' , CAST( 'JEmp$PJZ7'  AS VARBINARY),1000000051,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('LinnieM' , CAST( 'nKgd8#Qwg'  AS VARBINARY),1000000052,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('DaryaW' , CAST( 'Rc1r9!ggs3Z'  AS VARBINARY),1000000053,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('ColetteB' , CAST( '3fg*E7Xseq'  AS VARBINARY),1000000054,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('WatJ' , CAST( 'gK2a&pLjtd'  AS VARBINARY),1000000055,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('BennieG' , CAST( 'fK^opq1*ck'  AS VARBINARY),1000000056,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('SayR' , CAST( 'A1CE4%5WiuZE'  AS VARBINARY),1000000057,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('HedvigeA' , CAST( '5iNb$5Ce'  AS VARBINARY),1000000058,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('GlynB' , CAST( 'k7HUkYY#WiS'  AS VARBINARY),1000000059,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('ErichaL' , CAST( '3jr8!y9sM'  AS VARBINARY),1000000060,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('CatinaM' , CAST( 'RILr3*Bx46Ap'  AS VARBINARY),1000000061,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('MilkaM' , CAST( 'jNkBj&R6nIu7l'  AS VARBINARY),1000000062,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('SherryB' , CAST( 'c7DrM^rHKVW'  AS VARBINARY),1000000063,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('BronsonH' , CAST( 'l09%rEZe'  AS VARBINARY),1000000064,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('TandyF' , CAST( 'Vbl$LLXY'  AS VARBINARY),1000000065,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('ColeS' , CAST( 'ajyZ#aM2'  AS VARBINARY),1000000066,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('LissaD' , CAST( 'ppq!t5OV'  AS VARBINARY),1000000067,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('PederB' , CAST( 'E5G1*9Cmm'  AS VARBINARY),1000000068,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('SebastianM' , CAST( '2OOi&4B8mF8'  AS VARBINARY),1000000069,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('ErminieP' , CAST( 'jWsubk^znSi1'  AS VARBINARY),1000000070,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('WallaceO' , CAST( '8c2F00%u1qx'  AS VARBINARY),1000000071,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('DorotheeB' , CAST( '9tJV$65HZx'  AS VARBINARY),1000000072,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('DynaT' , CAST( 'qTst#k37v'  AS VARBINARY),1000000073,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('YovonndaJ' , CAST( 'irXU6!h7'  AS VARBINARY),1000000074,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('FernandinaF' , CAST( 'tH2z*qCG'  AS VARBINARY),1000000075,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('DannyK' , CAST( '2Yn&rtr6V'  AS VARBINARY),1000000076,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('RolfD' , CAST( 'W1uPm^KdcIa'  AS VARBINARY),1000000077,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('TitoN' , CAST( 'g1BOox%5xY'  AS VARBINARY),1000000078,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('JourdanO' , CAST( 'gVv$wzg7jIQX'  AS VARBINARY),1000000079,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('HewittG' , CAST( 'Dg5y#Pph'  AS VARBINARY),1000000080,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('KristoforoS' , CAST( 'er!MHpo8Ab'  AS VARBINARY),1000000081,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('AnnadianaW' , CAST( '8WYbg*zPA'  AS VARBINARY),1000000082,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('PrenticeD' , CAST( 'lECD&9oqL'  AS VARBINARY),1000000083,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('MireielleL' , CAST( 'GO32^eBSq'  AS VARBINARY),1000000084,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('MicK' , CAST( 'AJs7Ug%cs1ik'  AS VARBINARY),1000000085,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('AnneL' , CAST( 'J3XHn2$fokuUb'  AS VARBINARY),1000000086,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('GwennyS' , CAST( 'QDA6#EHyGS'  AS VARBINARY),1000000087,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('LyndyN' , CAST( 'YtZ6X!FaCOx'  AS VARBINARY),1000000088,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('AgostoN' , CAST( 'jaJp*Dgg8S'  AS VARBINARY),1000000089,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('ThainS' , CAST( 'a8ky&Qtrdmb'  AS VARBINARY),1000000090,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('FaunO' , CAST( 'Vakon^FlS03U'  AS VARBINARY),1000000091,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('GiffyE' , CAST( 'XJP%Ofvork7OG'  AS VARBINARY),1000000092,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('HolliA' , CAST( 'SlD$cPErt'  AS VARBINARY),1000000093,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('RafaelloE' , CAST( 'O4TQ#tYmf'  AS VARBINARY),1000000094,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('KelseyS' , CAST( 'wa507N!ZyIh'  AS VARBINARY),1000000095,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('OsbornW' , CAST( 'cCV5U%deYii'  AS VARBINARY),1000000096,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('ErnestusD' , CAST( 'xui45#fSm'  AS VARBINARY),1000000097,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('IdaliaV' , CAST( 'yUAd2$HbO'  AS VARBINARY),1000000098,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('BarP' , CAST( '8Ox#YYy6H'  AS VARBINARY),1000000099,0, NULL)
INSERT INTO CustomerLogin (LoginName, Password, CustomerId, IsLocked, ModifiedTimestamp) VALUES ('YvonneS' , CAST( 'UhU8i!1wM'  AS VARBINARY),1000000100,0, NULL)

-----------Branch Table
INSERT INTO Branch (IFSC, BranchName, BranchCode) VALUES ('EDUB0007066','Beberibe','007066')
INSERT INTO Branch (IFSC, BranchName, BranchCode) VALUES ('EDUB0007067','Handaqi','007067')
INSERT INTO Branch (IFSC, BranchName, BranchCode) VALUES ('EDUB0007068','Siverskiy','007068')
INSERT INTO Branch (IFSC, BranchName, BranchCode) VALUES ('EDUB0007069','Baiyanghe','007069')
INSERT INTO Branch (IFSC, BranchName, BranchCode) VALUES ('EDUB0007070','Shanling','007070')

INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000001' , 1 ,1 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000002' , 1 ,1 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000003' , 1 ,1 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000004' , 1 ,1 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000005' , 1 ,1 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000006' , 1 ,1 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000007' , 1 ,1 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000008' , 1 ,1 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000009' , 1 ,1 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000010' , 1 ,1 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000011' , 1 ,2 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000012' , 1 ,2 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000013' , 1 ,2 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000014' , 1 ,2 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000015' , 1 ,2 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000016' , 1 ,2 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000017' , 1 ,2 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000018' , 1 ,3 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000019' , 1 ,4 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000020' , 1 ,3 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000021' , 1 ,3 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000022' , 1 ,3 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000023' , 1 ,3 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000024' , 1 ,3 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000025' , 1 ,4 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000026' , 1 ,4 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000027' , 1 ,4 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000028' , 1 ,4 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000029' , 1 ,4 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000030' , 1 ,4 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000031' , 1 ,4 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000032' , 1 ,4 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000033' , 1 ,4 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000034' , 1 ,4 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000035' , 1 ,4 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000036' , 1 ,4 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000037' , 1 ,4 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000038' , 1 ,4 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000039' , 1 ,4 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000040' , 1 ,4 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000041' , 1 ,4 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000042' , 1 ,4 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000043' , 1 ,4 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000044' , 1 ,5 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000045' , 1 ,5 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000046' , 1 ,5 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000047' , 1 ,5 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000048' , 1 ,5 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000049' , 1 ,5 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000050' , 1 ,5 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000051' , 1 ,5 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000052' , 1 ,5 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000053' , 1 ,5 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000054' , 1 ,5 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000055' , 1 ,5 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000056' , 1 ,1 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000057' , 1 ,1 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000058' , 1 ,1 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000059' , 1 ,1 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000060' , 1 ,1 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000061' , 1 ,1 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000062' , 1 ,1 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000063' , 1 ,1 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000064' , 1 ,1 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000065' , 1 ,2 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000066' , 1 ,2 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000067' , 1 ,2 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000068' , 1 ,2 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000069' , 1 ,2 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000070' , 1 ,2 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000071' , 1 ,2 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000072' , 1 ,3 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000073' , 1 ,4 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000074' , 1 ,3 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000075' , 1 ,3 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000076' , 1 ,3 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000077' , 1 ,3 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000078' , 1 ,3 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000079' , 1 ,4 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000080' , 1 ,4 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000081' , 1 ,4 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000082' , 1 ,4 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000083' , 1 ,4 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000084' , 1 ,4 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000085' , 1 ,4 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000086' , 1 ,4 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000087' , 1 ,4 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000088' , 1 ,4 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000089' , 1 ,4 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000090' , 1 ,4 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000091' , 1 ,4 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000092' , 1 ,4 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000093' , 1 ,4 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000094' , 1 ,4 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000095' , 1 ,4 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000096' , 1 ,4 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000097' , 1 ,4 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000098' , 1 ,5 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000099' , 1 ,5 , NULL, NULL)
INSERT INTO Account (AccountNumber, BranchId, CreatedBy, ModifiedTimestamp, ModifiedBy) Values ('007066100000100' , 1 ,5 , NULL, NULL)

select * from Account

-----------AccountCustomerMapping Table
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000001' , 1000000001 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000002' , 1000000002 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000003' , 1000000003 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000004' , 1000000004 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000005' , 1000000005 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000006' , 1000000006 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000007' , 1000000007 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000008' , 1000000008 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000009' , 1000000009 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000010' , 1000000010 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000011' , 1000000011 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000012' , 1000000012 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000013' , 1000000013 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000014' , 1000000014 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000015' , 1000000015 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000016' , 1000000016 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000017' , 1000000017 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000018' , 1000000018 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000019' , 1000000019 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000020' , 1000000020 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000021' , 1000000021 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000022' , 1000000022 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000023' , 1000000023 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000024' , 1000000024 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000025' , 1000000025 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000026' , 1000000026 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000027' , 1000000027 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000028' , 1000000028 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000029' , 1000000029 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000030' , 1000000030 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000031' , 1000000031 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000032' , 1000000032 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000033' , 1000000033 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000034' , 1000000034 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000035' , 1000000035 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000036' , 1000000036 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000037' , 1000000037 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000038' , 1000000038 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000039' , 1000000039 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000040' , 1000000040 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000041' , 1000000041 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000042' , 1000000042 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000043' , 1000000043 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000044' , 1000000044 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000045' , 1000000045 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000046' , 1000000046 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000047' , 1000000047 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000048' , 1000000048 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000049' , 1000000049 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000050' , 1000000050 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000051' , 1000000051 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000052' , 1000000052 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000053' , 1000000053 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000054' , 1000000054 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000055' , 1000000055 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000056' , 1000000056 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000057' , 1000000057 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000058' , 1000000058 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000059' , 1000000059 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000060' , 1000000060 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000061' , 1000000061 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000062' , 1000000062 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000063' , 1000000063 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000064' , 1000000064 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000065' , 1000000065 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000066' , 1000000066 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000067' , 1000000067 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000068' , 1000000068 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000069' , 1000000069 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000070' , 1000000070 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000071' , 1000000071 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000072' , 1000000072 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000073' , 1000000073 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000074' , 1000000074 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000075' , 1000000075 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000076' , 1000000076 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000077' , 1000000077 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000078' , 1000000078 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000079' , 1000000079 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000080' , 1000000080 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000081' , 1000000081 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000082' , 1000000082 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000083' , 1000000083 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000084' , 1000000084 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000085' , 1000000085 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000086' , 1000000086 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000087' , 1000000087 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000088' , 1000000088 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000089' , 1000000089 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000090' , 1000000090 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000091' , 1000000091 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000092' , 1000000092 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000093' , 1000000093 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000094' , 1000000094 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000095' , 1000000095 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000096' , 1000000096 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000097' , 1000000097 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000098' , 1000000098 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000099' , 1000000099 , 1 )
INSERT INTO AccountCustomerMapping (AccountNumber, CustomerId, IsActive) VALUES ('007066100000100' , 1000000100 , 1 )

INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660005,1,CAST( '444'  AS VARBINARY), CAST( '7978'  AS VARBINARY),1, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660017,2,CAST( '441'  AS VARBINARY), CAST( '7879'  AS VARBINARY),1, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660029,3,CAST( '305'  AS VARBINARY), CAST( '6725'  AS VARBINARY),1, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660031,4,CAST( '360'  AS VARBINARY), CAST( '5307'  AS VARBINARY),1, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660043,5,CAST( '953'  AS VARBINARY), CAST( '6981'  AS VARBINARY),1, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660056,6,CAST( '212'  AS VARBINARY), CAST( '1730'  AS VARBINARY),1, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660068,7,CAST( '868'  AS VARBINARY), CAST( '8220'  AS VARBINARY),1, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660070,8,CAST( '247'  AS VARBINARY), CAST( '8094'  AS VARBINARY),1, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660082,9,CAST( '425'  AS VARBINARY), CAST( '3325'  AS VARBINARY),1, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660094,10,CAST( '897'  AS VARBINARY), CAST( '5846'  AS VARBINARY),1, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660106,11,CAST( '220'  AS VARBINARY), CAST( '2378'  AS VARBINARY),2, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660118,12,CAST( '333'  AS VARBINARY), CAST( '5557'  AS VARBINARY),2, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660120,13,CAST( '276'  AS VARBINARY), CAST( '4490'  AS VARBINARY),2, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660132,14,CAST( '183'  AS VARBINARY), CAST( '2676'  AS VARBINARY),2, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660144,15,CAST( '906'  AS VARBINARY), CAST( '8776'  AS VARBINARY),2, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660157,16,CAST( '587'  AS VARBINARY), CAST( '1644'  AS VARBINARY),2, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660169,17,CAST( '268'  AS VARBINARY), CAST( '1857'  AS VARBINARY),2, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660171,18,CAST( '683'  AS VARBINARY), CAST( '7883'  AS VARBINARY),3, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660183,19,CAST( '718'  AS VARBINARY), CAST( '3345'  AS VARBINARY),4, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660195,20,CAST( '895'  AS VARBINARY), CAST( '6459'  AS VARBINARY),3, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660207,21,CAST( '545'  AS VARBINARY), CAST( '1472'  AS VARBINARY),3, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660219,22,CAST( '237'  AS VARBINARY), CAST( '9991'  AS VARBINARY),3, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660221,23,CAST( '908'  AS VARBINARY), CAST( '7310'  AS VARBINARY),3, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660233,24,CAST( '469'  AS VARBINARY), CAST( '5198'  AS VARBINARY),3, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660245,25,CAST( '668'  AS VARBINARY), CAST( '1140'  AS VARBINARY),4, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660258,26,CAST( '574'  AS VARBINARY), CAST( '3949'  AS VARBINARY),4, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660260,27,CAST( '604'  AS VARBINARY), CAST( '5491'  AS VARBINARY),4, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660272,28,CAST( '816'  AS VARBINARY), CAST( '2977'  AS VARBINARY),4, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660284,29,CAST( '994'  AS VARBINARY), CAST( '2351'  AS VARBINARY),4, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660296,30,CAST( '951'  AS VARBINARY), CAST( '1336'  AS VARBINARY),4, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660308,31,CAST( '946'  AS VARBINARY), CAST( '7664'  AS VARBINARY),4, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660310,32,CAST( '728'  AS VARBINARY), CAST( '2957'  AS VARBINARY),4, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660322,33,CAST( '272'  AS VARBINARY), CAST( '5227'  AS VARBINARY),4, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660334,34,CAST( '338'  AS VARBINARY), CAST( '9475'  AS VARBINARY),4, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660346,35,CAST( '488'  AS VARBINARY), CAST( '6242'  AS VARBINARY),4, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660359,36,CAST( '416'  AS VARBINARY), CAST( '4821'  AS VARBINARY),4, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660361,37,CAST( '542'  AS VARBINARY), CAST( '1932'  AS VARBINARY),4, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660373,38,CAST( '406'  AS VARBINARY), CAST( '6311'  AS VARBINARY),4, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660385,39,CAST( '475'  AS VARBINARY), CAST( '8595'  AS VARBINARY),4, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660397,40,CAST( '971'  AS VARBINARY), CAST( '5587'  AS VARBINARY),4, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660409,41,CAST( '995'  AS VARBINARY), CAST( '3284'  AS VARBINARY),4, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660411,42,CAST( '613'  AS VARBINARY), CAST( '4394'  AS VARBINARY),4, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660423,43,CAST( '139'  AS VARBINARY), CAST( '7381'  AS VARBINARY),4, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660435,44,CAST( '387'  AS VARBINARY), CAST( '3322'  AS VARBINARY),5, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660447,45,CAST( '199'  AS VARBINARY), CAST( '6347'  AS VARBINARY),5, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660450,46,CAST( '732'  AS VARBINARY), CAST( '9104'  AS VARBINARY),5, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660462,47,CAST( '127'  AS VARBINARY), CAST( '9287'  AS VARBINARY),5, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660474,48,CAST( '856'  AS VARBINARY), CAST( '5628'  AS VARBINARY),5, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660486,49,CAST( '723'  AS VARBINARY), CAST( '9850'  AS VARBINARY),5, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660498,50,CAST( '692'  AS VARBINARY), CAST( '1384'  AS VARBINARY),5, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660500,51,CAST( '746'  AS VARBINARY), CAST( '2217'  AS VARBINARY),5, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660512,52,CAST( '439'  AS VARBINARY), CAST( '9946'  AS VARBINARY),5, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660524,53,CAST( '144'  AS VARBINARY), CAST( '4131'  AS VARBINARY),5, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660536,54,CAST( '750'  AS VARBINARY), CAST( '1567'  AS VARBINARY),5, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660548,55,CAST( '849'  AS VARBINARY), CAST( '6755'  AS VARBINARY),5, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660551,56,CAST( '835'  AS VARBINARY), CAST( '5760'  AS VARBINARY),1, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660563,57,CAST( '390'  AS VARBINARY), CAST( '2338'  AS VARBINARY),1, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660575,58,CAST( '547'  AS VARBINARY), CAST( '1765'  AS VARBINARY),1, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660587,59,CAST( '559'  AS VARBINARY), CAST( '5813'  AS VARBINARY),1, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660599,60,CAST( '254'  AS VARBINARY), CAST( '1581'  AS VARBINARY),1, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660601,61,CAST( '184'  AS VARBINARY), CAST( '9722'  AS VARBINARY),1, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660613,62,CAST( '347'  AS VARBINARY), CAST( '2067'  AS VARBINARY),1, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660625,63,CAST( '324'  AS VARBINARY), CAST( '5323'  AS VARBINARY),1, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660637,64,CAST( '555'  AS VARBINARY), CAST( '9272'  AS VARBINARY),1, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660649,65,CAST( '443'  AS VARBINARY), CAST( '9775'  AS VARBINARY),2, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660652,66,CAST( '399'  AS VARBINARY), CAST( '2079'  AS VARBINARY),2, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660664,67,CAST( '632'  AS VARBINARY), CAST( '3974'  AS VARBINARY),2, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660676,68,CAST( '876'  AS VARBINARY), CAST( '8830'  AS VARBINARY),2, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660688,69,CAST( '431'  AS VARBINARY), CAST( '8560'  AS VARBINARY),2, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660690,70,CAST( '442'  AS VARBINARY), CAST( '5485'  AS VARBINARY),2, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660702,71,CAST( '980'  AS VARBINARY), CAST( '4588'  AS VARBINARY),2, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660714,72,CAST( '744'  AS VARBINARY), CAST( '9731'  AS VARBINARY),3, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660726,73,CAST( '885'  AS VARBINARY), CAST( '9287'  AS VARBINARY),4, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660738,74,CAST( '238'  AS VARBINARY), CAST( '5060'  AS VARBINARY),3, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660740,75,CAST( '236'  AS VARBINARY), CAST( '5549'  AS VARBINARY),3, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660753,76,CAST( '368'  AS VARBINARY), CAST( '2204'  AS VARBINARY),3, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660765,77,CAST( '603'  AS VARBINARY), CAST( '2691'  AS VARBINARY),3, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660777,78,CAST( '467'  AS VARBINARY), CAST( '3801'  AS VARBINARY),3, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660789,79,CAST( '459'  AS VARBINARY), CAST( '4166'  AS VARBINARY),4, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660791,80,CAST( '809'  AS VARBINARY), CAST( '2167'  AS VARBINARY),4, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660803,81,CAST( '617'  AS VARBINARY), CAST( '9809'  AS VARBINARY),4, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660815,82,CAST( '205'  AS VARBINARY), CAST( '8902'  AS VARBINARY),4, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660827,83,CAST( '484'  AS VARBINARY), CAST( '5416'  AS VARBINARY),4, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660839,84,CAST( '498'  AS VARBINARY), CAST( '2657'  AS VARBINARY),4, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660841,85,CAST( '246'  AS VARBINARY), CAST( '7713'  AS VARBINARY),4, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660854,86,CAST( '248'  AS VARBINARY), CAST( '4915'  AS VARBINARY),4, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660866,87,CAST( '784'  AS VARBINARY), CAST( '6251'  AS VARBINARY),4, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660878,88,CAST( '608'  AS VARBINARY), CAST( '4081'  AS VARBINARY),4, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660880,89,CAST( '805'  AS VARBINARY), CAST( '6721'  AS VARBINARY),4, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660892,90,CAST( '554'  AS VARBINARY), CAST( '6530'  AS VARBINARY),4, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660904,91,CAST( '510'  AS VARBINARY), CAST( '5432'  AS VARBINARY),4, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660916,92,CAST( '698'  AS VARBINARY), CAST( '1586'  AS VARBINARY),4, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660928,93,CAST( '860'  AS VARBINARY), CAST( '6759'  AS VARBINARY),4, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660930,94,CAST( '300'  AS VARBINARY), CAST( '5763'  AS VARBINARY),4, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660942,95,CAST( '328'  AS VARBINARY), CAST( '3112'  AS VARBINARY),4, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660955,96,CAST( '479'  AS VARBINARY), CAST( '7687'  AS VARBINARY),4, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660967,97,CAST( '920'  AS VARBINARY), CAST( '6565'  AS VARBINARY),4, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660979,98,CAST( '714'  AS VARBINARY), CAST( '7699'  AS VARBINARY),5, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660981,99,CAST( '159'  AS VARBINARY), CAST( '6968'  AS VARBINARY),5, NULL)
INSERT INTO DebitCard (DebitCardNumber, AccountCustomerMappingId, CVV, PIN, CreatedBy, ModifiedTimestamp) VALUES (5166000070660993,100,CAST( '167'  AS VARBINARY), CAST( '5999'  AS VARBINARY),5, NULL)


CREATE Clustered INDEX idx_customer

BEGIN
    INSERT INTO Account(AccountNumber, BranchId, CreatedBy) VALUES('007066100000101', 1, 5) 
    INSERT INTO AccountCustomerMapping(AccountNumber, CustomerId) VALUES('007066100000101', 1000000100) 
END

select * from Account

BEGIN
	DECLARE @Number BIGINT, @Id INT = 4000
	select @Number = AccountNumber from Account where AccountId= @Id
	select @Number "MY NUMBER"
END

BEGIN
DECLARE @LoginName VARCHAR(5)
DECLARE @Password VARCHAR(300)
DECLARE @RetValue INT
	SET @LoginName = 'T1011'
	SET @Password = 'Indy!123'
   
    IF EXISTS (SELECT * FROM Teller WHERE LoginName = @LoginName)
		SET @RetValue = -1 
	IF (@RetValue!=-1)
		INSERT INTO Teller (LoginName, [Password]) VALUES(@LoginName ,CONVERT(VARBINARY(300),@Password))
		SET @RetValue=1
	IF(@RetValue=-1) 
		PRINT 'Login name already exists'
	ELSE
		PRINT 'Teller details added successfully'
END;

---xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--Execise-11


create table ChildCareerPolicies(
	QouteId INT PRIMARY KEY IDENTITY(1,1),
	InsuredId BIGINT CONSTRAINT fk21 REFERENCES Customer(CustomerId) NOT NULL,
	BenificiaryName varchar(50) NOT NULL,
	BenificiaryDOB DATE NOT NULL,
	PremiumMode varchar(20) NOT NULL,
	RebateMode varchar(20) NOT NULL,
	SumAssured MONEY NOT NULL,
	Term NUMERIC(18) NOT NULL,
	PremiumAMount MONEY NOT NULL,
	PercentageRebate DECIMAL(18,2) NOT NULL,
	PremiumModeBasedRebate MONEY NOT NULL,
	TermEndBasedRebate MONEY NOT NULL,
	TotalAmount MONEY NOT NULL,
	EffectiveDate date NOT NULL,
	ExpiryDate DATE NOT NULL,
	NomineeName varchar(20) NOT NULL,
	NomineeRelation varchar(20) NOT NULL,
	BranchId tinyint CONSTRAINT fk22 REFERENCES Branch(BranchId) NOT NULL,
	ClaimsTaken int DEFAULT 0,
	[Status] INT DEFAULT 0,
	Comment varchar(100) DEFAULT NULL
)

