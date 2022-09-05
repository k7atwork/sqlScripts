INSERT INTO PSMSGSETDEFN
SELECT * FROM HRINT..PSMSGSETDEFN A WHERE NOT EXISTS (SELECT 'X' FROM PSMSGSETDEFN B WHERE B.MESSAGE_SET_NBR=A.MESSAGE_SET_NBR)
INSERT INTO PSMSGCATDEFN
SELECT * FROM HRINT..PSMSGCATDEFN A WHERE NOT EXISTS (SELECT 'X' FROM PSMSGCATDEFN B WHERE B.MESSAGE_SET_NBR=A.MESSAGE_SET_NBR AND B.MESSAGE_NBR=A.MESSAGE_NBR)

--UPDATE PSVERSION SET VERSION=VERSION+1 WHERE OBJECTTYPENAME IN ('PPC','SYS');
UPDATE PSVERSION SET VERSION=(SELECT VERSION+1 FROM PSVERSION WHERE OBJECTTYPENAME IN ('PPC')) WHERE OBJECTTYPENAME IN ('PPC')
UPDATE PSVERSION SET VERSION=(SELECT VERSION+1 FROM PSVERSION WHERE OBJECTTYPENAME IN ('SYS')) WHERE OBJECTTYPENAME IN ('SYS')

--SELECT * FROM PSVERSION WHERE OBJECTTYPENAME IN ('PPC','SYS');


INSERT INTO PS_ANU_STRING_TBL
SELECT * FROM HRINT..PS_ANU_STRING_TBL

INSERT INTO PS_WL_TEMPLATE_GEN
SELECT * FROM HRINT..PS_WL_TEMPLATE_GEN A WHERE NOT EXISTS (SELECT 'X' FROM PS_WL_TEMPLATE_GEN B WHERE B.WL_TEMPLATE_ID=A.WL_TEMPLATE_ID)
INSERT INTO PS_WL_TEMPL_GEN_TK
SELECT * FROM HRINT..PS_WL_TEMPL_GEN_TK A WHERE NOT EXISTS (SELECT 'X' FROM PS_WL_TEMPL_GEN_TK B WHERE B.WL_TEMPLATE_ID=A.WL_TEMPLATE_ID)

INSERT INTO PS_HR_SSTEXT_CFG
SELECT * FROM HRINT..PS_HR_SSTEXT_CFG A WHERE NOT EXISTS (SELECT 'X' FROM PS_HR_SSTEXT_CFG B WHERE B.OBJECTOWNERID=A.OBJECTOWNERID and B.HR_SSTEXT_SUB_ID=A.HR_SSTEXT_SUB_ID)
INSERT INTO PS_HR_SSTEXT_MSGID
SELECT * FROM HRINT..PS_HR_SSTEXT_MSGID A WHERE NOT EXISTS (SELECT 'X' FROM PS_HR_SSTEXT_MSGID B WHERE B.OBJECTOWNERID=A.OBJECTOWNERID and B.HR_SSTEXT_SUB_ID=A.HR_SSTEXT_SUB_ID)
INSERT INTO PS_HR_SSTEXT_EFFDT
SELECT * FROM HRINT..PS_HR_SSTEXT_EFFDT A WHERE NOT EXISTS (SELECT 'X' FROM PS_HR_SSTEXT_EFFDT B WHERE B.OBJECTOWNERID=A.OBJECTOWNERID and B.HR_SSTEXT_SUB_ID=A.HR_SSTEXT_SUB_ID)
INSERT INTO PS_HR_SSTEXT_TEXT
SELECT * FROM HRINT..PS_HR_SSTEXT_TEXT A WHERE NOT EXISTS (SELECT 'X' FROM PS_HR_SSTEXT_TEXT B WHERE B.OBJECTOWNERID=A.OBJECTOWNERID and B.HR_SSTEXT_SUB_ID=A.HR_SSTEXT_SUB_ID)
INSERT INTO PS_HR_SSTEXT_MLNG
SELECT * FROM HRINT..PS_HR_SSTEXT_MLNG A WHERE NOT EXISTS (SELECT 'X' FROM PS_HR_SSTEXT_MLNG B WHERE B.OBJECTOWNERID=A.OBJECTOWNERID and B.HR_SSTEXT_SUB_ID=A.HR_SSTEXT_SUB_ID)

