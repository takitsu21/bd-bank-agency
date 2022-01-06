/*PLAN
Objectif des exercices
Exercices chapitre1_8: types et tables objets
Exercices chapitre10 : Les vues
Exercices chapitre11: Les objets volumineux
Exercices chaiptre12: Procedures
Exercices chapitre14: Java/JDBC et les objets complexes
Exercices chapitre 1_12: Test des performances entre une application relationnelle et une application objet relationnelle



Objectif des exercices

Mettre en œuvre l’approche objet relationnel / sql3 Oracle

Les points que nous visons sont :
Concevoir et creer le schema d'une base de donnees objet relationnelle
Consulter les objets du schema en exploitant entre autre les nouveaux operateurs tels que TABLE, VALUE, ...
Effectuer des insertions, mises à jour et suppressions dans ce schema en exit
Manipuler des objets dans PL/SQL
Manipuler les vues objets sur les tables relationnelles
Manipuler des objets volumineux
Acceder aux objets complexes Oracle depuis java/Jdbc
Effectuer un comparatif de performances entre une application relationnelle et une application objet relationnelle


Exercices chapitre1_8: types et tables objets

Definition du schema d'objets
Schema conceptuel

(voir le cours)
*/
--Definition du schema d'objets
--Description des entites
-- Creation des types de donnees

Nom entite	Nom des champs	type			Libelle
EMPLOYE	EMPNO			number(8)	Numero Employe. Champs identifiant et Non null
			ENAME		 	varchar2(15) 	Nom EMPLOYE : En lettre capitales et non null
			PRENOMS			varray		tableau de 4 prenom  max
			JOB				Varchar2(20)	Metier de l’employe {Ingenieur,
			Secretaire, Directeur, Planton, PDG} et non null
			SAL				number(7,2)		Salaire entre 1500 et 15000. Non null
			CV				CLOB		CV
			DATE_NAISS		date			Date de Naissance. Non null
			DATE_EMB			date			Date embauche : Non null et doit être superieure
			Date_Naiss


DEPT		DEPTNO			number(4)		Nr. de departement doit
									être entre 1000 et 9999. Identifiant et Non null
			DNAME			varchar2(30) 	Nom du departement {Recherche,
			RH, Marketing, Ventes, Finance}. Non null
			LOC				varchar2(30)	Localisation du departement. Non null


NOTE : 	prendre en compte les contraintes attributs UNIQUE ou OBLIGATOIRE
(voir schema page precedente)

/*
Chap_1_8.1. Creation des types : Les etapes

1. Creer les types FORWARD ou INCOMPLETS appropries. Il n'est pas necessaire de definir tous les types en FORWARD

2. Creer le type ARRAY tab_prenoms_t necessaire pour gerer la liste des PRENOMs

3. Creer le Type Table (liste) necessaire : ces elements seront des references vers des EMPLOYE_t

4. Definir maintenant vos types EMPLOYE_T, DEPT_T,…
	Vous devez y declarer les champs ou attributs des types, les methodes et les liens ou Nested Tables
	Note : pour les methodes et les liens, voir plus loin.

Creation des types : Les methodes

1. Les methodes de consultation

Definir une methode de classe qui renvoie des informations (, ...)
sur un DEPT connaissant son numero. Proceder à l’affichage des
ces informations
static function getDept (deptno1 IN number) return dept_t;

Definir une methode de classe qui renvoie la collection d’employees d’un DEPT donne. Afficher ensuite le nom et le pronom de chaque employe. La collection setEmployes_t est à definir
Static function getInfoEmp(deptno1 IN number) return setEmployes_t

2. Les methodes pour ordonner les elements des types

ecrire pour chaque type une methode ORDER ou MAP. Il est necessaire d'utiliser au moins une fois chacune de ces methodes.


Creation des types : Les methodes

3. Les methodes de gestion des Liens

Introduire pour chaque Lien Multivalue les procedures suivantes :
	- addLinkListeEmployes(RefEmp1 REF Employe_t);
		-- pour ajouter dans la liste
	- deleteLinkListeEmployes (RefEmp1 REF Employe_t);	-- suppression dans un lien
	- updateLinkListeEmployes (RefEmp1 REF Employe_t, 	RefEmp2 REF Employe_t);
		-- modification du lien
4. Notes
ces methodes DOIVENT être en Lecture seule(WNDS) (PRAGMA RESTRICT_REFERENCES) sauf celles decrites en 3.
dans cette phase, aucune methode n'a encore ete 	implementee. Il ne s'agit que des declarations.
*/

drop table employe_o cascade constraints;
drop table dept_o cascade constraints;
drop type dept_t force;
drop type employe_t force;
drop type  listRefEmployes_t force;
drop type  setEmployes_t force;
drop type  tabPrenoms_t;

create or replace type dept_t
/

