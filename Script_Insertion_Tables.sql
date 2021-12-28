
declare
    refLoc1        REF LOCATION_T;
    refLoc2        REF LOCATION_T;
    refLoc3        REF LOCATION_T;
    refLoc4       REF LOCATION_T;
    refLoc5        REF LOCATION_T;



	refAgency1	   REF AGENCY_T;
	refAgency2	   REF AGENCY_T;
    refAgency3	   REF AGENCY_T;
	refAgency4	   REF AGENCY_T;
    refAgency5	   REF AGENCY_T;
	
	refEmp1		   REF Employe_t;
	refEmp2		   REF Employe_t;
	refEmp3		   REF Employe_t;
    refEmp4		   REF Employe_t;
	refEmp5		   REF Employe_t;
	refEmp6		   REF Employe_t;
    refEmp7		   REF Employe_t;
	refEmp8		   REF Employe_t;
	refEmp9		   REF Employe_t;
    refEmp10	       REF Employe_t;
	refEmp11		   REF Employe_t;
	refEmp12		   REF Employe_t;
    refEmp13	       REF Employe_t;
	refEmp14		   REF Employe_t;
	refEmp15		   REF Employe_t;
    refEmp16	       REF Employe_t;
	refEmp17		   REF Employe_t;
	refEmp18		   REF Employe_t;
    refEmp19	       REF Employe_t;
	refEmp20		   REF Employe_t;
	refEmp21		   REF Employe_t;
    refEmp22		   REF Employe_t;
	refEmp23		   REF Employe_t;
    refEmp24	       REF Employe_t;
	refEmp25		   REF Employe_t;