--INSERT INTO PS_EOAW_IDS
SELECT * FROM HRINT..PS_EOAW_IDS B WHERE NOT EXISTS (SELECT 'X' FROM PS_EOAW_IDS A WHERE B.EOAWCOUNTERNAME=A.EOAWCOUNTERNAME)
UPDATE A SET A.EOAWCOUNTER = B.EOAWCOUNTER FROM HRINT..PS_EOAW_IDS B, PS_EOAW_IDS A WHERE B.EOAWCOUNTERNAME=A.EOAWCOUNTERNAME AND A.EOAWCOUNTER < B.EOAWCOUNTER

DELETE FROM PSCLASSDEFN where LASTUPDOPRID='CONVERSION'
DELETE FROM PSCLASSDEFN where LASTUPDOPRID='WEBTOOLS'
DELETE FROM PSCLASSDEFN where LASTUPDOPRID='U9308988'
DELETE FROM PSCLASSDEFN where LASTUPDOPRID LIKE 'U%' and CLASSID LIKE 'U%'


INSERT INTO PS_INSTALLATION 
SELECT * FROM HRINT..PS_INSTALLATION
--DELETE FROM PS_INSTALLATION WHERE COMPANY <> 'ANU'

INSERT INTO PS_ANU_EMPLID_NEXT
SELECT * FROM HRINT..PS_ANU_EMPLID_NEXT

UPDATE PS_INSTALLATION_HR SET EMPLID_LAST_EMPL = (SELECT MIN(EMPLID) FROM PS_ANU_EMPLID_NEXT)

INSERT INTO PS_OPR_DEF_TBL_HR
SELECT * FROM HRINT..PS_OPR_DEF_TBL_HR WHERE OPRCLASS='ANU_DEFAULT_PL'

INSERT INTO PS_SCRTY_TBL_GBL
SELECT * FROM HRINT..PS_SCRTY_TBL_GBL FILL WHERE FILL.OPRCLASS = 'ANU_DEFAULT_PL'

INSERT INTO PS_SCRTY_SEC_GBL
SELECT * FROM HRINT..PS_SCRTY_SEC_GBL FILL WHERE FILL.OPRCLASS = 'ANU_DEFAULT_PL'

INSERT INTO PS_SJT_CLASS
SELECT * FROM HRINT..PS_SJT_CLASS WHERE CLASSID='ANU_HR_ACCESS_POI'

INSERT INTO PS_ADDRESS_TYP_TBL
SELECT * FROM HRINT..PS_ADDRESS_TYP_TBL A WHERE NOT EXISTS (SELECT 'X' FROM PS_ADDRESS_TYP_TBL B WHERE B.ADDRESS_TYPE = A.ADDRESS_TYPE)
INSERT INTO PS_EO_ADDR_VALIDAT
SELECT * FROM HRINT..PS_EO_ADDR_VALIDAT A WHERE NOT EXISTS (SELECT 'X' FROM PS_EO_ADDR_VALIDAT B WHERE B.COUNTRY=A.COUNTRY AND B.POSTAL=A.POSTAL AND B.STATE=A.STATE AND B.CITY=A.CITY AND B.COUNTY=A.COUNTY AND B.ADDRESS1=A.ADDRESS1)

INSERT INTO PS_NAME_TYPE_TBL
SELECT * FROM HRINT..PS_NAME_TYPE_TBL A WHERE NOT EXISTS (SELECT 'X' FROM PS_NAME_TYPE_TBL B WHERE B.NAME_TYPE = A.NAME_TYPE)
INSERT INTO PS_ETHNIC_GRP_TBL
SELECT * FROM HRINT..PS_ETHNIC_GRP_TBL A WHERE NOT EXISTS (SELECT 'X' FROM PS_ETHNIC_GRP_TBL B WHERE B.SETID=A.SETID AND B.ETHNIC_GRP_CD=A.ETHNIC_GRP_CD)