create or replace type tabPrenoms_t as varray(4) of varchar2(40)
/

create or replace type EMPLOYE_T AS OBJECT(
	EMPNO			number(8),
	ENAME		 	varchar2(15),
	PRENOMS			tabPrenoms_t,
	JOB				Varchar2(20),
	SAL				number(7,2),
	CV				CLOB,
	DATE_NAISS		date,
	DATE_EMB		date,
	refDept			ref dept_t,
	order member function compEmp (emp IN EMPLOYE_T) return number
);
/

create or replace type listRefEmployes_t as table of REF employe_t
/

create or replace type setEmployes_t as table of employe_t
/
create or replace type DEPT_T AS OBJECT(
	DEPTNO			number(4),
	DNAME			varchar2(30),
	LOC				varchar2(30),
	listRefEmps		listRefEmployes_t,
	static function getDept (deptno1 IN number) return dept_t,
	Static function getInfoEmp(deptno1 IN number) return setEmployes_t,
	map member function  compDept return varchar2,
	member procedure addLinkListeEmployes(RefEmp1 REF Employe_t),
	member procedure deleteLinkListeEmployes (RefEmp1 REF Employe_t),
	member procedure updateLinkListeEmployes (RefEmp1 REF Employe_t,
		RefEmp2 REF Employe_t)
);
/


/*

Chap_1_8.2 Creation des tables

Creer les tables EMPLOYE_O, DEPT_O comme etant des tables objets

Les contraintes d'integrites
Definir les contraintes d'integrites d'entites sur chacune des tables
Definir les contraintes d'integrites de domaine (cf. la description
des champs page 264 et page 265)

Les Nested Tables
Donner les noms de segments à toutes vos Nested Tables
Format du nom : storeNomColNested

Les LOB internes PCTVERSION doit être à 30

Creation des tables
Localisation des objets
Les tuples des tables objets sont à localiser dans
le Tablespace TS_TABLE_RES
les index des tables objets y compris ceux crees implicitement
sont à localiser dans TS_INDEX_RES
les donnees et les index des LOB internes sont à localiser
dans le Tablespace TS_LOB_RES
*/


/*

DEPT		DEPTNO			number(4)		Nr. de departement doit
				être entre 1000 et 9999. Identifiant et Non null
			DNAME			varchar2(30) Nom du departement {Recherche,
			RH, Marketing, Ventes, Finance}. Non null
			LOC				varchar2(30)	Localisation du departement.
			Non null

*/
*/
drop table dept_o;
create table dept_o of dept_t(
	constraint pk_dept_o_deptno primary key(DEPTNO),
	constraint chk_dept_o_deptno  check(deptno between 1000 and 9999),
	constraint chk_dept_o_dname  check(dname in (
	'Recherche', 'RH', 'Marketing', 'Ventes', 'Finance')),
	dname constraint nnl_dept_o_dname  not null,
	loc  constraint nnl_dept_o_loc not null
)
nested table listRefEmps store as tableListRefEmps
/
1000,RH, ...., {refEmp1, refEmp2}
1001,Recherche, ...., {refEmp3}

vue physique

Dept_o
1000,RH, ...., @D1
1001,Recherche, @D2

tableListRefEmps
nested_table_id		column_value
@D1					refEmp1
@D2					refEmp3
@D1					refEmp2

select listRefEmps from dept_o od where od.deptno=1000
listRefEmployes_t(refEmp1, refEmp2)
select lre.column_value
from
table(select listRefEmps from dept_o od where od.deptno=1000) lre;

column_value
refEmp1
refEmp2





/*




EMPLOYE	EMPNO			number(8)	Numero Employe. Champs identifiant
et Non null
			ENAME		 	varchar2(15) 	Nom EMPLOYE :
			En lettre capitales et non null
			PRENOMS			varray		tableau de 4 prenom  max
			JOB				Varchar2(20)	Metier de l’employe
			{Ingenieur, Secretaire, Directeur, Planton, PDG} et non null
			SAL				number(7,2)		Salaire entre 1500 et 15000.
			Non null
			CV				CLOB		CV
			DATE_NAISS		date			Date de Naissance. Non null
			DATE_EMB			date			Date embauche : Non null
			et doit être superieure
			Date_Naiss
*/

drop table employe_o;
create table employe_o of employe_t(
	constraint pk_employe_o_empno primary key(empno),
	constraint chk_employe_o_ename check(ename=upper(ename)),
	constraint nnl_employe_o_ename check(ename is not null),
	constraint chk_employe_o_job check(
		job in ('Ingenieur', 'Secretaire', 'Directeur',
		'Planton', 'PDG')),
	constraint nnl_employe_o_job check(job is not null),
	constraint chk_employe_o_sal check(sal between 1500 and 15000),
	constraint nnl_employe_o_sal check(sal is not null),
	constraint chk_employe_o_date_emb_date_naiss
		check(date_emb>date_naiss),
	constraint nnl_employe_o_date_naiss check(date_naiss is not null),
	constraint nnl_employe_o_date_emb check(date_emb is not null)
)
LOB (CV) store as storeCV(pctversion 30)
/

