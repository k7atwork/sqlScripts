----------------------------
-- User Profile references a Role that does not exist
----------------------------
SELECT * FROM PSROLEUSER WHERE NOT EXISTS (SELECT 'X' FROM PSROLEDEFN R WHERE R.ROLENAME=PSROLEUSER.ROLENAME);

----------------------------
-- Role named in a User-Role relationship does not exist in the Role Definition table
----------------------------
SELECT DISTINCT ROLENAME FROM PSROLEUSER WHERE NOT EXISTS (SELECT 'X' FROM PSROLEDEFN R WHERE R.ROLENAME=PSROLEUSER.ROLENAME);

----------------------------
-- Role references a Permission List that does not exist
----------------------------
SELECT * FROM PSROLECLASS WHERE NOT EXISTS (SELECT 'X' FROM PSCLASSDEFN C WHERE C.CLASSID=PSROLECLASS.CLASSID);

----------------------------
-- OPRID references a Permission List that does not exist
----------------------------
SELECT * FROM PSOPRCLS WHERE NOT EXISTS (SELECT 'X' FROM PSCLASSDEFN C WHERE C.CLASSID=PSOPRCLS.OPRCLASS);

----------------------------
-- Row Level Security Permission List specified for user does not exist
----------------------------
SELECT * FROM PSOPRDEFN WHERE ROWSECCLASS <> ' ' AND NOT EXISTS (SELECT 'X' FROM PSCLASSDEFN C WHERE C.CLASSID=PSOPRDEFN.ROWSECCLASS);

----------------------------
-- Invalid entries in the PSAUTHITEM table
----------------------------
SELECT * FROM PSAUTHITEM WHERE NOT EXISTS (SELECT 'X' FROM PSCLASSDEFN C WHERE C.CLASSID=PSAUTHITEM.CLASSID);

----------------------------
-- Invalid entries in the PSAUTHITEM table
----------------------------
SELECT * FROM PSAUTHITEM WHERE EXISTS (SELECT 'X' FROM PSCLASSDEFN C WHERE C.CLASSID=PSAUTHITEM.CLASSID)
AND ((NOT EXISTS (SELECT 'X' FROM PSMENUITEM M, PSPNLGROUP PG WHERE PG.PNLGRPNAME=M.PNLGRPNAME AND M.MENUNAME=PSAUTHITEM.MENUNAME AND M.BARNAME=PSAUTHITEM.BARNAME AND M.ITEMNAME=PSAUTHITEM.BARITEMNAME AND PG.ITEMNAME=PSAUTHITEM.PNLITEMNAME)
     AND PSAUTHITEM.MENUNAME NOT LIKE 'WEBLIB%'
     AND PSAUTHITEM.MENUNAME <> ' ' AND PSAUTHITEM.BARNAME <> ' ' AND PSAUTHITEM.BARITEMNAME <> ' ' AND PSAUTHITEM.PNLITEMNAME <> ' ')
OR (NOT EXISTS (SELECT 'X' FROM PSPCMTXT PC WHERE PC.OBJECTVALUE1 = PSAUTHITEM.MENUNAME AND PC.OBJECTVALUE2 = PSAUTHITEM.BARNAME AND PC.OBJECTVALUE3 = PSAUTHITEM.BARITEMNAME)
     AND PSAUTHITEM.MENUNAME LIKE 'WEBLIB%'
     AND PSAUTHITEM.MENUNAME <> ' ' AND PSAUTHITEM.BARNAME <> ' ' AND PSAUTHITEM.BARITEMNAME <> ' '))
ORDER BY 1

----------------------------
-- Role Users do not have corresponding User IDs in PSOPRDEFN table
----------------------------
SELECT * FROM PS_ROLEXLATOPR WHERE NOT EXISTS (SELECT 'X' FROM PSOPRDEFN O WHERE O.OPRID=PS_ROLEXLATOPR.ROLEUSER);

----------------------------
-- OPRIDs not having corresponding Role Users in ROLEXLATOPR table
----------------------------
SELECT * FROM PSOPRDEFN WHERE NOT EXISTS (SELECT 'X' FROM PS_ROLEXLATOPR O WHERE O.ROLEUSER=PSOPRDEFN.OPRID);

