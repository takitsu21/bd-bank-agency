/*
Sabatier, Juliette Participant 1:	, Activités paricipant1
Batisse, Dylann Participant 2:	    , Activités paricipant2
Brault, Yann Participant 3:			, Activités paricipant3
Cousson, Antoine Participant 4:     , Activités paricipant4
*/

/*

2.	Implémentation des types et tables objets
Le résultat de cette phase doit être mis dans un fichier appelé
3Script_Implementation_type_tables_objet_NomProjet_Nom1_Nom2_Nom3_Nom4.sql
2.1	Création des types à partir du schéma de types
Proposer la création des types (partie spécification) avec l’ensembles des champs et des méthodes y compris les champs pour gérer les liens d’association.
2.2	Création des tables objets et des indexes à partir des types créés auparavant
Définir le schéma physique consiste à produire les ordres SQL de création des tables objets, indexes etc..
Si vous avez une base de données Oracle locale, il faut créer un utilisateur Oracle si ce n’est déjà fait ou utilser le compte Oracle qui vous a été fourni sur une base distante. Cet utilisateur sera le propriétaire de tous les objets de votre application (types, des tables objets, indexes, ...).

Vous devez aussi poser les indexes sur vos colonnes REF y compris dans les listes.
2.3	Insertion des lignes dans vos tables objets
Il s’agit d’effectuer manuellement des insertions de lignes dans chacunes de vos tables. Insérer 10 à 20 lignes par tables. Bien gérer les contraintes d’intégrités (primary key, check, non nul).
2.4	Mise à jour et consultation des données dans vos tables objets
Les requêtes de mise à jour (modification, suppression) et de consulatation à écrire sont celles définies dans le chapitre 1.
2.5	Implémentation des méthodes de vos types en PLSQL
Il s’agit définir les types Body et d’implémenter le code des méthodes des types définis dans la spécification des types.

Vous devez aussi proposer le code de test de chacune des méthodes.

2.6	Travail à rendre (04/01/2022)
Le travail à rendre doit être dans le fichier :
Script_Implementation_type_tables_objet_NomProjet_Nom1_Nom2_Nom3_Nom4.sql
Vous devez y mettre :
•	Création des types à partir du schéma de types
•	Création des tables objets et des indexes à partir des types créés auparavant
•	Insertion des lignes dans vos tables objets
•	Mise à jour et consultation des données dans vos tables objets
•	Implémentation des méthodes de vos types en PLSQL


*/



-- TABLES TYPES --


drop type AGENCY_T force
/
drop type listRefEmploye_t force
/
drop type EMPLOYE_T force
/

drop type LOCATION_T force
/
drop type CLIENT_T force
/
drop type listRefTransaction_t force
/
drop type TRANSACTION_T force
/
drop type ACCOUNT_T force
/

drop type tabPrenoms_t force
/

drop type listRefAccount_t force
/

CREATE OR replace type tabPrenoms_t as varray (4) of varchar2(30)
/

create or replace type LOCATION_T
/

create or replace type LOCATION_T AS OBJECT(
    country		        varchar2(50),
	city			    varchar2(50),
	streetName          varchar2(100),
    streetNo            number(5),

	map member function compLoc return varchar2,
	member function getLoc return location_t,
	
	-- getter --
	member function	getCountry return varchar2
	member function	getCity return varchar2,
	-- member function	getStreetName return varchar2,
	-- member function	getstreetNo return number,
	
	-- update LOC --
	-- member procedure updateCountry (country1 IN varchar2), 
	-- member procedure updateCity (city1 IN varchar2),
	-- member procedure updateStreetName (streetName1 IN varchar2),
	-- member procedure updateStreetNo (streetNo1 IN number),

	-- delete an entry -- 
	-- static procedure deleteLoc(loc in location_t)
);
/


create or replace type AGENCY_T
/

