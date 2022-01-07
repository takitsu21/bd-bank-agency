-- - requête de mise a jour:
--     - 2 impliquant 1 table
--     - 2 impliquant 2 tables
--     - 2 impliquant >2 tables

-- - requête de suppression:
--     - 2 impliquant 1 table
--     - 2 impliquant 2 tables
--     - 2 impliquant >2 tables

-- -requête de consultation:
--     - 5 impliquant 1 tables (1 avec group by, 1 avec order by)
--     - 5 impliquant 2 tables avec jointure interne ( 1 externe, 1 group by, 1 tri)
--     - 5 impliquant >2 tables avec jointure interne ( 1 externe, 1 group by, 1 tri)


-- Requêtes d'access data -- 

	set serverout on

	declare 

	locationPaix location_t;
	agency agency_t;
	emp employe_t;
	client1 client_t;
	account1 account_t;
	transactionTest TRANSACTION_T;

	begin

	select value(lo) into locationPaix from
	o_location lo where lo.country='France' and lo.city='Paris';

	select value(ag) into agency from
	o_agency ag where ag.agencyNo=1;

	select value(em) into emp from
	o_employe em where em.empNo=1;

	select value(cl) into client1 from
	o_client cl where cl.numCli=1;

	select value(ac) into account1 from
	o_account ac where ac.accountNo=1;

	select value(tran) into transactionTest from
	O_TRANSACTION tran where tran.TNUM=2;

	DBMS_OUTPUT.PUT_LINE(locationPaix.getCountry);


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


-- Requêtes de suppressions -- 

	-- Requêtes de suppressions sur 1 table --
		declare 
		begin 
			delete from o_client oc where oc.numCli=11;
		end;
		/

		declare 
		begin 
			delete from o_agency oa where oa.agencyNo=4;
		end;
		/
	-- Requêtes de suppressions sur 2 tables --

		declare 
		agency agency_t;
		refOe ref employe_t;

		begin 

		select value(ag) into agency from
		o_agency ag where ag.agencyNo=1;

		update o_employe oe set oe.refAgency=null
		where oe.refAgency.agencyNo=1 and oe.empNo=1 returning ref(oe) into refOe;

		agency.deleteLinkListEmploye(refOe);

		end;
		/

		declare 
		accountIssuer account_t;
		accountPayee account_t;
		refTrans ref transaction_t;

		begin
		
		select value (ac) into accountIssuer from
		o_account ac where ac.accountNo=1;

		select value (ac) into accountPayee from
		o_account ac where ac.accountNo=2;

		update O_TRANSACTION ot set ot.refAccIssuer=null, ot.refAccPayee=null
		where ot.refAccIssuer.accountNo=1 and ot.refAccPayee.accountNo=2 and ot.tNum=1 returning ref(ot) into refTrans;

		accountIssuer.deleteLinkListTransaction(refTrans);
		accountPayee.deleteLinkListTransaction(refTrans);

		end;
		/
	
	-- Requêtes de suppresions sur plus de 2 tables --



-- Requêtes de mise à jour -- 

	-- Requêtes sur 1 table --
		declare
			loc location_t;
		begin
			select value(lo) into loc from 
			o_location lo where lo.country='France' and lo.city='Paris' and lo.streetName='Rue de la paix' and lo.streetNo=8;
			loc.updateCountry('a', loc);
		end;
		/

		declare
			loc location_t;
		begin
			select value(lo) into loc from 
			o_location lo where lo.country='France' and lo.city='Paris' and lo.streetName='Rue de la paix';

			loc.updateStreetName('Place Vendome');
		end;
		/

		declare
		cli client_t;
		begin
			select value(oc) into cli from 
			o_client oc where oc.numCli='7';

			cli.updateJob('Directeur');
			cli.updateSal(5000)
		end;
		/

	-- Requêtes sur 2 tables -- 

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

		DECLARE 

		efOe ref EMPLOYE_T;
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
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
	-- Requêtes sur plus de 2 tables --

	

-- Requêtes de consultations --
	-- Requêtes sur 1 table --
		select ag.agencyNo, ag.aName
		from o_agency ag
		order by ag.aName;
	-- Requêtes sur 2 tables --
	-- Requêtes sur plus de 2 tables --
	





-- section de dyl le génie
select oe FROM 
TABLE(select frenchAgencies.listRefEmp from
	TABLE(
			SELECT ag 
			FROM o_agency
			WHERE ag.loc.country='France'
		) frenchAgencies	
	) listeEMP 



-- on cherche une transaction > 3000€ (ACCOUNT_T)
-- dans une agence Française (Agency_t)
-- qui vient du client c (CLIENT_T)


declare
agency agency_t;
refAgency ref agency_t;

refClient ref client_t;
valClient client_t;

account account_t;
refCliAccount ref account_t;

trans transaction_t;
begin



-- select * from (
-- 	select * from(
-- 		select * from (
-- 			select * from o_transaction tr
-- 			where tr.amount > 3000
-- 		) transac where transac.refAccIssuer.refAgency.loc.country = 'France' and transac.issuer.birthDate > to_date('01-01-1950', 'DD-MM-YYYY')
-- 	)
-- )


select ref(ag) into refAgency 
from O_AGENCY ag where ag.loc.country='France' and ag.loc.city='Nice';

-- select ref(oc) into refClient
-- from o_client oc
-- where oc.birthDate > to_date('01-01-1950', 'DD-MM-YYYY');


select * from (select * from o_transaction tr where tr.amount > 3000) transac
where transac.refAccIssuer.refAgency=refAgency
and transac.issuer.birthDate > to_date('01-01-1950', 'DD-MM-YYYY');




end;
/

declare
agency agency_t;
refAg ref agency_t;

refClient ref client_t;
valClient client_t;

account account_t;
refCliAccount ref account_t;

trans transaction_t;

begin

select ref(ag) into refAg
from O_AGENCY ag 
where ag.loc.country='France' and ag.loc.city='Nice';

select transac.issuer into refClient from (select * from o_transaction tr where tr.amount > 3000) transac where transac.tNum=14;


end;
/

select * from o_client oc where oc.numCli=refClient.numCli;


declare 
trans transaction_t;
refCliAccount ref account_t;
refAg ref agency_t;
begin
select value(ot) into trans from o_transaction ot where ot.tNum=5;

select oac into refCliAccount from o_account oac where oac.accountNo=trans.refAccIssuer.accountNo;

select oa into refAg from o_agency oa where oa.agencyNo=refCliAccount.refAgency.agencyNo;

end;
/


