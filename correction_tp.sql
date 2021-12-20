/*
PLAN
1. Objectif du TP
2. Cration des types objets
3. Cration des tablespaces
4. Cration des tables et organisation stockage
5. Pose d'indexes
6. Insertion des objets
7. Mise  jour des objets
8. Consultation des objets
9. Implmentation et test Procdures stockes
10. Les vues et les OID pour les tables relationnelles
11. Test des performances et l'objet relationnelle
12. Manipulation des objets volumineux
13. Appel des procdures externes C/C++
14. Manipulation des objets d'un BD Objet relationnel en Java
15. Accs aux objets d'un BD Objet relationnel depuis une page WEB
*/
/*
1. Objectif du TP

Manipuler une base de donnes objet relationnelle

Les points que nous visons sont :

concevoir et crer le schma d'une base de donnes objet
relationnelle

consulter les objets du schma en exploitant entre autre
les nouveaux oprateurs tels que TABLE, VALUE, ...

effectuer des insertions, mises  jour et suppressions dans
ce schma en exit

Manipuler des objets dans PL/SQL

Manipuler les vues objets sur les tables rlationnelles

manipuler des objets volumineux

Tester les performances

Appeler des fonctions crites en C, C++, etc.

Manipuler des objets complexes depuis le langage Java


*/
------------------------------------------------------------
-- 2. Cration des types objets

-- Il s'agit ici de crer les types EMPLOYE_T et DEPT_T
-- Ainsi que les types dpendants en fonction des spcifications
-- suivantes :
/*
Nom entit	Nom des champs	type			Libell
EMPLOYE		EMPNO			number(8)		Numro Employ
			ENAME		 	varchar2(15) 	Nom EMPLOYE : En lettre capitales
			PRENOMS			varray			tableau de 4 prnom  max
			JOB				Varchar2(20)	Mtier de lemploy {Ingnieur,
											Secrtaire, Directeur, Planton, PDG}
			SAL				number(7,2)		Salaire entre 1500 et 15000
			CV				CLOB			CV d'un employ
			DATE_NAISS		date			Date de Naissance
			DATE_EMB		date			Date embauche : doit tre suprieure
											Date_Naiss

DEPT		DEPTNO			number(4)		Nr. de dpartement doit
											tre entre 1000 et 9999
			DNAME			varchar2(30) 	Nom du dpartement {Recherche,
											RH, Marketing, Ventes, Finance}
			LOC				varchar2(30)	Localisation du dpartement

NOTE :
	-- EMPNO et DEPTNO sont des champs identifiants
	-- Tous les champs sont obligatoires sauf les champs
	-- CV et PRENOMS
*/
------------------------------------------------------------
-- 2.0 Cration d'un utilisateur qui sera propritaire
-- des objets de l'application
-- Remplacer ORCL par le nom rseau de votre base.
-- et pass par le password de votre compte system
connect System@ORCL/pass

create user tpsql3V2 identified by OracleTpsql3v201;
grant dba to tpsql3V2;
revoke unlimited tablespace FROM tpsql3V2;
alter user tpsql3V2 quota unlimited on users;
alter user tpsql3V2 default tablespace users;


connect tpsql3V2@ORCL/OracleTpsql3v201;
set MYPATH=C:\1agm05092005\1Cours\tporacleSql3
-- 2.1 Suppression des tables avant la suppression des types

-- activation du spool : pour rcuprer la trace
-- d'excution sous sqlplus
-- attention  la fin du script faire "spool off" afin*
-- d'crire dans le fichier
spool &MYPATH\SpoolcorrectionTpsql3.sql

set linesize 200

-- Suppression de tables si elles existent
drop table R_EMPLOYE cascade  constraints
/
drop table r_dept cascade  constraints
/
drop table o_dept cascade  constraints
/

drop table o_employe cascade constraints
/
-- 2.2 Suppression des types qui utilisent d'autres types
-- avant la suppression des types autonomes.
-- En cas de suppression d'un type qui dpend d'un
-- autre, le mot cl FORCE est  utiliser.
drop type dept_t force
/
drop type employe_t force
/

drop type tabPrenoms_t
/

drop type LISTREFEMPLOYES_T
/
drop type setEmployes_t
/


-- 2.3 Cration des types.
/*
note :Le type dept_t doit tre dclar en forward

a. Les mthodes de consultation

Dfinir une mthode de classe qui renvoie des informations
(, ...) sur un DEPT connaissant son numro. Procder
laffichage des ces informations
static function getDept (deptno1 IN number) return dept_t;

Dfinir une mthode de classe qui renvoie la collection
demployes dun DEPT donn. Afficher ensuite le nom
et le pronom de chaque employ. La collection
setEmployes_t est  dfinir
Static function getInfoEmp(deptno1 IN number) return
setEmployes_t

b. Les mthodes pour ordonner les lments des types

crire pour chaque type une mthode ORDER ou MAP. Il est
ncessaire d'utiliser au moins une fois chacune de ces
mthodes.

b. Les mthodes de gestion des Liens

Introduire pour chaque Lien Multivalu les procdures suivantes :
	- addLinkListeEmployes(RefEmp1 REF Employe_t);
		-- pour ajouter dans la liste
	- deleteLinkListeEmployes (RefEmp1 REF Employe_t);	-- suppression dans un lien
	- updateLinkListeEmployes (RefEmp1 REF Employe_t, 	RefEmp2 REF Employe_t);
		-- modification du lien
c. Notes
ces mthodes DOIVENT tre en Lecture seule(WNDS) (PRAGMA RESTRICT_REFERENCES) sauf celles dcrites en 3.
dans cette phase, aucune mthode n'a encore t 	implmente. Il ne s'agit que des dclarations.

*/
create or replace type DEPT_T
/

-- tableau des prnoms
create or replace type tabPrenoms_t as varray (4) of varchar2(30)
/