CREATE OR REPLACE TYPE EMPLOYE_T AS OBJECT(
	empNo       number(8),
	eName       varchar2(15),
	prenoms     tabPrenoms_t,
	job		    Varchar2(20),
	sal	        number(7,2),
	cv		    CLOB,
	birthDate  date,
	employementDate    date,
	refAgency	    REF AGENCY_T,

	order member function compEmp(emp IN employe_t) return number,
	member function getEmploye return employe_t

	-- getter
	--member function getEmpNo return number, 
	--member function getEName return varchar2,
	--member function getPrenoms return
	--member function getJob return varchar2,
	--member function getSal return number, 
	--member function getCV return CLOB,
	--member function getBirthDate return date,
	--member function getEmployementDate return date, 

	-- update 
	--member procedure updateName (name IN Varchar2),
	--member procedure updatePrenom (prenom1 REF tabPrenoms_t, prenom2 REF tabPrenoms_t),
	--member procedure addPrenom (prenom REF tabPrenoms_t),
	--member procedure deletePrenom (prenom REF tabPrenoms_t),
	--member procedure updateJob (job IN varchar2),
	--member procedure updateSal (sal IN number),
	--member procedure updateCV (cv IN CLOB),
	--member procedure updateBirthDate (birthDate in date),
	--member procedure updateEmploymentDate (employmentDate IN date),

	-- delete an entry
	-- static procedure deleteEmp( emp in employe_t)

 
);
/

CREATE OR REPLACE type listRefEmploye_t as table of REF EMPLOYE_T
/

create or replace type AGENCY_T AS OBJECT(
	agencyNo		     number(4),
	aName		    	varchar2(30),
	loc			   		ref location_t,
	listRefEmp    		listRefEmploye_t,

	member function getAgency return AGENCY_T,
	map member function compAgency return number


	-- static function getInfoEmp (agencyNo1 IN number, nomTable IN varchar2 ) return listRefEmploye_t,
	

	-- member procedure 	addLinkListeEmployes(RefEmp1 REF Employe_t, nomTable IN varchar2),
	-- member procedure 	deleteLinkListeEmployes (RefEmp1 REF Employe_t, nomTable IN varchar2 ),
	-- member procedure 	updateLinkListeEmployes (RefEmp1 REF Employe_t, 	RefEmp2 REF Employe_t, nomTable IN varchar2)
);
/

create or replace type CLIENT_T
/

CREATE OR REPLACE type TRANSACTION_T as OBJECT(
    tNum            number(8),
    issuer          ref CLIENT_T,
    payee           ref CLIENT_T,
    amount         number(11, 4),
	map member function compTransaction return number
);
/

CREATE OR REPLACE type listRefTransaction_t as table of REF TRANSACTION_T
/


CREATE OR REPLACE type ACCOUNT_T AS OBJECT(
	accountNo		    number(4),
    accountType		    Varchar2(20), -- livret A, compte eparge, compte courrant ...
	balance		        number(10, 4),
	bankCeiling         number(10, 4),
    statements          listRefTransaction_t,
    refAgency           REF AGENCY_T,

	order member function compAccount( account IN ACCOUNT_T ) return number

);
/
CREATE OR REPLACE type listRefAccount_t as table of REF ACCOUNT_T
/

CREATE OR REPLACE TYPE CLIENT_T AS OBJECT(
	numCli       number(8),
	cName       varchar2(15),
	prenoms     tabPrenoms_t,
	job		    Varchar2(20),-- peut etre null, demande en cas de pret
	sal	        number(7,2), -- peut etre null, demande en cas de pret
    listRefAccount   listRefAccount_t,
    project       CLOB,   -- project pour appuyer un pret
	birthDate  date,
	refAgency	    REF AGENCY_T,
	map member function compCli return number
);
/


-- TABLES OBJETS --



drop table O_LOCATION cascade constraints;
create table O_LOCATION of LOCATION_T(
	constraint chk_O_LOCATION_streetNo check(streetNo between 1 and 99999),
	country constraint nnl_O_LOCATION_country  not null,
	city constraint nnl_O_LOCATION_city  not null,
    streetName constraint nnl_O_LOCATION_streetName  not null
);
/

drop table O_EMPLOYE cascade constraints;
create table O_EMPLOYE of EMPLOYE_T(
     	constraint pk_O_EMPLOYE_empNo primary key(empNo),
		constraint chk_O_EMPLOYE_eName check(eName=upper(eName)),
		eName constraint nnl_O_EMPLOYE_eName not null,
		constraint chk_O_EMPLOYE_job
			check(job IN ('Ingenieur','Banquier','Vigile','Avocat' ,'Secretaire', 'Directeur', 'Analyste', 'PDG') ),
		job constraint nnl_O_EMPLOYE_job not null,
		constraint chk_O_EMPLOYE_sal check(sal between 1500 and 30000),
		sal constraint nnl_O_EMPLOYE_sal not null,
		constraint chk_O_EMPLOYE_dnaiss_demb check(employementDate>birthDate),
		 employementDate constraint nnl_O_EMPLOYE_date_emb not null,
		birthDate constraint nnl_O_EMPLOYE_date_naiss not null
)
LOB(CV) store as table_LobCV (PCTVERSION 30);
/


