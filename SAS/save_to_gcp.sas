*Need to authorize your Google account to connect to SAS Viya. Please copy and paste this in a new tab/window:
https://accounts.google.com/o/oauth2/auth?scope=https://www.googleapis.com/auth/bigquery+https://www.googleapis.com/auth/cloud-platform&response_type=code&redirect_uri=urn:ietf:wg:oauth:2.0:oob&client_id=796806615214-biigj9brf3h8ahkmgsudo2ackot6l1jp.apps.googleusercontent.com

* Then grab the token value from the window, and change the value below in the get_refresh_token macro;
*%get_refresh_token(4/1AX4XfWiOEKQ1A1WxRhM4C4h9ugtG9gDnr4h70E9Z1TRd_56CJLW9doc9cKs);

option compress=binary obs=max dlcreatedir;
options mprint mlogic symbolgen;

/********************** Change the below Maro Variables as Required***********************/

%let asOfmonthEnd=20220131;                         /* -- 2nd argument rundate -- last date of previous month */
%global outTable;                              
%let outTable = wg_sample_KID_12m_perf_202201;     /* -- table to which the output of this process to be written */
%let emailFrom = "ignite.direct2@equifax.com";      
%let emailTo = "william.gates@equifax.com";
%let sub = "";
%let msg = "";

/******************************* Library of Input and Output data *************************/

%bq_connect(MYTEST, PROJECT="dfa-dna-ws5056-us-prd-7402", 
			SCHEMA="dfa_dna_ws5056_us_prd_sandbox", 
			READ_MODE=STORAGE,
            SCANSTRINGCOLUMNS=YES,
            BULKLOAD=YES)

libname IPPATH "/export/home/wxg30/nc_data/";
libname OUTPATH "/export/home/wxg30/nc_data/";

/************************************* The macro sends email *****************************/

%macro send_mail(emailFrom, emailTo, sub, msg);
    filename outbox email
    from = (&emailFrom.) 
    to = (&emailTo.)
    type = "text/html"
	subject = &sub.;

	data _null_;
	   file outbox;
	   put &msg.;
    run;

%mend send_mail;


/**************** Checking if the output table already exists in BigQuery ***************/
%if %sysfunc(exist(MYTEST.&outTable.)) %then %do;
   data _null_;
      file print;
      put #3 @5 "The output table &outTable. already exists in BigQuery.";
      put #3 @5 "The BigQuery connection currently doesn't support 'Overwrite'. Hence, please drop table in bq and run the script again.";
   run;
   %let sub = "NCTUE process 'ABORTED' - BQ table already exists";
   %let msg = "The output table &outTable. already exists in BigQuery. The BigQuery connection currently doesn't support 'Overwrite'. Hence, please drop table in bq and run the script again.";
   %send_mail(&emailFrom., &emailTo., &sub., &msg.);
   endsas;
%end;


data MYTEST.&outTable.;
	set OUTPATH.&outTable.;
run;