-- Le type employ complet avec ses mthodes
CREATE OR REPLACE TYPE EMPLOYE_T AS OBJECT(
	EMPNO       number(8),
	ENAME       varchar2(15),
	PRENOMS     tabPrenoms_t,
	JOB		    Varchar2(20),
	SAL	        number(7,2),
	CV		    CLOB,
	DATE_NAISS  date,
	DATE_EMB    date,
	refDept	    REF dept_t,
	order member function compEmp(emp IN employe_t) return number
);
/
-- collection des rfrences vers les employs
create or replace type ListRefEmployes_t as table of REF employe_t
/

-- Collection des instances d'employs
create or replace type setEmployes_t as table of employe_t
/

-- Le type Dept_t complet avec ses mthodes
create or replace type DEPT_T AS OBJECT(
	DEPTNO		     number(4),
	DNAME		    varchar2(30),
	LOC			    varchar2(30),
	listRefEmp    ListRefEmployes_t,
	member function getDept return dept_t,
	member function  getInfoEmp return setEmployes_t,
	static function getDept (deptno1 IN number, nomTable IN varchar2 ) return dept_t,
	static function getInfoEmp(deptno1 IN number, nomTable IN varchar2 ) return setEmployes_t,
	map  member  function  compDept return varchar2,
	member procedure addLinkListeEmployes(RefEmp1 REF Employe_t, nomTable IN varchar2),
	member procedure deleteLinkListeEmployes (RefEmp1 REF Employe_t, nomTable IN varchar2 ),
	member procedure updateLinkListeEmployes (RefEmp1 REF Employe_t, 	RefEmp2 REF Employe_t, nomTable IN varchar2)
);
/


------------------------------------------------------
-- 3. Cration des tablespaces
-- Ces tablespaces permettrant de mieux organiser les donnes
-- Remplacer orcl par le nom de votre base
-------------------------------------------------------
drop tablespace ts_table_res cascade constraint;
drop tablespace ts_index_res cascade constraint;
drop tablespace ts_lob_res cascade constraint;

create tablespace ts_table_res
datafile '%ORACLE_BASE%\oradata\orcl\tsobj\ts_table_res_1.dbf' size 10M;

create tablespace ts_index_res
datafile '%ORACLE_BASE%\oradata\orcl\tsobj\ts_index_res_1.dbf' size 10M;

create tablespace ts_lob_res
datafile '%ORACLE_BASE%\oradata\orcl\tsobj\ts_lob_res_1.dbf' size 10M;

-- affectation des droits sur les tablespaces
alter user tpsql3
quota unlimited on ts_table_res
quota unlimited on ts_index_res
quota unlimited on ts_lob_res
/

/*
4. Cration des tables et organisation stockage

Crer les tables EMPLOYE_O, DEPT_O comme tant des tables objets

Les contraintes d'intgrits

Dfinir les contraintes d'intgrits d'entits sur chacune des
 tables

Dfinir les contraintes d'intgrits de domaine
(cf. la description des champs page 264 et page 265)

Les Nested Tables
Donner les noms de segments  toutes vos Nested Tables
Format du nom : storeNomColNested

Les LOB internes PCTVERSION doit tre  30

Localisation des objets

Les tuples des tables objets sont  localiser dans
le Tablespace TS_TABLE_RES

les index des tables objets y compris ceux crs implicitement
sont  localiser dans TS_INDEX_RES

les donnes et les index des LOB internes sont  localiser
dans le Tablespace TS_LOB_RES


*/

-- cration des tables O_DEPT et O_EMPLOYE
-- Table O_DEPT
create table O_DEPT of dept_t(
constraint pk_o_dept_deptno primary key (deptno),
constraint chk_o_dept_deptno check(deptno between 1000 and 9999),
constraint chk_o_dept_dname check(dname IN
	('Recherche', 'RH', 'Marketing', 'Ventes', 'Finance')),
constraint nnl_o_dept_dname dname not null
)
NESTED TABLE LISTREFEMP STORE AS table_LISTREFEMP;



-- Table O_EMPLOYE
drop table O_EMPLOYE;
create table O_EMPLOYE of employe_t(
     	Constraint pk_O_EMPLOYE_empno primary key(empno),
		constraint chk_o_employe_ename check(ename=upper(ename)),
		constraint nnl_o_employe_ename ename not null,
		constraint chk_o_employe_job
			check(job IN ('Ingnieur', 'Secrtaire', 'Directeur', 'Planton', 'PDG') ),
		constraint nnl_o_employe_job job not null,
		constraint chk_o_employe_sal check(sal between 1500 and 15000),
		constraint nnl_o_employe_sal sal not null,
		constraint chk_o_employe_dnaiss_demb check(date_emb>date_naiss),
		constraint nnl_o_employe_date_emb date_emb not null,
		constraint nnl_o_employe_date_naiss date_naiss not null
)
LOB(CV) store as table_LobCV (PCTVERSION 30);



-- Afin de pour crer un index sur la colonne refDept
-- Il faut utiliser clause SCOPE FOR
-- Qui indique que les REF qui seront affects  RefDept
-- Viennent forcement de la table Dept_o
-- Sorte de Foreign Key
ALTER TABLE o_employe
	ADD (SCOPE FOR (refDept) IS o_dept);
ALTER TABLE table_listrefemp
	ADD (SCOPE FOR (column_value) IS o_employe);
--------------------------------------------
-- 5. Pose d'indexes

--Crer un index unique sur la colonne dname de DEPT_o
--crer un index sur la colonne implicite Nested_table_id de la Nested Table. Peut - il tre unique ?
--Crer un index sur la rfrence vers un dpartement dans la table employe_o

--------------------------------------
--Crer un index unique sur la colonne dname de DEPT_o
drop index idx_unique_dname;

