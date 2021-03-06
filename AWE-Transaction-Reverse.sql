/*--------*/
/* UPDATE */
/*--------*/

UPDATE PS_EOAW_USERINST SET EOAWSTEP_STATUS='P', EOAWDTTM_MODIFIED=DTTM_CREATED	WHERE EOAWUSTEP_INST_ID IN (4673522,4673523) and EOAWSTEP_STATUS='A'
UPDATE PS_EOAW_STEPINST SET EOAWSTEP_STATUS='P' WHERE EOAWTHREAD_ID IN (2,3) AND EOAWSTEP_INSTANCE IN (4658380, 4658381) and EOAWSTEP_STATUS='A'
UPDATE PS_HR_MSS_CT_XREF SET EOAWTHREAD_STATUS='P' WHERE EOAWTHREAD_ID IN (2,3) and EOAWTHREAD_STATUS='A'

DELETE FROM PS_HR_MSS_CT_STA WHERE HR_WF_ACTION='APV'
UPDATE PS_HR_MSS_CT_DAT SET WF_STATUS='I', SS_STAT_INDICATOR = 'I' WHERE EMPLID IN ('1032984','1024583') AND WF_STATUS='A' AND SS_STAT_INDICATOR = 'A'

UPDATE PSWORKLIST SET INSTSTATUS=0 , INSTWORKEDDTTM = NULL, DO_REPLICATE_FLAG=' ', LASTUPDDTTM = NULL WHERE ORIGINATORID = 'SS_U1000189' AND INSTAVAILABLEDTTM > '2021-05-01' AND INSTSTATUS=2 AND INSTWORKEDDTTM IS NOT NULL
UPDATE PS_EOAW_SUMM_DTL SET EOAWUSTEP_STATUS='P', EOAWPREV_STATUS=' ' WHERE EOAWPRCS_ID IN ('GSSReportingChgEmployee','GSSGroupUpdate') AND EOAWTHREAD_ID IN (2,3) and EOAWUSTEP_STATUS='A'
UPDATE PS_EOAW_SUMMARY SET LASTUPDDTTM=CREATEDTTM, EOAWTHREAD_STATUS='P' WHERE EOAWPRCS_ID IN ('GSSReportingChgEmployee','GSSGroupUpdate') AND EOAWTHREAD_ID IN (2,3) and EOAWTHREAD_STATUS='A'

/*--------*/
/* SELECT */
/*--------*/
SELECT  D.* FROM PS_HR_MSS_CT_DAT D
SELECT DX.* FROM PS_HR_MSS_CT_DAT_X DX
SELECT  M.* FROM PS_HR_MSS_CT_MULTI M
SELECT  S.* FROM PS_HR_MSS_CT_STA S

SELECT X.* FROM PS_HR_MSS_CT_XREF X WHERE X.EOAWTHREAD_STATUS='P'
SELECT S.* FROM PS_EOAW_STEPINST S, PS_HR_MSS_CT_XREF X WHERE S.EOAWTHREAD_ID=X.EOAWTHREAD_ID AND S.EOAWPRCS_ID=X.EOAWPRCS_ID AND S.EOAWDEFN_ID=X.EOAWDEFN_ID AND X.EOAWTHREAD_STATUS='P' --AND S.EOAWSTEP_STATUS='P'
SELECT U.* FROM PS_EOAW_USERINST U, PS_EOAW_STEPINST S, PS_HR_MSS_CT_XREF X WHERE S.EOAWTHREAD_ID=X.EOAWTHREAD_ID AND S.EOAWPRCS_ID=S.EOAWPRCS_ID AND S.EOAWDEFN_ID=X.EOAWDEFN_ID AND X.EOAWTHREAD_STATUS='P' --AND S.EOAWSTEP_STATUS='P'
                                                                            AND U.EOAWSTEP_INSTANCE=S.EOAWSTEP_INSTANCE

SELECT S.* FROM PS_EOAW_SUMMARY S, PS_HR_MSS_CT_XREF X WHERE S.EOAWTHREAD_ID=X.EOAWTHREAD_ID AND S.EOAWPRCS_ID=X.EOAWPRCS_ID AND X.EOAWTHREAD_STATUS='P'
SELECT S.* FROM PS_EOAW_SUMM_HDR S, PS_HR_MSS_CT_XREF X WHERE S.EOAWPRCS_ID=X.EOAWPRCS_ID AND X.EOAWTHREAD_STATUS='P'
SELECT S.* FROM PS_EOAW_SUMM_DTL S, PS_HR_MSS_CT_XREF X WHERE S.EOAWTHREAD_ID=X.EOAWTHREAD_ID AND S.EOAWPRCS_ID=X.EOAWPRCS_ID AND X.EOAWTHREAD_STATUS='P'