----------------------------
-- Orphan App Pkg PeopleCode
----------------------------
SELECT * FROM PSPCMTXT WHERE (OBJECTVALUE3 = 'OnExecute' or OBJECTVALUE4 = 'OnExecute' or 
OBJECTVALUE5 = 'OnExecute') 
AND NOT EXISTS (SELECT 'X' FROM PSAPPCLASSDEFN AP WHERE AP.PACKAGEROOT=PSPCMTXT.OBJECTVALUE1 
AND (   (PSPCMTXT.OBJECTVALUE3 = 'OnExecute' AND AP.APPCLASSID=PSPCMTXT.OBJECTVALUE2) 
     OR (PSPCMTXT.OBJECTVALUE4 = 'OnExecute' AND AP.QUALIFYPATH=PSPCMTXT.OBJECTVALUE2 AND AP.APPCLASSID=PSPCMTXT.OBJECTVALUE3)
	 OR (PSPCMTXT.OBJECTVALUE5 = 'OnExecute' AND AP.QUALIFYPATH=PSPCMTXT.OBJECTVALUE2 + ':' + PSPCMTXT.OBJECTVALUE3 AND AP.APPCLASSID=PSPCMTXT.OBJECTVALUE4)
	 )
)


SELECT * FROM PSPCMPROG WHERE (OBJECTVALUE3 = 'OnExecute' or OBJECTVALUE4 = 'OnExecute' or 
OBJECTVALUE5 = 'OnExecute') 
AND NOT EXISTS (SELECT 'X' FROM PSAPPCLASSDEFN AP WHERE AP.PACKAGEROOT=PSPCMPROG.OBJECTVALUE1 
AND (   (PSPCMPROG.OBJECTVALUE3 = 'OnExecute' AND AP.APPCLASSID=PSPCMPROG.OBJECTVALUE2) 
     OR (PSPCMPROG.OBJECTVALUE4 = 'OnExecute' AND AP.QUALIFYPATH=PSPCMPROG.OBJECTVALUE2 AND AP.APPCLASSID=PSPCMPROG.OBJECTVALUE3)
	 OR (PSPCMPROG.OBJECTVALUE5 = 'OnExecute' AND AP.QUALIFYPATH=PSPCMPROG.OBJECTVALUE2 + ':' + PSPCMPROG.OBJECTVALUE3 AND AP.APPCLASSID=PSPCMPROG.OBJECTVALUE4)
	 )
)


SELECT * FROM PSPCMNAME WHERE (OBJECTVALUE3 = 'OnExecute' or OBJECTVALUE4 = 'OnExecute' or 
OBJECTVALUE5 = 'OnExecute') 
AND NOT EXISTS (SELECT 'X' FROM PSAPPCLASSDEFN AP WHERE AP.PACKAGEROOT=PSPCMNAME.OBJECTVALUE1 
AND (   (PSPCMNAME.OBJECTVALUE3 = 'OnExecute' AND AP.APPCLASSID=PSPCMNAME.OBJECTVALUE2) 
     OR (PSPCMNAME.OBJECTVALUE4 = 'OnExecute' AND AP.QUALIFYPATH=PSPCMNAME.OBJECTVALUE2 AND AP.APPCLASSID=PSPCMNAME.OBJECTVALUE3)
	 OR (PSPCMNAME.OBJECTVALUE5 = 'OnExecute' AND AP.QUALIFYPATH=PSPCMNAME.OBJECTVALUE2 + ':' + PSPCMNAME.OBJECTVALUE3 AND AP.APPCLASSID=PSPCMNAME.OBJECTVALUE4)
	 )
)

----------------------------
-- Row Security Permission List specified does not exist in the Permission List table
----------------------------
SELECT * FROM PSOPRDEFN WHERE ROWSECCLASS <> ' ' AND NOT EXISTS (SELECT 'X' FROM PSCLASSDEFN C WHERE C.CLASSID=PSOPRDEFN.ROWSECCLASS);

----------------------------
-- Query Definition Record name does not exist in the Record Definition table
----------------------------
SELECT * FROM PSQRYRECORD where RECNAME <> ' ' AND NOT EXISTS (SELECT 'X' FROM PSRECDEFN R WHERE R.RECNAME=PSQRYRECORD.RECNAME) ORDER BY 2
----------------------------
-- Query Field Record name does not exist in the Record Definition table
----------------------------
SELECT DISTINCT QRYNAME, RECNAME FROM PSQRYFIELD where RECNAME <> ' ' AND NOT EXISTS (SELECT 'X' FROM PSRECDEFN R WHERE R.RECNAME=PSQRYFIELD.RECNAME) ORDER BY 1
----------------------------
-- Query Definition Field name does not exist in the Field Definition table
----------------------------
SELECT QRYNAME, RECNAME, FIELDNAME FROM PSQRYFIELD where FIELDNAME <> ' ' AND NOT EXISTS (SELECT 'X' FROM PSRECFIELDDB R WHERE R.RECNAME=PSQRYFIELD.RECNAME AND R.FIELDNAME=PSQRYFIELD.FIELDNAME) ORDER BY 1,2,3
----------------------------
-- Following Queries Do Not Exist in PSQRYRECORD
----------------------------
SELECT * FROM PSQRYDEFN WHERE NOT EXISTS (SELECT 'X' FROM PSQRYRECORD R WHERE R.QRYNAME=PSQRYDEFN.QRYNAME AND EXISTS (SELECT 'X' FROM PSRECDEFN R1 WHERE R1.RECNAME=R.RECNAME)) ORDER BY 2