INSERT INTO PS_COMPANY_TBL
SELECT * FROM HRINT..PS_COMPANY_TBL A WHERE A.EFFDT=(SELECT MAX(A1.EFFDT) FROM HRINT..PS_COMPANY_TBL A1 WHERE A1.COMPANY=A.COMPANY) AND NOT EXISTS (SELECT 'X' FROM PS_COMPANY_TBL B WHERE B.COMPANY = A.COMPANY)
INSERT INTO PS_PAYGROUP_TBL
SELECT * FROM HRINT..PS_PAYGROUP_TBL A WHERE A.EFFDT=(SELECT MAX(A1.EFFDT) FROM HRINT..PS_PAYGROUP_TBL A1 WHERE A1.COMPANY=A.COMPANY AND A1.PAYGROUP=A.PAYGROUP) AND NOT EXISTS (SELECT 'X' FROM PS_PAYGROUP_TBL B WHERE B.COMPANY = A.COMPANY AND B.PAYGROUP=A.PAYGROUP)
INSERT INTO PS_ACTION_TBL
SELECT * FROM HRINT..PS_ACTION_TBL A WHERE A.EFFDT=(SELECT MAX(A1.EFFDT) FROM HRINT..PS_ACTION_TBL A1 WHERE A1.ACTION=A.ACTION) AND NOT EXISTS (SELECT 'X' FROM PS_ACTION_TBL B WHERE B.ACTION = A.ACTION) 
INSERT INTO PS_ACTN_REASON_TBL
SELECT * FROM HRINT..PS_ACTN_REASON_TBL A WHERE A.EFFDT=(SELECT MAX(A1.EFFDT) FROM HRINT..PS_ACTN_REASON_TBL A1 WHERE A1.ACTION=A.ACTION AND A1.ACTION_REASON=A.ACTION_REASON) AND NOT EXISTS (SELECT 'X' FROM PS_ACTN_REASON_TBL B WHERE B.ACTION = A.ACTION AND B.ACTION_REASON=A.ACTION_REASON) 
INSERT INTO PS_COUNTRY_TBL
SELECT * FROM HRINT..PS_COUNTRY_TBL A WHERE NOT EXISTS (SELECT 'X' FROM PS_COUNTRY_TBL B WHERE B.COUNTRY = A.COUNTRY) 
INSERT INTO PS_STATE_TBL
SELECT * FROM HRINT..PS_STATE_TBL A WHERE NOT EXISTS (SELECT 'X' FROM PS_STATE_TBL B WHERE B.COUNTRY = A.COUNTRY AND B.STATE=A.STATE) 
INSERT INTO PS_CURRENCY_CD_TBL
SELECT * FROM HRINT..PS_CURRENCY_CD_TBL A WHERE A.EFFDT=(SELECT MAX(A1.EFFDT) FROM HRINT..PS_CURRENCY_CD_TBL A1 WHERE A1.CURRENCY_CD=A.CURRENCY_CD) AND NOT EXISTS (SELECT 'X' FROM PS_CURRENCY_CD_TBL B WHERE B.CURRENCY_CD = A.CURRENCY_CD)
INSERT INTO PS_DEPT_TBL
SELECT * FROM HRINT..PS_DEPT_TBL A WHERE (A.EFFDT > {FN CURDATE()} OR A.EFFDT=(SELECT MAX(A1.EFFDT) FROM HRINT..PS_DEPT_TBL A1 WHERE A1.SETID=A.SETID AND A1.DEPTID=A.DEPTID AND A.EFFDT <= {FN CURDATE()})) AND NOT EXISTS (SELECT 'X' FROM PS_DEPT_TBL B WHERE B.SETID=A.SETID AND B.DEPTID=A.DEPTID)
INSERT INTO PS_LOCATION_TBL
SELECT * FROM HRINT..PS_LOCATION_TBL A WHERE (A.EFFDT > {FN CURDATE()} OR A.EFFDT=(SELECT MAX(A1.EFFDT) FROM HRINT..PS_LOCATION_TBL A1 WHERE A1.SETID=A.SETID AND A1.LOCATION=A.LOCATION AND A.EFFDT <= {FN CURDATE()})) AND NOT EXISTS (SELECT 'X' FROM PS_LOCATION_TBL B WHERE B.SETID=A.SETID AND B.LOCATION=A.LOCATION)
INSERT INTO PS_JOBCODE_TBL
SELECT * FROM HRINT..PS_JOBCODE_TBL A WHERE (A.EFFDT > {FN CURDATE()} OR A.EFFDT=(SELECT MAX(A1.EFFDT) FROM HRINT..PS_JOBCODE_TBL A1 WHERE A1.SETID=A.SETID AND A1.JOBCODE=A.JOBCODE AND A.EFFDT <= {FN CURDATE()})) AND NOT EXISTS (SELECT 'X' FROM PS_JOBCODE_TBL B WHERE B.SETID=A.SETID AND B.JOBCODE=A.JOBCODE)