drop table O_AGENCY cascade constraints;
create table O_AGENCY of AGENCY_T(
	Constraint pk_O_AGENCY_agencyNo primary key(agencyNo),
	Constraint chk_O_AGENCY_aName check(aName=lower(aName)),
	aName constraint nnl_O_AGENCY_aName not null
)
nested table listRefEmp store as tableListRefEmp
/



drop table O_ACCOUNT cascade constraints;
CREATE TABLE O_ACCOUNT of ACCOUNT_T(
    constraint pk_O_ACCOUNT_accountNo primary key(accountNo),
    constraint chk_O_ACCOUNT_accountType check(accountType IN ('Livret A', 'Compte Epargne', 'Compte Courant', 'PEL', 'PEL Pro')),
    accountType constraint nnl_O_ACCOUNT_accountType not null,
    constraint chk_O_ACCOUNT_balance check(balance between 0 and 999999999),
    balance constraint nnl_O_ACCOUNT_balance not null,
    constraint chk_O_ACCOUNT_bankCeiling check(bankCeiling between 0 and 999999999),
    bankCeiling constraint nnl_O_ACCOUNT_bankCeiling not null
)
nested table statements store as tableListRefTransaction
/

drop table O_TRANSACTION cascade constraints;
create table O_TRANSACTION of TRANSACTION_T(
	constraint pk_O_TRANSACTION_tNum primary key(tNum),
    issuer constraint nnl_O_TRANSACTION_issuer not null,
    payee constraint nnl_O_TRANSACTION_payee not null,
    amount constraint nnl_O_TRANSACTION_amount not null
);
/

drop table O_CLIENT cascade constraints;
create table O_CLIENT of CLIENT_T(
    CONSTRAINT pk_O_CLIENT_numCli primary key(numCli),
    CONSTRAINT chk_O_CLIENT_cName check(cName=upper(cName)),
    cName CONSTRAINT nnl_O_CLIENT_cName  not null,
    birthDate CONSTRAINT nnl_O_CLIENT_date_naiss not null,
    prenoms CONSTRAINT nnl_O_CLIENT_prenoms not null
    ---listRefAccount CONSTRAINT nnl_O_CLIENT_listRefAccount not null va savoir pourquoi masi il aime pas qu'on check si on en fait une nested table
)
LOB(project) store as table_Lobproject (PCTVERSION 30),
nested table listRefAccount store as tableListRefAccount;
/



-- INDEXES --

ALTER TABLE o_employe
	ADD (SCOPE FOR (refAgency) IS O_AGENCY);
ALTER TABLE tableListRefEmp
	ADD (SCOPE FOR (column_value) IS o_employe);

CREATE UNIQUE INDEX idx_unique_aName ON O_AGENCY(aName)
/
-- tablespace ts_index_res;




------- IMPLEMENTATION METHODS --

CREATE OR REPLACE TYPE BODY location_t AS

	member function getLoc return location_t IS
		BEGIN
			return self;
		END;

	map member function compLoc return varchar2 is
		BEGIN 
			return country||city||streetName||streetNo;
		END;

	-- getter --
	member function	getCountry return varchar2 is 
		begin
			return country;
		end;

	member function	getCity return varchar2 is 
		begin
			return city;
		end;
	-- member function	getStreetName return varchar2 is 
	-- 	begin
	-- 		return streetName;
	-- 	end;
	-- member function getstreetNo return number is 
	-- 	begin
	-- 		return streetNo;
	-- 	end;
	
	-- -- update LOC --
	-- member procedure updateCountry (country1 IN varchar2) is 
	-- 	BEGIN
	-- 		update TABLE(select lo.country from o_location lo where lo.country = country and lo.city = city and lo.streetName = streetName and lo.streetNo = streetNo) set lo.country = country1;
	-- 	END;
	-- member procedure updateCity (city1 IN varchar2) is 
	-- 	myQuery clob:='update location_t set city = '||city1||' where location_t.compLoc = '|| self.compLoc;
	-- 	BEGIN
	-- 		EXECUTE IMMEDIATE myQuery;
	-- 	END;
	-- member procedure updateStreetName (streetName1 IN varchar2) is 
	-- 	myQuery clob:='update location_t set streetName = '||streetName1||' where location_t.compLoc = '|| self.compLoc;
	-- 	BEGIN
	-- 		EXECUTE IMMEDIATE myQuery;
	-- 	END;
	-- member procedure updateStreetNo (streetNo1 IN number) is 
	-- 	myQuery clob:='update location_t set streetNo = '||streetNo1||' where location_t.compLoc = '|| self.compLoc;
	-- 	BEGIN
	-- 		EXECUTE IMMEDIATE myQuery;
	-- 	END;

	-- -- delete an entry -- 
	-- static procedure deleteLoc(loc in location_t) is
	-- 	myQuery clob:='delete from location_t where location_t.compLoc = '|| loc.compLoc;
	-- 	BEGIN
	-- 		EXECUTE IMMEDIATE myQuery;
	-- 	END;