CREATE UNIQUE INDEX idx_unique_dname ON o_dept(dname)
tablespace ts_index_res;

-- crer un index sur la colonne implicite Nested_table_id
-- de la Nested Table. Peut - il tre unique ?
drop index idx_listRefEmp_nested_table_id;
CREATE INDEX idx_listRefEmp_nested_table_id ON table_listrefemp(NESTED_TABLE_ID)
TABLESPACE ts_index_res;

ERREUR  la ligne 1 :
ORA-01408: cette liste de colonnes est dj indexe

-- Crer un index unique concaten avec les colonnes Nested_table_id
-- et Column_value afin dviter lajout deux fois de la rfrence
-- dun employ dans la liste des rfrences des employs dun
-- dpartement
drop index idx_employe_nested_table_id;

CREATE UNIQUE INDEX idx_employe_nested_table_id ON
 table_listrefemp (nested_table_id, column_value)
 TABLESPACE ts_index_res;
ERREUR  la ligne 1 :
ORA-02327: impossible de crer un index sur une expression de type REF

ALTER TABLE table_listrefemp
	ADD (SCOPE FOR (column_value) IS o_employe);

CREATE UNIQUE INDEX idx_employe_nested_table_id ON
 table_listrefemp (nested_table_id, column_value)
 TABLESPACE ts_index_res;

-- Crer un index sur la rfrence vers un dpartement
-- dans la table employe_o
drop index idx_o_employe_refDept;
CREATE INDEX idx_o_employe_refDept on o_employe(refDept)
TABLESPACE ts_index_res;
ERREUR  la ligne 1 :
ORA-02327: impossible de crer un index sur une expression de type REF

ALTER TABLE o_employe
	ADD (SCOPE FOR (refDept) IS o_dept);



CREATE INDEX idx_o_employe_refDept on o_employe(refDept)
TABLESPACE ts_index_res;
Index cr.

-- 6. Insertion des objets
-- Insrer 2 ou 3 objets dans chacune des tables cres
-- prcdemment. L'intgrit des objets doit tre assure
-- 'RH', 'Marketing'
declare
refdept1 REF dept_t;
refdept2 REF dept_t;

refEmp1 REF Employe_t;
refEmp2 REF Employe_t;
refEmp3 REF Employe_t;

begin
-- insertion des dpartements 1000 et 1001 avec listes de rferences vers les employs vides
INSERT INTO o_dept od VALUES (
	dept_t( 1000,	'RH',	'Antananarivo', ListRefEmployes_t()))
	returning ref(od) into refdept1;
INSERT INTO o_dept od VALUES (
	dept_t( 1001,	'Marketing',	'Antananarivo', ListRefEmployes_t()))
	returning ref(od) into refdept2;

-- insertion des employes
INSERT INTO o_employe oe VALUES (
	employe_t(1,'RAKOTO', tabPrenoms_t('Jean'),'PDG',
				15000, empty_clob(),'25/12/1973','10/08/2018',refDept1))
	returning ref(oe) into refEmp1;
INSERT INTO o_employe oe VALUES (
	employe_t(2,'RABE', tabPrenoms_t('Marie', 'Jeanne', 'Clestine'),'Secrtaire',
				2500, 'Le CV de RABE','01/01/1982','10/01/2019',refDept1))
	returning ref(oe) into refEmp2;
INSERT INTO o_employe oe VALUES (
	employe_t(3,'RAKOTO', tabPrenoms_t('Christophe'),'Ingnieur',
				7500, null,'12/10/1984','17/12/2018',refDept2))
	returning ref(oe) into refEmp3;

-- mise  des listes
-- mise  jour de la liste des employs du dept 1000
INSERT INTO
	TABLE(SELECT d.listRefEmp FROM o_dept d WHERE d.deptno = 1000)
	values (refEmp1);
INSERT INTO
	TABLE(SELECT d.listRefEmp FROM o_dept d WHERE d.deptno = 1000)
	values (refEmp2);
-- mise  jour de la liste des employs du dept 1001
INSERT INTO
	TABLE(SELECT d.listRefEmp FROM o_dept d WHERE d.deptno = 1001)
	values (refEmp3);

end;
/
commit;


select oe.ename, oe.sal, oe.refdept.dname, tprenoms.column_value
from o_employe oe, table(oe.prenoms) tprenoms order by oe.refdept.dname



commit;
--- gabriel.mopolo@gmail.com

-- 7. Mise  jour des objets

-- Modifier la localit d'un dpartement connaissant son nom

-- Modifier la date d'embauche d'un Employ connaissant
-- son nom sachant quil doit travailler dans lun des
-- dpartements suivants : Recherche, Finance ou  RH

-- Supprimer un DEPT et mettre la rfrence vers le dpartement
--  null dans la table employe_o

-- Modifier la localit d'un dpartement connaissant son nom
?
UPDATE o_dept  od set od.loc='Tana' where od.dname='RH';
-- vrifier puis rollback
roolback;

-- Modifier la date d'embauche d'un Employ connaissant
-- son nom sachant quil doit travailler dans lun des
-- dpartements suivants : Recherche, Finance ou  RH

?
update o_employe oe
set oe.date_emb='17/12/2017'
where oe.refdept.dname in ('Recherche', 'Finance',  'RH')
and oe.empno=1;
rollback;


-- Supprimer un DEPT et mettre la rfrence vers le dpartement
--  null dans la table employe_o

-- solution 1
select ename, oe.refdept.deptno, oe.refdept.dname from o_employe oe
where oe.refdept.deptno=1000;

/*
ENAME           REFDEPT.DEPTNO REFDEPT.DNAME
--------------- -------------- ------------------------------
RAKOTO                    1000 RH
RABE                      1000 RH
*/
-- Effecuter la MAJ
-- Mettre la rfrence vers les employs du dept 1000  NULL
?
update o_employe oe set oe.refDept=null where oe.refdept.deptno=1000;

