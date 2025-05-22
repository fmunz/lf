-- you can have a single MV or ST statement per SQL or python file. 

CREATE MATERIALIZED VIEW total_loan_balances
  COMMENT "Combines historical and new loan data for unified rollup of loan balances"
  TBLPROPERTIES ("pipelines.autoOptimize.zOrderCols" = "location_code")
AS SELECT sum(revol_bal)  AS bal, addr_state   AS location_code FROM historical_txs  GROUP BY addr_state
  UNION SELECT sum(balance) AS bal, country_code AS location_code FROM cleaned_new_txs GROUP BY country_code