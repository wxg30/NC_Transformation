
create or replace table dfa_dna_ws5056_us_prd_sandbox.wg_valid_sample as 
with full_pop as (
  select distinct
  a.cnx, a.acct_uniq_id, a.svc_cnct_dt, a.svc_dscnt_dt, a.svc_typ_cd,
  a.cust_cd, a.acct_sts_cd
  from dfa_dna_ws5056_us_prd_sandbox.wg_trades_202201 a 
  --join dfa_dna_ws5056_us_prd_sandbox.wg_12m_perf_output b on a.acct_uniq_id = b.acct_uniq_id
  join dfa_dna_ws5056_us_prd_sandbox.wg_valid_sample_12m_perf_Prep_202201 c on a.acct_uniq_id = c.acct_uniq_id
  --where b.perf is not null
)
select * from full_pop;

create or replace table dfa_dna_ws5056_us_prd_sandbox.wg_extract_baseline as

with cteCNX as (
	select distinct cnx 
	from dfa_dna_ws5056_us_prd_sandbox.wg_valid_sample
  where cnx is not null and cnx!='000000000000' and cnx!=''
  --and not (klcat = 'one for one' and multicat = 'single')
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
  select a.acct_uniq_id, a.cnx, a.csmr_nbr, a.addresses, CSMR_STRT_DATE, CSMR_END_DATE,
    ROW_NUMBER() OVER (PARTITION BY a.cnx, a.acct_uniq_id ORDER BY a.cnx, a.acct_uniq_id DESC) AS rank 
  from 	`df-dna-datamgmt-prd-3ccc.ncplus_analyst_us_prd.ncp_consumer_us_prd` a,
	cteCNXSource b 
  
  where _PARTITIONTIME = '2023-02-01' and a.cnx = b.cnx -- Update / verify archive date
)

select * 
From
(
   select a.payment_account_grid from
   (
	select dfa_dna_ws5056_us_prd_sandbox.evaluate(
		 24,  -- variable for choosing the number of months of history.
         '2022-01-01',  -- variable for 'as of date' of the data.
         ncpgv.acct_uniq_id,
         csmr.cnx,
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



