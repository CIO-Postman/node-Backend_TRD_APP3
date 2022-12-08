  -- เปลี่ยนตารางคำนวนเป็น NS3K ก่อน
UPDATE  TDASSET_FORMER.tdadmin.PARCEL_47_NS3K_16
  SET LOG_PARCEL = NULL ,
  A_SUBMIT = NULL ,
  A_SUBMIT_DATE = NULL ,
  W_SUBMIT = NULL ,
  W_SUBMIT_DATE = NULL ,
  CURR_EVAPRICE = NULL , 
  VAL_PER_WAH = NULL  
WHERE BRANCH_CODE = @BRANCH_CODE
  AND NS3K_RN = @NS3K_RN
  AND CHANGWAT_CODE = @CHANGWAT_CODE
  
UPDATE TDASSET_FORMER.tdadmin.PARCEL_47_NS3K_16
SET DATE_UPDATED =  GETDATE()  ,
VAL_PER_WAH = TJOIN.VAL_PER_WAH ,
VAL_PER_WAH_ = TJOIN.VAL_PER_WAH ,
LOG_PARCEL = TJOIN.ERR_MSG ,
--CHANOD_NO = TJOIN.CHANODE_NO ,
--SURVEY_NO = TJOIN.SURVEY_NO ,
-- AMPHUR_CODE = TJOIN.AMPHUR_CODE ,
-- TUMBON_CODE = TJOIN.TUMBON_CODE ,
PARCEL_SHAPE = TJOIN.TABLE_NO ,
USER_UPDATED = 'SYS2 CAL1.0'
FROM TDASSET_FORMER.tdadmin.PARCEL_47_NS3K_16  TMAS 
LEFT OUTER JOIN (
SELECT * , 
CASE 
	WHEN ERR_MSG IS NULL THEN NULL 
	ELSE 0 
END VAL_PER_WAH
FROM (
	SELECT 
	T1.CHANGWAT_CODE ,
	T1.BRANCH_CODE ,
	T1.PARCEL_TYPE ,
	T1.UTMMAP1 ,
	T1.UTMMAP2 ,
	T1.UTMMAP3 , 
	T1.UTMMAP4 ,
	T1.UTMSCALE ,
	T1.LAND_NO ,
	T1.CURR_EVAPRICE ,
	--T2.CHANODE_NO AS CHANODE_NO ,
    --T2.SURVEY_NO AS SURVEY_NO ,
    -- T2.AMPHUR_CODE AS AMPHUR_CODE ,
	-- T2.TUMBON_CODE AS TUMBON_CODE ,
    TREL.OBJECTID AS REL_RN ,
	T1.NS3K_RN ,
	TREL.BLOCK_FIX_RN AS BLOCK_FIX_RN ,
	TREL.BLOCK_BLUE_RN AS BLOCK_BLUE_RN ,
	TREL.BLOCK_PRICE_RN AS	BLOCK_PRICE_RN ,
	TREL.STREET_RN AS REL_STREET_RN , 

	--- TO_COL_CAL --
	TREL.TABLE_NO ,
	TTYPE.LAND_TYPE_NAME ,
	TREL.SUB_TABLE_NO ,
	TREL.DEPTH_R ,
	--TREL.DEPTH_GROUP ,
	TTYPE.LAND_TYPE_CAL AS TYPE_PERCENT ,

	CASE
			WHEN ISNULL(TFIX.BLOCK_FIX_RN,0) > 0 THEN 1
			WHEN ISNULL(TREL.DEPTH_R,0) = 0 OR ISNULL(TREL.DEPTH_R,0) <= ( TROAD.STREET_DEPTH * 1.25 ) OR ISNULL(TROAD.STREET_DEPTH,0) = 0 THEN 1
			WHEN ISNULL(TREL.DEPTH_R,0) <= TROAD.STREET_DEPTH * 2.25  THEN 2
			WHEN ISNULL(TREL.DEPTH_R,0) <= TROAD.STREET_DEPTH * 3.25  THEN 3
			WHEN ISNULL(TREL.DEPTH_R,0) <= TROAD.STREET_DEPTH * 4.25  THEN 4
			WHEN ISNULL(TREL.DEPTH_R,0) <= TROAD.STREET_DEPTH * 5.25  THEN 5
			WHEN ISNULL(TREL.DEPTH_R,0) <= TROAD.STREET_DEPTH * 6.25  THEN 6
			WHEN ISNULL(TREL.DEPTH_R,0) > TROAD.STREET_DEPTH * 6.25  THEN 7
	END DEPTH_LEVEL ,

	CASE
        WHEN ISNULL(TFIX.BLOCK_FIX_RN ,0) > 0 THEN TFIX.STREET_NAME 
        WHEN ISNULL(TFIX.BLOCK_FIX_RN ,0) = 0 AND ISNULL(TROAD.STREET_RN ,0) > 0 THEN TROAD.STREET_NAME
        WHEN ISNULL(TFIX.BLOCK_FIX_RN ,0) = 0 AND ISNULL(TROAD.STREET_RN ,0) = 0 AND  ISNULL(TPRICE.BLOCK_PRICE_RN,0) > 0 THEN TPRICE.STREET_NAME
    END STREET_NAME ,
    CASE
        WHEN ISNULL(TFIX.BLOCK_FIX_RN ,0) > 0 THEN TFIX.STREET_VALUE 
        WHEN ISNULL(TFIX.BLOCK_FIX_RN ,0) = 0 AND ISNULL(TROAD.STREET_RN ,0) > 0 THEN TROAD.STREET_VALUE
        WHEN ISNULL(TFIX.BLOCK_FIX_RN ,0) = 0 AND ISNULL(TROAD.STREET_RN ,0) = 0 AND  ISNULL(TPRICE.BLOCK_PRICE_RN,0) > 0 THEN TPRICE.LOWEST_PRICE
    END STREET_VALUE ,
    CASE
        WHEN ISNULL(TFIX.BLOCK_FIX_RN ,0) > 0 THEN 0
        WHEN ISNULL(TFIX.BLOCK_FIX_RN ,0) = 0 AND ISNULL(TROAD.STREET_RN ,0) > 0 THEN TROAD.STREET_DEPTH
        WHEN ISNULL(TFIX.BLOCK_FIX_RN ,0) = 0 AND ISNULL(TROAD.STREET_RN ,0) = 0 AND  ISNULL(TPRICE.BLOCK_PRICE_RN,0) > 0 THEN 0
    END STREET_DEPTH  ,

    ISNULL(TPRICE.LOWEST_PRICE,0) LOWEST_PRICE ,

	-- BLOCK_FIX COLUM --
	ISNULL(TFIX.BLOCK_FIX_RN,0) AS FIX_BLOCK_FIX_RN ,
	TFIX.STREET_NAME AS FIX_STREET_NAME , 
	TFIX.STREET_CODE AS FIX_STREET_CODE ,
	TFIX.STREET_VALUE AS FIX_STREET_VALUE ,

	-- BLOCK_BLUE COLUM --
	ISNULL(TBLUE.BLOCK_BLUE_RN,0) AS BLUE_BLOCK_BLUE_RN ,
	ISNULL(TBLUE.BLOCK_TYPE_ID,0) AS BLUE_BLOCK_TYPE_ID ,

	-- BLOCK_PRICE COLUM --
	ISNULL(TPRICE.BLOCK_PRICE_RN,0) AS PRICE_BLOCK_BLUE_RN ,
	TPRICE.STREET_NAME AS PRICE_STREET_NAME , 
	TPRICE.STREET_CODE AS PRICE_STREET_CODE ,
	TPRICE.STREET_VALUE AS PRICE_LOWEST_PRICE ,

	-- ROAD COLUM ---
	ISNULL(TROAD.STREET_RN,0) AS ROAD_STREET_RN ,
	TROAD.STREET_NAME AS ROAD_STREET_NAME ,
	TROAD.STREET_CODE AS ROAD_STREET_CODE ,
	TROAD.STREET_VALUE AS ROAD_STREET_VALUE ,


	 ---------------------------- ERR MASSAGE -------------------
	 CASE 
			WHEN ISNULL(TREL.OBJECTID,0) = 0 THEN 'Y1PA-แปลงไม่มีเส้น REL' 
            WHEN ISNULL(TREL.TABLE_NO,0) = 0 THEN 'Y1R-ไม่ระบุ TABLE_NO'
            WHEN ISNULL(TREL.TABLE_NO,0) <>  2 AND ISNULL(TREL.STREET_RN,0) = 0 THEN 'YS-ไม่มี STREET_RN'
			WHEN ISNULL(TREL.DEPTH_R,0) = 0 AND ISNULL(TREL.BLOCK_FIX_RN,0) = 0 AND TREL.TABLE_NO <> 2 THEN 'Y2R-ไม่ระบุ ระยะความลึก'
			WHEN ISNULL(TREL.TABLE_NO,0) = 4 AND ISNULL(TREL.SUB_TABLE_NO,0) = 0  THEN 'Y3R-TABLE_NO 4 ต้องมี SUB_TABLE NO 1 หรือ 2'
			--- ERROR BLOCK_PRICE ---
			WHEN ISNULL(TREL.BLOCK_PRICE_RN,0)=0 THEN  'Y4R-ค่า BLOCK_PRICE_RN ว่าง'
			WHEN ISNULL(TREL.BLOCK_PRICE_RN,0)>0 AND ISNULL(TPRICE.BLOCK_PRICE_RN,0)=0 THEN 'Y1P-BLOCK_PRICE_RN ไม่ถูกต้อง'
			WHEN ISNULL(TREL.BLOCK_PRICE_RN,0)>0 AND ISNULL(TPRICE.BLOCK_PRICE_RN,0)>0 AND ISNULL(TPRICE.STREET_VALUE,0)=0 THEN 'Y2P-BLOCK_PRICE ไม่มีราคา'
			--- ERROR BLOCK_FIX ---
			WHEN ISNULL(TREL.BLOCK_FIX_RN,0) > 0 AND ISNULL(TFIX.BLOCK_FIX_RN,0) = 0 THEN 'Y1F-BLOCK_FIX_RN ไม่ถูกต้อง' 
			WHEN ISNULL(TFIX.BLOCK_FIX_RN,0) > 0 AND ISNULL(TFIX.STREET_VALUE,0) = 0 THEN 'Y2F-BLOCK_FIX ไม่มีราคา'
			--- ERROR BLOCK BLUE ---
			WHEN ISNULL(TREL.BLOCK_BLUE_RN,0) > 0 AND ISNULL(TBLUE.BLOCK_BLUE_RN,0) = 0 THEN 'Y1B-BLOCK_BLUE_RN ไม่ถูกต้อง'
			WHEN ISNULL(TBLUE.BLOCK_BLUE_RN,0) > 0 AND ISNULL(TBLUE.BLOCK_TYPE_ID,0) = 0 THEN 'Y2B-BLOCK_BLUE ไม่ระบุ TYPE'
			WHEN ISNULL(TBLUE.BLOCK_BLUE_RN,0) > 0 AND ISNULL(TBLUE.BLOCK_TYPE_ID,0) = 2 AND TREL.TABLE_NO = 2 THEN 'Y3B-TABLE NO ไม่สามารถเป็น 2 ได้'
			--- ERROR STREET ---
			WHEN ISNULL(TREL.STREET_RN,0) > 0 AND TREL.TABLE_NO <> 2 AND ISNULL(TROAD.STREET_RN,0) = 0 AND ISNULL(TFIX.BLOCK_FIX_RN,0) = 0  THEN 'Y1S-ไม่พบข้อมูล STREET_RN นี้ในชั้นข้อมูล ROAD'
			WHEN ISNULL(TROAD.STREET_RN,0) > 0 AND TREL.TABLE_NO <> 2 AND ISNULL(TROAD.STREET_VALUE,0) = 0 THEN 'Y2S-ถนนไม่มีราคา (STREET_VALUE)'
			--WHEN ISNULL(TFIX.BLOCK_FIX_RN,0) = 0 AND ISNULL(TROAD.STREET_RN,0) > 0 AND  ISNULL(TROAD.STREET_DEPTH,0) = 0 THEN 'Y3S-ถนนไม่มีระยะความลึกมาตรฐาน'
	END ERR_MSG

	FROM TDASSET_FORMER.tdadmin.PARCEL_47_NS3K_16 T1

	---- JOIN PARCEL_HD ----
	LEFT OUTER JOIN (
	SELECT TMAS.* FROM land.dbo.NS3A_HD_16 TMAS
	LEFT OUTER JOIN
	( SELECT * FROM (	SELECT COUNT(1) COUNT_HD , BRANCH_CODE , UTM_CODE , UTM_NO_P , UTM_NO , UTM_PAGE , UTM_RATIO , UTM_LANDNO FROM land.dbo.NS3A_HD_16
	GROUP BY BRANCH_CODE , UTM_CODE , UTM_NO_P , UTM_NO , UTM_PAGE , UTM_RATIO , UTM_LANDNO ) T1 
	WHERE COUNT_HD > 1
	 ) TJOIN1
	 ON TMAS.UTM_CODE = TJOIN1.UTM_CODE
	 AND TMAS.UTM_NO_P = TJOIN1.UTM_NO_P
	 AND TMAS.UTM_NO = TJOIN1.UTM_NO 
	 AND TMAS.UTM_PAGE = TJOIN1.UTM_PAGE
	 AND TMAS.UTM_RATIO = TJOIN1.UTM_RATIO
	 AND TMAS.UTM_LANDNO = TJOIN1.UTM_LANDNO
	 WHERE COUNT_HD IS NULL 
	) T2
	ON T1.UTMMAP1 = T2.UTM_CODE
	AND T1.UTMMAP2 = T2.UTM_NO_P
	AND T1.UTMMAP3 = T2.UTM_NO
	AND RIGHT('00' + T1.UTMMAP4 , 2) = RIGHT('00' + T2.UTM_PAGE , 2) 
	AND T1.UTMSCALE = T2.UTM_RATIO
	AND T1.LAND_NO = T2.UTM_LANDNO
	AND T1.BRANCH_CODE = T2.BRANCH_CODE
	LEFT OUTER JOIN TDASSET_FORMER.tdadmin.NS3K_REL_47 TREL 
	ON T1.BRANCH_CODE = TREL.BRANCH_CODE
	AND T1.NS3K_RN = TREL.NS3K_RN
	LEFT OUTER JOIN 
	( SELECT * FROM TDASSET_FORMER.tdadmin.BLOCK_FIX_47 WHERE BRANCH_CODE = @BRANCH_CODE AND ISNULL(BLOCK_FIX_RN,0) <> 0 ) TFIX 
	ON T1.BRANCH_CODE = TFIX.BRANCH_CODE
	AND TREL.BLOCK_FIX_RN = TFIX.BLOCK_FIX_RN
	LEFT OUTER JOIN 
	( SELECT * FROM TDASSET_FORMER.tdadmin.BLOCK_BLUE_47 WHERE BRANCH_CODE = @BRANCH_CODE AND ISNULL(BLOCK_BLUE_RN,0) <> 0 ) TBLUE 
	ON T1.BRANCH_CODE = TBLUE.BRANCH_CODE
	AND TREL.BLOCK_BLUE_RN = TBLUE.BLOCK_BLUE_RN
	LEFT OUTER JOIN 
	( SELECT * FROM TDASSET_FORMER.tdadmin.BLOCK_PRICE_47 WHERE BRANCH_CODE = @BRANCH_CODE AND ISNULL(BLOCK_PRICE_RN,0) <> 0 ) TPRICE 
	ON T1.BRANCH_CODE = TPRICE.BRANCH_CODE
	AND TREL.BLOCK_PRICE_RN = TPRICE.BLOCK_PRICE_RN
	LEFT OUTER JOIN 
	( SELECT * FROM TDASSET_FORMER.tdadmin.ROAD_47 WHERE BRANCH_CODE = @BRANCH_CODE AND ISNULL(STREET_RN,0) <> 0 ) TROAD 
	ON T1.BRANCH_CODE = TROAD.BRANCH_CODE
	AND TREL.STREET_RN = TROAD.STREET_RN

	LEFT OUTER JOIN common.dbo.LAND_TYPE TTYPE 
	ON TREL.TABLE_NO = TTYPE.LAND_TYPE_ID

	WHERE T1.BRANCH_CODE = @BRANCH_CODE
	AND T1.NS3K_RN = @NS3K_RN) TT1
	) TJOIN
	ON TMAS.BRANCH_CODE = TJOIN.BRANCH_CODE 
	AND TMAS.NS3K_RN = TJOIN.NS3K_RN
	WHERE TMAS.BRANCH_CODE = TJOIN.BRANCH_CODE 
    AND TMAS.NS3K_RN = TJOIN.NS3K_RN
    
