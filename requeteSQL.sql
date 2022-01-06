-- - requète de mise a jour:
--     - 2 impliquant 1 table
--     - 2 impliquant 2 tables
--     - 2 impliquant >2 tables

-- - requète de supression:
--     - 2 impliquant 1 table
--     - 2 impliquant 2 tables
--     - 2 impliquant >2 tables

-- -requète de consultation:
--     - 5 impliquant 1 tables (1 avec group by, 1 avec order by)
--     - 5 impliquant 2 tables avec jointure interne ( 1 externe, 1 group by, 1 tri)
--     - 5 impliquant >2 tables avec jointire interne ( 1 externe, 1 group by, 1 tri)


set serverout on

declare 

locationPaix location_t;
agency agency_t;
emp employe_t;
client1 client_t;
account1 account_t;
transactionTest TRANSACTION_T;
loc location_t;

refOe ref EMPLOYE_T;


begin

select value(lo) into locationPaix from
o_location lo where lo.country='France' and lo.city='Paris';

select value(ag) into agency from
o_agency ag where ag.agencyNo=1;

select value(ag) into agency4 from
o_agency ag where ag.agencyNo=4;

select value(em) into emp from
o_employe em where em.empNo=1;

select value(cl) into client1 from
o_client cl where cl.numCli=1;


select value(ac) into account1 from
o_account ac where ac.accountNo=1;

select value(tran) into transactionTest from
O_TRANSACTION tran where tran.TNUM=2;

select value(lo) into loc from 
o_location lo where lo.country='France' and lo.city='Paris' and lo.streetName='Rue de la paix' and lo.streetNo=8;


DBMS_OUTPUT.PUT_LINE(locationPaix.getCountry);

loc.updateCountry('a', loc);
DBMS_OUTPUT.PUT_LINE(agency.getAgencyNo);
DBMS_OUTPUT.PUT_LINE(agency.getAName);

DBMS_OUTPUT.PUT_LINE(emp.getEmpNo);
DBMS_OUTPUT.PUT_LINE(emp.getEName);

DBMS_OUTPUT.PUT_LINE(emp.getJob);
DBMS_OUTPUT.PUT_LINE(emp.getSal);
DBMS_OUTPUT.PUT_LINE(emp.getCV);
DBMS_OUTPUT.PUT_LINE(emp.getBirthDate);
DBMS_OUTPUT.PUT_LINE(emp.getEmployementDate);

DBMS_OUTPUT.PUT_LINE(client1.getCName);

DBMS_OUTPUT.PUT_LINE(client1.getCName);
DBMS_OUTPUT.PUT_LINE(client1.getJob);
DBMS_OUTPUT.PUT_LINE(client1.getSal);
DBMS_OUTPUT.PUT_LINE(client1.getProject);
DBMS_OUTPUT.PUT_LINE(client1.getBirthDate);

DBMS_OUTPUT.PUT_LINE(account1.getAccountNo);
DBMS_OUTPUT.PUT_LINE(account1.getAccountType);
DBMS_OUTPUT.PUT_LINE(account1.getBalance);
DBMS_OUTPUT.PUT_LINE(account1.getBankCeiling);

DBMS_OUTPUT.PUT_LINE(transactionTest.getTNum);
DBMS_OUTPUT.PUT_LINE(transactionTest.getAmount);

-- SUPPRESSION 2 tables impliquées

update o_employe oe set oe.refAgency=null
where oe.refAgency.agencyNo=1 and oe.empNo=1 returning ref(oe) into refOe;

agency.deleteLinkListEmploye(refOe);

update o_employe oe set oe.refAgency=null
where oe.refAgency.agencyNo=4 and oe.empNo=8 returning ref(oe) into refOe;

agency4.deleteLinkListEmploye(refOe);


end;
/

-- requete d'ajout d'employe
DECLARE 

refOe ref EMPLOYE_T;
agency agency_t;
refAgency ref agency_t;
emp employe_t := employe_t(
	25,
	'DEBREUILLE',
	TABPRENOMS_T('Louis'),
	'Vigile',
	1500,
	Empty_clob(),
	to_date('11-11-1970','DD-MM-YYYY'),
	to_date('11-12-2012','DD-MM-YYYY'),
	refAgency
);
    
begin

	select value(oa), ref(oa) into agency, refAgency
	from o_agency oa where oa.agencyNo=4;

	emp.refAgency:=refAgency;

	insert into o_employe oe
	values(emp) returning ref(oe) into refOe;

	agency.addLinkListEmploye(refOe);

end;
/

-- requète de màj

-- 1 table
	declare
	loc location_t;
	begin
		select value(lo) into loc from 
		o_location lo where lo.country='France' and lo.city='Paris' and lo.streetName='Rue de la paix';

		loc.updateStreetName('Place Vendome', loc);
	end;
	/

	declare
	cli client_t;
	begin
		select value(oc) into cli from 
		o_client oc where oc.numCli='7';

		cli.updateJob('Directeur', cli);
		cli.updateSal(5000, cli)
	end;
	/
-- 2 tables
DECLARE 

refOe1 ref EMPLOYE_T;
agency agency_t;
refAgency ref agency_t;
agency2 agency_t;
refAgency2 ref agency_t;
refOe2 ref employe_t;

emp1 employe_t;
emp2 employe_t;

begin

	select value(oa), ref(oa) into agency, refAgency
	from o_agency oa where oa.agencyNo=1;
    
    select value(oa), ref(oa) into agency2, refAgency2
	from o_agency oa where oa.agencyNo=2;
    
    select value(oe), ref(oe) into emp1, refOe1
    from o_employe oe where oe.empNo=1;
    
    select value(oe), ref(oe) into emp2, refOe2
    from o_employe oe where oe.empNo=3;
    
    emp1.updateAgency(null);
    emp2.updateAgency(refAgency);
    
	agency.updateLinkListEmploye(refOe1, refOe2);
    agency2.deleteLinkListEmploye(refOe2);
    

end;
/

declare 

acc account_t;

begin
	select value(lra.column_value) into acc
	from table(select oc.listRefAccount
	from o_client oc
	where oc.numCli=13) lra;

	acc.updateBankCeiling(20000);
end;

-- >2 tables


commit;



select * from o_location;
select * from o_agency;
select * from o_employe;



