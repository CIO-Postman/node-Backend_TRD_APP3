SELECT CHANGWAT_CODE, CHANGWAT_NAME
FROM common.dbo.CHANGWAT_BRANCH
GROUP BY CHANGWAT_CODE, CHANGWAT_NAME
ORDER BY CHANGWAT_CODE, CHANGWAT_NAME