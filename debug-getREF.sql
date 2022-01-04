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
	member function	getCountry return varchar2,
	member function	getCity return varchar2,
	member function	getStreetName return varchar2,
	member function	getstreetNo return number
	
	-- update LOC --
	-- member function updateCountry (country1 IN varchar2) return boolean
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
	member function getEmploye return employe_t,

	-- getter
	member function getEmpNo return number, 
	member function getEName return varchar2,
	member function getJob return varchar2,
	member function getSal return number, 
	member function getCV return CLOB,
	member function getBirthDate return date,
	member function getEmployementDate return date,
	member function getAgency return ref agency_t
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
	map member function compAgency return number,


	-- static function getInfoEmp (agencyNo1 IN number, nomTable IN varchar2 ) return listRefEmploye_t,
	
    -- getter 
    member function getAgencyNo return number,
    member function getAName return varchar2,
    member function getLoc return ref LOCATION_T
    -- member function loc return ref location_t,
    -- member function Employes return listRefEmploye_t

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
	map member function compTransaction return number,
    
    -- getter
    member function getTNum return number,
    member function getIssuer return ref client_t,
    member function getPayee return ref client_t,
    member function getAmount return number
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

	order member function compAccount( account IN ACCOUNT_T ) return number,
    
    -- getter
    member function getAccountNo return number,
    member function getAccountType return varchar2, 
    member function getBalance return number,
    member function getBankCeiling return number,
    -- ajout 
    member function getAgency return ref AGENCY_T 
    -- member function getStatements return listRefTransaction_t,
    -- member function getRefAgency return REF agency_t

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


	map member function compCli return number,
    
    member function getCName return varchar2,
    member function getJob return varchar2,
    member function getSal return number,
    member function getProject return CLOB,
    member function getBirthDate return date,
    --ajout
    member function getAgency return ref AGENCY_T
--    member function getAccounts return listRefAccount_t
   
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
	member function	getStreetName return varchar2 is 
		begin
			return streetName;
		end;
	member function getstreetNo return number is 
		begin
			return streetNo;
		end;
	
	-- -- update LOC --
	-- member function updateCountry (country1 IN varchar2) return boolean is 
	-- 	BEGIN
    --         -- country := country1;
    --         dbms_output.put_line('update country');
    --         return true;

	-- 	END;
    -- update TABLE(select * from o_location lo where lo.country = country and lo.city = city and lo.streetName = streetName and lo.streetNo = streetNo) set lo.country = country1;
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

    -- getter 
    member function getAgencyNo return number is
        begin
            return agencyNo;
        end;
    member function getAName return varchar2 is
        begin
            return aName;
        end;
    member function getLoc return ref LOCATION_T is 
    BEGIN
    return self.loc;
     end;
   -- member function loc return ref location_t is
     --   begin
       --     return loc;
       -- end;
  ---  member function Employes return listRefEmploye_t is
        ---begin
      --      return listRefEmploye;
    --    end;
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
				WHEN 'Vigile'  THEN position1 := 8;
				WHEN 'Secretaire'  THEN position1 := 7;
				WHEN 'Analyste'  THEN position1 := 6;
				WHEN 'Ingenieur'  THEN position1 := 5;
				WHEN 'Avocat' THEN position1 := 4;
				WHEN 'Banquier' THEN position1 := 3;
				WHEN 'Directeur' THEN position1 := 2;
				WHEN 'PDG' THEN position1 := 1;
			END CASE;

			CASE emp.job
				WHEN 'Vigile'  THEN position2 := 8;
				WHEN 'Secretaire'  THEN position2 := 7;
				WHEN 'Analyste'  THEN position2 := 6;
				WHEN 'Ingenieur'  THEN position2 := 5;
				WHEN 'Avocat' THEN position2 := 4;
				WHEN 'Banquier' THEN position2 := 3;
				WHEN 'Directeur' THEN position2 := 2;
				WHEN 'PDG' THEN position2 := 1;
			END CASE;

		position1 := position1 || SELF.empNo;
		position2 := position2 || emp.empNo;

		IF position1 = position2 THEN return 0;
		ELSIF position1 > position2 THEN return 1;
		ELSIF position1 < position2 THEN return -1;
		END IF;	

		END;

	-- getter
	member function getEmpNo return number is
        BEGIN
            return empNo;
        END;
	member function getEName return varchar2 is
        BEGIN
            return eName;
        END;
	member function getJob return varchar2 is
        BEGIN
            return job;
        END;
	member function getSal return number is
        BEGIN
            return sal;
        END;
	member function getCV return CLOB is
        BEGIN
            return cv;
        END;
	member function getBirthDate return date is
        BEGIN
            return birthDate;
        END;
	member function getEmployementDate return date is
        BEGIN
            return employementDate;
        END;
    member function getAgency return ref agency_t is 
	begin
		return self.refAgency;
		end;

END;
/

CREATE OR REPLACE TYPE BODY CLIENT_T AS
	map member function compCli return number is
		BEGIN
			-- return sal || numCli;
			return numCli;
		END;

    member function getCName return varchar2 is 
    BEGIN 
        return cName;
    END;
    member function getJob return varchar2 is
    BEGIN 
        return job;
    END;
    member function getSal return number is
    BEGIN 
        return sal;
    END;
    member function getProject return CLOB is
    BEGIN 
        return project;
    END;
    member function getBirthDate return date is
    BEGIN 
        return birthDate;
    END;

    --member function getAccounts return listRefAccount_t is
    ---BEGIN 
      -- return self.accounts;
    --END;
   member function getAgency return REF AGENCY_T is
   BEGIN 
      return self.refAgency;
  END;
END;
/

