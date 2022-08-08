--
--Compare Projects
--
SELECT * FROM PSPROJECTDEFN WHERE PROJECTNAME LIKE 'ANU_HRINT_PDMO_CMPR_00%';

--
--Total Objects in the Projects
--
SELECT COUNT(1) FROM PSPROJECTITEM WHERE PROJECTNAME IN (SELECT PROJECTNAME FROM PSPROJECTDEFN WHERE PROJECTNAME LIKE 'ANU_HRINT_PDMO_CMPR_00%');

--
--Total Objects in each Project
--
SELECT PROJECTNAME, COUNT(1) FROM PSPROJECTITEM WHERE PROJECTNAME IN (SELECT PROJECTNAME FROM PSPROJECTDEFN WHERE PROJECTNAME LIKE 'ANU_HRINT_PDMO_CMPR_00%') GROUP BY PROJECTNAME;

--
--Total/Distinct Objects in the Projects
--
select COUNT(1) from (
SELECT --OBJECTTYPE, OBJECTID1, OBJECTVALUE1, OBJECTID2, OBJECTVALUE2, OBJECTID3, OBJECTVALUE3, OBJECTID4, OBJECTVALUE4, NODETYPE, SOURCESTATUS, TARGETSTATUS, UPGRADEACTION, TAKEACTION, COPYDONE 
DISTINCT OBJECTTYPE, OBJECTID1, OBJECTVALUE1, OBJECTID2, OBJECTVALUE2, OBJECTID3, OBJECTVALUE3, OBJECTID4, OBJECTVALUE4
--COUNT(1)
FROM PSPROJECTITEM WHERE PROJECTNAME IN (SELECT PROJECTNAME FROM PSPROJECTDEFN WHERE PROJECTNAME LIKE 'ANU_HRINT_PDMO_CMPR_00%')-- and PROJECTNAME NOT LIKE 'ANU_HRINT_CMPR_0011A%')
) A

--
--Temp table with Object Type description
--
--SELECT * FROM #ANU_OBJTYP_TBL
/* SELECT * FROM PS_PTOBJECTTYPES ORDER BY 1

SELECT * INTO #ANU_OBJTYP_TBL FROM PS_PTOBJECTTYPES ORDER BY 1
DELETE FROM #ANU_OBJTYP_TBL

INSERT INTO #ANU_OBJTYP_TBL VALUES ('0','Record');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('1','Index');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('2','Field');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('3','Field Format');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('4','Translate Value');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('5','Page');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('6','Menu');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('7','Component');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('8','Record PeopleCode');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('9','Menu PeopleCode');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('10','Query');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('11','Tree Structure');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('12','Tree');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('13','Access Group');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('14','Color');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('15','Style');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('16','Not Used');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('17','Business Process');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('18','Activity');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('19','Roles');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('20','Process Definitions');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('21','Servers');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('22','Process Types');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('23','Job Definitions');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('24','Recurrences');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('25','Message Catalog');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('26','Dimension');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('27','Cube Definition');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('28','Cube Instance');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('29','Business Interlink');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('30','SQL');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('31','File Layout');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('32','Component Interface');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('33','Application Engine Program');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('34','Application Engine Section');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('35','Message Node');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('36','Message Channel');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('37','Message');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('38','Approval Rule Set');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('39','Message PeopleCode');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('40','Subscription PeopleCode');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('41','Not Used');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('42','Component Interface PeopleCode');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('43','Application Engine PeopleCode');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('44','Page PeopleCode');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('45','Page Field PeopleCode');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('46','Component PeopleCode');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('47','Component Record PeopleCode');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('48','Component Rec Field PeopleCode');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('49','Image');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('50','Style Sheet');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('51','HTML');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('52','Not Used');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('53','Permission List');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('54','Portal Registry Definition');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('55','Portal Registry Structure');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('56','URL Definition');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('57','Application Package');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('58','Application Package PeopleCode');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('59','Portal Registry User Homepage');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('60','Analytic Type');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('61','Archive Template');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('62','XSLT');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('63','Portal Registry User Favorite');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('64','Mobile Page');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('65','Relationships');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('66','Component Interface Property PeopleCode');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('67','Optimization Model');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('68','File References');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('69','File Type Codes');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('70','Archive Object');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('71','Archive Templates (Type 2)');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('72','Diagnostic Plug-ins');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('73','Analytic Model');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('74','Not Used');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('75','Java Portlet User Preferences');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('76','WSRP Remote Producers');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('77','WSRP Remote Portlets');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('78','WSRP Cloned Portlet Handles');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('79','Service');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('80','Service Operation');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('81','Service Operation Handler');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('82','Service Operation Version');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('83','Service Operation Routing');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('84','IB Queues');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('85','BIP Template Definition');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('86','BIP Report Definition');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('87','BIP File Definition');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('88','BIP Data Source Definitions');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('89','WSDL');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('90','Message Schema');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('91','Connected Query');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('92','Logical Schema');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('93','XML Schema');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('94','Relational Schema');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('95','Dependency Document');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('96','Document Schema');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('97','Essbase Cube Dimension');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('98','Essbase Cube Outline');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('99','Essbase Cube Connection');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('100','Essbase Cube Template');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('101','Delimited Schema');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('102','Positional Schema');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('103','Data Set Definition');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('104','Test');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('105','Test Case');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('106','Application Data Set Binding');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('107','Feed Definition');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('108','Feed Category');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('109','Feed Data Type');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('110','JSON Document');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('111','Related Content Definition');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('112','Related Content Services');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('113','Related Content Configuration');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('114','Related Content Layout');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('115','Search Attribute');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('116','Search Definition');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('117','Search Category');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('118','Search Context');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('119','Integration Group');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('120','XML Documents');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('121','MAP Layouts');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('122','MAP Template');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('123','Composite Query');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('125','MAP Admin');
INSERT INTO #ANU_OBJTYP_TBL VALUES ('126','MAP Store');

*/