INSERT INTO PS_SAL_PLAN_TBL
SELECT * FROM HRINT..PS_SAL_PLAN_TBL A WHERE (A.EFFDT > {FN CURDATE()} OR A.EFFDT=(SELECT MAX(A1.EFFDT) FROM HRINT..PS_SAL_PLAN_TBL A1 WHERE A1.SETID=A.SETID AND A1.SAL_ADMIN_PLAN=A.SAL_ADMIN_PLAN AND A.EFFDT <= {FN CURDATE()})) AND NOT EXISTS (SELECT 'X' FROM PS_SAL_PLAN_TBL B WHERE B.SETID=A.SETID AND B.SAL_ADMIN_PLAN=A.SAL_ADMIN_PLAN)
INSERT INTO PS_SAL_GRADE_TBL
SELECT * FROM HRINT..PS_SAL_GRADE_TBL A WHERE (A.EFFDT > {FN CURDATE()} OR A.EFFDT=(SELECT MAX(A1.EFFDT) FROM HRINT..PS_SAL_GRADE_TBL A1 WHERE A1.SETID=A.SETID AND A1.SAL_ADMIN_PLAN=A.SAL_ADMIN_PLAN AND A1.GRADE=A.GRADE AND A.EFFDT <= {FN CURDATE()})) AND NOT EXISTS (SELECT 'X' FROM PS_SAL_GRADE_TBL B WHERE B.SETID=A.SETID AND B.SAL_ADMIN_PLAN=A.SAL_ADMIN_PLAN AND B.GRADE=A.GRADE)
INSERT INTO PS_SAL_STEP_TBL
SELECT * FROM HRINT..PS_SAL_STEP_TBL A WHERE (A.EFFDT > {FN CURDATE()} OR A.EFFDT=(SELECT MAX(A1.EFFDT) FROM HRINT..PS_SAL_STEP_TBL A1 WHERE A1.SETID=A.SETID AND A1.SAL_ADMIN_PLAN=A.SAL_ADMIN_PLAN AND A1.GRADE=A.GRADE AND A1.STEP=A.STEP AND A.EFFDT <= {FN CURDATE()})) AND NOT EXISTS (SELECT 'X' FROM PS_SAL_STEP_TBL B WHERE B.SETID=A.SETID AND B.SAL_ADMIN_PLAN=A.SAL_ADMIN_PLAN AND B.GRADE=A.GRADE AND B.STEP=A.STEP)
INSERT INTO PS_SAL_RATECD_TBL
SELECT * FROM HRINT..PS_SAL_RATECD_TBL A WHERE (A.EFFDT > {FN CURDATE()} OR A.EFFDT=(SELECT MAX(A1.EFFDT) FROM HRINT..PS_SAL_RATECD_TBL A1 WHERE A1.SETID=A.SETID AND A1.SAL_ADMIN_PLAN=A.SAL_ADMIN_PLAN AND A1.GRADE=A.GRADE AND A1.STEP=A.STEP AND A.EFFDT <= {FN CURDATE()})) 
AND NOT EXISTS (SELECT 'X' FROM PS_SAL_RATECD_TBL B WHERE B.SETID=A.SETID AND B.SAL_ADMIN_PLAN=A.SAL_ADMIN_PLAN AND B.GRADE=A.GRADE AND B.STEP=A.STEP)