CREATE OR REPLACE TYPE BODY TRANSACTION_T AS
	map member function compTransaction return number is
		BEGIN
			return tNum;
			-- return amount || tNum;
		END;

    -- getter
    member function getTNum return number is
    BEGIN 
        return tNum;
    END;
    --ajout
    member function getIssuer return ref client_t is
    BEGIN 
         return self.issuer;
    END;
    member function getPayee return ref client_t is
    BEGIN 
         return self.payee;
    END;
    member function getAmount return number is
    BEGIN 
        return amount;
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
				WHEN 'Compte Courant' THEN position1 := 5;
				WHEN 'Livret A' THEN position1 := 4;
				WHEN 'Compte Epargne' THEN position1 := 3;
				WHEN 'PEL' THEN position1 := 2;
				WHEN 'PEL Pro' THEN position1 := 1;
			END CASE;

			CASE account.accountType
				WHEN 'Compte Courant' THEN position2 := 5;
				WHEN 'Livret A' THEN position2 := 4;
				WHEN 'Compte Epargne' THEN position2 := 3;
				WHEN 'PEL' THEN position2 := 2;
				WHEN 'PEL Pro' THEN position2 := 1;
			END CASE;

		position1 := position1 || SELF.accountNo;
		position2 := position2 || account.accountNo;

		IF position1 = position2 THEN return 0;
		ELSIF position1 > position2 THEN return 1;
		ELSIF position1 < position2 THEN return -1;
		END IF;	
		END;


    member function getAccountNo return number IS
    BEGIN
        return accountNo;
    END;

    member function getAccountType return varchar2 Is
    BEGIN 
        return accountType;
    END;

    member function getBalance return number IS
    BEGIN
        return balance;
    END;

    member function getBankCeiling return number IS 
    BEGIN
        return bankCeiling;
    END;

    --member function getStatements return listRefTransaction_t is
    --BEGIN 
    --    return statements;
    --END;

-- ajout
    member function getAgency return ref AGENCY_T IS
    BEGIN 
        return self.refAgency;
    END;
    
END;
/

































declare

-- Références des locations -- 

    refLoc1        REF LOCATION_T;
    refLoc2        REF LOCATION_T;
    refLoc3        REF LOCATION_T;
    refLoc4        REF LOCATION_T;
    refLoc5        REF LOCATION_T;
	refLoc6        REF LOCATION_T;
    refLoc7        REF LOCATION_T;
    refLoc8        REF LOCATION_T;
    refLoc9        REF LOCATION_T;
    refLoc10       REF LOCATION_T;

-- Références des agences --

	refAgency1	   REF AGENCY_T;
	refAgency2	   REF AGENCY_T;
    refAgency3	   REF AGENCY_T;
	refAgency4	   REF AGENCY_T;
    refAgency5	   REF AGENCY_T;
	refAgency6	   REF AGENCY_T;
	refAgency7	   REF AGENCY_T;
    refAgency8	   REF AGENCY_T;
	refAgency9	   REF AGENCY_T;
    refAgency10	   REF AGENCY_T;
	
-- Références des Employés --

	refEmp1		   REF Employe_t;
	refEmp2		   REF Employe_t;
	refEmp3		   REF Employe_t;
    refEmp4		   REF Employe_t;
	refEmp5		   REF Employe_t;
	refEmp6		   REF Employe_t;
    refEmp7		   REF Employe_t;
	refEmp8		   REF Employe_t;
	refEmp9		   REF Employe_t;
    refEmp10	   REF Employe_t;
	refEmp11	   REF Employe_t;
	refEmp12	   REF Employe_t;
    refEmp13	   REF Employe_t;
	refEmp14	   REF Employe_t;
	refEmp15	   REF Employe_t;
    refEmp16	   REF Employe_t;
	refEmp17	   REF Employe_t;
	refEmp18	   REF Employe_t;
    refEmp19	   REF Employe_t;
	refEmp20  	   REF Employe_t;
	
-- Références des clients --

	refClt1		   REF CLIENT_T;
	refClt2		   REF CLIENT_T;
	refClt3		   REF CLIENT_T;
	refClt4		   REF CLIENT_T;
	refClt5		   REF CLIENT_T;
	refClt6		   REF CLIENT_T;
	refClt7		   REF CLIENT_T;
	refClt8		   REF CLIENT_T;
	refClt9		   REF CLIENT_T;
	refClt10	   REF CLIENT_T;
	refClt11	   REF CLIENT_T;
	refClt12	   REF CLIENT_T;
	refClt13	   REF CLIENT_T;
	refClt14	   REF CLIENT_T;
	refClt15	   REF CLIENT_T;
	refClt16	   REF CLIENT_T;
	refClt17	   REF CLIENT_T;
	refClt18	   REF CLIENT_T;
	refClt19	   REF CLIENT_T;
	refClt20	   REF CLIENT_T;

-- Références des transactions --

	refTransac1	   REF TRANSACTION_T;
	refTransac2	   REF TRANSACTION_T;
	refTransac3	   REF TRANSACTION_T;
	refTransac4	   REF TRANSACTION_T;
	refTransac5	   REF TRANSACTION_T;
	refTransac6	   REF TRANSACTION_T;
	refTransac7	   REF TRANSACTION_T;
	refTransac8	   REF TRANSACTION_T;
	refTransac9	   REF TRANSACTION_T;
	refTransac10   REF TRANSACTION_T;
	refTransac11   REF TRANSACTION_T;
	refTransac12   REF TRANSACTION_T;
	refTransac13   REF TRANSACTION_T;
	refTransac14   REF TRANSACTION_T;
	refTransac15   REF TRANSACTION_T;
	refTransac16   REF TRANSACTION_T;
	refTransac17   REF TRANSACTION_T;
	refTransac18   REF TRANSACTION_T;
	refTransac19   REF TRANSACTION_T;
	refTransac20   REF TRANSACTION_T;

-- Références des comptes --

	refAct1 	   REF ACCOUNT_T;
	refAct2 	   REF ACCOUNT_T;
	refAct3 	   REF ACCOUNT_T;
	refAct4 	   REF ACCOUNT_T;
	refAct5 	   REF ACCOUNT_T;
	refAct6 	   REF ACCOUNT_T;
	refAct7 	   REF ACCOUNT_T;
	refAct8 	   REF ACCOUNT_T;
	refAct9 	   REF ACCOUNT_T;
	refAct10 	   REF ACCOUNT_T;
	refAct11 	   REF ACCOUNT_T;
	refAct12 	   REF ACCOUNT_T;
	refAct13 	   REF ACCOUNT_T;
	refAct14 	   REF ACCOUNT_T;
	refAct15 	   REF ACCOUNT_T;
	refAct16 	   REF ACCOUNT_T;
	refAct17 	   REF ACCOUNT_T;
	refAct18 	   REF ACCOUNT_T;
	refAct19 	   REF ACCOUNT_T;
	refAct20 	   REF ACCOUNT_T;

begin

