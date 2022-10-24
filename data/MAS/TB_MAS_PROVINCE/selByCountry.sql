

SELECT [PROVINCE_SEQ], 
    [PROVINCE_ID], [PROVINCE_ABBR], 
    [PROVINCE_NAME_TH], [PROVINCE_NAME_EN], 
    [COUNTRY_SEQ], 
    [PROVINCE_NOTE], 
    [RECORD_STATUS], 
    [CREATE_USER], [CREATE_DTM], [LAST_UPD_USER], [LAST_UPD_DTM] 
FROM [common].[dbo].[TB_MAS_PROVINCE] 
WHERE 1 = 1 
    AND [COUNTRY_SEQ] = @COUNTRY_SEQ 
ORDER BY [PROVINCE_ID] ASC, [PROVINCE_NAME_TH] ASC, [PROVINCE_NAME_EN] ASC 


