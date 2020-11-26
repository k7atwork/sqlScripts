--===============================================================================================================================
SELECT * FROM PS_ANU_SS_REIMBURS
--UPDATE PS_ANU_SS_REIMBURS SET CLAIM_ID=1
--DELETE FROM PS_ANU_SS_REIMBURS

SELECT * FROM PS_ANU_SS_RIMB_DTL
--UPDATE PS_ANU_SS_RIMB_DTL SET CLAIM_ID=1
--DELETE FROM PS_ANU_SS_RIMB_DTL WHERE INVOICE_ID=' '

SELECT * FROM PS_ANU_ID_COUNTERS
--INSERT INTO PS_ANU_ID_COUNTERS VALUES ('ESS_CLAIM_ID',0)
--update PS_ANU_ID_COUNTERS set LASTGEN_KEY=0

SELECT * FROM PS_ANU_SS_RIMB_ATT --where ATTACHSYSFILENAME='20201008_12130400_8.pdf'
--DELETE FROM PS_ANU_SS_RIMB_ATT

SELECT * FROM PS_ANU_SS_F_ATTACH --where ATTACHSYSFILENAME='20201008_12130400_8.pdf'
--DELETE FROM PS_ANU_SS_F_ATTACH

SELECT * FROM 
--DELETE
PS_ANU_SS_F_ATTACH
WHERE NOT EXISTS (SELECT 'X' FROM PS_ANU_SS_RIMB_DTL LA WHERE LA.ATTACHSYSFILENAME=PS_ANU_SS_F_ATTACH.ATTACHSYSFILENAME)
  AND NOT EXISTS (SELECT 'X' FROM PS_ANU_SS_RIMB_ATT HA WHERE HA.ATTACHSYSFILENAME=PS_ANU_SS_F_ATTACH.ATTACHSYSFILENAME)

SELECT * FROM 
--DELETE
PS_ANU_SS_RIMB_ATT
--WHERE NOT EXISTS (SELECT 'X' FROM PS_ANU_SS_F_ATTACH A WHERE A.ATTACHSYSFILENAME=PS_ANU_SS_RIMB_ATT.ATTACHSYSFILENAME)

SELECT * FROM 
--DELETE
PS_ANU_SS_RIMB_DTL
--WHERE ATTACHSYSFILENAME <> ' '
--AND NOT EXISTS (SELECT 'X' FROM PS_ANU_SS_F_ATTACH A WHERE A.ATTACHSYSFILENAME=PS_ANU_SS_RIMB_DTL.ATTACHSYSFILENAME)
SELECT * FROM PS_ANU_OCR_AF_HVW WHERE KOFAX_KEY='S0000004'

--===============================================================================================================================

SELECT * 
--DELETE
FROM PS_ANU_OCR_INVOICE WHERE KOFAX_KEY='S0000004'

SELECT * 
--DELETE
FROM PS_ANU_OCR_LINES WHERE KOFAX_KEY='S0000004'

SELECT * 
--DELETE 
FROM PS_ANU_OCR_DISTRIB WHERE KOFAX_KEY='S0000004'

SELECT *
--DELETE 
FROM PS_PV_ATTACHMENTS WHERE SCM_ATTACH_ID IN (SELECT SCM_ATTACH_ID FROM PS_ANU_OCR_ATT WHERE KOFAX_KEY='S0000004')

SELECT *
--DELETE 
FROM PS_ANU_OCR_ATT WHERE KOFAX_KEY='S0000004'

SELECT * 
--DELETE
FROM PS_EOAW_USERINST WHERE EOAWSTEP_INSTANCE IN 
(SELECT EOAWSTEP_INSTANCE FROM PS_EOAW_STEPINST WHERE EOAWTHREAD_ID IN (SELECT EOAWTHREAD_ID FROM PS_ANU_OCR_AF_XREF WHERE KOFAX_KEY='S0000004') AND EOAWPRCS_ID='ANU_OCR_Workflow') 

SELECT * 
--DELETE
FROM PS_EOAW_STEPINST WHERE EOAWTHREAD_ID IN (SELECT EOAWTHREAD_ID FROM PS_ANU_OCR_AF_XREF WHERE KOFAX_KEY='S0000004')  AND EOAWPRCS_ID='ANU_OCR_Workflow'

SELECT * 
--DELETE
FROM PS_EOAW_COMMENTS WHERE EOAWTHREAD_ID IN (SELECT EOAWTHREAD_ID FROM PS_ANU_OCR_AF_XREF WHERE KOFAX_KEY='S0000004')  AND EOAWPRCS_ID='ANU_OCR_Workflow'

SELECT * 
--DELETE
FROM PS_ANU_OCR_AF_XREF WHERE KOFAX_KEY='S0000004'

--===============================================================================================================================
