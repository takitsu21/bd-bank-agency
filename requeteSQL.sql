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
end;
/

-- Requêtes de suppressions --

	-- Requêtes de suppressions sur 1 table --

		-- Requete 1
		delete from o_client oc where oc.numCli=11;
        /


		rollback;
		-- Requete 2
		delete from o_agency oa where oa.agencyNo=4;
        /

		rollback;


	-- Requêtes de suppressions sur 2 tables --

		-- Requete 1
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
		rollback;


		-- Requete 2
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
		rollback;



	-- Requêtes de suppresions sur plus de 2 tables --

		-- Requete 1
			delete from o_transaction ot where ot.amount > 4000 and ot.issuer.numCli=10 and ot.refAccPayee.accountNo=11;
			/
		rollback;

		-- Requete 2
			delete from o_transaction ot
			where ot.amount > 3000 and ot.issuer.job='Ecrivain'
			and ot.issuer.refAgency.loc.country='France';
			/
rollback;



-- Requêtes de mise à jour --

	-- Requêtes sur 1 table --

		-- Requete 1
		declare
			loc location_t;
		begin
			select value(lo) into loc from
			o_location lo where lo.country='France' and lo.city='Paris' and lo.streetName='Rue de la paix' and lo.streetNo=8;
			loc.updateCountry('a');
		end;
		/
		rollback;


		-- Requete 2
		declare
			loc location_t;
		begin
			select value(lo) into loc from
			o_location lo where lo.country='France' and lo.city='Paris' and lo.streetName='Rue de la paix';

			loc.updateStreetName('Place Vendome');
		end;
		/
		rollback;


		-- Requete 3
		declare
		cli client_t;
		begin
			select value(oc) into cli from
			o_client oc where oc.numCli='7';

			cli.updateJob('Directeur');
			cli.updateSal(5000);
		end;
		/

	-- Requêtes sur 2 tables --

		-- Requete 1
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
		rollback;


		-- Requete 2
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
		rollback;

	-- Requêtes sur plus de 2 tables --

		-- Requete 1
		update (select * from o_transaction ot
		where ot.amount > 3000 and ot.issuer.job='Ecrivain'
		and ot.issuer.refAgency.loc.country='France') set amount=5000;
		/

		-- Requete 2
		update (select * from o_employe oe
		where oe.empNo>5 and oe.refAgency.agencyNo>5
		and oe.refAgency.loc.country='USA') set sal=10000;
		/



-- Requêtes de consultations --

	-- Requêtes sur 1 table --

		-- Requete 1 avec order by
		select ag.agencyNo, ag.aName
		from o_agency ag
		order by ag.aName;
		/

		-- Requete 2 avec group by
		select ot.payee, SUM(ot.amount) from o_transaction ot
		group by ot.payee;
		/


		-- Requete 3
			select * from o_account oa where oa.accountType='PEL';
			/

		-- Requete 4
			select * from o_client oc
			where oc.job='Médecin';
			/

		-- Requete 5
			select * from o_employe oe
			where oe.sal > 2000;
			/

	-- Requêtes sur 2 tables --

		-- Requete 1 avec interne

			select * from o_transaction ot left join o_client oc on ot.issuer.numCli=oc.numCli
			where ot.issuer.numCli=1;
			/

		-- Requete 2 avec group by

			select ot.issuer.cName, SUM(ot.amount)
			from o_transaction ot where ot.issuer.refAgency.agencyNo=1
			group by ot.issuer;
			/


		-- Requete 3 avec tri / order by
			select * from o_transaction ot where ot.issuer.refAgency.aName='pine bank' and ot.amount > 3000
   			ORDER BY ot.amount;
			/


		-- Requete 4 avec externe
			select * from o_transaction ot left outer join o_client oc
			on (ot.issuer.numCli=oc.numCli and oc.job='Médecin');
			/

		-- Requete 5
			select * from o_client oc
			where oc.job='Ingenieur' and oc.refAgency.aName='agence le cèdre';
			/


	-- Requêtes sur plus de 2 tables --

		-- Requete 1 avec externe ?


			SELECT *
			FROM o_transaction ot
				left outer join o_agency oa
					on(ot.payee.refAgency.agencyNo = oa.agencyNo and oa.loc.country='Italie');
					/

		-- Requete 2 avec group by
			select ot.issuer.numCli, ot.issuer.cName, ot.issuer.prenoms, ot.issuer.job, SUM(ot.amount) from o_transaction ot
			where ot.amount > 3000 and ot.issuer.birthDate > to_date('11-12-1960','DD-MM-YYYY')
			and ot.refAccIssuer.accountType='PEL' group by ot.issuer;
			/

		-- Requete 3 avec tri / order by
			select * from o_transaction ot
			where ot.amount > 3000 and ot.issuer.job='Ecrivain'
			and ot.issuer.refAgency.loc.country='France' ORDER BY issuer.cName DESC;
			/

		-- Requete 4 interne
			SELECT * FROM o_transaction  ot LEFT JOIN o_client oc ON ot.payee.numCli = oc.numCli
			where ot.issuer.refAgency.loc.country='France';
			/

		-- Requete 5
			select * from o_transaction ot
			where ot.amount > 3000 and ot.issuer.birthDate > to_date('11-12-1970','DD-MM-YYYY')
			and ot.refAccIssuer.accountType='Compte Epargne';
			/








