BEGIN TRAN
    UPDATE TDASSET_FORMER.tdadmin.PARCEL_REL_47 
    SET VALUATION_MANUAL_ = TJOIN.SUM_ST_VALUE ,
    DEPTH_R_ = NULL ,
    VAL_PER_WAH_ = 100
    FROM TDASSET_FORMER.tdadmin.PARCEL_REL_47  TMAS 
    LEFT OUTER JOIN (
        SELECT BRANCH_CODE , PARCEL_RN , DEPTH_GROUP , SUM(ST_VALUE) SUM_ST_VALUE FROM (
        SELECT
        ROW_NUMBER() OVER(PARTITION BY T2.PARCEL_RN , T2.DEPTH_GROUP ORDER BY T2.ST_VALUE DESC ) ROW_NUMS ,
        T2.BRANCH_CODE ,
        T2.PARCEL_RN ,
        T2.DEPTH_R ,
        ISNULL(T2.DEPTH_GROUP,0) DEPTH_GROUP ,
        T2.TABLE_NO ,
        T2.SUB_TABLE_NO ,
        T2.ST_VALUE 
        FROM TDASSET_FORMER.tdadmin.PARCEL_47_10 T1 
        LEFT OUTER JOIN TDASSET_FORMER.tdadmin.PARCEL_REL_47 T2 
        ON T1.BRANCH_CODE = T2.BRANCH_CODE 
        AND T1.PARCEL_RN = T2.PARCEL_RN
        WHERE T1.BRANCH_CODE = @BRANCH_CODE
        AND T1.PARCEL_RN = @PARCEL_RN ) T1
        WHERE DEPTH_GROUP > 0 OR ( DEPTH_GROUP = 0 AND ROW_NUMS = 1)
        GROUP BY  BRANCH_CODE , PARCEL_RN , DEPTH_GROUP
        ) TJOIN 
        ON TMAS.BRANCH_CODE = TJOIN.BRANCH_CODE 
        AND TMAS.PARCEL_RN = TJOIN.PARCEL_RN 
        AND ISNULL(TMAS.DEPTH_GROUP,0) = TJOIN.DEPTH_GROUP
        WHERE TMAS.BRANCH_CODE = TJOIN.BRANCH_CODE 
        AND TMAS.PARCEL_RN = TJOIN.PARCEL_RN 
        AND ISNULL(TMAS.DEPTH_GROUP,0) = TJOIN.DEPTH_GROUP
    
    COMMIT TRAN
    
    BEGIN TRAN
    UPDATE TDASSET_FORMER.tdadmin.PARCEL_REL_47 
    SET DEPTH_R_ = TJOIN.DEPTH_R_
    FROM TDASSET_FORMER.tdadmin.PARCEL_REL_47 TMAS
    LEFT OUTER JOIN (
        SELECT OBJECTID , PARCEL_RN , DEPTH_R ,
        ST_VALUE ,
        VALUATION_MANUAL_ ,
        CASE 
		 WHEN ISNULL(ST_VALUE,0) <> 0 AND ISNULL (VALUATION_MANUAL_,0) <> 0  THEN CAST ( ( CAST(ST_VALUE as float ) / CAST(VALUATION_MANUAL_ AS float ) ) * DEPTH_R AS INT ) 
		 ELSE DEPTH_R	
		 END DEPTH_R_ FROM TDASSET_FORMER.tdadmin.PARCEL_REL_47
        WHERE BRANCH_CODE =@BRANCH_CODE
        AND PARCEL_RN = @PARCEL_RN
        AND ( (ISNULL(DEPTH_GROUP,0)=0 AND ST_VALUE = VALUATION_MANUAL_ ) OR (ISNULL(DEPTH_GROUP,0) <> 0 ) ) ) TJOIN 
    ON TMAS.OBJECTID = TJOIN.OBJECTID
    WHERE TMAS.OBJECTID = TJOIN.OBJECTID
    COMMIT TRAN
  UPDATE TDASSET_FORMER.tdadmin.PARCEL_47_10
    SET VAL_PER_WAH_ = TJOIN.VAL_PER_WAH_ ,
    VAL_PER_WAH = TJOIN.VAL_PER_WAH
    FROM TDASSET_FORMER.tdadmin.PARCEL_47_10 TMAS 
    LEFT OUTER JOIN (
    SELECT BRANCH_CODE , PARCEL_RN , LOWEST_PRICE , SUM(VAL_PER_WAH_)/COUNT(1) AS VAL_PER_WAH_ , MAX(STREET_VALUE) STREET_VALUE ,
    CASE 
	WHEN ISNULL(BLOCK_FIX_RN,0) = 0 AND TABLE_NO = 2 THEN LOWEST_PRICE
	WHEN TABLE_NO = 7 THEN land.dbo.LOWPRICE_TRUNC(SUM(VAL_PER_WAH_)/COUNT(1),0,MAX(STREET_VALUE))
	WHEN SUB_TABLE_NO = 4 THEN land.dbo.LOWPRICE_TRUNC(SUM(VAL_PER_WAH_)/COUNT(1),0,MAX(STREET_VALUE))
	ELSE land.dbo.LOWPRICE_TRUNC(SUM(VAL_PER_WAH_)/COUNT(1),LOWEST_PRICE,MAX(STREET_VALUE)) 
    END VAL_PER_WAH
    FROM (
    SELECT 
     * ,
    
     CASE 
        WHEN ISNULL(BLOCK_FIX_RN,0) > 0 AND TABLE_NO = 2 THEN ST_VALUE
        WHEN ISNULL(BLOCK_FIX_RN,0) <> 0 AND TABLE_NO <> 7 THEN ST_VALUE * LAND_TYPE_SUB_CAL
		WHEN TABLE_NO = 7 THEN ST_VALUE * .5
		WHEN SUB_TABLE_NO = 4 THEN ST_VALUE * .25 * DEPTH_CAL * LAND_TYPE_CAL
        WHEN TABLE_NO = 4 AND SUB_TABLE_NO = 1 THEN ST_VALUE * .65 * DEPTH_CAL
        WHEN TABLE_NO = 4 AND SUB_TABLE_NO = 2 THEN ST_VALUE * .35 * DEPTH_CAL
        WHEN TABLE_NO = 2 THEN LOWEST_PRICE
        ELSE ST_VALUE * DEPTH_CAL * LAND_TYPE_CAL * LAND_TYPE_SUB_CAL 
    END VAL_PER_WAH_
    FROM (
    SELECT T1.* , T2.DEPTH_CAL  , T3.LAND_TYPE_CAL , ISNULL(T4.LAND_TYPE_SUB_CAL,1) AS LAND_TYPE_SUB_CAL
    FROM (
        SELECT 
        OBJECTID ,
        BRANCH_CODE ,
        PARCEL_RN ,
        TABLE_NO ,
        SUB_TABLE_NO ,
        BLOCK_BLUE_RN ,
        BLOCK_FIX_RN ,
        BLOCK_PRICE_RN ,
        LOWEST_PRICE ,
        ST_VALUE ,
        STANDARD_DEPTH ,
        DEPTH_R_,
        ST_VALUE STREET_VALUE ,
        CASE 
                WHEN ISNULL(BLOCK_FIX_RN,0) > 0 THEN 1
                WHEN ISNULL(DEPTH_R_,0) = 0 OR ISNULL(DEPTH_R_,0) <= ( STANDARD_DEPTH * 1.25 ) OR ISNULL(STANDARD_DEPTH,0) = 0 THEN 1
                WHEN ISNULL(DEPTH_R_,0) <= STANDARD_DEPTH * 2.25  THEN 2
                WHEN ISNULL(DEPTH_R_,0) <= STANDARD_DEPTH * 3.25  THEN 3
                WHEN ISNULL(DEPTH_R_,0) <= STANDARD_DEPTH * 4.25  THEN 4
                WHEN ISNULL(DEPTH_R_,0) <= STANDARD_DEPTH * 5.25  THEN 5
                WHEN ISNULL(DEPTH_R_,0) <= STANDARD_DEPTH * 6.25  THEN 6
                WHEN ISNULL(DEPTH_R_,0) > STANDARD_DEPTH * 6.25  THEN 7
        END DEPTH_LEVEL
        FROM TDASSET_FORMER.tdadmin.PARCEL_REL_47 T1
        WHERE T1.BRANCH_CODE = @BRANCH_CODE
        AND T1.PARCEL_RN = @PARCEL_RN
        AND T1.DEPTH_R_ IS NOT NULL ) T1 
    LEFT OUTER JOIN common.dbo.LAND_DEPTH_CAL T2
    ON T1.DEPTH_LEVEL = T2.LAND_CAL_ID
    LEFT OUTER JOIN common.dbo.LAND_TYPE T3
    ON T1.TABLE_NO = T3.LAND_TYPE_ID
    LEFT OUTER JOIN common.dbo.LAND_TYPE_SUB T4
    ON T1.SUB_TABLE_NO = T4.LAND_TYPE_SUB_ID ) T1 ) T1
    GROUP BY BRANCH_CODE , BLOCK_FIX_RN , TABLE_NO , SUB_TABLE_NO , PARCEL_RN , LOWEST_PRICE ) TJOIN 
    ON TMAS.BRANCH_CODE = TJOIN.BRANCH_CODE
    AND TMAS.PARCEL_RN = TJOIN.PARCEL_RN
    WHERE TMAS.BRANCH_CODE = TJOIN.BRANCH_CODE
    AND TMAS.PARCEL_RN = TJOIN.PARCEL_RN
