--DROP TABLES
DROP TABLE Articles;
DROP TABLE Candidate;
DROP TABLE PoliticalParty;
DROP TABLE Shipment;
DROP TABLE MemOrder;
DROP TABLE ArtOrder;
DROP TABLE Author;
DROP TABLE Cart;
DROP TABLE Memorabilia;


DROP TABLE Account;

CREATE TABLE Account (
	UserID INT,
	UserName VARCHAR(20) NOT NULL,
	Password VARCHAR(20) NOT NULL,
	FirstName VARCHAR(20) NOT NULL,
	LastName VARCHAR(20) NOT NULL,
	Address VARCHAR(50),
	email VARCHAR(50) NOT NULL,
	Age int NOT NULL,
	isAdmin BIT,
	PRIMARY KEY (UserID)
);

CREATE TABLE Cart (
CartID INT,
UserId INT,
PRIMARY KEY(CartID),
CONSTRAINT FK_CART_Account FOREIGN KEY(UserID) References Account(UserId)
							ON UPDATE CASCADE
							ON DELETE NO ACTION
);

CREATE TABLE Shipment(
	ShipmentID INT,
	ShipmentDate date,
	Weight float,
	Height float,
	Length float,
	Width  float,
	TrackingNum INT,
	CartID INT,
	UserID INT,
	Shipped BIT,
	PRIMARY KEY(ShipmentID),
	CONSTRAINT FK_Shipment_Cart FOREIGN KEY(CartID) REFERENCES Cart(CartID)
								ON DELETE NO ACTION
								ON UPDATE NO ACTION,
	CONSTRAINT FK_Shipment_Account FOREIGN KEY (UserID) REFERENCES Account(UserID)
								ON DELETE NO ACTION
								ON UPDATE NO ACTION
);

CREATE TABLE Author(
	UserID INT,
	Earnings DECIMAL(9,2),
	PRIMARY KEY (UserID),
	CONSTRAINT FK_Author_USERID FOREIGN KEY(USERID) References Account(UserID)
								ON DELETE NO ACTION 
								ON UPDATE NO ACTION
);

CREATE TABLE Memorabilia(
	DesignID INT,
	Memorabilia VARCHAR(15) CHECK( Memorabilia in('˜T-Shirt', 'Hat', 'Button', 'BumperSticker')) Not Null,
	PartyLogo VARCHAR(20) CHECK(PartyLogo in('Conservative', 'Liberal', 'NDP', 'Green')),
	SalesCount INT,
	Rating INT,
	PRIMARY KEY(DesignID)
);

CREATE TABLE MemOrder(
	DesignID int,
	CartID int,
	Price DECIMAL(6,2),
	PRIMARY KEY(DesignID, CartID),
	CONSTRAINT FK_MemOrder_Cart FOREIGN KEY(CartID) References Cart(CartID)
								ON DELETE NO ACTION 
								ON UPDATE NO ACTION
);

CREATE TABLE ArtOrder(
ArticleID int,
CartID int,
Price DECIMAL(6,2),
PRIMARY KEY(ArticleID, CartID),
FOREIGN KEY(CartID) References Cart(CartID)
			ON DELETE NO ACTION 
			ON UPDATE NO ACTION
);

CREATE TABLE PoliticalParty(
	PartyName VARCHAR(30), 
	PRIMARY KEY(PartyName)
);

CREATE TABLE Candidate(
	CID INT, 
	Address VARCHAR(50),
	Position VARCHAR(10) CHECK(Position in ('PrimeMinister', 'MP', 'Premier', 'MLA', 'Mayor', 'Councilor')),
	FirstName VARCHAR(30),
	LastName VARCHAR(30),
	PartyName VARCHAR(30),
	PRIMARY KEY(CID),
	CONSTRAINT FK_CANDIDATE_POLITICALPARTY FOREIGN KEY (PartyName) REFERENCES PoliticalParty(PartyName) 
							 			   ON DELETE NO ACTION 
										   ON UPDATE NO ACTION
);