----------------------------
-- XMLP/BI - Query Data Source does not exist in Query Definition table
----------------------------
SELECT * FROM PSXPDATASRC WHERE DS_TYPE='QRY' AND NOT EXISTS (SELECT 'X' FROM PSQRYDEFN Q WHERE Q.QRYNAME=PSXPDATASRC.DS_ID) ORDER BY 2

----------------------------
-- Rowset based messages referencing non-existing records:
----------------------------
SELECT * FROM PSMSGREC WHERE NOT EXISTS (SELECT 'X' FROM PSRECDEFN R WHERE R.RECNAME=PSMSGREC.RECNAME)

----------------------------
-- 
----------------------------
SELECT * FROM PSSERVICEOPR WHERE NOT EXISTS (SELECT 'X' FROM PSOPERATION  O WHERE O.IB_OPERATIONNAME=PSSERVICEOPR.IB_OPERATIONNAME);

----------------------------
-- 
----------------------------
SELECT * FROM PSIBRTNGDEFN WHERE NOT EXISTS (SELECT 'X' FROM PSOPERATION  O WHERE O.IB_OPERATIONNAME=PSIBRTNGDEFN.IB_OPERATIONNAME)
----------------------------
-- 
----------------------------
SELECT * FROM PSIBRTNGDEFN WHERE ((SENDERNODENAME <> '~~ANY~~' AND NOT EXISTS (SELECT 'X' FROM PSMSGNODEDEFN M WHERE M.MSGNODENAME=PSIBRTNGDEFN.SENDERNODENAME))
                             OR (RECEIVERNODENAME <> '~~ANY~~' AND NOT EXISTS (SELECT 'X' FROM PSMSGNODEDEFN M WHERE M.MSGNODENAME=PSIBRTNGDEFN.RECEIVERNODENAME)))
----------------------------
-- 
----------------------------
SELECT * FROM PSMSGNODEDEFN WHERE NOT EXISTS (SELECT 'X' FROM PSGATEWAY G WHERE G.CONNGATEWAYID= PSMSGNODEDEFN.CONNGATEWAYID)
----------------------------
-- 
----------------------------

SELECT * FROM PSADSDEFNITEM WHERE NOT EXISTS (SELECT 'X' FROM PSRECDEFN R WHERE R.RECNAME=PSADSDEFNITEM.RECNAME)

SELECT * FROM PSADSDEFNITEM WHERE PTPARENTRECNAME <> ' '  AND NOT EXISTS (SELECT 'X' FROM PSRECDEFN R WHERE R.RECNAME=PSADSDEFNITEM.PTPARENTRECNAME)

----------------------------
-- Service Configuration is missing the following Service Definitions
----------------------------
SELECT C.* FROM PSPTCSSRVCONF C, PSPTCS_SRVCFG S where C.PORTAL_NAME=S.PORTAL_NAME AND C.PORTAL_OBJNAME=S.PORTAL_OBJNAME
AND NOT EXISTS (SELECT 'X' FROM PSPTCSSRVDEFN SD WHERE SD.PTCS_SERVICEID=C.PTCS_SERVICEID)
----------------------------
-- Missing Application packages for Service Definitions
----------------------------
SELECT * FROM PSPTCSSRVDEFN WHERE PTCS_SERVICEURLTYP='UAPC' AND NOT EXISTS (SELECT 'X' FROM PSAPPCLASSDEFN AC WHERE AC.PACKAGEROOT=PSPTCSSRVDEFN.PACKAGEROOT AND AC.QUALIFYPATH=PSPTCSSRVDEFN.QUALIFYPATH AND AC.APPCLASSID=PSPTCSSRVDEFN.APPCLASSID)
----------------------------
-- 
----------------------------