create table employe2_o of employe_t(
	constraint pk_employe2_o_empno primary key(empno)
);

/*
Chap_1_8.3 Creation index
Creer un index unique sur la colonne dname de DEPT_o
Creer un index sur la colonne implicite Nested_table_id de la
Nested Table. Peut - il être unique ?
Creer un index unique concatene avec les colonnes Nested_table_id
et Column_value afin d’eviter l’ajout deux fois de la reference
d’un employe dans la liste des references des employes d’un departement
Creer un index sur la reference vers un departement dans la
table employe_o
*/

-- Creer un index unique sur la colonne dname de DEPT_o
create unique index idx_dept_o_dname on dept_o(dname)
/
?
-- Creer un index sur la colonne implicite Nested_table_id de la
-- Nested Table. Peut - il être unique ?

?
create index idx_tableListRefEmps_Nested_table_id
on tableListRefEmps(Nested_table_id);

Unique index IDX_DEPT_O_DNAME cree(e).

Erreur commençant à la ligne: 1 de la commande -
create index idx_tableListRefEmps_Nested_table_id
on tableListRefEmps(Nested_table_id)
Rapport d'erreur -
Erreur SQL : ORA-01408: cette liste de colonnes est dejà indexee
01408. 00000 -  "such column list already indexed"
*Cause:
*Action:
--'
-- Creer un index unique concatene avec les colonnes Nested_table_id
-- et Column_value afin d’eviter l’ajout deux fois de la reference
-- d’un employe dans la liste des references des employes d’un departement
?
ALTER TABLE tableListRefEmps
	ADD (SCOPE FOR (column_value) IS EMPLOYE_O);

create unique index idx_tableListRefEmps_Nested_table_id_Column_value
on tableListRefEmps(Nested_table_id, Column_value);


-- Supprimer l'index concatene et le remplacer par une
-- Primary key sur la nested table avec le colonnes
-- nestedf_table_id et column_value
?

-- Creer un index sur la reference vers un departement dans la
-- table employe_o
?
ALTER TABLE employe_o
	ADD (SCOPE FOR (refDept) IS DEPT_O);
create index idx_employe_o_refDept on employe_o(refDept)
/
-----------------------------------------------------------------------
--Exercices chapitre1_8: types et tables objets
--Chap_1_8.4 Insertion des objets
-- Inserer 2 ou 3 objets dans chacune des tables creees precedemment.
-- L'integrite des objets doit être assuree
------------------------------------------------------------------------


declare
	refDept1	   REF dept_t;
	refDept2	   REF dept_t;
	refEmp1		   REF Employe_t;
	refEmp2		   REF Employe_t;
	refEmp3		   REF Employe_t;

begin
	-- Etape 1 : Insertion des departements 1000 et 1001
	insert INTO dept_o od values(dept_t(1000, 'RH', 'Nice', LISTREFEMPLOYES_T()))
		returning ref(od) INTO refDept1;
	insert INTO dept_o od values(1001, 'Recherche', 'Paris', LISTREFEMPLOYES_T())
		returning ref(od) INTO refDept2;

	-- Etape 2 : Insertion des demployes
	-- Employes du departement 1000
	Insert into employe_o oe values (employe_t(
	1,
	'KING',
	TABPRENOMS_T('Kingston', 'Leroi'),
	'PDG',
	14000,
	Empty_clob(),
	to_date('11-12-1960','DD-MM-YYYY'),
	to_date('11-12-2000','DD-MM-YYYY'),
	refdept1
	))
	returning ref(oe) INTO refEmp1;

	Insert into employe_o oe values (employe_t(
	2,
	'ADAMS',
	TABPRENOMS_T(),
	'Directeur',
	10000,
	Empty_clob(),
	to_date('11-11-1970','DD-MM-YYYY'),
	to_date('11-12-2012','DD-MM-YYYY'),
	refdept1
	))
	returning ref(oe) INTO refEmp2;

	-- Employes du departement 1001
	Insert into employe_o oe values (employe_t(
	3,
	'BOUMLID',
	TABPRENOMS_T('Mohamed'),
	'Planton',
	2000,
	Empty_clob(),
	to_date('11-12-1961','DD-MM-YYYY'),
	to_date('11-12-2015','DD-MM-YYYY'),
	refdept2
	))
	returning ref(oe) INTO refEmp3;

-- Etape 3 : Mise à jours des listes

-- Mise à jour de la liste des pointeurs vers les employes du departement 1000

	insert into
	TABLE(select od.listRefEmps from dept_o od where od.deptno=1000) lre
	values(refEmp1);
	insert into
	TABLE(select od.listRefEmps from dept_o od where od.deptno=1000) lre
	values(refEmp2);