-- supprimer le dpt
?
-- Vrifier
delete from o_dept od where od.deptno=1000;

-- Annuler
rollback;

-- solution 2
-- vrification
select ename, oe.refdept.deptno, oe.refdept.dname from employe_o oe
where oe.refdept.deptno=1000;

declare

refDept1 REF dept_t ;

begin
-- Supprimer le dpartement
delete from o_dept od where od.deptno=1000
returning ref(od) into refDept1;

-- puis modifier les employs du dpartement

update o_employe oe set oe.refDept=null where oe.refdept=refDept1;

end;
/

-- vridfication
select ename, oe.refdept.deptno, oe.refdept.dname from employe_o oe
where oe.refdept.deptno=1000;

rollback;

-- vrification
select ename, oe.refdept.deptno, oe.refdept.dname from employe_o oe
where oe.refdept.deptno=1000;


-- Solution 3
select ename, oe.refdept.deptno, oe.refdept.dname from employe_o oe
where oe.refdept.deptno=1000;

set serveroutput on
declare
listRefEmpD1000  ListRefEmployes_t;
begin
-- Supprimer le dpartement
delete from o_dept od where od.deptno=1000
returning od.listRefEmp INTO listRefEmpD1000;


-- parcours la liste des ref des ref des employs de ce dpartement et la mettre  null
for i in listRefEmpD1000.first .. listRefEmpD1000.last
loop
	update o_employe oe
	set oe.refdept=null
	where ref(oe) =listRefEmpD1000(i);
end loop;


EXCEPTION
WHEN OTHERS THEN
	dbms_output.put_line('Erreur grave');
	dbms_output.put_line('sqlcode :'||sqlcode);
	dbms_output.put_line('sqlerrm :'||sqlerrm);

end;
/

select ename, oe.refdept.deptno, oe.refdept.dname from employe_o oe
where oe.refdept.deptno=1000;

rollback;

select ename, oe.refdept.deptno, oe.refdept.dname from employe_o oe
where oe.refdept.deptno=1000;


--8. Consultation des objets
-- Faire un Listing des DEPTs tris par nom

-- Pour un DEPT donn, lister tous les EMPLOYEs qui y travaillent
-------------------------------------------------------------

-- Faire un Listing des DEPTs tris par nom
?

select od.deptno, od.dname
from o_dept od
order by od.dname;

-- Pour un DEPT donn, lister tous les EMPLOYEs qui y
-- travaillent
-- solution  1
select le.column_value.ename, le.column_value.sal,
le.column_value.refDept.dname
FROM TABLE(select  od.listRefEmp from o_dept od where od.deptno=1000) le;

-- solution  2

?
select oe.ename, oe.sal, oe.refDept.dname
from o_employe oe where oe.refDept.deptno=1000;


-- solution  3

?
select  od.dname, le.column_value.ename, le.column_value.sal
from o_dept od, TABLE(od.listRefEmp) le where od.deptno=1000;

select ename, sal, lp.column_value
from o_employe oe , table(oe.prenoms) lp;

set linesize 200
col prenoms format a50
select ename, sal, prenoms
from o_employe oe ;



-- solution  4
?

-- tri des instances d'employe
?
select oe.job, oe.ename, oe.sal, oe.refdept.dname
from o_employe oe
order by value(oe);

ERREUR  la ligne 3 :
ORA-04067: type body "TPSQL3.EMPLOYE_T" n'existe pas - non excut
ORA-06508: PL/SQL : unit de programme nomme : "TPSQL3.EMPLOYE_T" introuvable
ORA-06512:  ligne 1
--'

select oe.job, oe.ename, oe.sal, oe.refdept.dname
from o_employe oe
order by value(oe);

JOB                  ENAME                  SAL REFDEPT.DNAME
-------------------- --------------- ---------- ------------------------------
PDG                  RAKOTO               15000 RH
Ingnieur            RAKOTO                7500 Marketing
Secrtaire           RABE                  2500 RH

select oe.job, oe.ename, oe.sal, oe.refdept.dname
from o_employe oe
order by value(oe) desc;

JOB                  ENAME                  SAL REFDEPT.DNAME
-------------------- --------------- ---------- ------------------------------
Secrtaire           RABE                  2500 RH
Ingnieur            RAKOTO                7500 Marketing
PDG                  RAKOTO               15000 RH


/*
-- echec car oprateur d'ordre nomimplant.

  2  order by value(oe);
ERROR:
ORA-04067: type body "TPSQL3.EMPLOYE_T" n'existe pas - non excut
ORA-06508: PL/SQL : unit de programme nomme : "TPSQL3.EMPLOYE_T" introuvable
ORA-06512:  ligne 1

aucune ligne slectionne
*/

-- 9. Implmentation et test Procdures stockes

-- implmentation des mthodes

-- Implmenter les mthodes dcrites plus haut au niveau des
-- types DEPT_T et EMPLOYE_T
-- tester les mthodes

-- les employs sur class selon l'ordre hirarchique
-- PDG vient avant le Directeur vient avant l'Ingnieur, secrataire
--, Planton
-- job IN ('Ingnieur', 'Secrtaire', 'Directeur', 'Planton', 'PDG')

CREATE OR REPLACE TYPE BODY EMPLOYE_T AS
	order member function compEmp(emp IN employe_t) return number is

position1 NUMBER :=0;
position2 NUMBER :=0;
concEmpValue1 varchar2(30):= self.ename||self.empno;
concEmpValue2 varchar2(30):= emp.ename||emp.empno;

