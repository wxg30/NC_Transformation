
create or replace table dfa_dna_ws5056_us_prd_sandbox.wg_extract_KID as

with cteCNX as (
	select distinct cnx 
	from dfa_dna_ws5056_us_prd_sandbox.wg_valid_sample
  where cnx is not null and cnx!='000000000000' and cnx!=''
),
cteCNXList as (
	select cnx
	from `df-dna-datamgmt-prd-3ccc.ncplus_analyst_us_prd.ncp_consumer_us_prd`
	where _PARTITIONTIME = '2023-02-01' group by cnx having count(*) > 1000
),
cteCNXSource as (
	select source.cnx 
	from cteCNX source
	left outer join cteCNXList hc on source.cnx = hc.cnx
	where hc.cnx is null
),
cteCSMR as (
  select a.acct_uniq_id, entity_key, a.csmr_nbr, a.addresses, 
    cast(CSMR_STRT_DATE as string) as CSMR_STRT_DATE, cast (CSMR_END_DATE as string) as CSMR_END_DATE,
    ROW_NUMBER() OVER (PARTITION BY entity_key, a.acct_uniq_id ORDER BY entity_key, a.acct_uniq_id DESC) AS rank 
  from 	`df-dna-datamgmt-prd-3ccc.ncplus_analyst_us_prd.ncp_consumer_us_prd` a,
	cteCNXSource b
  join (select distinct cnx, entity_key from dfa_dna_ws5056_us_prd_sandbox.NCTUE_Mapping_20220622) m on b.cnx = m.cnx
    
  where _PARTITIONTIME = '2023-02-01' and a.cnx = b.cnx -- Update / verify archive date
)

select distinct * 
From
(
   select a.payment_account_grid from
   (
	select dfa_dna_ws5056_us_prd_sandbox.evaluate_modified(
		 24,  -- variable for choosing the number of months of history.
         '2022-01-01',  -- variable for 'as of date' of the data.
         ncpgv.acct_uniq_id,
         CSMR_STRT_DATE, 
         CSMR_END_DATE,
         entity_key,
         ncpgv.exch_abbr ,
         ncpgv.cust_cd ,
         ncpgv.cust_rptg_dt,
         ncpgv.acct_nbr_hash,
         csmr.csmr_nbr,
         ncpgv.pymt_hist_snapshot,
         ncpgv.main_acct_typ,
         ncpgv.svc_typ_cd,
         ncpgv.acct_sts_cd,
         ncpgv.crnt_bal_dt,
         ncpgv.crnt_bal,
         ncpgv.lst_pymt_amt,
         ncpgv.lst_chrg_off_amt,
         ncpgv.exp_dt,
         ncpgv.svc_cnct_dt,
         ncpgv.svc_dscnt_dt,
         csmr.addresses,
         ncpgv.payments) as payment_account_grid
      from 
	     `df-dna-datamgmt-prd-3ccc.ncplus_analyst_us_prd.ncp_account_view_us_prd` ncpgv
      join
		cteCSMR csmr on ncpgv.acct_uniq_id = csmr.acct_uniq_id
      where ncpgv.archive = '2023-02-01' and rank = 1 and ncpgv.exp_indctr = 'N' and  ncpgv.acct_sts_cd not in ("F","B") -- Update / verify archive date

      and (CSMR_STRT_DATE is not null and svc_cnct_dt >= '2015-01-01')


	) a 
where a.payment_account_grid is not null) ext;

