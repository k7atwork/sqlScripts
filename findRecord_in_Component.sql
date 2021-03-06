SELECT DISTINCT --P.PNLNAME, 
P.RECNAME 
FROM PSPNLFIELD P, PSRECDEFN R, PSRECFIELDDB F
WHERE PNLNAME IN (SELECT PNLNAME FROM PSPNLGROUP WHERE PNLGRPNAME='SCC_CG_RUNCTL')
AND R.RECNAME=P.RECNAME
AND R.RECTYPE=0 --(0:SQL_Table, 1:SQL_View, 2:WorkRecord, 5:DynamicView)
AND F.RECNAME=R.RECNAME AND F.FIELDNAME='RUN_CNTL_ID'
