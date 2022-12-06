SELECT ID_CARD,
    TEST_PASSWORD,
    USER_ID,
    USER_NAME,
    EMAIL,
    USER_TYPE
FROM common.dbo.users
WHERE 1=1
AND ID_CARD = @ID_CARD
AND  TEST_PASSWORD = @TEST_PASSWORD



-- -- declare @ID_CARD varchar(13) = 538516268074; 
-- -- declare @TEST_PASSWORD int = 12345 ;


-- IF NOT EXISTS
-- (
--    SELECT TOP 1 USER_ID FROM common.dbo.users  WHERE 1=1
-- AND ID_CARD = @ID_CARD
-- AND  TEST_PASSWORD = @TEST_PASSWORD
-- ) 
--    SELECT TOP 1 '' AS USER_ID,
--     '' AS USER_NAME,
--     '' AS EMAIL,
--     '' AS USER_TYPE,
-- 	'ไม่พบผู้ใช้งานหรือรหัสผ่านไม่ถูกต้อง' AS ERMES 
-- 	FROM common.dbo.users WHERE  1=1
-- AND ID_CARD != @ID_CARD
-- OR  TEST_PASSWORD != @TEST_PASSWORD
-- --FOR JSON AUTO;
-- ELSE
-- SELECT USER_ID,
--     USER_NAME,
--     EMAIL,
--     USER_TYPE ,'' AS ERMES
-- FROM common.dbo.users
-- WHERE 1=1
-- AND ID_CARD = @ID_CARD
-- AND  TEST_PASSWORD = @TEST_PASSWORD
-- --FOR JSON AUTO;