END;
/


CREATE OR REPLACE TYPE BODY AGENCY_T AS

	member function getAgency return agency_t IS
		BEGIN
			return self;
		END;

	map member function compAgency return number is
		BEGIN
			return agencyNo;
		END;
END;
/

CREATE OR REPLACE TYPE BODY employe_t AS

	member function getEmploye return employe_t IS
		BEGIN
			return self;
		END;

	order member function compEmp(emp IN employe_t) return number is
	
	-- order en fonction du job dans l'entreprise 
	position1 NUMBER := 0;
	position2 NUMBER := 0;

		BEGIN
			CASE SELF.job
				WHEN 'Vigile'  THEN position1 := 1;
				WHEN 'Secretaire'  THEN position1 := 2;
				WHEN 'Analyste'  THEN position1 := 3;
				WHEN 'Ingenieur'  THEN position1 := 4;
				WHEN 'Avocat' THEN position1 := 5;
				WHEN 'Banquier' THEN position1 := 6;
				WHEN 'Directeur' THEN position1 := 7;
				WHEN 'PDG' THEN position1 := 8;
			END CASE;

			CASE emp.job
				WHEN 'Vigile'  THEN position2 := 1;
				WHEN 'Secretaire'  THEN position2 := 2;
				WHEN 'Analyste'  THEN position2 := 3;
				WHEN 'Ingenieur'  THEN position2 := 4;
				WHEN 'Avocat' THEN position2 := 5;
				WHEN 'Banquier' THEN position2 := 6;
				WHEN 'Directeur' THEN position2 := 7;
				WHEN 'PDG' THEN position2 := 8;
			END CASE;

		position1 := position1 || SELF.empNo;
		position2 := position2 || emp.empNo;

		IF position1 = position2 THEN return 0;
		ELSIF position1 > position2 THEN return 1;
		ELSIF position1 < position2 THEN return -1;
		END IF;	

		END;

	

END;
/

CREATE OR REPLACE TYPE BODY CLIENT_T AS
	map member function compCli return number is
		BEGIN
			-- return sal || numCli;
			return numCli;
		END;
END;
/

CREATE OR REPLACE TYPE BODY TRANSACTION_T AS
	map member function compTransaction return number is
		BEGIN
			return tNum;
			-- return amount || tNum;
		END;
END;
/

CREATE OR REPLACE TYPE BODY ACCOUNT_T AS
	order member function compAccount( account IN ACCOUNT_T ) return number is 

	-- order en fonction du accountType puis du numero 
	position1 NUMBER := 0;
	position2 NUMBER := 0;

		BEGIN
			CASE SELF.accountType
				WHEN 'Compte Courant' THEN position1 := 1;
				WHEN 'Livret A' THEN position1 := 2;
				WHEN 'Compte Epargne' THEN position1 := 3;
				WHEN 'PEL' THEN position1 := 4;
				WHEN 'PEL Pro' THEN position1 := 5;
			END CASE;

			CASE account.accountType
				WHEN 'Compte Courant' THEN position2 := 1;
				WHEN 'Livret A' THEN position2 := 2;
				WHEN 'Compte Epargne' THEN position2 := 3;
				WHEN 'PEL' THEN position2 := 4;
				WHEN 'PEL Pro' THEN position2 := 5;
			END CASE;

		position1 := position1 || SELF.accountNo;
		position2 := position2 || account.accountNo;

		IF position1 = position2 THEN return 0;
		ELSIF position1 > position2 THEN return 1;
		ELSIF position1 < position2 THEN return -1;
		END IF;	
		END;
END;
/