-- Insertion des locations des agences --

    insert INTO O_LOCATION ol values(location_t('France','Nice','Place Mascena',42))
        returning ref(ol) INTO refLoc1;
    insert INTO O_LOCATION ol values(location_t('France','Paris','Rue de la paix',8))
        returning ref(ol) INTO refLoc2;
    insert INTO O_LOCATION ol values(location_t('Italie','Rome','Place de la pizza',108))
        returning ref(ol) INTO refLoc3;
    insert INTO O_LOCATION ol values(location_t('USA','New-York','Route du pont neuf',9))
        returning ref(ol) INTO refLoc4;
    insert INTO O_LOCATION ol values(location_t('France','bezier','Route de nulle part ',2))
        returning ref(ol) INTO refLoc5;
	insert INTO O_LOCATION ol values(location_t('USA', 'San Francisco', 'Rue du bout du monde', 69))
		returning ref(ol) INTO refLoc6;
	insert INTO O_LOCATION ol values(location_t('USA', 'Los Angeles', 'Avenue de Venise Beach', 4))
		returning ref(ol) INTO refLoc7;
	insert INTO O_LOCATION ol values(location_t('Espagne', 'Madrid', 'Route de la pealla', 10))
		returning ref(ol) INTO refLoc8;
	insert INTO O_LOCATION ol values(location_t('Norvège', 'Oslo', 'Place du port', 1))
	returning ref(ol) INTO refLoc9;
	insert INTO O_LOCATION ol values(location_t('France', 'Lyon', 'Rue antoinette', 6))
		returning ref(ol) INTO refLoc10;

-- Insertion des agences --

	insert INTO O_AGENCY oa values(AGENCY_T(1, 'agence les pins', refLoc1 , listRefEmploye_T()))
		returning ref(oa) INTO refAgency1;
    insert INTO O_AGENCY oa values(AGENCY_T(2, 'banque des pins', refLoc2 , listRefEmploye_T()))
		returning ref(oa) INTO refAgency2;
    insert INTO O_AGENCY oa values(AGENCY_T(3, 'agenzia pineta', refLoc3 , listRefEmploye_T()))
		returning ref(oa) INTO refAgency3;
    insert INTO O_AGENCY oa values(AGENCY_T(4, 'pine forest agency', refLoc4 , listRefEmploye_T()))
		returning ref(oa) INTO refAgency4;
    insert INTO O_AGENCY oa values(AGENCY_T(5, 'agence le cèdre', refLoc5 , listRefEmploye_T()))
		returning ref(oa) INTO refAgency5;
	insert INTO O_AGENCY oa values(AGENCY_T(6, 'cedar agency', refLoc6 , listRefEmploye_T()))
		returning ref(oa) INTO refAgency6;
    insert INTO O_AGENCY oa values(AGENCY_T(7, 'pine bank', refLoc7 , listRefEmploye_T()))
		returning ref(oa) INTO refAgency7;
    insert INTO O_AGENCY oa values(AGENCY_T(8, 'agencia de pino', refLoc8 , listRefEmploye_T()))
		returning ref(oa) INTO refAgency8;
    insert INTO O_AGENCY oa values(AGENCY_T(9, 'furu byrå', refLoc9 , listRefEmploye_T()))
		returning ref(oa) INTO refAgency9;
    insert INTO O_AGENCY oa values(AGENCY_T(10, 'banque des cèdres', refLoc10 , listRefEmploye_T()))
		returning ref(oa) INTO refAgency10;
	

-- Employes de l'agence 1  --

	insert into o_employe oe values (employe_t(
	1,
	'AGRIPPA',
	TABPRENOMS_T('Théodore'),
	'Banquier',
	1700,
	Empty_clob(),
	to_date('11-12-1960','DD-MM-YYYY'),
	to_date('11-12-2000','DD-MM-YYYY'),
	refAgency1
	))
	returning ref(oe) INTO refEmp1;

	insert into O_EMPLOYE oe values (employe_t(
	2,
	'APOLLINAIRE',
	TABPRENOMS_T('Guillaume'),
	'Directeur',
	25000,
	Empty_clob(),
	to_date('11-11-1970','DD-MM-YYYY'),
	to_date('11-12-2012','DD-MM-YYYY'),
	refAgency1
	))
	returning ref(oe) INTO refEmp2;

-- Mise à jour de la liste des pointeurs vers les employes de l'agence 1 --

	insert into
	TABLE(select oa.listRefEmp from O_AGENCY oa where oa.agencyNo=1) lre
	values(refEmp1);
	insert into
	TABLE(select oa.listRefEmp from O_AGENCY oa where oa.agencyNo=1) lre
	values(refEmp2);



-- Employes de l'agence 2 --

	insert into O_EMPLOYE oe values (employe_t(
	3,
	'ARAGON',
	TABPRENOMS_T('Louis'),
	'Vigile',
	2000,
	Empty_clob(),
	to_date('11-12-1961','DD-MM-YYYY'),
	to_date('11-12-2015','DD-MM-YYYY'),
	refAgency2
	))
	returning ref(oe) INTO refEmp3;

    insert into O_EMPLOYE oe values (employe_t(
	4,
	'BALZAC',
	TABPRENOMS_T('Honoré'),
	'Avocat',
	15000,
	Empty_clob(),
	to_date('11-11-1970','DD-MM-YYYY'),
	to_date('11-12-2010','DD-MM-YYYY'),
	refAgency2
	))
	returning ref(oe) INTO refEmp4;

-- Mise à jour de la liste des pointeurs vers les employes de l'agence 2 --

	insert into
	TABLE(select oa.listRefEmp from O_AGENCY oa where oa.agencyNo=2) lre
	values(refEmp3);
    insert into
	TABLE(select oa.listRefEmp from O_AGENCY oa where oa.agencyNo=2) lre
	values(refEmp4);




-- Employes de l'agence 3 --

	insert into O_EMPLOYE oe values (employe_t(
	5,
	'BARTHES',
	TABPRENOMS_T('Roland'),
	'Ingenieur',
	7000,
	Empty_clob(),
	to_date('11-12-1961','DD-MM-YYYY'),
	to_date('11-12-2006','DD-MM-YYYY'),
	refAgency3
	))
	returning ref(oe) INTO refEmp5;

	insert into O_EMPLOYE oe values (employe_t(
	6,
	'BAUDELAIRE',
	TABPRENOMS_T('Charles'),
	'Analyste',
	2700,
	Empty_clob(),
	to_date('11-12-1965','DD-MM-YYYY'),
	to_date('11-12-1990','DD-MM-YYYY'),
	refAgency3
	))
	returning ref(oe) INTO refEmp6;
	