-- Mise à jour de la liste des pointeurs vers les employes du departement 1001
	insert into
	TABLE(select od.listRefEmps from dept_o od where od.deptno=1001) lre
	values(refEmp3);
end;
/



select * from employe_o;
select * from dept_o;


select ename, oe.refdept.dname
from employe_o oe;

commit;
--ou
rollback;




Nom                                       NULL ?   Type
 ----------------------------------------- -------- ----------------------------
 EMPNO                                     NOT NULL NUMBER(8)
 ENAME                                     NOT NULL VARCHAR2(15)
 PRENOMS                                            TABPRENOMS_T
 JOB                                       NOT NULL VARCHAR2(20)
 SAL                                       NOT NULL NUMBER(7,2)
 CV                                                 CLOB
 DATE_NAISS                                NOT NULL DATE
 DATE_EMB                                  NOT NULL DATE
 REFDEPT                                            REF OF DEPT_T


--------------------------------------------------------------------
-- Chap_1_8.5 Mise à jour des objets
-- Modifier la localite d'un departement connaissant son nom
-- Modifier la date d'embauche d'un Employe connaissant son nom sachant
-- qu'il doit travailler  l’un des departements suivants : 'Recherche',
-- 'Finance' ou  ‘RH’
-- Supprimer un DEPT et mettre la reference vers le departement à null
-- dans la table employe_o
------------------------------------------------------------------------

-- Chap_1_8.5.1 Modifier la localite d'un departement connaissant son
-- nom

?
update dept_o
set loc='Sophia-Antipolis'
where dname='RH';
select * from dept_o;
rollback;
-- Chap_1_8.5.2 Modifier la date d'embauche d'un Employe connaissant
-- son nom sachant qu'il doit travailler dans l'un des departements
-- suivants : 'Recherche', 'Finance' ou  'RH'

?

update employe_o oe
set oe.date_emb=to_date('25-12-2020','DD-MM-YYYY')
where oe.ename='KING' and oe.refDept.dname in ('Recherche', 'Finance',  'RH');

select * from employe_o;

rollback;

-- Chap_1_8.5.3 Supprimer un DEPT et mettre la reference vers le
-- departement à null
-- dans la table employe_o

?
update employe_o oe
set oe.refDept=null
where oe.refDept.deptno=1000;
delete from dept_o od
where od.deptno=1000;

select * from employe_o;
select * from dept_o ;

rollback;

------------------------------------------------------------------------
-- Exercices chapitre1_8: types et tables objets
-- Chap_1_8.6 Consultation des objets
-- Faire un Listing des DEPTs tries par nom
-- Pour un DEPT donne, lister tous les EMPLOYEs qui y travaillent
-------------------------------------------------------------------------


-- Chap_1_8.6.1 Faire un Listing des DEPTs tries par nom

?
select * from dept_o od order by od.dname;

-- Chap_1_8.6.2 Pour un DEPT donne, lister tous les EMPLOYEs qui y
-- travaillent PL/SQL et Procedures stockees
?
select lre.column_value.ename,
lre.column_value.sal,
lre.column_value.prenoms,
lre.column_value.refDept.dname
FROM TABLE(select od.listRefEmps
from dept_o od
where od.deptno=1000) lre;


select
lre.column_value.sal,
lre.column_value.prenoms,
od.dname
from dept_o od, table(od.listRefEmps) lre
where od.deptno=1000;


-------------------------------------------------------------------------
-- Chap_1_8 : PL/SQL et Procedures stockees
-- Implementer les methodes decrites plus haut au niveau des types DEPT_T
-- et EMPLOYE_T tester les methodes
-------------------------------------------------------------------------

-- Chap_1_8.1 Implementer les methodes du type EMPLOYE_T
-- Ci-dessous une implementation à vide à completer en remplaçant
-- null par du vrai code. Le code null permet une implementation
-- incrementatale. En effet PLSQL toutes les fonctions d'un package
-- doivent être codees avant d'être testez
-- Les prototypes des fonctions doivent être identiques
-- à la specification.

create or replace type BODY EMPLOYE_T AS

order member function compEmp (Emp IN EMploye_t)
return number  IS

	pos1 NUMBER :=0;
	pos2 NUMBER :=0;
	empSelf VARCHAR2(60) := SELF.ename||SELF.empno;
	empPar VARCHAR2(60) := Emp.ename||Emp.empno;
	BEGIN
		CASE SELF.job
				WHEN 'PDG' THEN pos1 := 1;
				WHEN 'Directeur' THEN pos1 := 2;
				WHEN 'Ingenieur' THEN pos1 := 3;
				WHEN 'Secretaire' THEN pos1 := 4;
				WHEN 'Planton' THEN pos1 := 5;
		END CASE;
		CASE Emp.job
				WHEN 'PDG' THEN pos2 := 1;
				WHEN 'Directeur' THEN pos2 := 2;
				WHEN 'Ingenieur' THEN pos2 := 3;
				WHEN 'Secretaire' THEN pos2 := 4;
				WHEN 'Planton' THEN pos2 := 5;
		END CASE;

		empSelf :=  pos1||empSelf;
		empPar := pos2|| empPar;

		IF empSelf = empPar 	THEN return 0;
		ELSIF empSelf > empPar 	THEN return 1;
		ELSIF empSelf < empPar 	THEN return -1;
		END IF;

	END;