BEGIN
	CASE SELF.job
			WHEN 'PDG' THEN position1 := 1;
			WHEN 'Directeur' THEN position1 := 2;
			WHEN 'Ingnieur' THEN position1 := 3;
			WHEN 'Secrtaire' THEN position1 := 4;
			WHEN 'Planton' THEN position1 := 5;
	END CASE;
	CASE emp.job
			WHEN 'PDG' THEN position2 := 1;
			WHEN 'Directeur' THEN position2 := 2;
			WHEN 'Ingnieur' THEN position2 := 3;
			WHEN 'Secrtaire' THEN position2 := 4;
			WHEN 'Planton' THEN position2 := 5;
	END CASE;
	concEmpValue1:=position1||concEmpValue1;
	concEmpValue2:=position2||concEmpValue2;
	IF concEmpValue1 = concEmpValue2 	THEN return 0;
	ELSIF concEmpValue1 > concEmpValue2 	THEN return 1;
	ELSIF concEmpValue1 < concEmpValue2 	THEN return -1;
	END IF;
END;
end;
/


create or replace type body DEPT_T AS
	member function getDept return dept_t  is
	begin
		return self;
	end;

	member function getInfoEmp return setEmployes_t is
	setEmp setEmployes_t:=setEmployes_t();
	emp1 employe_t;

	begin
		-- ajoute self.listRefEmp.count lement vide dans setEmp
		setEmp.extend(self.listRefEmp.count);
		-- parcours de self.listRefEmp et remplissage de setEmp
		for i in self.listRefEmp.first .. self.listRefEmp.last
		loop

		utl_ref.SELECT_OBJECT (self.listRefEmp(i), emp1);
		setEmp(i):=emp1;

		end loop;

		return setEmp;
		Exception
			WHEN OTHERS THEN
				raise no_data_found;

	end;

	static function getDept (deptno1 IN number, nomTable varchar2) return dept_t  is
		dept1 dept_t:=null;
		myQuery clob:='select value(od) from '||
		nomTable || ' od '|| ' where od.deptno='||deptno1;

	begin
		EXECUTE IMMEDIATE myQuery INTO dept1 ;
		return dept1;
		Exception
			WHEN OTHERS THEN
				raise ;
	end;

	static function getInfoEmp(deptno1 IN number, nomTable varchar2)
	return setEmployes_t is
	setEmp setEmployes_t:=null;
	myQuery clob:='select CAST( COLLECT (deref(le.column_value)) AS setEmployes_t) '
		|| ' FRom TABLE(select od.listRefEmp from '|| nomTable
		|| ' od '|| ' where od.deptno='||deptno1 || ') le';

	begin

		EXECUTE IMMEDIATE myQuery INTO setEmp ;

		return setEmp;
		Exception
			WHEN OTHERS THEN
				raise ;


	end;


	map member function compDept return varchar2 is
	begin
		return dname||deptno;
	end;

	member procedure addLinkListeEmployes(RefEmp1 REF Employe_t, nomTable varchar2) is

	myQuery clob:=' insert into TABLE(select od.listRefEmp from ' || nomTable || ' od '
	|| ' where od.deptno=:BindSelfDeptno) le '|| ' values( :bindRefEmp1)';

	begin
		EXECUTE IMMEDIATE myQuery using self.deptno, refEmp1;

		EXCEPTION
			when OTHERS then
				raise ;

	end;

	member procedure deleteLinkListeEmployes (RefEmp1 REF Employe_t, nomTable varchar2) is
	myQuery clob:='delete FROM TABLE(select od.listRefEmp from '
	|| nomTable || ' od '
	|| ' where od.deptno=:BindSelfDeptno) le '
	|| ' where le.column_value='||':bindRefEmp1';

	begin

		EXECUTE IMMEDIATE myQuery using self.deptno,  refEmp1;
		EXCEPTION
			when OTHERS then
				raise ;

	end;

	member procedure updateLinkListeEmployes (RefEmp1 REF Employe_t,
	RefEmp2 REF Employe_t, nomTable varchar2) is
	myQuery clob:='UPDATE TABLE(select od.listRefEmp from  '
	|| nomTable || ' od '
	|| ' where od.deptno=:BindSelfDeptno) le '
	|| ' set le.column_value='||':bindRefEmp2'
	|| ' where le.column_value='||':bindRefEmp1';

	begin
		EXECUTE IMMEDIATE myQuery using self.deptno, refEmp2, refEmp1;
		EXCEPTION
			when OTHERS then
				raise ;

	end;
end;
/

-- Test de la fonction getDept sans paramtre.
-- member function getDept return dept_t,
set serveroutput on
declare
dept1 dept_t;
dept2 dept_t;
begin
	select value(od) into dept1 from o_dept od where deptno=1000;
	dept2:= dept1.getDept;
	dbms_output.put_line('dept1.dname='||dept1.dname);
	dbms_output.put_line('dept2.dname='||dept2.dname);
	EXCEPTION
		WHEN OTHERS THEN
				dbms_output.put_line('sqlcode='||sqlcode);
				dbms_output.put_line('sqlerrm='||sqlerrm);

end;
/


-- Test de la fonction getInfoEmp sans paramtre.
-- member function  getInfoEmp return setEmployes_t,

declare
dept1 dept_t;
setEmp setEmployes_t;
begin
	select value(od) into dept1 from o_dept od where deptno=1000;
	setEmp:= dept1.getInfoEmp;
	for i in setEmp.first .. setEmp.last
	loop
		dbms_output.put_line('setEmp('||i||')='||setEmp(i).ename);
	end loop;
	EXCEPTION
		WHEN OTHERS THEN
				dbms_output.put_line('sqlcode='||sqlcode);
				dbms_output.put_line('sqlerrm='||sqlerrm);

end;
/



-- Test de la fonction getDept avec paramtre.
--static function getDept (deptno1 IN number,
--nomTable IN varchar2 ) return dept_t,