INSERT INTO PS_CMP_RULE_DEFN
SELECT * FROM HRINT..PS_CMP_RULE_DEFN A WHERE (A.EFFDT > {FN CURDATE()} OR A.EFFDT=(SELECT MAX(A1.EFFDT) FROM HRINT..PS_CMP_RULE_DEFN A1 WHERE A1.CMP_RULE_ID=A.CMP_RULE_ID))
AND NOT EXISTS (SELECT 'X' FROM PS_CMP_RULE_DEFN B WHERE B.CMP_RULE_ID=A.CMP_RULE_ID AND B.EFFDT=A.EFFDT)
INSERT INTO PS_CMP_RULE_WHERE
SELECT * FROM HRINT..PS_CMP_RULE_WHERE A WHERE (A.EFFDT > {FN CURDATE()} OR A.EFFDT=(SELECT MAX(A1.EFFDT) FROM HRINT..PS_CMP_RULE_WHERE A1 WHERE A1.CMP_RULE_ID=A.CMP_RULE_ID))
AND NOT EXISTS (SELECT 'X' FROM PS_CMP_RULE_WHERE B WHERE B.CMP_RULE_ID=A.CMP_RULE_ID AND B.EFFDT=A.EFFDT)
INSERT INTO PS_CMP_RULE_VALUES
SELECT * FROM HRINT..PS_CMP_RULE_VALUES A WHERE (A.EFFDT > {FN CURDATE()} OR A.EFFDT=(SELECT MAX(A1.EFFDT) FROM HRINT..PS_CMP_RULE_VALUES A1 WHERE A1.CMP_RULE_ID=A.CMP_RULE_ID))
AND NOT EXISTS (SELECT 'X' FROM PS_CMP_RULE_VALUES B WHERE B.CMP_RULE_ID=A.CMP_RULE_ID AND B.EFFDT=A.EFFDT AND B.CMP_RULE_OPER_SEQ=A.CMP_RULE_OPER_SEQ)
INSERT INTO PS_CMP_RULE_RATECD
SELECT * FROM HRINT..PS_CMP_RULE_RATECD A WHERE (A.EFFDT > {FN CURDATE()} OR A.EFFDT=(SELECT MAX(A1.EFFDT) FROM HRINT..PS_CMP_RULE_RATECD A1 WHERE A1.CMP_RULE_ID=A.CMP_RULE_ID))
AND NOT EXISTS (SELECT 'X' FROM PS_CMP_RULE_RATECD B WHERE B.CMP_RULE_ID=A.CMP_RULE_ID AND B.EFFDT=A.EFFDT)