end;
/
select * from employe_o oe
order by oe.ename;

select * from employe_o oe
order by value(oe);

select value(oe) from employe_o oe
order by value(oe);

create table projet(
projectid number(4) primary key,
projectManager employe_t
);

insert into projet values(1,
employe_t(
	1,
	'KING',
	TABPRENOMS_T('Kingston', 'Leroi'),
	'PDG',
	14000,
	Empty_clob(),
	to_date('11-12-1960','DD-MM-YYYY'),
	to_date('11-12-2000','DD-MM-YYYY'),
	null
	)
);

insert into projet values(2,
employe_t(
	2,
	'ADAMS',
	TABPRENOMS_T(),
	'Directeur',
	10000,
	Empty_clob(),
	to_date('11-11-1970','DD-MM-YYYY'),
	to_date('11-12-2012','DD-MM-YYYY'),
	null
	)
);

select * from projet order by projectManager;
select * from projet where
projectManager>employe_t(
	2,
	'ADAMS',
	TABPRENOMS_T(),
	'Directeur',
	10000,
	Empty_clob(),
	to_date('11-11-1970','DD-MM-YYYY'),
	to_date('11-12-2012','DD-MM-YYYY'),
	null
	);

-- Chap_1_8.2 Implementer les methodes du type DEPT_T
-- Ci-dessous une implementation à vide à completer en remplaçant
-- null par du vrai code. Le code null permet une implementation
-- incrementatale. En effet PLSQL toutes les fonctions d'un package
-- doivent être codees avant d'être testez
-- Les prototypes des fonctions doivent être identiques
-- à la specification.

create or replace type BODY DEPT_T AS

static function getDept (deptno1 IN number)
	return dept_t IS
		dept1 dept_t:=null;
begin
	select value(od) into dept1 from dept_o od where od.deptno=deptno1;
	return dept1;
	Exception
		WHEN NO_DATA_FOUND THEN
			raise no_data_found;
end;
Static function getInfoEmp(deptno1 IN number)
	return setEmployes_t IS
	setEmp setEmployes_t:=null;
begin

	select CAST( COLLECT (deref(le.column_value)) AS setEmployes_t) INTO SetEMP
	FRom TABLE(select od.listRefEmp from dept_o od where od.deptno=deptno1) le;

	return setEmp;
	Exception
		WHEN NO_DATA_FOUND THEN
			raise no_data_found;

end;
member procedure addLinkListeEmployes(RefEmp1 REF Employe_t) IS
begin

	insert into
	TABLE(select od.listRefEmp from dept_o od where od.deptno=self.deptno) le
	values(refEmp1);

	EXCEPTION
		when OTHERS then
			raise;
end;
member procedure deleteLinkListeEmployes (RefEmp1 REF Employe_t) IS
begin

	delete from
	TABLE(select od.listRefEmp from dept_o od where od.deptno=self.deptno) le
	where le.column_value=refEmp1;
	EXCEPTION
		when OTHERS then
			raise;
end;
member procedure updateLinkListeEmployes (RefEmp1 REF Employe_t,
	RefEmp2 REF Employe_t) IS
begin
	UPDATE
	TABLE(select od.listRefEmp from dept_o od where od.deptno=self.deptno) le
	set le.column_value=refEmp2
	where le.column_value=refEmp1;

	EXCEPTION
		when OTHERS then
			raise;

end;
map member function compDept return varchar2 IS
BEGIN
	return loc||dname||deptno;
END;

end;
/

select * from dept_o od
order by value (od);

-- Chap_1_8.3 Tester chaque methode du type EMPLOYE_T

?
-- Chap_1_8.4 Tester chaque methode du type DEPT_T
?

-- trier les instances d'employes
select empno,job, ename, sal
from employe_o oe;

select job, empno, ename, sal
from employe_o oe
order by value(oe) desc;




-- trier les instances de departement
select * from dept_o od
order by value(od);

-- Ajouter un nouvel employe et l'attacher au dept 1000
set serveroutput on
declare
emp4 employe_t:=employe_t(
4,
'TINTIN',
tabPrenoms_t('Milou'),
'Directeur',
15000,
empty_clob(),
to_date('12-12-1970', 'DD-MM-YYYY'),
to_date('12-12-1990', 'DD-MM-YYYY'),
null
);