begin
	
    insert INTO O_LOCATION ol values(location_t('France','Nice',"Place Mascena",42))
        returning ref(ol) INTO refLoc1;
    insert INTO O_LOCATION ol values(location_t('France','Paris',"rue de la paix",8))
        returning ref(ol) INTO refLoc2;
    insert INTO O_LOCATION ol values(location_t('Italie','Rome',"Place de la pizza",108))
        returning ref(ol) INTO refLoc3;
    insert INTO O_LOCATION ol values(location_t('USA','New-York',"route du pont neuf",9))
        returning ref(ol) INTO refLoc4;
    insert INTO O_LOCATION ol values(location_t('France','bezier',"route de nulle part ",2))
        returning ref(ol) INTO refLoc5;

	insert INTO O_AGENCY oa values(AGENCY_T(1, 'Angence les Pins', refLoc1 , LISTREFEMPLOYES_T()))
		returning ref(oa) INTO refAgency1;
    insert INTO O_AGENCY oa values(AGENCY_T(2, 'Banque des Pins', refLoc2 , LISTREFEMPLOYES_T()))
		returning ref(oa) INTO refAgency2;
    insert INTO O_AGENCY oa values(AGENCY_T(3, 'agenzia pineta', refLoc3 , LISTREFEMPLOYES_T()))
		returning ref(oa) INTO refAgency3;
    insert INTO O_AGENCY oa values(AGENCY_T(4, 'pine forest agency', refLoc4 , LISTREFEMPLOYES_T()))
		returning ref(oa) INTO refAgency4;
    insert INTO O_AGENCY oa values(AGENCY_T(5, 'Agence Le cèdre', refLoc5 , LISTREFEMPLOYES_T()))
		returning ref(oa) INTO refAgency5;
	


	-- Employes de l'agence 1 
	Insert into employe_o oe values (employe_t(
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
	Insert into employe_o oe values (employe_t(
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

	Insert into employe_o oe values (employe_t(
	3,
	'ARAGON',
	TABPRENOMS_T('Louis'),
	'Planton',
	2000,
	Empty_clob(),
	to_date('11-12-1961','DD-MM-YYYY'),
	to_date('11-12-2015','DD-MM-YYYY'),
	refAgency1
	))
	returning ref(oe) INTO refEmp3;
    Insert into employe_o oe values (employe_t(
	4,
	'BALZAC',
	TABPRENOMS_T('Honoré'),
	'Avocat',
	15000,
	Empty_clob(),
	to_date('11-11-1970','DD-MM-YYYY'),
	to_date('11-12-2010','DD-MM-YYYY'),
	refAgency1
	))
	returning ref(oe) INTO refEmp4;

	Insert into employe_o oe values (employe_t(
	5,
	'BARTHES',
	TABPRENOMS_T('Roland'),
	'Ingenieur',
	7000,
	Empty_clob(),
	to_date('11-12-1961','DD-MM-YYYY'),
	to_date('11-12-2006','DD-MM-YYYY'),
	refAgency1
	))
	returning ref(oe) INTO refEmp5;


-- Mise à jour de la liste des pointeurs vers les employes de l'agence 1

	insert into
	TABLE(select oa.listRefEmps from O_AGENCY oa where oa.agencyNo=1) lre
	values(refEmp1);
	insert into
	TABLE(select oa.listRefEmps from O_AGENCY oa where oa.agencyNo=1) lre
	values(refEmp2);
    insert into
	TABLE(select oa.listRefEmps from O_AGENCY oa where oa.agencyNo=1) lre
	values(refEmp3);
    insert into
	TABLE(select oa.listRefEmps from O_AGENCY oa where oa.agencyNo=1) lre
	values(refEmp4);
    insert into
	TABLE(select oa.listRefEmps from O_AGENCY oa where oa.agencyNo=1) lre
	values(refEmp5);
    

    -- Employes de l'agence 2
	Insert into employe_o oe values (employe_t(
	6,
	'BAUDELAIRE',
	TABPRENOMS_T('Charles'),
	'Analyste',
	2700,
	Empty_clob(),
	to_date('11-12-1965','DD-MM-YYYY'),
	to_date('11-12-1990','DD-MM-YYYY'),
	refAgency2
	))
	returning ref(oe) INTO refEmp6;
	Insert into employe_o oe values (employe_t(
	7,
	'BEAUMARCHAIS',
	TABPRENOMS_T('Pierre-Augustin, Caron'),
	'Secretaire',
	1630,
	Empty_clob(),
	to_date('11-11-1970','DD-MM-YYYY'),
	to_date('11-12-2010','DD-MM-YYYY'),
	refAgency2
	))
	returning ref(oe) INTO refEmp7;

	Insert into employe_o oe values (employe_t(
	8,
	'BEAUVOIR',
	TABPRENOMS_T('Simone'),
	'Banquier',
	3000,
	Empty_clob(),
	to_date('11-12-1976','DD-MM-YYYY'),
	to_date('11-12-2013','DD-MM-YYYY'),
	refAgency2
	))
	returning ref(oe) INTO refEmp8;
    Insert into employe_o oe values (employe_t(
	9,
	'CAMUS',
	TABPRENOMS_T('Albert'),
	'Vigile',
	1500,
	Empty_clob(),
	to_date('11-11-1985','DD-MM-YYYY'),
	to_date('11-12-2010','DD-MM-YYYY'),
	refAgency2
	))
	returning ref(oe) INTO refEmp9;

	Insert into employe_o oe values (employe_t(
	10,
	'CELINE',
	TABPRENOMS_T('Louis-Ferdinand'),
	'Ingenieur',
	6000,
	Empty_clob(),
	to_date('11-12-1963','DD-MM-YYYY'),
	to_date('11-12-2005','DD-MM-YYYY'),
	refAgency2
	))
	returning ref(oe) INTO refEmp10;

-- Mise à jour de la liste des pointeurs vers les employes de l'agence 2

	insert into
	TABLE(select oa.listRefEmps from O_AGENCY oa where oa.agencyNo=2) lre
	values(refEmp6);
	insert into
	TABLE(select oa.listRefEmps from O_AGENCY oa where oa.agencyNo=2) lre
	values(refEmp7);
    insert into
	TABLE(select oa.listRefEmps from O_AGENCY oa where oa.agencyNo=2) lre
	values(refEmp8);
    insert into
	TABLE(select oa.listRefEmps from O_AGENCY oa where oa.agencyNo=2) lre
	values(refEmp9);
    insert into
	TABLE(select oa.listRefEmps from O_AGENCY oa where oa.agencyNo=2) lre
	values(refEmp10);

    -- faire les autres agences ...

end;