-- Mise à jour de la liste des pointeurs vers les employes de l'agence 3 --
    insert into
	TABLE(select oa.listRefEmp from O_AGENCY oa where oa.agencyNo=3) lre
	values(refEmp5);
    insert into
	TABLE(select oa.listRefEmp from O_AGENCY oa where oa.agencyNo=3) lre
	values(refEmp6);




-- Employes de l'agence 4 --
	
	insert into O_EMPLOYE oe values (employe_t(
	7,
	'BEAUMARCHAIS',
	TABPRENOMS_T('Pierre-Augustin', 'Caron'),
	'Secretaire',
	1630,
	Empty_clob(),
	to_date('11-11-1970','DD-MM-YYYY'),
	to_date('11-12-2010','DD-MM-YYYY'),
	refAgency4
	))
	returning ref(oe) INTO refEmp7;

	insert into O_EMPLOYE oe values (employe_t(
	8,
	'BEAUVOIR',
	TABPRENOMS_T('Simone'),
	'Banquier',
	3000,
	Empty_clob(),
	to_date('11-12-1976','DD-MM-YYYY'),
	to_date('11-12-2013','DD-MM-YYYY'),
	refAgency4
	))
	returning ref(oe) INTO refEmp8;

-- Mise à jour de la liste des pointeurs vers les employes de l'agence 4 --

	insert into
	TABLE(select oa.listRefEmp from O_AGENCY oa where oa.agencyNo=4) lre
	values(refEmp7);
    insert into
	TABLE(select oa.listRefEmp from O_AGENCY oa where oa.agencyNo=4) lre
	values(refEmp8);




-- Employes de l'agence 5 --

    insert into O_EMPLOYE oe values (employe_t(
	9,
	'CAMUS',
	TABPRENOMS_T('Albert'),
	'Vigile',
	1500,
	Empty_clob(),
	to_date('11-11-1985','DD-MM-YYYY'),
	to_date('11-12-2010','DD-MM-YYYY'),
	refAgency5
	))
	returning ref(oe) INTO refEmp9;

	insert into O_EMPLOYE oe values (employe_t(
	10,
	'CELINE',
	TABPRENOMS_T('Louis-Ferdinand'),
	'Ingenieur',
	6000,
	Empty_clob(),
	to_date('11-12-1963','DD-MM-YYYY'),
	to_date('11-12-2005','DD-MM-YYYY'),
	refAgency5
	))
	returning ref(oe) INTO refEmp10;

-- Mise à jour de la liste des pointeurs vers les employes de l'agence 5 --

    insert into
	TABLE(select oa.listRefEmp from O_AGENCY oa where oa.agencyNo=5) lre
	values(refEmp9);
    insert into
	TABLE(select oa.listRefEmp from O_AGENCY oa where oa.agencyNo=5) lre
	values(refEmp10);




-- Employes de l'agence 6 --

	insert into O_EMPLOYE oe values (employe_t(
	11,
	'DAUDET',
	TABPRENOMS_T('Alphonse'),
	'Directeur',
	15000,
	Empty_clob(),
	to_date('11-12-1987','DD-MM-YYYY'),
	to_date('11-12-2000','DD-MM-YYYY'),
	refAgency6
	))
	returning ref(oe) INTO refEmp11;

	insert into O_EMPLOYE oe values (employe_t(
	12,
	'DIDEROT',
	TABPRENOMS_T('Denis'),
	'Secretaire',
	1630,
	Empty_clob(),
	to_date('11-11-1970','DD-MM-YYYY'),
	to_date('11-12-2010','DD-MM-YYYY'),
	refAgency6
	))
	returning ref(oe) INTO refEmp12;

-- Mise à jour de la liste des pointeurs vers les employes de l'agence 6 --

	insert into
	TABLE(select oa.listRefEmp from O_AGENCY oa where oa.agencyNo=6) lre
	values(refEmp11);
	insert into
	TABLE(select oa.listRefEmp from O_AGENCY oa where oa.agencyNo=6) lre
	values(refEmp12);




-- Employes de l'agence 7 --

	insert into O_EMPLOYE oe values (employe_t(
	13,
	'DUMAS',
	TABPRENOMS_T('Alexandre'),
	'Banquier',
	4000,
	Empty_clob(),
	to_date('11-12-1983','DD-MM-YYYY'),
	to_date('11-12-2006','DD-MM-YYYY'),
	refAgency7
	))
	returning ref(oe) INTO refEmp13;

    insert into O_EMPLOYE oe values (employe_t(
	14,
	'ELUARD',
	TABPRENOMS_T('Paul'),
	'Vigile',
	1500,
	Empty_clob(),
	to_date('11-11-1982','DD-MM-YYYY'),
	to_date('11-12-2012','DD-MM-YYYY'),
	refAgency7
	))
	returning ref(oe) INTO refEmp14;

-- Mise à jour de la liste des pointeurs vers les employes de l'agence 7 --

	insert into
	TABLE(select oa.listRefEmp from O_AGENCY oa where oa.agencyNo=7) lre
	values(refEmp13);
    insert into
	TABLE(select oa.listRefEmp from O_AGENCY oa where oa.agencyNo=7) lre
	values(refEmp14);




-- Employes de l'agence 8 --

	insert into O_EMPLOYE oe values (employe_t(
	15,
	'FRANCE',
	TABPRENOMS_T('Anatole'),
	'Avocat',
	5000,
	Empty_clob(),
	to_date('11-12-1969','DD-MM-YYYY'),
	to_date('11-12-1995','DD-MM-YYYY'),
	refAgency8
	))
	returning ref(oe) INTO refEmp15;

	insert into O_EMPLOYE oe values (employe_t(
	16,
	'GIRAUDOUX',
	TABPRENOMS_T('Jean'),
	'Analyste',
	3500,
	Empty_clob(),
	to_date('11-12-1985','DD-MM-YYYY'),
	to_date('11-12-2000','DD-MM-YYYY'),
	refAgency8
	))
	returning ref(oe) INTO refEmp16;

-- Mise à jour de la liste des pointeurs vers les employes de l'agence 8 --

    insert into
	TABLE(select oa.listRefEmp from O_AGENCY oa where oa.agencyNo=8) lre
	values(refEmp15);
	insert into
	TABLE(select oa.listRefEmp from O_AGENCY oa where oa.agencyNo=8) lre
	values(refEmp16);




