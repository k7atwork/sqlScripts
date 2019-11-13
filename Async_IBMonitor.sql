SELECT H.*, S.* FROM PSAPMSGSUBCN_VW S, PSIBPUBHDR_VW H 
WHERE S.IB_OPERATIONNAME='ANU_ERMS_CREATE_FOLDER_ASYNC' 
AND S.SUBCONSTATUS <> H.PUBSTATUS
AND S.IBPUBTRANSACTID=H.IBTRANSACTIONID
AND H.IB_OPERATIONNAME=S.IB_OPERATIONNAME
AND S.LASTUPDDTTM > DATEADD(HOUR, 2, H.LASTUPDDTTM)
ORDER BY H.LASTUPDDTTM DESC
