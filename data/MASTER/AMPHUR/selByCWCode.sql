SELECT AMPHUR_CODE, AMPHUR_DESCRIPTION
FROM common.dbo.AMPHUR_TUMBON
WHERE  CHANGWAT_CODE = @CHANGWAT_CODE
GROUP BY AMPHUR_CODE, AMPHUR_DESCRIPTION
ORDER BY AMPHUR_CODE, AMPHUR_DESCRIPTION

