options symbolgen mprint;

libname stg "/export/home/wxg30/nc_data/";

 *********************************************************************************************;
 ** SAS Program: p02_NCTUE_aggregation_program_V1.sas                                       **;
 ** Description: Attribute Aggregation for first set of NC+ V1.0 attributesAggregation code **;
 ** Date:        02/19/2014                                                                 **;
 *********************************************************************************************;

options obs=max compress=binary mlogic mprint symbolgen nodate nonumber threads source2;

***************************************************************************************************;
                               *** USER MODIFICATION AREA ***;
***************************************************************************************************;

%let path =/export/home/wxg30/xrs3/;   


%Macro NC_Aggregation(Metadata_Name=, dsetin=, Outputdata=, Rundate=);

%let Time      = %sysfunc(time(),time8.0)     ;   %*HH:MM:SS;
%put ;
%put This SAS program started running at: &Time;
%put ;

%let run_date  = &rundate.;                           /***** User modified mmddyyyy - example: 11302010 , run_date is the last date of the archive month **/
%let inputdata = stg.&dsetin.;                                 /***** User modified it is the readin dataset name****/

/* Removing Purged Records */
/*
data &dsetin.; 
set hdmdlib.&Metadata_Name. (read_method=JDBC);
rundt = input(&run_date.,mmddyy8.);
format rundt yymmdd.;
if expiration_dt >.Z and rundt >.Z and expiration_dt < rundt then delete;

run;
*/

proc freq; 
 tables Company_cd / missing norow nocol;
run;

/*
GENERIC XRS3 CONTRIBUTOR LIST FROM SPECS
ATLS (CT removed from GDS as of 10/2014), ATMT, ATMW, ATSE, ATSW, ATTT, ATWE, 
DISH, DTVC, GAPR, GSOU, 
NI01, NI02, NI03, NI04, NI05, NI06, NI07, NI08, NI09, 
NI11, NI13, NI15, NI16, NI17, 
NI20, NI22, NI25, NI26, NI28, NI29, 
NI32, NI36, NI38, 
NI42, NI44, 
NTEL, WIND, 
VZNT, VZNW  
*/   
 

%let comp=(
'ATLS'
'ATMT'
'ATMW'
'ATSE'
'ATSW'
'ATTT'
'ATWE'
'DISH'
'DTVC'
'GAPR'
'GSOU'
'NI01'
'NI02'
'NI03'
'NI04'
'NI05'
'NI06'
'NI07'
'NI08'
'NI09'
'NI11'
'NI13'
'NI15'
'NI16'
'NI17'
'NI20'
'NI22'
'NI25'
'NI26'
'NI28'
'NI29'
'NI32'
'NI36'
'NI38' 
'NI42'
'NI44'
'VZNT'
'VZNW'
'NTEL' 
'WIND'
'CCBS'
'CCBW'
'CCCA'
'CCCH'
'CCFL'
'CCFR'
'CCHL'
'CCHO'
'CCIN'
'CCKS'
'CCMH'
'CCMO'
'CCNE'
'CCPO'
'CCSE'
'CCTC'
);


*%include "&path./comp.mac";

***User defined-- Enter the list of the company code user wants to include in the attribute aggreagtion****;

/* DKMW - removed 10/2014 */
/* ATEA - removed 10/2014 */