--
--Object compare report/summary 
--
SELECT COUNT(1) FROM (
SELECT --P.OBJECTTYPE, OBJECTID1, OBJECTVALUE1, OBJECTID2, OBJECTVALUE2, OBJECTID3, OBJECTVALUE3, OBJECTID4, OBJECTVALUE4, NODETYPE, SOURCESTATUS, TARGETSTATUS, UPGRADEACTION, TAKEACTION, COPYDONE, O.PTOBJECTTYPETEXT 
DISTINCT O.PTOBJECTTYPETEXT, P.OBJECTTYPE, OBJECTID1, OBJECTVALUE1, OBJECTID2, OBJECTVALUE2, OBJECTID3, OBJECTVALUE3, OBJECTID4, OBJECTVALUE4, SOURCESTATUS, TARGETSTATUS, UPGRADEACTION
, CASE WHEN SOURCESTATUS='0' THEN 'Unknown'
       WHEN SOURCESTATUS='1' THEN 'Absent'
	   WHEN SOURCESTATUS='2' THEN 'Changed'
	   WHEN SOURCESTATUS='3' THEN 'Unchanged'
	   WHEN SOURCESTATUS='4' THEN '*Changed'
	   WHEN SOURCESTATUS='5' THEN '*Unchanged'
	   WHEN SOURCESTATUS='6' THEN 'Same'
	   ELSE 'Other' END SOURCE_STATUS
, CASE WHEN TARGETSTATUS='0' THEN 'Unknown'
       WHEN TARGETSTATUS='1' THEN 'Absent'
	   WHEN TARGETSTATUS='2' THEN 'Changed'
	   WHEN TARGETSTATUS='3' THEN 'Unchanged'
	   WHEN TARGETSTATUS='4' THEN '*Changed'
	   WHEN TARGETSTATUS='5' THEN '*Unchanged'
	   WHEN TARGETSTATUS='6' THEN 'Same'
	   ELSE 'Other' END TARGET_STATUS
, CASE WHEN SOURCESTATUS IN ('2','3') AND TARGETSTATUS IN ('2','3') THEN 'PeopleSoft Modified'
       WHEN SOURCESTATUS IN ('2','3') AND TARGETSTATUS IN ('1') THEN 'PeopleSoft Deleted'
	   WHEN SOURCESTATUS IN ('1') AND TARGETSTATUS IN ('2','3') THEN 'PeopleSoft Added'
       WHEN SOURCESTATUS IN ('4','5') AND TARGETSTATUS IN ('1') THEN 'Customer Added'
	   WHEN SOURCESTATUS IN ('4','5') AND TARGETSTATUS IN ('2','3') THEN 'Customer Modified'
	   else 'Investigate' END ORIENTATION
FROM PSPROJECTITEM P
, #ANU_OBJTYP_TBL O
WHERE PROJECTNAME IN (SELECT PROJECTNAME FROM PSPROJECTDEFN WHERE PROJECTNAME LIKE 'ANU_HRINT_PDMO_CMPR_00%')
--AND NOT ((SOURCESTATUS = '6' AND UPGRADEACTION = '2')) --SAME/SAME
--AND (SOURCESTATUS IN ('2','3') AND TARGETSTATUS IN ('2','3')) -- PSOFT Changed
--AND (SOURCESTATUS IN ('4','5') AND TARGETSTATUS IN ('2','3')) -- Customer Changed
--AND (SOURCESTATUS IN ('4','5') AND TARGETSTATUS IN ('1')) -- Customer Objects
AND (SOURCESTATUS IN ('0') AND TARGETSTATUS IN ('0'))
AND O.OBJECTTYPE=P.OBJECTTYPE
) A