--- ajouter un employer dans le departement 1000
dept1000 dept_t;
refdept1000 REF dept_t;

refEmp4 REF employe_t;
begin

select value(od), ref(od) into dept1000, refdept1000
from dept_o od where od.deptno=1000;

emp4.refdept:=refdept1000;

insert into employe_o oe
values(emp4) returning ref(oe) into refemp4;

dept1000.ADDLINKLISTEEMPLOYES(refemp4);

end;
/

commit;


----------------------------------------
-- tentative d'ajout d'un employe existant
-- dans la liste des employes d'un departement

select empno, ename
from employe_o oe
where oe.refdept.deptno=1000;

select le.column_value.empno, le.column_value.ename
FROM TABLE(select od.listRefEmp
from dept_o od
where od.deptno=1000) le;

set serveroutput on
declare

dept1000 dept_t;
refdept1000 REF dept_t;

refEmp4 REF employe_t;
emp4  employe_t;
begin
select ref(oe), value(oe) into refemp4, emp4
from employe_o oe
where oe.empno=4;

select value(od), ref(od) into dept1000, refdept1000
from dept_o od where od.deptno=1000;

emp4.refdept:=refdept1000;

dept1000.ADDLINKLISTEEMPLOYES(refemp4);

end;
/



-------------------------------------------------------------------------
-- Exercice chapitre 10 : Les vues objets
-- Chap_10.1 creer une table relationnelle r_dept et r_employe comme
-- suit :creation des tables relationnelles
-------------------------------------------------------------------------

-- Chap_10.1  creation des tables relationnelles
CREATE TABLE R_DEPT(
DEPTNO	number(4) constraint pk_r_dept_deptno primary key,
DNAME	varchar2(30)constraint chk_r_dept_dname check(dname in
		('Recherche','RH', 'Marketing','Ventes', 'Finance')),
LOC	varchar2(30),
constraint chk_r_dept_deptno check(deptno between 1000 and 9999)
)
/
CREATE TABLE R_EMPLOYE(
EMPNO		number(8) constraint pk_r_employe_empno primary key,
ENAME		varchar2(15)constraint chk_r_employe_ename check (ename =upper(ename)),
JOB		Varchar2(20) constraint chk_r_employe_job check
		(job IN ('Ingenieur','Secretaire', 'Directeur', 'PDG', 'Planton')),
SAL		number(7,2),
CV		CLOB,
DATE_NAISS	date,
DATE_EMB	date,
deptno		number(4) constraint fk_r_emp_r_dept references r_dept(deptno),
constraint chk_r_emp_date_e_date_n check (date_emb>date_naiss)
)
/


-- Chap_10.2 Inserer 2 departements et 3 employes


-- Exercice chapitre 10 : Les vues
-- En vue de la creation de vues objets, creer les types suivants:
DROP TYPE EMPLOYE2_T FORCE
/
DROP TYPE DEPT2_T FORCE
/
DROP TYPE tabPrenoms2_t
/
drop TYPE listEmployes2_t
/
CREATE OR REPLACE TYPE EMPLOYE2_T
/
CREATE OR REPLACE TYPE tabPrenoms2_t AS VARRAY(4) OF varchar2(20)
/
create or replace type listRefEmployes2_t as table of ref employe2_t
/
CREATE OR REPLACE TYPE DEPT2_T AS OBJECT(
DEPTNO		number(4),
DNAME		varchar2(30),
LOC		varchar2(30),
listEmployes	listRefEmployes2_t
)
/

-- Exercice chapitre 10 : Les vues
-- Chap_10.3 En vue de la creation de vues objets, creer les
-- types suivants:Type employe2_t
CREATE OR REPLACE TYPE EMPLOYE2_T AS OBJECT(
EMPNO		number(8),
ENAME		varchar2(15),
JOB		Varchar2(20),
SAL		number(7,2),
CV		CLOB,
DATE_NAISS	date,
DATE_EMB	date,
deptno		number(4),
refDept		REF dept2_t
)
/

-- Chap_10.4 Creer les vues objets v_employe2 et v_dept2 mappant les
-- tables relationnelles grâces aux 2 types precedemment crees
----------------------------------------------------------------
-- creation des vues v_dept2 et v_employe2
-- Ces 2 vues ont des references circulaires. Trois etapes
-- pour les creer :
-- 1. Creer la vue v_employe2 avec reference NULL.
--    Pas de reference à la vue v_dept2
-- 2. Creer la vue v_dept2 avec reference à v_employe2
-- 3. Recreer la vue v_employe2 avec reference à v_dept2

CREATE OR REPLACE  VIEW v_employe2 OF employe2_t
WITH OBJECT IDENTIFIER(empno) AS
SELECT rv.empno, rv.ename, rv.job, rv.sal,
rv.cv, rv.DATE_NAISS, rv.date_emb, rv.deptno, null
FROM r_employe rv;