CREATE TABLE Articles(
	ArticleID int,
	CID int,
	Views int,
	ArticleTitle VARCHAR(50),
	text VARCHAR(1500),
	Theme VarChar(15),
	ReleaseDate DATE,
	Price DECIMAL(10,2),
	IsSold BIT,
	Rating INT,
	UserID INT,
	OwnerID INT,
	Primary Key(ArticleID),
	CONSTRAINT FK_Articles_Author FOREIGN KEY (UserID) REFERENCES Author(UserID)
							  	  ON DELETE NO ACTION
						      	  ON UPDATE NO ACTION,
 	CONSTRAINT FK_Articles_Candidate FOREIGN KEY (CID) REFERENCES Candidate(CID) 
 								  	 ON DELETE NO ACTION 
 									 ON UPDATE NO ACTION
 );
 

 
 INSERT INTO Account VALUES (1, 'DandyMatt', 'DandyCandy', 'Matthew', 'Locklee', '777 Hahaha Street', 'dandy.matt@live.com', 24, 1);
 INSERT INTO Account VALUES (2, 'Mattew', 'pikachu', 'Matt', 'NumberTwo', '666 wastreet', 'dandy.candy@fakeemail.com', 30, 0);
 INSERT INTO Account VALUES (3, '420potxJointMan', 'Lul', 'Jose', 'Noway', '123 toomany addreses street', 'ugh@ugh.com', 100, 0);
 
 INSERT INTO Author VALUES (1,1);
 INSERT INTO Author VALUES (2, 0.25);
 INSERT INTO Author VALUES (3, 420);
 
 INSERT INTO Cart VALUES (1, 1);
 INSERT INTO Cart VALUES (2, 2);
 INSERT INTO Cart VALUES (3, 3);
 
 INSERT INTO ArtOrder VALUES(1,1,5);
 INSERT INTO ArtOrder VALUES(2,2,5);
 INSERT INTO ArtOrder VALUES(3,3,5);

 
 INSERT INTO Shipment VALUES (1, '2018-11-26',1.00, 1.00, 1.00, 1.00, 90210, 1, 1, 1);
 
INSERT INTO PoliticalParty VALUES ('Liberal Party');
INSERT INTO PoliticalParty VALUES ('Conservative Party');
INSERT INTO PoliticalParty VALUES ('NDP');				   
INSERT INTO PoliticalParty VALUES ('Green Party');
INSERT INTO PoliticalParty VALUES ('Republican Party');
INSERT INTO PoliticalParty VALUES ('Democratic Party');
INSERT INTO PoliticalParty VALUES ('Rhinoceros Party');
INSERT INTO PoliticalParty VALUES ('Matthew''s dope Party');