--
-- 1. Split Project if compare is slow.
--
--INSERT INTO PSPROJECTDEFN
SELECT 'ANU_HRINT_PDMO_CMPR_0009B', VERSION, PROJECTDESCR, TGTSERVERNAME, TGTDBNAME, TGTOPRID, TGTOPRACCT, COMPRELEASE, SRCCOMPRELDTTM, TGTCOMPRELDTTM, COMPRELDTTM, KEEPTGT, TGTORIENTATION, COMPARETYPE, COMMITLIMIT, REPORTFILTER, MAINTPROJ, LASTUPDDTTM, LASTUPDOPRID, RELEASELABEL, RELEASEDTTM, OBJECTOWNERID, DESCRLONG
 FROM PSPROJECTDEFN WHERE PROJECTNAME = 'ANU_HRINT_PDMO_CMPR_0009A'

--
-- 2. Split Project if compare is slow.
--
--INSERT INTO PSPROJECTITEM
SELECT 'ANU_HRINT_PDMO_CMPR_0009B', OBJECTTYPE, OBJECTID1, OBJECTVALUE1, OBJECTID2, OBJECTVALUE2, OBJECTID3, OBJECTVALUE3, OBJECTID4, OBJECTVALUE4, NODETYPE, SOURCESTATUS, TARGETSTATUS, UPGRADEACTION, TAKEACTION, COPYDONE
 FROM PSPROJECTITEM WHERE PROJECTNAME = 'ANU_HRINT_PDMO_CMPR_0009A' AND SOURCESTATUS='0' AND TARGETSTATUS='0'

--
-- Delete from Parent project once child is created.
--
--DELETE
--SELECT PSPROJECTITEM.* 
FROM PSPROJECTITEM WHERE PSPROJECTITEM.PROJECTNAME = 'ANU_HRINT_PDMO_CMPR_0009A' AND SOURCESTATUS='0' AND TARGETSTATUS='0'
AND EXISTS (SELECT 'X' FROM PSPROJECTITEM B WHERE B.PROJECTNAME='ANU_HRINT_PDMO_CMPR_0009B' 
AND B.OBJECTTYPE=PSPROJECTITEM.OBJECTTYPE 
AND B.OBJECTID1=PSPROJECTITEM.OBJECTID1 AND B.OBJECTVALUE1=PSPROJECTITEM.OBJECTVALUE1
AND B.OBJECTID2=PSPROJECTITEM.OBJECTID2 AND B.OBJECTVALUE2=PSPROJECTITEM.OBJECTVALUE2
AND B.OBJECTID3=PSPROJECTITEM.OBJECTID3 AND B.OBJECTVALUE3=PSPROJECTITEM.OBJECTVALUE3
AND B.OBJECTID4=PSPROJECTITEM.OBJECTID4 AND B.OBJECTVALUE4=PSPROJECTITEM.OBJECTVALUE4)

0 = Unknown
1 = Absent
2 = Changed
3 = Unchanged
4 = *Changed
5 = *Unchanged
6 = Same


0 = Copy
1 = Delete
2 = None
3 = CopyProp