-- Exercice chapitre 10 : Les vues


CREATE OR REPLACE  VIEW v_dept2 OF dept2_t
WITH OBJECT IDENTIFIER(deptno) AS
SELECT rp.deptno, rp.dname, rp.loc,
CAST(MULTISET(select ref(v)
from v_employe2 v
where v.deptno=rp.deptno) AS listRefEmployes2_t)
FROM r_dept rp;


CREATE OR REPLACE  VIEW v_employe2 OF employe2_t
WITH OBJECT IDENTIFIER(empno) AS
SELECT rv.empno, rv.ename, rv.job, rv.sal,
rv.cv, rv.DATE_NAISS, rv.date_emb, rv.deptno,
MAKE_REF(v_dept2, rv.deptno)
FROM r_employe rv;


-- Chap_10.5 Consulter à travers ses vues. Utiliser les liens

-- Chap_10.6 Inserer un departement et un employe à travers
-- les vues. Verifier qu’ils s’auto-referencent

-- Chap_10.7 Creer un trigger INSTEAD OF permettant d’inserer un
-- departement dans les tables r_dept et o_dept


------------------------------------------------------------------------
-- Exercices chapitre 11: Objets volumineux
-- Chap_11. Adapter le code ci-dessus pour charger un CV pour un employe
-- donne dans la colonne CV de la table o_employe
------------------------------------------------------------------------
-- Creation du repertoire sous L'OS
-- 1. Creation du repertoire sous L'OS
mkdir 'C:\oracle\product\10.2.0\oradata\orcl\lobFiles\';
--'
-- 2. Copier le fichier dans ce repertoire :
exemple LOB1.DOC, LOB2.DOC, LOB3.DOC

-- 3. Creer la table contenant le BFILE

create table bfiles(
	id	number (5),
	text	bfile
);

-- 4. Creer un objet DIRECTORY

CREATE OR REPLACE DIRECTORY bfile_dir
	AS 'C:\oracle\product\10.2.0\oradata\orcl\lobFiles\';


--'
-- 5. Insertion de bfiles
delete from bfiles;

INSERT INTO bfiles
	VALUES(1, BFILENAME('BFILE_DIR', 'lob1.doc'));
INSERT INTO bfiles
	VALUES(2, BFILENAME('BFILE_DIR', 'lob2.doc'));
INSERT INTO bfiles
	VALUES(3, BFILENAME('BFILE_DIR', 'lob3.doc'));


-- Exercices chapitre 11: Objets volumineux
-- Adapter le code ci-dessus pour charger un CV pour un employe donne dans la colonne CV de la table o_employe
-- Creation du repertoire sous L'OS
-- 1. Creation du repertoire sous L'OS
mkdir 'C:\oracle\product\10.2.0\oradata\orcl\BFILES\';

--'
-- Copier les fichiers contenant les Cv dans ce repertoire :
--exemple cv1Miloud.txt, cv2Boumlid.txt, cv3Milou.txt,
--cv4Miloud.txt,cv5Chanik.txt

-- 3. Creer la table contenant le BFILE
create table empCVFiles(
	empno	number (4) references o_employe,
	ename	varchar2(15),
	cvFile	bfile
);

-- 4. Creer un objet DIRECTORY
CREATE OR REPLACE DIRECTORY bfile_dir
	AS 'C:\oracle\product\10.2.0\oradata\orcl\BFILES\';

--'
-- 5. Insertion des bfiles
delete from empCVFiles;
INSERT INTO empCVFiles
	VALUES(1, 'MILOUD', BFILENAME('BFILE_DIR', 'cv1Miloud.txt'));
INSERT INTO empCVFiles
VALUES(2, 'BOUMLID', BFILENAME('BFILE_DIR', 'cv2Boumlid.txt'));
INSERT INTO empCVFiles
	VALUES(3, 'MILOU', BFILENAME('BFILE_DIR', 'cv3Milou.txt'));
INSERT INTO empCVFiles
	VALUES(4, 'MILOUD', BFILENAME('BFILE_DIR', 'cv4Miloud.txt'));
INSERT INTO empCVFiles
	VALUES(5, 'CHANIK', BFILENAME('BFILE_DIR', 'cv5Chanik.txt'));


-- Exercices chapitre 11: Objets volumineux
-- Adapter le code ci-dessus pour charger un CV pour un employe
-- donne dans la colonne CV de la table o_employe
-- Copier les cv dans la colonne CV de la table o_employe
declare
cursor c is
select empno, cvFile from empCVFiles;
v_clob clob;
lg number(38);
begin
for j in c
loop
Dbms_Lob.FileOpen ( j.cvFile, Dbms_Lob.File_Readonly );
lg:=Dbms_Lob.GETLENGTH(j.cvFile);