declare
dept1 dept_t;
deptno1 number(8):=1000;
nomTable Varchar2(40):= 'O_DEPT'; -- 'O_DEPT2'
begin
	dept1:= dept_t.getDept(deptno1, nomTable);
	dbms_output.put_line('dept1.dname='||dept1.dname);

	EXCEPTION
		WHEN OTHERS THEN
				dbms_output.put_line('sqlcode='||sqlcode);
				dbms_output.put_line('sqlerrm='||sqlerrm);

end;
/

-- Test de la fonction getInfoEmp avec paramtre.
-- static function getInfoEmp(deptno1 IN number, nomTable IN varchar2 )
-- return setEmployes_t,


declare

setEmp setEmployes_t;
deptno1 number(8):=1000;
nomTable Varchar2(40):= 'O_DEPT';
begin
	setEmp:= dept_t.getInfoEmp(deptno1, nomTable);
	for i in setEmp.first .. setEmp.last
	loop
		dbms_output.put_line('setEmp('||i||')='||setEmp(i).ename);
	end loop;
	EXCEPTION
		WHEN OTHERS THEN
				dbms_output.put_line('sqlcode='||sqlcode);
				dbms_output.put_line('sqlerrm='||sqlerrm);

end;
/

-- Test de la fonction compDept avec paramtre.
-- map  member  function  compDept return varchar2,
select job, empno, ename, sal from o_employe oe order by value(oe);
select job, empno, ename, sal from o_employe oe order by value(oe) desc;

-- Test de la fonction addLinkListeEmployes
-- member procedure addLinkListeEmployes(RefEmp1 REF Employe_t,
-- nomTable IN varchar2),
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

--- ajouter un employer dans le dpartement 1000
dept1000 dept_t;
refdept1000 REF dept_t;

refEmp4 REF employe_t;
nomTable Varchar2(40):= 'O_DEPT';
begin

	select value(od), ref(od) into dept1000, refdept1000
	from o_dept od where od.deptno=1000;

	emp4.refdept:=refdept1000;

	insert into o_employe oe
	values(emp4) returning ref(oe) into refemp4;

	dept1000.ADDLINKLISTEEMPLOYES(refemp4, nomTable);

	EXCEPTION
		WHEN OTHERS THEN
				dbms_output.put_line('sqlcode='||sqlcode);
				dbms_output.put_line('sqlerrm='||sqlerrm);


end;
/

-- vrification
select dname, loc from o_dept order by dname;

select oe.refdept.dname, oe.ename, oe.sal
from o_employe oe order by oe.refdept.dname;
REFDEPT.DNAME                  ENAME                  SAL
------------------------------ --------------- ----------
Marketing                      RAKOTO                7500
RH                             RAKOTO               15000
RH                             TINTIN               15000
RH                             RABE                  2500


-- Test de la fonction deleteLinkListeEmployes avec paramtre.
-- member procedure deleteLinkListeEmployes (RefEmp1 REF Employe_t,
-- nomTable IN varchar2 ),
set serveroutput on
declare

--- dtacher un employ du dpartement 1000
dept1000 dept_t;
refEmp1 REF employe_t;
nomTable Varchar2(40):= 'O_DEPT';
begin

	select value(od) into dept1000
	from o_dept od where od.deptno=1000;

	update o_employe oe set oe.refDept=null
	where oe.refDept.deptno=1000 and oe.empno=1 returning ref(oe) into refEmp1;

	dept1000.deleteLINKLISTEEMPLOYES(refEmp1, nomTable);

	EXCEPTION
		WHEN OTHERS THEN
				dbms_output.put_line('sqlcode='||sqlcode);
				dbms_output.put_line('sqlerrm='||sqlerrm);


end;
/

-- vrification
-- vrification
select dname, loc, le.column_value.empno
 from o_dept od, table(od.listRefEmp) le order by dname;
DNAME                          LOC                            COLUMN_VALUE.EMPNO
------------------------------ ------------------------------ ------------------
Marketing                      Antananarivo                                    3
RH                             Antananarivo                                    2
RH                             Antananarivo                                    4

select oe.refdept, oe.ename, oe.sal
from o_employe oe where oe.empno=1;

-- annulation

rollback;

select dname, loc, le.column_value.empno
 from o_dept od, table(od.listRefEmp) le order by dname;

DNAME                          LOC                            COLUMN_VALUE.EMPNO
------------------------------ ------------------------------ ------------------
Marketing                      Antananarivo                                    3
RH                             Antananarivo                                    4
RH                             Antananarivo                                    1
RH                             Antananarivo                                    2

select oe.refdept, oe.ename, oe.sal
from o_employe oe where oe.empno=1;

REFDEPT
--------------------------------------------------------------------------------
ENAME                  SAL
--------------- ----------
00002202087F2197AB9B402A00E053FA57C40A37EB7F2197AB9B3E2A00E053FA57C40A37EB
RAKOTO               15000

-- Test de la fonction updateLinkListeEmployes avec paramtre.
-- member procedure updateLinkListeEmployes (RefEmp1 REF Employe_t,
-- RefEmp2 REF Employe_t, nomTable IN varchar2)



-- 10. Les vues et les OID pour les tables relationnelles

-- Les vues
--- crer une table relationnelle r_dept et r_employe comme suit :
-- cration des tables relationnelles
CREATE TABLE R_DEPT(
DEPTNO number(4) constraint pk_r_dept_deptno primary key,
DNAME varchar2(30)constraint chk_r_dept_dname check(dname in
		('Recherche','RH', 'Marketing','Ventes', 'Finance')),
LOC varchar2(30),
constraint chk_r_dept_deptno check(deptno between 1000 and 9999)
)
/
CREATE TABLE R_EMPLOYE(
EMPNO number(8) constraint pk_r_employe_empno primary key,
ENAME varchar2(15)constraint chk_r_employe_ename check (ename =upper(ename)),
JOB	  Varchar2(20) constraint chk_r_employe_job check
		(job IN ('Ingnieur','Secrtaire', 'Directeur', 'PDG', 'Planton')),
SAL	  number(7,2),
CV	  CLOB,
DATE_NAISS  date,
DATE_EMB    date,
deptno  number(4) constraint fk_r_emp_r_dept references r_dept(deptno),
constraint chk_r_emp_date_e_date_n check (date_emb>date_naiss)
)
/


