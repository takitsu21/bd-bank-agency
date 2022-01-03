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