select e.cv into v_clob
from o_employe e
where e.empno=J.empno for update;

Dbms_Lob.LoadFromFile
(
dest_lob => v_clob,
src_lob => j.cvFile,
amount => lg,
dest_offset => 1,
src_offset => 1
);
--amount => 4294967296, /* = 4Gb */
Dbms_Lob.FileClose ( j.cvFile );
end loop;
commit;
end;
/

-- Exercice chapitre 12: Procedure externes
--- Chap_12 :
-- Construire une DLL contenant une fonction factoriel.
-- Pour cela il faut telecharger et installer le compilateur
-- C/C++ DeV-CPP

-- Creer un projet visant la fabrication d’une DLL en langage C.
-- puis cliquer sur OK



















-- Deux fichiers dll.h et dllmain.c seront crees. Completer ces fichiers
-- avec les lignes en gras ensuite effectuer les etapes 1 à 4 du
-- chapitre 12 sur les fonctions externes pour l’utiliser depuis Oracle




-- Exercice chapitre 12 : Procedure externes

Fichier dll.h

#ifndef _DLL_H_
#define _DLL_H_

#if BUILDING_DLL
# define DLLIMPORT __declspec (dllexport)
#else /* Not BUILDING_DLL */
# define DLLIMPORT __declspec (dllimport)
#endif /* Not BUILDING_DLL */


DLLIMPORT void HelloWorld (void);

int __declspec (dllexport) c_calcFactorial (int n);

#endif /* _DLL_H_ */



Exercice chapitre 12 : Procedure externes

Fichier dllmain.h

* Replace "dll.h" with the name of your header */
#include "dll.h"
#include <windows.h>
#include <stdio.h>
#include <stdlib.h>

DLLIMPORT void HelloWorld (){
    MessageBox (0, "Hello World from DLL!\n", "Hi", MB_ICONINFORMATION);
}

int __declspec (dllexport) c_calcFactorial (int n) {
if (n == 1) return 1;
/*return n;*/
else return n * c_calcFactorial(n - 1);
}

BOOL APIENTRY DllMain (HINSTANCE hInst     /* Library instance handle. */ ,
                       DWORD reason        /* Reason this function is being called. */ ,
                       LPVOID reserved     /* Not used. */ ){
    switch (reason)
    {
      case DLL_PROCESS_ATTACH:
        break;

      case DLL_PROCESS_DETACH:
        break;

      case DLL_THREAD_ATTACH:
        break;

      case DLL_THREAD_DETACH:
        break;
    }
    /* Returns TRUE on success, FALSE on failure */
    return TRUE;
}

-----------------------------------------------------------------------
-- Exercice chapitre 14 : Java/JDBC et les objets complexes
-- Chap_14
-- Chap_14.1 Tester l’exemple presente au chapitre 14 sur l’utilisation de
-- la classe JDBC STRUCT pour acceder depuis Java aux objets complexes
-- instances de Steutiant_t

-- Chap_14.2 Tester l’exemple presente au chapitre 14 sur l’utilisation
-- des classes Java/DBC specialise pour acceder depuis Java aux objets
-- complexes instances de Artiste_t et Tableau_t

-- Chap_14.3 Developper une application Java/JDBC pour acceder et
-- manipuler les objets des tables employe_o et dept_o




-- Exercices chapitre 1_12:
-- Chap_1_12: Test des performances entre une application
-- relationnelle et une application objet relationnelle

-- Mise en evidence des performances du relationnel objet
-- Considerons les tables relationnelles r_dept et r_employe decrites
-- dans la section
-- Exercices chapitre 10: les vues. Considerons les tables objets o_dept
-- et o_employe
-- creees plus haut. Afin d’effectuer des tests comparatifs
-- significatifs, il faut creer aumoins 4 departements et 1000 Employes.

-- Selectionner ensuite l'optimiseur statistique
ALTER SESSION SET OPTIMIZER_MODE=ALL_ROWS;

-- Verifier que Oracle calcule bien les statitisques
-- Le paramètre statistics_level doit être mis à TYPICAL par exemple
show parameter statistics_level
/*
statistics_level                     string      TYPICAL
*/
--actualiser les statistiques sur les objets de l'utilisateur
-- proprietaire des tables
--exemple : TPSQL3
EXECUTE DBMS_STATS.GATHER_SCHEMA_STATS('TPSQL3');

-- Afficher les plans et les temps d'execution
set autotrace on

-- rechercher par exemple des informations sur les employes
-- du departement 1000

-- Solution en utilisant les tables objets
select ename, job, e.refdept.dname from employe_o e
where e.refdept.deptno=1000;

-- Solution en utilisant les tables relationnelles
-- besoin de jointure
select ename, job, d.dname from r_employe e, r_dept d
where d.deptno=1000 and e.deptno=d.deptno;

-- comparer les plans