-- Insrer 2 dpartements et 3 employs

insert into r_dept
select deptno, dname, loc
from dept_o;

commit;
insert into r_employe
select
EMPNO, ENAME, JOB, SAL, CV, DATE_NAISS, DATE_EMB, oe.refdept.DEPTNO
from employe_o oe;

commit;


-- En vue de la cration de vues objets, crer les types
-- suivants:
DROP TYPE EMPLOYE2_T FORCE
/
DROP TYPE DEPT2_T FORCE
/
DROP TYPE tabPrenoms2_t
/
drop TYPE listRefEmployes2_t
/
CREATE OR REPLACE TYPE EMPLOYE2_T
/
CREATE OR REPLACE TYPE tabPrenoms2_t AS VARRAY(4) OF varchar2(20)
/
create or replace type listRefEmployes2_t as table of ref employe2_t
/
CREATE OR REPLACE TYPE DEPT2_T AS OBJECT(
DEPTNO	 number(4),
DNAME	 varchar2(30),
LOC	     varchar2(30),
listRefEmp listRefEmployes2_t
)
/


-- Les vues
-- En vue de la cration de vues objets, crer les types suivants:
-- Type employe2_t
CREATE OR REPLACE TYPE EMPLOYE2_T AS OBJECT(
EMPNO	    number(8),
ENAME	    varchar2(15),
JOB		    Varchar2(20),
SAL		    number(7,2),
CV		    CLOB,
DATE_NAISS  date,
DATE_EMB    date,
deptno	    number(4),
refDept     REF dept2_t
)
/
-- Crer les vues objets v_employe2 et v_dept2 mappant
-- les tables relationnelles grces aux 2 types prcdemment
-- crs
----------------------------------------------------------------
-- cration des vues v_dept2 et v_employe2
-- Ces 2 vues ont des rfrences circulaires. Trois tapes
-- pour les crer :
-- 1. Crer la vue v_employe2 avec rfrence NULL.
--    Pas de rfrence  la vue v_dept2
-- 2. Crer la vue v_dept2 avec rfrence  v_employe2
-- 3. Recrer la vue v_employe2 avec rfrence  v_dept2

CREATE OR REPLACE  VIEW v_employe2 OF employe2_t
WITH OBJECT IDENTIFIER(empno) AS
SELECT rv.empno, rv.ename, rv.job, rv.sal,
rv.cv, rv.DATE_NAISS, rv.date_emb, rv.deptno, null
FROM r_employe rv;



--Les vues


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



--- Consulter  travers ses vues. Utiliser les liens

select * from v_dept2;

select * from v_employe2;

select ve.ename, ve.sal, ve.refdept.dname
from v_employe2 ve;



-- Insrer un dpartement et un employ  travers les vues. Vrifier quils sauto-rfrencent
insert into v_dept2 (deptno, dname, loc)
values (1003, 'Marketing', 'Lyon');

insert into v_employe2(
 EMPNO, ENAME, JOB, SAL, CV, DATE_NAISS, DATE_EMB, DEPTNO)
values (5, 'JOHNES', 'Directeur', 1700, empty_clob(),
to_date('11-11-1963','DD-MM-YYYY'), to_date('11-11-1993','DD-MM-YYYY'), 1003);

-- vrification
select ve.ename, ve.sal, ve.refdept.dname
from v_employe2 ve;




-- Crer un trigger INSTEAD OF permettant dinsrer un
-- dpartement dans les tables r_dept et o_dept
create or replace trigger tr_insert_dept
INSTEAD OF INSERT ON v_dept2
declare

begin
insert into r_dept values(:new.deptno, :new.dname, :new.loc);
insert into dept_o values(:new.deptno, :new.dname, :new.loc, LISTREFEMPLOYES_T());

end;
/


insert into v_dept2 (deptno, dname, loc)
values (1004, 'Finance', 'Lyon');

select deptno, dname from r_dept;

select deptno, dname from dept_o;


-- 11. Manipulation des objets volumineux

-- 1. Cration du rpertoire sous L'OS
-- mkdir 'C:\app\mondi\oradata\orcl\BFILES\';

-- Copier les fichiers contenant les Cv dans ce rpertoire :
-- exemple cv1KING.txt, cv2BLECK.txt, cv3ZEMBLA.txt,
-- cv4TINTIN.txt

-- 3. Crer la table contenant le BFILE
drop table empCVFiles;

create table empCVFiles(
	empno	 number (4) references employe_o,
	ename	 varchar2(15),
	cvFile	 bfile
);