-- Employes de l'agence 9 --

	insert into O_EMPLOYE oe values (employe_t(
	17,
	'HUGO',
	TABPRENOMS_T('Victor'),
	'Banquier',
	7600,
	Empty_clob(),
	to_date('11-11-1964','DD-MM-YYYY'),
	to_date('11-12-1980','DD-MM-YYYY'),
	refAgency9
	))
	returning ref(oe) INTO refEmp17;

	insert into O_EMPLOYE oe values (employe_t(
	18,
	'DE LA FONTAINE',
	TABPRENOMS_T('JEAN'),
	'Vigile',
	1700,
	Empty_clob(),
	to_date('11-12-1980','DD-MM-YYYY'),
	to_date('11-12-2005','DD-MM-YYYY'),
	refAgency9
	))
	returning ref(oe) INTO refEmp18;


-- Mise à jour de la liste des pointeurs vers les employes de l'agence 9 --

	insert into
	TABLE(select oa.listRefEmp from O_AGENCY oa where oa.agencyNo=9) lre
	values(refEmp17);
    insert into
	TABLE(select oa.listRefEmp from O_AGENCY oa where oa.agencyNo=9) lre
	values(refEmp18);



-- Employes de l'agence 10 --

    insert into O_EMPLOYE oe values (employe_t(
	19,
	'MALOT',
	TABPRENOMS_T('Hector'),
	'Banquier',
	3660,
	Empty_clob(),
	to_date('11-11-1982','DD-MM-YYYY'),
	to_date('11-12-2012','DD-MM-YYYY'),
	refAgency10
	))
	returning ref(oe) INTO refEmp19;

	insert into O_EMPLOYE oe values (employe_t(
	20,
	'MONTAIGNE',
	TABPRENOMS_T('Michel','Eyquem'),
	'Banquier',
	5044,
	Empty_clob(),
	to_date('11-12-1971','DD-MM-YYYY'),
	to_date('11-12-1996','DD-MM-YYYY'),
	refAgency10
	))
	returning ref(oe) INTO refEmp20;

-- Mise à jour de la liste des pointeurs vers les employes de l'agence 10 --

    insert into
	TABLE(select oa.listRefEmp from O_AGENCY oa where oa.agencyNo=10) lre
	values(refEmp19);
    insert into
	TABLE(select oa.listRefEmp from O_AGENCY oa where oa.agencyNo=10) lre
	values(refEmp20);


    