SELECT ID.* FROM PS_EOAW_IDS ID WHERE EOAWCOUNTERNAME='HR_MSS_CT_XREF'

SELECT  W.* FROM PS_EOAW_WL W, PS_HR_MSS_CT_XREF X WHERE W.EOAWTHREAD_ID=X.EOAWTHREAD_ID AND W.EOAWPRCS_ID=X.EOAWPRCS_ID AND W.EOAWDEFN_ID=X.EOAWDEFN_ID AND X.EOAWTHREAD_STATUS='P'
SELECT WL.* FROM PSWORKLIST WL, PS_EOAW_WL W, PS_HR_MSS_CT_XREF X WHERE W.EOAWTHREAD_ID=X.EOAWTHREAD_ID AND W.EOAWPRCS_ID=X.EOAWPRCS_ID AND W.EOAWDEFN_ID=X.EOAWDEFN_ID AND X.EOAWTHREAD_STATUS='P'
                                                               AND WL.INSTANCEID=W.INSTANCEID AND WL.BUSPROCNAME=W.BUSPROCNAME AND WL.ACTIVITYNAME=W.ACTIVITYNAME AND WL.EVENTNAME=W.EVENTNAME AND WL.WORKLISTNAME=W.WORKLISTNAME


/*--------*/
/* DELETE */
/*--------*/
DELETE FROM PSWORKLIST WHERE EXISTS (SELECT 'X' FROM PS_EOAW_WL W, PS_HR_MSS_CT_XREF X WHERE W.EOAWTHREAD_ID=X.EOAWTHREAD_ID AND W.EOAWPRCS_ID=X.EOAWPRCS_ID AND W.EOAWDEFN_ID=X.EOAWDEFN_ID 
                                                               AND PSWORKLIST.INSTANCEID=W.INSTANCEID AND PSWORKLIST.BUSPROCNAME=W.BUSPROCNAME AND PSWORKLIST.ACTIVITYNAME=W.ACTIVITYNAME AND PSWORKLIST.EVENTNAME=W.EVENTNAME 
															   AND PSWORKLIST.WORKLISTNAME=W.WORKLISTNAME)
DELETE FROM PS_EOAW_WL WHERE EXISTS (SELECT 'X' FROM PS_HR_MSS_CT_XREF X WHERE PS_EOAW_WL.EOAWTHREAD_ID=X.EOAWTHREAD_ID AND PS_EOAW_WL.EOAWPRCS_ID=X.EOAWPRCS_ID AND PS_EOAW_WL.EOAWDEFN_ID=X.EOAWDEFN_ID)

UPDATE PS_EOAW_IDS SET EOAWCOUNTER=0 WHERE EOAWCOUNTERNAME='HR_MSS_CT_XREF'

DELETE FROM PS_EOAW_SUMM_DTL WHERE EXISTS (SELECT 'X' FROM PS_HR_MSS_CT_XREF X WHERE PS_EOAW_SUMM_DTL.EOAWTHREAD_ID=X.EOAWTHREAD_ID AND PS_EOAW_SUMM_DTL.EOAWPRCS_ID=X.EOAWPRCS_ID)
DELETE FROM PS_EOAW_SUMMARY  WHERE EXISTS (SELECT 'X' FROM PS_HR_MSS_CT_XREF X WHERE PS_EOAW_SUMMARY.EOAWTHREAD_ID=X.EOAWTHREAD_ID AND PS_EOAW_SUMMARY.EOAWPRCS_ID=X.EOAWPRCS_ID)


DELETE FROM PS_EOAW_USERINST WHERE EXISTS (SELECT 'X' FROM PS_EOAW_STEPINST S, PS_HR_MSS_CT_XREF X WHERE S.EOAWTHREAD_ID=X.EOAWTHREAD_ID AND S.EOAWPRCS_ID=S.EOAWPRCS_ID AND S.EOAWDEFN_ID=X.EOAWDEFN_ID
                                                                            AND PS_EOAW_USERINST.EOAWSTEP_INSTANCE=S.EOAWSTEP_INSTANCE)
DELETE FROM PS_EOAW_STEPINST WHERE EXISTS (SELECT 'X' FROM PS_HR_MSS_CT_XREF X WHERE PS_EOAW_STEPINST.EOAWTHREAD_ID=X.EOAWTHREAD_ID AND PS_EOAW_STEPINST.EOAWPRCS_ID=X.EOAWPRCS_ID AND PS_EOAW_STEPINST.EOAWDEFN_ID=X.EOAWDEFN_ID)

DELETE FROM PS_HR_MSS_CT_XREF 

DELETE FROM PS_HR_MSS_CT_DAT 
DELETE FROM PS_HR_MSS_CT_DAT_X 
DELETE FROM PS_HR_MSS_CT_MULTI
DELETE FROM PS_HR_MSS_CT_STA