-- 4. Crer un objet DIRECTORY (adapter le chemin  votre PC

CREATE OR REPLACE DIRECTORY bfile_dir
	AS 'C:\app\mondi\oradata\orcl\LobFiles\';
--' ;


--5. Insertion des bfiles

---
delete from empCVFiles;
--
INSERT INTO empCVFiles
	VALUES(1, 'KING', BFILENAME('BFILE_DIR', 'cv1KING.txt'));
INSERT INTO empCVFiles
VALUES(2, 'BLECK', BFILENAME('BFILE_DIR', 'cv2BLECK.txt'));
INSERT INTO empCVFiles
	VALUES(3, 'ZEMBLA', BFILENAME('BFILE_DIR', 'cv3ZEMBLA.txt'));
INSERT INTO empCVFiles
	VALUES(4, 'TINTIN', BFILENAME('BFILE_DIR', 'cv4TINTIN.txt'));


-- Adapter le code ci-dessus pour charger un CV pour un employ donn dans la colonne CV de la table o_employe
-- Copier les cv dans la colonne CV de la table employe_o
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
from employe_o e
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

-- vrification
-- Nom et CV de l'employ Nr 4
select ename, cv
from employe_o
where empno=4;


-- vrification
-- Nom et CV des employs
select ename, cv
from employe_o
order by ename;











-- 12. Test des performances et l'objet relationnelle

-- Mise en vidence des performances du relationnel objet
-- Considrons les tables relationnelles r_dept et r_employe dcrites dans la section  sur les vues
-- Considrons les tables objets o_dept et o_employe cres plus haut

-- Slectionner l'optimiser statistique
ALTER SESSION SET OPTIMIZER_MODE=ALL_ROWS;

-- Vrifier que Oracle calcule bien les statitisques
-- Le paramtre statistics_level doit tre mis  TYPICAL
-- par exemple
show parameter statistics_level

/*
statistics_level                     string      TYPICAL
*/
--actualiser les statistiques sur les objets de l'utilisateur TPSQL3
EXECUTE DBMS_STATS.GATHER_SCHEMA_STATS('TPSQL3');

-- tracer les plans et les temps d'excution
set autotrace on

-- rechercher par exemple des informations sur les employes
-- du dpartement 1000

-- Solution en utilisant les tables objets
select ename, job, e.refdept.dname from employe_o e
where e.refdept.deptno=1000;

-- Solution en utilisant les tables relationnelles
-- besoin de jointure
select ename, job, d.dname from r_employe e, r_dept d
where d.deptno=1000 and e.deptno=d.deptno;

-- comparer les plans
--jointure classique cot 4
--Accs via l'objet cot 2
--

-- 13. Appel des procdures externes C/C++

-- Mise en uvre des procdures externes tape par tape
-- Etape 0 : Construction d'une DLL
-- Etape 1 : Fixer les variables  denvironnements
-- Etape 2 : Identifier la DLL contenant la procdure externe
-- Etape 3 : Publier la procedure externe
-- Etape 4 : Utiliser la procedure externe

-- Etape 0 : Construire une DLL contenant une fonction factoriel.
-- Pour cela il faut tlcharger et installer le compilateur
-- C/C++ DeV-CPP

-- Crer un projet visant la fabrication dune DLL en langage C.
-- puis cliquer sur OK

-- Deux fichiers dll.h et dllmain.c seront crs. Complter
-- ces fichiers avec les lignes en gras ensuite effectuer
-- les tapes 1  4 du chapitre 12 sur les fonctions
-- externes pour lutiliser depuis Oracle


Procdure externes

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


-- Etape 1 : Fixer les variables  denvironnements

Ladministrateur doit configurer la base pour excuter
les procdures externes crites en C.
configurer lagent extproc dans les fichiers listener.ora
 et tnsnames.ora
dmarrer le listener un listener EXCLUSIVEMENT pour les *
procdures externes
Le listener doit prciser les variables denvironnement
tels que:
ORACLE_HOME, ORACLE_SID, LD_LIBRARY_PATH
Attention : il faut substituer les chemins en dur par les votres

--Dans TNSNAMES.ORA
EXTPROC_CONNECTION_DATA =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SID = PLSExtProc)
    )
  )

-- DANS LISTENER.ORA
   (SID_DESC =
      (SID_NAME = PLSExtProc)
      (ORACLE_HOME = C:\oracle\product\10.2.0\db_1)
      (PROGRAM = extproc)
      (ENVS=
	"EXTPROC_DLLS=ONLY: 'D:\gm05092005\Cours\oracleSql3\2009_2010\callBack\TestCallExternalC\TestCallExternalC.dll "
      )
    )
--version C++
'D:\gm05092005\Cours\oracleSql3\2009_2010\callBack\TestCallExternalCPP\TestCallExternalCPP.dll';

NOTA : Il faut ensuite arrte et redmarrer le listener


-- Etape 2 : Identifier la DLL contenant la procdure externe
Crer un objet library
   -- Avec une dll C
CREATE OR REPLACE LIBRARY  TestCallExternalC
IS 'D:\gm05092005\Cours\oracleSql3\2009_2010\callBack\TestCallExternalC\TestCallExternalC.dll';

-- Avec une dll C++
CREATE OR REPLACE LIBRARY  TestCallExternalC
IS 'D:\gm05092005\Cours\oracleSql3\2009_2010\callBack\TestCallExternalCPP\TestCallExternalCPP.dll';
-- Nota : Il est utile de donner le chemin complet vers la
-- librairie

-- Etape 3 : Publier la procedure externe

La procdure doit tre publie  travers une procdure PL/SQL qui indique le langage dimplmentation et la signature C
int c_calcFactorial (int n)

CREATE OR REPLACE FUNCTION plsql_c_calcFactorial (n BINARY_INTEGER)
return BINARY_INTEGER
AS LANGUAGE C
NAME "c_calcFactorial"
LIBRARY TestCallExternalC;
/

-- Etape 4 : Utiliser la procedure externe

Sqlplus tpsql3/tpsql3@orcl

Set serveroutput on

Declare
Fact 	number:=0;
i		number:=5;
Begin
	Fact:= plsql_c_calcFactorial(i);
	Dbms_output.put_line('Factoriel de '|| I || '= '|| fact);
End;
/
-- Factoriel de 5= 120
-- Procdure PL/SQL termine avec succs.

-- dsactivation du spool
spool off;






-- 14. Manipulation des objets d'un BD Objet relationnel en Java

voir le code java dans le dossier
..\3CorrectionTPSQL3\2TPSql3Java

--J'ai utilis netbean pour construire l'application

-- 15. Accs aux objets d'un BD Objet relationnel depuis une
-- page WEB
A faire


































