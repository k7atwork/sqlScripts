UPDATE PS_EOAW_USERINST SET EOAWSTEP_STATUS='P', EOAWDTTM_MODIFIED=DTTM_CREATED	WHERE EOAWUSTEP_INST_ID IN (4673522,4673523) and EOAWSTEP_STATUS='A'
UPDATE PS_EOAW_STEPINST SET EOAWSTEP_STATUS='P' WHERE EOAWTHREAD_ID IN (2,3) AND EOAWSTEP_INSTANCE IN (4658380, 4658381) and EOAWSTEP_STATUS='A'
UPDATE PS_HR_MSS_CT_XREF SET EOAWTHREAD_STATUS='P' WHERE EOAWTHREAD_ID IN (2,3) and EOAWTHREAD_STATUS='A'

DELETE FROM PS_HR_MSS_CT_STA WHERE HR_WF_ACTION='APV'
UPDATE PS_HR_MSS_CT_DAT SET WF_STATUS='I', SS_STAT_INDICATOR = 'I' WHERE EMPLID IN ('1032984','1024583') AND WF_STATUS='A' AND SS_STAT_INDICATOR = 'A'

UPDATE PSWORKLIST SET INSTSTATUS=0 , INSTWORKEDDTTM = NULL, DO_REPLICATE_FLAG=' ', LASTUPDDTTM = NULL WHERE ORIGINATORID = 'SS_U1000189' AND INSTAVAILABLEDTTM > '2021-05-01' AND INSTSTATUS=2 AND INSTWORKEDDTTM IS NOT NULL
UPDATE PS_EOAW_SUMM_DTL SET EOAWUSTEP_STATUS='P', EOAWPREV_STATUS=' ' WHERE EOAWPRCS_ID IN ('GSSReportingChgEmployee','GSSGroupUpdate') AND EOAWTHREAD_ID IN (2,3) and EOAWUSTEP_STATUS='A'
UPDATE PS_EOAW_SUMMARY SET LASTUPDDTTM=CREATEDTTM, EOAWTHREAD_STATUS='P' WHERE EOAWPRCS_ID IN ('GSSReportingChgEmployee','GSSGroupUpdate') AND EOAWTHREAD_ID IN (2,3) and EOAWTHREAD_STATUS='A'