-- Insertion des clients dans la table des clients -- 

	insert into O_CLIENT oc values (CLIENT_T(
		1,
		'GIDE',
		TABPRENOMS_T('Andre'),
		'Ecrivain',
		5000,
		listRefAccount_t(),
		Empty_clob(),
		to_date('1-1-1947','DD-MM-YYYY'),
		refAgency1
	))
	returning ref(oc) into refClt1;

	insert into
	Table(select oc.listRefAccount from O_CLIENT oc where oc.numCli=1) lra 
	values(refAct1);

	insert into O_CLIENT oc values (CLIENT_T(
		2,
		'CAMUS',
		TABPRENOMS_T('Albert'),
		'Ecrivain',
		2500,
        listRefAccount_t(),
		Empty_clob(),
		to_date('2-2-1957','DD-MM-YYYY'),
		refAgency2		
	))
	returning ref(oc) into refClt2;

	insert into
	Table(select oc.listRefAccount from O_CLIENT oc where oc.numCli=2) lra 
	values(refAct2);

	insert into O_CLIENT oc values (CLIENT_T(
		3,
		'SARTRE',
		TABPRENOMS_T('Jean-Paul'),
		'Cuisinier',
		25000,
        listRefAccount_t(),
		Empty_clob(),
		to_date('3-3-1964','DD-MM-YYYY'),
		refAgency3
	))
	returning ref(oc) into refClt3;

	insert into
	Table(select oc.listRefAccount from O_CLIENT oc where oc.numCli=3) lra 
	values(refAct3);

	insert into O_CLIENT oc values (CLIENT_T(
		4,
		'JACOB',
		TABPRENOMS_T('François'),
		'Médecin',
		99999,
        listRefAccount_t(),
		Empty_clob(),
		to_date('4-4-1965','DD-MM-YYYY'),
		refAgency4
	))
	returning ref(oc) into refClt4;

	insert into
	Table(select oc.listRefAccount from O_CLIENT oc where oc.numCli=4) lra 
	values(refAct4);

	insert into O_CLIENT oc values (CLIENT_T(
		5,
		'LWOFF',
		TABPRENOMS_T('André'),
		'Psychologue',
		2500,
        listRefAccount_t(),
		Empty_clob(),
		to_date('5-5-1965','DD-MM-YYYY'),
		refAgency5
	))
	returning ref(oc) into refClt5;

	insert into
	Table(select oc.listRefAccount from O_CLIENT oc where oc.numCli=5) lra 
	values(refAct5);

	insert into O_CLIENT oc values (CLIENT_T(
		6,
		'MONOD',
		TABPRENOMS_T('Jacques'),
		'Médecin',
		5000,
        listRefAccount_t(),
		Empty_clob(),
		to_date('6-6-1965','DD-MM-YYYY'),
		refAgency6
	))
	returning ref(oc) into refClt6;

	insert into
	Table(select oc.listRefAccount from O_CLIENT oc where oc.numCli=6) lra 
	values(refAct6);

	insert into O_CLIENT oc values (CLIENT_T(
		7,
		'KASTLER',
		TABPRENOMS_T('Alfred'),
		'Chercheur',
		1500,
        listRefAccount_t(),
		Empty_clob(),
		to_date('7-7-1966','DD-MM-YYYY'),
		refAgency7
	))
	returning ref(oc) into refClt7;

	insert into
	Table(select oc.listRefAccount from O_CLIENT oc where oc.numCli=7) lra 
	values(refAct7);

	insert into O_CLIENT oc values (CLIENT_T(
		8,
		'CASSIN',
		TABPRENOMS_T('René'),
		'Vétérinaire',
		7200,
        listRefAccount_t(),
		Empty_clob(),
		to_date('8-8-1968','DD-MM-YYYY'),
		refAgency8
	))
	returning ref(oc) into refClt8;

	insert into
	Table(select oc.listRefAccount from O_CLIENT oc where oc.numCli=8) lra 
	values(refAct8);

	insert into O_CLIENT oc values (CLIENT_T(
		9,
		'NEEL',
		TABPRENOMS_T('Louis'),
		'Cheminot',
		4500,
        listRefAccount_t(),
		Empty_clob(),
		to_date('9-9-1970','DD-MM-YYYY'),
		refAgency9
	))
	returning ref(oc) into refClt9;

	insert into
	Table(select oc.listRefAccount from O_CLIENT oc where oc.numCli=9) lra 
	values(refAct9);

	insert into O_CLIENT oc values (CLIENT_T(
		10,
		'GUILLEMIN',
		TABPRENOMS_T('Roger'),
		'Plombier',
		1200,
        listRefAccount_t(),
		Empty_clob(),
		to_date('10-10-1977','DD-MM-YYYY'),
		refAgency10
	))
	returning ref(oc) into refClt10;

	insert into
	Table(select oc.listRefAccount from O_CLIENT oc where oc.numCli=10) lra 
	values(refAct10);

	insert into O_CLIENT oc values (CLIENT_T(
		11,
		'DAUSSET',
		TABPRENOMS_T('Jean'),
		'Psychiatre',
		8900,
        listRefAccount_t(),
		Empty_clob(),
		to_date('11-11-1980','DD-MM-YYYY'),
		refAgency1
	))
	returning ref(oc) into refClt11;

	insert into
	Table(select oc.listRefAccount from O_CLIENT oc where oc.numCli=11) lra 
	values(refAct11);

	insert into O_CLIENT oc values (CLIENT_T(
		12,
		'DEBREU',
		TABPRENOMS_T('Gérard'),
		'Trader',
		50000,
        listRefAccount_t(),
		Empty_clob(),
		to_date('12-12-1983','DD-MM-YYYY'),
		refAgency2
	))
	returning ref(oc) into refClt12;

	insert into
	Table(select oc.listRefAccount from O_CLIENT oc where oc.numCli=12) lra 
	values(refAct12);

	insert into O_CLIENT oc values (CLIENT_T(
		13,
		'SIMON',
		TABPRENOMS_T('Claude'),
		'Professeur',
		2200,
        listRefAccount_t(),
		Empty_clob(),
		to_date('13-1-1985', 'DD-MM-YYYY'),
		refAgency3
	))
	returning ref(oc) into refClt13;

	insert into
	Table(select oc.listRefAccount from O_CLIENT oc where oc.numCli=13) lra 
	values(refAct13);

	insert into O_CLIENT oc values (CLIENT_T(
		14,
		'ALLAIS',
		TABPRENOMS_T('Maurice'),
		'Commerical',
		2700,
		listRefAccount_t(),
		Empty_clob(),
		to_date('14-2-1988','DD-MM-YYYY'),
		refAgency4
	))
	returning ref(oc) into refClt14;

	insert into
	Table(select oc.listRefAccount from O_CLIENT oc where oc.numCli=14) lra 
	values(refAct14);

	insert into O_CLIENT oc values (CLIENT_T(
		15,
		'CHARPAK',
		TABPRENOMS_T('Georges'),
		'Ingenieur',
		4300,
        listRefAccount_t(),
		Empty_clob(),
		to_date('15-3-1964','DD-MM-YYYY'),
		refAgency5
	))
	returning ref(oc) into refClt15;

	insert into
	Table(select oc.listRefAccount from O_CLIENT oc where oc.numCli=15) lra 
	values(refAct15);

	insert into O_CLIENT oc values (CLIENT_T(
		16,
		'CHAUVIN',
		TABPRENOMS_T('Yves'),
		'Laborantin',
		1800,
		listRefAccount_t(),
		Empty_clob(),
		to_date('16-4-1964','DD-MM-YYYY'),
		refAgency6
	))
	returning ref(oc) into refClt16;

	insert into
	Table(select oc.listRefAccount from O_CLIENT oc where oc.numCli=16) lra 
	values(refAct16);

	insert into O_CLIENT oc values (CLIENT_T(
		17,
		'FERT',
		TABPRENOMS_T('Albert'),
		'Laborantin',
		1800,
		listRefAccount_t(),
		Empty_clob(),
		to_date('17-5-1987','DD-MM-YYYY'),
		refAgency7
	))
	returning ref(oc) into refClt17;

	insert into
	Table(select oc.listRefAccount from O_CLIENT oc where oc.numCli=17) lra 
	values(refAct17);

	insert into O_CLIENT oc values (CLIENT_T(
		18,
		'HAROCHE',
		TABPRENOMS_T('Serge'),
		'Maçon',
		1800,
		listRefAccount_t(),
		Empty_clob(),
		to_date('18-6-1964','DD-MM-YYYY'),
		refAgency8
	))
	returning ref(oc) into refClt18;

	insert into
	Table(select oc.listRefAccount from O_CLIENT oc where oc.numCli=18) lra 
	values(refAct18);

	insert into O_CLIENT oc values (CLIENT_T(
		19,
		'MOUROU',
		TABPRENOMS_T('Gérard'),
		'Electricien',
		2100,
		listRefAccount_t(),
		Empty_clob(),
		to_date('19-7-1964','DD-MM-YYYY'),
		refAgency9
	))
	returning ref(oc) into refClt19;

	insert into
	Table(select oc.listRefAccount from O_CLIENT oc where oc.numCli=19) lra 
	values(refAct19);

	insert into O_CLIENT oc values (CLIENT_T(
		20,
		'BOULANGER',
		TABPRENOMS_T('Paul'),
		'Laborantin',
		1800,
		listRefAccount_t(),
		Empty_clob(),
		to_date('20-8-1964','DD-MM-YYYY'),
		refAgency10
	))
	returning ref(oc) into refClt20;

	insert into
	Table(select oc.listRefAccount from O_CLIENT oc where oc.numCli=20) lra 
	values(refAct20);