INSERT INTO PS_JOB_FAMILY_TBL
SELECT * FROM HRINT..PS_JOB_FAMILY_TBL A WHERE A.EFFDT=(SELECT MAX(A1.EFFDT) FROM HRINT..PS_JOB_FAMILY_TBL A1 WHERE A1.JOB_FAMILY=A.JOB_FAMILY) AND NOT EXISTS (SELECT 'X' FROM PS_JOB_FAMILY_TBL B WHERE B.JOB_FAMILY=A.JOB_FAMILY)
INSERT INTO PS_HOLIDAY_TBL
SELECT * FROM HRINT..PS_HOLIDAY_TBL A WHERE NOT EXISTS (SELECT 'X' FROM PS_HOLIDAY_TBL B WHERE B.HOLIDAY_SCHEDULE=A.HOLIDAY_SCHEDULE)
INSERT INTO PS_GP_ELIG_GRP
SELECT * FROM HRINT..PS_GP_ELIG_GRP A WHERE A.EFFDT=(SELECT MAX(A1.EFFDT) FROM HRINT..PS_GP_ELIG_GRP A1 WHERE A1.ELIG_GRP=A.ELIG_GRP) AND NOT EXISTS (SELECT 'X' FROM PS_GP_ELIG_GRP B WHERE B.ELIG_GRP=A.ELIG_GRP)
INSERT INTO PS_EMPL_CLASS_TBL
SELECT * FROM HRINT..PS_EMPL_CLASS_TBL A WHERE A.EFFDT=(SELECT MAX(A1.EFFDT) FROM HRINT..PS_EMPL_CLASS_TBL A1 WHERE A1.SETID=A.SETID AND A1.EMPL_CLASS=A.EMPL_CLASS) AND NOT EXISTS (SELECT 'X' FROM PS_EMPL_CLASS_TBL B WHERE B.EMPL_CLASS=A.EMPL_CLASS)
INSERT INTO PS_COMP_RATECD_TBL
SELECT * FROM HRINT..PS_COMP_RATECD_TBL A WHERE A.EFFDT=(SELECT MAX(A1.EFFDT) FROM HRINT..PS_COMP_RATECD_TBL A1 WHERE A1.COMP_RATECD=A.COMP_RATECD) AND NOT EXISTS (SELECT 'X' FROM PS_COMP_RATECD_TBL B WHERE B.COMP_RATECD=A.COMP_RATECD)


INSERT INTO PS_SETID_TBL
SELECT * FROM HRINT..PS_SETID_TBL A WHERE NOT EXISTS (SELECT 'X' FROM PS_SETID_TBL B WHERE B.SETID=A.SETID)
INSERT INTO PS_BUS_UNIT_TBL_HR
SELECT * FROM HRINT..PS_BUS_UNIT_TBL_HR A WHERE NOT EXISTS (SELECT 'X' FROM PS_BUS_UNIT_TBL_HR B WHERE B.BUSINESS_UNIT=A.BUSINESS_UNIT) 
INSERT INTO PS_BUS_UNIT_OPT_HR
SELECT * FROM HRINT..PS_SETID_TBL
INSERT INTO PS_BUS_UNIT_OPT_HR
SELECT * FROM HRINT..PS_BUS_UNIT_OPT_HR A WHERE NOT EXISTS (SELECT 'X' FROM PS_BUS_UNIT_OPT_HR B WHERE B.SETID=A.SETID) 

INSERT INTO PS_SET_CNTRL_GROUP
SELECT * FROM HRINT..PS_SET_CNTRL_GROUP WHERE SETCNTRLVALUE='ANUID'
INSERT INTO PS_SET_CNTRL_REC
SELECT * FROM HRINT..PS_SET_CNTRL_REC WHERE SETCNTRLVALUE='ANUID'
INSERT INTO PS_SET_CNTRL_TBL
SELECT * FROM HRINT..PS_SET_CNTRL_TBL WHERE SETCNTRLVALUE IN ('ANUID','ANUGL')
INSERT INTO PS_SET_CNTRL_TREE
SELECT * FROM HRINT..PS_SET_CNTRL_TREE WHERE SETCNTRLVALUE IN ('ANUID')

INSERT INTO PS_SCH_DEFN_TBL
SELECT * FROM HRINT..PS_SCH_DEFN_TBL WHERE SETID='ANUID' AND SUBSTRING(RIGHT(SCHEDULE_ID, 5),1,3) <> '000'
INSERT INTO PS_SCH_DEFN_DTL
SELECT * FROM HRINT..PS_SCH_DEFN_DTL WHERE SETID='ANUID' AND SUBSTRING(RIGHT(SCHEDULE_ID, 5),1,3) <> '000'


UPDATE S2 
SET S2.STMT_TEXT = S1.STMT_TEXT
--SELECT * 
FROM HRINT..PS_SQLSTMT_TBL S1, PS_SQLSTMT_TBL S2
WHERE S1.PGM_NAME = S2.PGM_NAME AND S1.STMT_TYPE=S2.STMT_TYPE AND S1.STMT_NAME=S2.STMT_NAME
AND S1.STMT_TEXT <> S2.STMT_TEXT