DECLARE @CID int
INSERT INTO Candidate VALUES (1, '256 Hastings Ave', 'Mayor', 'Matthew', 'Lockhart', 'Matthew''s dope Party');
INSERT INTO Candidate VALUES (2, '123 John Snow Road', 'MLA', 'Russell', 'Morgan', 'Rhinoceros Party');
INSERT INTO Candidate VALUES (3, '555 Yellow Brick Rd', 'MP', 'Carla', 'Mather', 'Conservative Party');
INSERT INTO Candidate VALUES (4, '555 Yellow Brick Rd', 'PrimeMinster', 'Justin', 'Trudeau', 'Liberal Party');
INSERT INTO Candidate VALUES (5, '555 Yellow Brick Rd', 'PrimeMinster', 'Andrew', 'Scheer', 'Conservative Party');
INSERT INTO Candidate VALUES (6, '555 Yellow Brick Rd', 'PrimeMinster', 'Jagmeet', 'Singh', 'NDP');
INSERT INTO Candidate VALUES (7, '555 Yellow Brick Rd', 'PrimeMinster', 'Elizabeth', 'May', 'Conservative Party');
INSERT INTO Candidate VALUES (8, '555 Yellow Brick Rd', 'Premier', 'Rachel', 'Notley', 'NDP');
INSERT INTO Candidate VALUES (9, '555 Yellow Brick Rd', 'Premier', 'John', 'Horgan', 'NDP');
INSERT INTO Candidate VALUES (10, '555 Yellow Brick Rd', 'Premier', 'Brian', 'Pallister', 'Conservative Party');
INSERT INTO Candidate VALUES (11, '555 Yellow Brick Rd', 'Premier', 'Blaine', 'Higgs', 'Conservative Party');
INSERT INTO Candidate VALUES (12, '555 Yellow Brick Rd', 'Premier', 'Dwight', 'Ball', 'Liberal Party');
INSERT INTO Candidate VALUES (13, '555 Yellow Brick Rd', 'Premier', 'Stephen', 'McNeil', 'Liberal Party');
INSERT INTO Candidate VALUES (14, '555 Yellow Brick Rd', 'Premier', 'Doug', 'Ford', 'Conservative Party');
INSERT INTO Candidate VALUES (15, '555 Yellow Brick Rd', 'Premier', 'Wade', 'MacLauchlan', 'Liberal Party');
INSERT INTO Candidate VALUES (16, '555 Yellow Brick Rd', 'Premier', 'François', 'Legault', 'CAQ');
INSERT INTO Candidate VALUES (17, '555 Yellow Brick Rd', 'Premier', 'Scott', 'Moe', 'Saskatchewan Party');
INSERT INTO Candidate VALUES (18, '555 Yellow Brick Rd', 'Premier', 'Bob', 'McLeod', 'Independant');
INSERT INTO Candidate VALUES (19, '555 Yellow Brick Rd', 'Premier', 'Joe', 'Savikataaq', 'Independant');
INSERT INTO Candidate VALUES (20, '555 Yellow Brick Rd', 'Premier', 'Sandy', 'Silver', 'Liberal Party');				   
				   
				   
 INSERT INTO Articles VALUES (1,2, 0, 'Hundreds Of Canadians React Hilariously To Picture Of Trudeau's Family Dressed Up For Halloween','Usually, Trudeau's gang of followers are rubbing their hands together ready with incendiary comments, waiting for the perfect opportunity to pounce.', 'Funny', 'Fake' '2018-11-29',5, 0, 0, 1, null );
 INSERT INTO Articles VALUES (2,2, 0, 'Trudeau’s turn from cool to laughing stock','Ever since his election as Canada’s Prime Minister last October, Justin Trudeau has revelled in global tributes, raves and swoons. He’s the Disney prince with the trippy dance moves, the groovy Haida tattoo and the gender-balanced cabinet. He’s the last best hope for globalization, the star attraction at the Pride parades, the hero of the Paris Climate Summit, the guy everyone wants a selfie with.', 'Political','Truth' '2018-11-28',5, 0, 0, 1,3 );
 INSERT INTO Articles VALUES (3,3, 0, 'For Justin Trudeau and Doug Ford, it’s time to fight','If politicians in Ottawa and Queen’s Park run up the white flag rather than fight Monday’s GM announcement, it shouldn’t be GM held responsible for killing Oshawa’s assembly plant. It should be every politician who didn’t show up for the political fight when it really mattered to people. Tens of thousands of people.', 'Truth', '2018-11-27',5, 0, 0, 3,1 );
 INSERT INTO Articles VALUES (6,3, 0, 'Jeopardy host Alex Trebek thinks Justin Trudeau wears a buzzer under his shirt to signal his assistants','Alex Trebek says he once spent “almost an hour” with Trudeau — and was rudely interrupted by a buzzer under the Canadian prime minister’s shirt.', 'Truth', '2018-11-26',5, 0, 0, 2,1 );
 INSERT INTO Articles VALUES (7,1, 0, 'GoFundMe campaign launched to 'Give Justin Trudeau a shirt'','After Prime Minister Justin Trudeau was spotted running shirtless in Toronto last week, a few good-hearted Canadians decided to get together and help out our PM.', 'Truth', '2018-11-25',5, 0, 0, 3,1 );
 INSERT INTO Articles VALUES (8,3, 0, 'Andrew Scheer Says He Smoked Marijuana When He Was 'Young'','In case you were wondering, Conservative Leader Andrew Scheer smoked marijuana when he was younger. "I hope my father isn't watching this show," Scheer joked Sunday after he made the admission on Radio-Canada's "Tout le Monde en Parle," a hugely popular French talk show in the battleground province of Quebec.', 'Truth', '2018-11-24',5, 0, 0, 2,1 );
 INSERT INTO Articles VALUES (9,1, 0, 'Premier Sandy Silver gets caught with young woman,'Priemer Sandy Silver of the Yukon was caught texting underage girl ', 'False', '2018-11-23',5, 0, 0, 2,1 );
 INSERT INTO Articles VALUES (10,2, 0, 'Leader of the Green Party Elizabeth May doesn’t recycle at home’, 'Green Party Leader is found throwing out her garbage and inside the bag contained recyclable goods ', 'False', '2018-11-22',5, 0, 0, 1,1 );
 INSERT INTO Articles VALUES (4,2, 0, 'Makes COSC 304 Designed To','testetestestsetestsetests', 'Drama', '2018-11-21',5, 0, 0, 3,2 );
 INSERT INTO Articles VALUES (5,3, 0, 'Carla Said WHAT?!','tesssssssssssssstttt', 'Horror', '2018-11-20',5, 0, 0, 2,2 );