-- Insertion des transactions dans la table --

	insert into O_TRANSACTION otr values (TRANSACTION_T (
		1,
		refClt1,
		refClt2,
		1000
	))
	returning ref(otr) into refTransac1;

	insert into O_TRANSACTION otr values (TRANSACTION_T(
		2,
		refClt3,
		refClt4,
		2000
	))
	returning ref(otr) into refTransac2;

	insert into O_TRANSACTION otr values (TRANSACTION_T(
		3,
		refClt5,
		refClt6,
		3000
	))
	returning ref(otr) into refTransac3;

	insert into O_TRANSACTION otr values (TRANSACTION_T(
		4,
		refClt7,
		refClt8,
		4000
	))
	returning ref(otr) into refTransac4;

	insert into O_TRANSACTION otr values (TRANSACTION_T(
		5,
		refClt9,
		refClt10,
		5000
	))
	returning ref(otr) into refTransac5;

	insert into O_TRANSACTION otr values (TRANSACTION_T(
		6,
		refClt11,
		refClt12,
		6000
	))
	returning ref(otr) into refTransac6;

	insert into O_TRANSACTION otr values (TRANSACTION_T(
		7,
		refClt13,
		refClt14,
		7000
	))
	returning ref(otr) into refTransac7;

	insert into O_TRANSACTION otr values (TRANSACTION_T(
		8,
		refClt15,
		refClt16,
		8000
	))
	returning ref(otr) into refTransac8;

	insert into O_TRANSACTION otr values (TRANSACTION_T(
		9,
		refClt17,
		refClt18,
		9000
	))
	returning ref(otr) into refTransac9;

	insert into O_TRANSACTION otr values (TRANSACTION_T(
		10,
		refClt19,
		refClt20,
		10000
	))
	returning ref(otr) into refTransac10;

	insert into O_TRANSACTION otr values (TRANSACTION_T(
		11,
		refClt1,
		refClt20,
		11000
	))
	returning ref(otr) into refTransac11;

	insert into O_TRANSACTION otr values (TRANSACTION_T(
		12,
		refClt2,
		refClt19,
		12000
	))
	returning ref(otr) into refTransac12;

	insert into O_TRANSACTION otr values (TRANSACTION_T(
		13,
		refClt3,
		refClt18,
		13000
	))
	returning ref(otr) into refTransac13;

	insert into O_TRANSACTION otr values (TRANSACTION_T(
		14,
		refClt4,
		refClt17,
		14000
	))
	returning ref(otr) into refTransac14;

	insert into O_TRANSACTION otr values (TRANSACTION_T(
		15,
		refClt5,
		refClt16,
		15000
	))
	returning ref(otr) into refTransac15;

	insert into O_TRANSACTION otr values (TRANSACTION_T(
		16,
		refClt6,
		refClt15,
		16000
	))
	returning ref(otr) into refTransac16;

	insert into O_TRANSACTION otr values (TRANSACTION_T(
		17,
		refClt7,
		refClt14,
		17000
	))
	returning ref(otr) into refTransac17;

	insert into O_TRANSACTION otr values (TRANSACTION_T(
		18,
		refClt8,
		refClt13,
		108000
	))
	returning ref(otr) into refTransac18;

	insert into O_TRANSACTION otr values (TRANSACTION_T(
		19,
		refClt9,
		refClt12,
		19000
	))
	returning ref(otr) into refTransac19;

	insert into O_TRANSACTION otr values (TRANSACTION_T(
		20,
		refClt10,
		refClt11,
		1000000
	))
	returning ref(otr) into refTransac20;