/* The following contributors are set up for each product in GDS/BCS
ISC - ATLS, ATMT, ATMW, ATSE, ATSW, ATTT, ATWE, DISH, DTVC, GAPR, GSOU, VZNT, VZNW

ISRBv2 - ATLS, ATMT, ATMW, ATSE, ATSW, ATTT, ATWE, DISH, DTVC, GAPR, GSOU, NI01, NI02, NI03,
NI04, NI05, NI06, NI07, NI08, NI09, NI10, NI11, NI12, NI13, NI14, NI15, NI16, NI17, NI18, NI19, NI20,
NI21, NI22, NI23, NI24, NI25, NI26, NI27, NI28, VZNT, VZNW

ISI - ATLS, ATMT, ATMW, ATSE, ATSW, ATTT, ATWE, DISH, DTVC, GAPR, GSOU, NI01, NI02, NI03,
NI04, NI05, NI06, NI07, NI08, NI09, NI11, NI13, NI15, NI16, NI17, NI20, NI22, NI24, NI25, NI26, NI28, 
NI29, NI32, NI36, NI38, NI42, NI43, NI44, NTEL, VZNT, VZNW, WIND

ADRS Advanced Energy + - ATLS, ATMT, ATMW, ATSE, ATSW, ATTT, ATWE, DISH, DTVC, GAPR, GSOU, NI01, NI02, NI03,
NI04, NI05, NI06, NI07, NI08, NI09, NI11, NI13, NI15, NI16, NI17, NI20, NI22, NI25, NI26, NI28, 
NI29, NI32, NI38, NI42, NTEL, VZNT, VZNW, WIND

ADRS CARD - ATLS, ATMT, ATMW, ATSE, ATSW, ATTT, ATWE, DISH, DTVC, GAPR, GSOU, NI01, NI02, NI03,
NI04, NI05, NI06, NI07, NI08, NI09, NI11, NI15, NI17, NI20, NTEL, VZNT, VZNW, WIND

ADRS Advanced Communications + - ATLS, ATMT, ATMW, ATSE, ATSW, ATTT, ATWE, DISH, DTVC, GAPR, GSOU, NI01, NI02, NI03,
NI04, NI05, NI06, NI07, NI08, NI09, NI11, NI13, NI15, NI16, NI17, NI20, NI22, NI24, NI25, NI26, NI28, 
NI29, NI32, NI36, NI38, NI42, NI43, NI44, NTEL, VZNT, VZNW, WIND

ADRS Auto - ATLS, ATMT, ATMW, ATSE, ATSW, ATTT, ATWE, DISH, DTVC, GAPR, GSOU, NI01, NI02, NI03,
NI04, NI05, NI06, NI07, NI08, NI09, NI10, NI11, NI12, NI13, NI14, NI15, NI16, NI17, NI18, NI19, NI20, NI21, NI22, NI23, 
NI24, NI25, NI26, NI27, NI28, VZNT, VZNW
�� The following contributors are set up for each product in GDS/BCS */


data all_temp(rename=(Last_Reporting_date=last_reported_date Last_Acct_status=last_reported_status) );
  set stg.&dsetin.;
  cnxid=CNX_Key;
  if (Account_Number=" " and Company_cd=" " and Srv_Typ=" ") then delete;
  if trim(company_cd)  in &comp;

 /* begin of hdmd temp fix */
array PMT{*}     PMT01-PMT24;
array BAL{*}      BAL01-BAL24;
array CHG{*}     CHG01-CHG24;

Charge_off_amt = Charge_off_amt / 100;
Pmt_Amt           = Pmt_Amt           / 100;
Curr_bal             = Curr_bal             / 100;

do _i = 1 to dim(PMT);
   PMT{_i}        = PMT{_i}     / 100; 
   BAL{_i}         = BAL{_i}      / 100;
   CHG{_i}        = CHG{_i}      / 100;
end;
drop _i;
 /* end of hdmd temp fix */

Account_unique_id = scan(Surrogate_key,2,';');

  run;

***** Dedupe *****;
  * proc sort data=all_temp;
    * by cnxid Company_cd Account_Number Srv_Typ descending Reportg_dt descending Curr_Bal_dt;
  * run;
  proc sort data=all_temp;
    by cnxid Company_cd Account_Number Srv_Typ descending Reportg_dt descending Curr_Bal_dt descending last_reported_date Account_unique_id;
  run;  
  proc sort data=all_temp nodupkey;
    by cnxid Company_cd Account_Number Srv_Typ;  
 run;

************************************************** END OF MODIFICATION -- DO NOT TOUCH BELOW **********************************************;
************************************************** END OF MODIFICATION -- DO NOT TOUCH BELOW **********************************************;
************************************************** END OF MODIFICATION -- DO NOT TOUCH BELOW **********************************************;
%include "&path/attr1.mac"/source; 
%include "&path/attr2.mac"/source;

proc sort data=ncvar1_final;by cnxid;run;
proc sort data=ncvar2_final;by cnxid;run;

data ncvar_all;
 merge ncvar1_final (in=a) ncvar2_final (in=b);
 by cnxid;
 if a and b;
 run;
 
data stg.&Outputdata.;
	set ncvar_all;
	/*%inc "&path/convert_missing_101a.txt";*/
    /*%inc "&path/convert_missing_101b.txt";*/
	
run;

proc contents data=stg.&Outputdata. varnum;
run;

%let Time      = %sysfunc(time(),time8.0)     ;   %*HH:MM:SS;
%put ;
%put This SAS program ended running at: &Time;
%put ;

/*
%bq_connect(MYTEST, PROJECT="dfa-dna-ws5056-us-prd-7402", 
			SCHEMA="dfa_dna_ws5056_us_prd_sandbox", 
			READ_MODE=STORAGE,
            SCANSTRINGCOLUMNS=YES,
            BULKLOAD=YES)

data MYTEST.nc_v1_202201;
	set stg.&Outputdata.;
run;
*/

%Mend;

/* User Modify below information */ 
%NC_Aggregation(Metadata_Name= blah, dsetin=wg_pmt_grid_modified_202201, Outputdata= NC_modified_202201, Rundate='01312022');