BEGIN TRAN
    UPDATE TDASSET_FORMER.tdadmin.NS3K_REL_47 
    SET ST_VALUE = TJOIN.STREET_VALUE ,
    --LOWEST_PRICE = TJOIN.LOWEST_PRICE ,
    STANDARD_DEPTH = TJOIN.STREET_DEPTH
    FROM TDASSET_FORMER.tdadmin.NS3K_REL_47  TMAS 
    LEFT OUTER JOIN (
    SELECT 
        OBJECTID  ,
        BRANCH_CODE , 
        NS3K_RN ,
        CASE 
            WHEN ISNULL(BLOCK_FIX_RN,0) <> 0 THEN FIX_STREET_VALUE
            WHEN ISNULL(STREET_RN,0) = 0 AND ISNULL(BLOCK_FIX_RN,0) = 0 THEN PRICE_LOWEST_PRICE
            ELSE ROAD_STREET_VALUE
        END STREET_VALUE ,
        CASE 
            WHEN ISNULL(BLOCK_FIX_RN,0) <> 0 THEN 0
            ELSE ROAD_STREET_DEPTH
        END STREET_DEPTH ,
        PRICE_LOWEST_PRICE LOWEST_PRICE
        FROM (
        SELECT T2.* ,
        TFIX.STREET_VALUE AS FIX_STREET_VALUE ,
        TROAD.STREET_VALUE AS ROAD_STREET_VALUE ,
        TROAD.STREET_DEPTH AS ROAD_STREET_DEPTH ,
        TPRICE.LOWEST_PRICE AS PRICE_LOWEST_PRICE
        FROM TDASSET_FORMER.tdadmin.PARCEL_47_NS3K_16 T1
        LEFT OUTER JOIN TDASSET_FORMER.tdadmin.NS3K_REL_47 T2
        ON T1.BRANCH_CODE = T2.BRANCH_CODE
        AND T1.NS3K_RN = T2.NS3K_RN
        LEFT OUTER JOIN ( SELECT * FROM TDASSET_FORMER.tdadmin.BLOCK_FIX_47 WHERE BRANCH_CODE = @BRANCH_CODE AND ISNULL(BLOCK_FIX_RN,0) <> 0 ) TFIX 
        ON T2.BRANCH_CODE = TFIX.BRANCH_CODE
        AND T2.BLOCK_FIX_RN = TFIX.BLOCK_FIX_RN
        LEFT OUTER JOIN ( SELECT * FROM TDASSET_FORMER.tdadmin.ROAD_47 WHERE BRANCH_CODE = @BRANCH_CODE AND ISNULL(STREET_RN,0) <> 0 ) TROAD 
        ON T2.BRANCH_CODE = TROAD.BRANCH_CODE
        AND T2.STREET_RN = TROAD.STREET_RN
        LEFT OUTER JOIN ( SELECT * FROM TDASSET_FORMER.tdadmin.BLOCK_PRICE_47 WHERE BRANCH_CODE = @BRANCH_CODE AND ISNULL(BLOCK_PRICE_RN,0) <> 0 ) TPRICE 
        ON T2.BRANCH_CODE = TPRICE.BRANCH_CODE
        AND T2.BLOCK_PRICE_RN = TPRICE.BLOCK_PRICE_RN
    
        WHERE T1.BRANCH_CODE = @BRANCH_CODE
        AND T1.NS3K_RN =@NS3K_RN
        AND T1.LOG_PARCEL IS  NULL ) T1 ) TJOIN 
        ON TMAS.OBJECTID = TJOIN.OBJECTID
        WHERE TMAS.OBJECTID = TJOIN.OBJECTID
    COMMIT TRAN   

SELECT* FROM TDASSET_FORMER.tdadmin.PARCEL_47_NS3K_16
WHERE CHANGWAT_CODE = @CHANGWAT_CODE AND BRANCH_CODE = @BRANCH_CODE AND NS3K_RN = @NS3K_RN