-- Insertion des comptes en banque --

	insert into O_ACCOUNT oact values (ACCOUNT_T(
		1,
		'Livret A',
		12678,
		25000,
		listRefTransaction_t(),
		refAgency1
	))
	returning ref(oact) into refAct1;

	insert into
	Table(select oact.statements from O_ACCOUNT oact where oact.accountNo=1) lrt 
	values(refTransac1);

	insert into
	Table(select oact.statements from O_ACCOUNT oact where oact.accountNo=1) lrt 
	values(refTransac11);

	insert into O_ACCOUNT oact values (ACCOUNT_T(
		2,
		'PEL',
		15000,
		60000,
		listRefTransaction_t(),
		refAgency2
	))
	returning ref(oact) into refAct2;

	insert into
	Table(select oact.statements from O_ACCOUNT oact where oact.accountNo=2) lrt 
	values(refTransac1);

	insert into
	Table(select oact.statements from O_ACCOUNT oact where oact.accountNo=2) lrt 
	values(refTransac12);
	
	insert into O_ACCOUNT oact values (ACCOUNT_T(
		3,
		'Compte Courant',
		50000,
		160000,
		listRefTransaction_t(),
		refAgency3
	))
	returning ref(oact) into refAct3;

	insert into
	Table(select oact.statements from O_ACCOUNT oact where oact.accountNo=3) lrt 
	values(refTransac2);
	
	insert into
	Table(select oact.statements from O_ACCOUNT oact where oact.accountNo=3) lrt 
	values(refTransac13);

	insert into O_ACCOUNT oact values (ACCOUNT_T(
		4,
		'Compte Epargne',
		150000,
		600000,
		listRefTransaction_t(),
		refAgency4
	))
	returning ref(oact) into refAct4;

	insert into
	Table(select oact.statements from O_ACCOUNT oact where oact.accountNo=4) lrt 
	values(refTransac2);

	insert into
	Table(select oact.statements from O_ACCOUNT oact where oact.accountNo=4) lrt 
	values(refTransac14);

	insert into O_ACCOUNT oact values (ACCOUNT_T(
		5,
		'PEL Pro',
		10000,
		50000,
		listRefTransaction_t(),
		refAgency5
	))
	returning ref(oact) into refAct5;

	insert into
	Table(select oact.statements from O_ACCOUNT oact where oact.accountNo=5) lrt 
	values(refTransac3);
	insert into
	Table(select oact.statements from O_ACCOUNT oact where oact.accountNo=5) lrt 
	values(refTransac15);

	insert into O_ACCOUNT oact values (ACCOUNT_T(
		6,
		'Livret A',
		7000,
		15000,
		listRefTransaction_t(),
		refAgency6
	))
	returning ref(oact) into refAct6;

	insert into
	Table(select oact.statements from O_ACCOUNT oact where oact.accountNo=6) lrt 
	values(refTransac3);

	insert into
	Table(select oact.statements from O_ACCOUNT oact where oact.accountNo=6) lrt 
	values(refTransac16);

	insert into O_ACCOUNT oact values (ACCOUNT_T(
		7,
		'Compte Epargne',
		22687,
		80000,
		listRefTransaction_t(),
		refAgency7
	))
	returning ref(oact) into refAct7;

	insert into
	Table(select oact.statements from O_ACCOUNT oact where oact.accountNo=7) lrt 
	values(refTransac4);

	insert into
	Table(select oact.statements from O_ACCOUNT oact where oact.accountNo=7) lrt 
	values( refTransac17);

	insert into O_ACCOUNT oact values (ACCOUNT_T(
		8,
		'Compte Epargne',
		22687,
		80000,
		listRefTransaction_t(),
		refAgency8
	))
	returning ref(oact) into refAct8;

	insert into
	Table(select oact.statements from O_ACCOUNT oact where oact.accountNo=8) lrt 
	values(refTransac4);
	insert into
	Table(select oact.statements from O_ACCOUNT oact where oact.accountNo=8) lrt 
	values(refTransac18);

	insert into O_ACCOUNT oact values (ACCOUNT_T(
		9,
		'Compte Courant',
		23456,
		40000,
		listRefTransaction_t(),
		refAgency9
	))
	returning ref(oact) into refAct9;

	insert into
	Table(select oact.statements from O_ACCOUNT oact where oact.accountNo=9) lrt 
	values(refTransac5);
	
	insert into
	Table(select oact.statements from O_ACCOUNT oact where oact.accountNo=9) lrt 
	values(refTransac19);

	insert into O_ACCOUNT oact values (ACCOUNT_T(
		10,
		'PEL',
		150000,
		260000,
		listRefTransaction_t(),
		refAgency10
	))
	returning ref(oact) into refAct10;

	insert into
	Table(select oact.statements from O_ACCOUNT oact where oact.accountNo=10) lrt 
	values(refTransac5);

		insert into
	Table(select oact.statements from O_ACCOUNT oact where oact.accountNo=10) lrt 
	values(refTransac20);

	insert into O_ACCOUNT oact values (ACCOUNT_T(
		11,
		'PEL Pro',
		6789,
		30000,
		listRefTransaction_t(),
		refAgency1
	))
	returning ref(oact) into refAct11;

	insert into
	Table(select oact.statements from O_ACCOUNT oact where oact.accountNo=11) lrt 
	values(refTransac6);

	insert into
	Table(select oact.statements from O_ACCOUNT oact where oact.accountNo=11) lrt 
	values( refTransac20);
	
	

	insert into O_ACCOUNT oact values (ACCOUNT_T(
		12,
		'Livret A',
		12678,
		30000,
		listRefTransaction_t(),
		refAgency2
	))
	returning ref(oact) into refAct12;

	insert into
	Table(select oact.statements from O_ACCOUNT oact where oact.accountNo=12) lrt 
	values(refTransac6);


    insert into
	Table(select oact.statements from O_ACCOUNT oact where oact.accountNo=12) lrt 
	values(refTransac19);

	insert into O_ACCOUNT oact values (ACCOUNT_T(
		13,
		'Compte Epargne',
		15000,
		60000,
		listRefTransaction_t(),
		refAgency3
	))
	returning ref(oact) into refAct13;

	insert into
	Table(select oact.statements from O_ACCOUNT oact where oact.accountNo=13) lrt 
	values(refTransac7);
	
	insert into
	Table(select oact.statements from O_ACCOUNT oact where oact.accountNo=13) lrt 
	values(refTransac18);

	insert into O_ACCOUNT oact values (ACCOUNT_T(
		14,
		'Compte Courant',
		34567,
		60000,
		listRefTransaction_t(),
		refAgency4
	))
	returning ref(oact) into refAct14;

	insert into
	Table(select oact.statements from O_ACCOUNT oact where oact.accountNo=14) lrt 
	values(refTransac7);

    insert into
	Table(select oact.statements from O_ACCOUNT oact where oact.accountNo=14) lrt 
	values(refTransac17);

	insert into O_ACCOUNT oact values (ACCOUNT_T(
		15,
		'PEL',
		78901,
		90000,
		listRefTransaction_t(),
		refAgency5
	))
	returning ref(oact) into refAct15;

	insert into
	Table(select oact.statements from O_ACCOUNT oact where oact.accountNo=15) lrt 
	values(refTransac8);

	insert into
	Table(select oact.statements from O_ACCOUNT oact where oact.accountNo=15) lrt 
	values(refTransac16);

	insert into O_ACCOUNT oact values (ACCOUNT_T(
		16,
		'PEL Pro',
		12345,
		30000,
		listRefTransaction_t(),
		refAgency6
	))
	returning ref(oact) into refAct16;

	insert into
	Table(select oact.statements from O_ACCOUNT oact where oact.accountNo=16) lrt 
	values(refTransac8);

	insert into
	Table(select oact.statements from O_ACCOUNT oact where oact.accountNo=16) lrt 
	values(refTransac15);

	insert into O_ACCOUNT oact values (ACCOUNT_T(
		17,
		'Livret A',
		23738,
		40000,
		listRefTransaction_t(),
		refAgency7
	))
	returning ref(oact) into refAct17;

	insert into
	Table(select oact.statements from O_ACCOUNT oact where oact.accountNo=17) lrt 
	values(refTransac9);

	insert into
	Table(select oact.statements from O_ACCOUNT oact where oact.accountNo=17) lrt 
	values(refTransac14);

	insert into O_ACCOUNT oact values (ACCOUNT_T(
		18,
		'Compte Epargne',
		9876,
		20000,
		listRefTransaction_t(),
		refAgency8
	))
	returning ref(oact) into refAct18;

	insert into
	Table(select oact.statements from O_ACCOUNT oact where oact.accountNo=18) lrt 
	values(refTransac9);

    insert into
	Table(select oact.statements from O_ACCOUNT oact where oact.accountNo=18) lrt 
	values(refTransac13);

	insert into O_ACCOUNT oact values (ACCOUNT_T(
		19,
		'Compte Courant',
		15000,
		60000,
		listRefTransaction_t(),
		refAgency9
	))
	returning ref(oact) into refAct19;

	insert into
	Table(select oact.statements from O_ACCOUNT oact where oact.accountNo=19) lrt 
	values(refTransac10);

	insert into
	Table(select oact.statements from O_ACCOUNT oact where oact.accountNo=19) lrt 
	values(refTransac12);

	insert into O_ACCOUNT oact values (ACCOUNT_T(
		20,
		'PEL',
		15000,
		60000,
		listRefTransaction_t(),
		refAgency10
	))
	returning ref(oact) into refAct20;

	insert into
	Table(select oact.statements from O_ACCOUNT oact where oact.accountNo=20) lrt 
	values(refTransac10);

    insert into
	Table(select oact.statements from O_ACCOUNT oact where oact.accountNo=20) lrt 
	values(refTransac11);

end;
/

commit;