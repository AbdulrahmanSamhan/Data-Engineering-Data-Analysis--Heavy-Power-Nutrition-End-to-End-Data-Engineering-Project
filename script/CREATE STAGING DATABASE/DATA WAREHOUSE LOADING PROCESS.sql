/*============================================================
    DATA WAREHOUSE LOADING PROCESS

    Source:
    -------
    HeavyPowerNutrition_SA

    Destination:
    ------------
    HeavyPowerNutrition_DWH

    Purpose:
    --------
    Load Customer Dimension data from Staging Area
    into Data Warehouse Dimension Table.

============================================================*/


/*============================================================
    STORED PROCEDURE:
    SP_Loading_Data_Dim_Customers_DWH

    Process:
    --------
    1. Remove existing records from Dim_Customers.
    2. Load refreshed customer dimension data.
    3. Calculate execution duration.
    4. Display execution status messages.
    5. Handle runtime errors using TRY/CATCH.

============================================================*/

CREATE OR ALTER PROCEDURE SP_Loading_Data_Dim_Customers_DWH
AS
BEGIN

    DECLARE
          @Start_Time DATETIME
        , @End_Time DATETIME
        , @Batch_Start_Time DATETIME
        , @Batch_End_Time DATETIME;

    BEGIN TRY

        SET @Batch_Start_Time = GETDATE();    -- تسجيل وقت بداية التنفيذ

        PRINT '================================================';
        PRINT 'Loading Dimension: Dim_Customers';
        PRINT '================================================';

        /*====================================================
            STEP 1: TRUNCATE DIMENSION TABLE
        ====================================================*/

        SET @Start_Time = GETDATE();  -- تسجيل وقت بداية خطوة التحميل

        PRINT '>> Truncating Table: HeavyPowerNutrition_DWH..Dim_Customers';

        TRUNCATE TABLE HeavyPowerNutrition_DWH..Dim_Customers;

        /*====================================================
            STEP 2: LOAD CUSTOMER DIMENSION DATA
        ====================================================*/

        PRINT '>> Inserting Data Into: HeavyPowerNutrition_DWH..Dim_Customers';

        INSERT INTO HeavyPowerNutrition_DWH..Dim_Customers
        (
              CustomerKey
            , Customer
            , BusinessType
            , CityName
            , StateCode
            , StateName
            , CountryName
            , Region
            , Continent
        )
        SELECT
              CustomerKey
            , Customer
            , BusinessType
            , CityName
            , StateCode
            , StateName
            , CountryName
            , Region
            , Continent
        FROM HeavyPowerNutrition_SA..vwDim_Customer;

        /*====================================================
            STEP 3: LOAD STATISTICS
        ====================================================*/

        SET @End_Time = GETDATE();      -- يسجل وقت انتهاء التحميل.

        PRINT '>> Load Duration: '
            + CAST(DATEDIFF(SECOND, @Start_Time, @End_Time) AS NVARCHAR)
            + ' seconds';

        PRINT '==========================================';
        PRINT 'Dim_Customers Load Completed Successfully';
        PRINT '==========================================';

        SET @Batch_End_Time = GETDATE();    -- حساب مدة الـ Batch بالكامل

        PRINT 'Total Load Duration: '
            + CAST(DATEDIFF(SECOND, @Batch_Start_Time, @Batch_End_Time) AS NVARCHAR)
            + ' seconds';

    END TRY

    BEGIN CATCH

        PRINT '==========================================';
        PRINT 'ERROR OCCURRED DURING LOADING Dim_Customers';
        PRINT '==========================================';

        PRINT 'Error Message : ' + ERROR_MESSAGE();
        PRINT 'Error Number  : ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error State   : ' + CAST(ERROR_STATE() AS NVARCHAR);

        PRINT '==========================================';

    END CATCH

END;
GO


/*============================================================
    Execute: SP_Loading_Data_Dim_Customers_DWH
============================================================*/
USE HeavyPowerNutrition_DWH;
GO

EXEC SP_Loading_Data_Dim_Customers_DWH;
GO



/*============================================================
STORED PROCEDURE:
SP_Loading_Data_Dim_Products_DWH

Source:
-------
HeavyPowerNutrition_SA

Destination:
------------
HeavyPowerNutrition_DWH

Purpose:
--------
Load Product Dimension data from Staging Area
into Data Warehouse Dimension Table.

Process:
--------
1. Remove existing records from Dim_Product.
2. Load refreshed product dimension data.
3. Calculate execution duration.
4. Display execution status messages.
5. Handle runtime errors using TRY/CATCH.
============================================================*/

CREATE OR ALTER PROCEDURE SP_Loading_Data_Dim_Products_DWH
AS
BEGIN

    DECLARE
          @Start_Time DATETIME
        , @End_Time DATETIME
        , @Batch_Start_Time DATETIME
        , @Batch_End_Time DATETIME;

    BEGIN TRY

        SET @Batch_Start_Time = GETDATE();

        PRINT '================================================';
        PRINT 'Loading Dimension: Dim_Product';
        PRINT '================================================';

        /*====================================================
            STEP 1: TRUNCATE DIMENSION TABLE
        ====================================================*/

        SET @Start_Time = GETDATE();

        PRINT '>> Truncating Table: HeavyPowerNutrition_DWH..Dim_Product';

        TRUNCATE TABLE HeavyPowerNutrition_DWH..Dim_Product;

        /*====================================================
            STEP 2: LOAD PRODUCT DIMENSION DATA
        ====================================================*/

        PRINT '>> Inserting Data Into: HeavyPowerNutrition_DWH..Dim_Product';

        INSERT INTO HeavyPowerNutrition_DWH..Dim_Product
        (
              ProductKey
            , ProductName
            , ProductSubcategoryKey
            , Size
            , Detail
            , SubcategoryName
            , CategoryName
        )
        SELECT
              ProductKey
            , ProductName
            , ProductSubcategoryKey
            , Size
            , Detail
            , SubcategoryName
            , CategoryName
        FROM HeavyPowerNutrition_SA..vwDim_Product;

        /*====================================================
            STEP 3: LOAD STATISTICS
        ====================================================*/

        SET @End_Time = GETDATE();

        PRINT '>> Load Duration: '
            + CAST(DATEDIFF(SECOND, @Start_Time, @End_Time) AS NVARCHAR)
            + ' seconds';

        PRINT '==========================================';
        PRINT 'Dim_Product Load Completed Successfully';
        PRINT '==========================================';

        SET @Batch_End_Time = GETDATE();

        PRINT 'Total Load Duration: '
            + CAST(DATEDIFF(SECOND, @Batch_Start_Time, @Batch_End_Time) AS NVARCHAR)
            + ' seconds';

    END TRY

    BEGIN CATCH

        PRINT '==========================================';
        PRINT 'ERROR OCCURRED DURING LOADING Dim_Product';
        PRINT '==========================================';

        PRINT 'Error Message : ' + ERROR_MESSAGE();
        PRINT 'Error Number  : ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error State   : ' + CAST(ERROR_STATE() AS NVARCHAR);

        PRINT '==========================================';

    END CATCH

END;
GO


/*============================================================
    EXECUTE STORED PROCEDURE
    SP_Loading_Data_Dim_Products_DWH
============================================================*/

USE HeavyPowerNutrition_DWH;
GO

EXEC SP_Loading_Data_Dim_Products_DWH;
GO


/*============================================================
STORED PROCEDURE:
SP_Loading_Data_Fact_Sales_DWH

Source:
-------
HeavyPowerNutrition_SA

Destination:
------------
HeavyPowerNutrition_DWH

Purpose:
--------
Load Sales Fact data from Staging Area
into Data Warehouse Fact Table.

Process:
--------
1. Remove existing records from Fact_Sales.
2. Load refreshed sales fact data.
3. Calculate execution duration.
4. Display execution status messages.
5. Handle runtime errors using TRY/CATCH.
============================================================*/

CREATE OR ALTER PROCEDURE SP_Loading_Data_Fact_Sales_DWH
AS
BEGIN

    DECLARE
          @Start_Time DATETIME
        , @End_Time DATETIME
        , @Batch_Start_Time DATETIME
        , @Batch_End_Time DATETIME;

    BEGIN TRY

        SET @Batch_Start_Time = GETDATE();

        PRINT '================================================';
        PRINT 'Loading Fact Table: Fact_Sales';
        PRINT '================================================';

        /*====================================================
            STEP 1: TRUNCATE FACT TABLE
        ====================================================*/

        SET @Start_Time = GETDATE();

        PRINT '>> Truncating Table: HeavyPowerNutrition_DWH..Fact_Sales';

        TRUNCATE TABLE HeavyPowerNutrition_DWH..Fact_Sales;

        /*====================================================
            STEP 2: LOAD FACT SALES DATA
        ====================================================*/

        PRINT '>> Inserting Data Into: HeavyPowerNutrition_DWH..Fact_Sales';

        INSERT INTO HeavyPowerNutrition_DWH..Fact_Sales
        (
              SalesOrderNumber
            , CustomerKey
            , OrderDate
            , DueDate
            , ShipDate
            , OrderQuantity
            , UnitPrice
            , DiscountAmount
            , Discount_Percentage
            , Discount_Value
            , Net_Sales
            , UnitCost
        )
        SELECT
              SalesOrderNumber
            , CustomerKey
            , OrderDate
            , DueDate
            , ShipDate
            , OrderQuantity
            , UnitPrice
            , DiscountAmount
            , Discount_Percentage
            , Discount_Value
            , Net_Sales
            , UnitCost
        FROM HeavyPowerNutrition_SA..vwFact_Sales;

        /*====================================================
            STEP 3: LOAD STATISTICS
        ====================================================*/

        SET @End_Time = GETDATE();

        PRINT '>> Load Duration: '
            + CAST(DATEDIFF(SECOND, @Start_Time, @End_Time) AS NVARCHAR)
            + ' seconds';

        PRINT '==========================================';
        PRINT 'Fact_Sales Load Completed Successfully';
        PRINT '==========================================';

        SET @Batch_End_Time = GETDATE();

        PRINT 'Total Load Duration: '
            + CAST(DATEDIFF(SECOND, @Batch_Start_Time, @Batch_End_Time) AS NVARCHAR)
            + ' seconds';

    END TRY

    BEGIN CATCH

        PRINT '==========================================';
        PRINT 'ERROR OCCURRED DURING LOADING Fact_Sales';
        PRINT '==========================================';

        PRINT 'Error Message : ' + ERROR_MESSAGE();
        PRINT 'Error Number  : ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error State   : ' + CAST(ERROR_STATE() AS NVARCHAR);

        PRINT '==========================================';

    END CATCH

END;
GO


/*============================================================
    EXECUTE STORED PROCEDURE
    SP_Loading_Data_Fact_Sales_DWH
============================================================*/

USE HeavyPowerNutrition_DWH;
GO

EXEC SP_Loading_Data_Fact_Sales_DWH;
GO


/*============================================================
STORED PROCEDURE:
SP_Loading_Data_Fact_Returns_DWH

Source:
-------
HeavyPowerNutrition_SA

Destination:
------------
HeavyPowerNutrition_DWH

Purpose:
--------
Load Returns Fact data from Staging Area
into Data Warehouse Fact Table.

Process:
--------
1. Remove existing records from Fact_Returns.
2. Load refreshed returns fact data.
3. Calculate execution duration.
4. Display execution status messages.
5. Handle runtime errors using TRY/CATCH.
============================================================*/

CREATE OR ALTER PROCEDURE SP_Loading_Data_Fact_Returns_DWH
AS
BEGIN

    DECLARE
          @Start_Time DATETIME
        , @End_Time DATETIME
        , @Batch_Start_Time DATETIME
        , @Batch_End_Time DATETIME;

    BEGIN TRY

        SET @Batch_Start_Time = GETDATE();

        PRINT '================================================';
        PRINT 'Loading Fact Table: Fact_Returns';
        PRINT '================================================';

        /*====================================================
            STEP 1: TRUNCATE FACT TABLE
        ====================================================*/

        SET @Start_Time = GETDATE();

        PRINT '>> Truncating Table: HeavyPowerNutrition_DWH..Fact_Returns';

        TRUNCATE TABLE HeavyPowerNutrition_DWH..Fact_Returns;

        /*====================================================
            STEP 2: LOAD FACT RETURNS DATA
        ====================================================*/

        PRINT '>> Inserting Data Into: HeavyPowerNutrition_DWH..Fact_Returns';

        INSERT INTO HeavyPowerNutrition_DWH..Fact_Returns
        (
              CustomerKey
            , ProductKey
            , OrderDate
            , ReturnDate
            , ReturnQuantity
            , ReturnAmount
            , UnitPrice
            , SalesOrderNumber
        )
        SELECT
              CustomerKey
            , ProductKey
            , OrderDate
            , ReturnDate
            , ReturnQuantity
            , ReturnAmount
            , UnitPrice
            , SalesOrderNumber
        FROM HeavyPowerNutrition_SA..vwFact_Returns;

        /*====================================================
            STEP 3: LOAD STATISTICS
        ====================================================*/

        SET @End_Time = GETDATE();

        PRINT '>> Load Duration: '
            + CAST(DATEDIFF(SECOND, @Start_Time, @End_Time) AS NVARCHAR)
            + ' seconds';

        PRINT '==========================================';
        PRINT 'Fact_Returns Load Completed Successfully';
        PRINT '==========================================';

        SET @Batch_End_Time = GETDATE();

        PRINT 'Total Load Duration: '
            + CAST(DATEDIFF(SECOND, @Batch_Start_Time, @Batch_End_Time) AS NVARCHAR)
            + ' seconds';

    END TRY

    BEGIN CATCH

        PRINT '==========================================';
        PRINT 'ERROR OCCURRED DURING LOADING Fact_Returns';
        PRINT '==========================================';

        PRINT 'Error Message : ' + ERROR_MESSAGE();
        PRINT 'Error Number  : ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error State   : ' + CAST(ERROR_STATE() AS NVARCHAR);

        PRINT '==========================================';

    END CATCH

END;
GO


/*============================================================
    EXECUTE STORED PROCEDURE
    SP_Loading_Data_Fact_Returns_DWH
============================================================*/

USE HeavyPowerNutrition_DWH;
GO

EXEC SP_Loading_Data_Fact_Returns_DWH;
GO



               /*====================================================
                                
                                  Start Procedure
                                        ↓
                                  تسجيل وقت البداية  
                                        ↓
                                TRUNCATE 
                                         ↓
                               قراءة البيانات من vw
                                         ↓
                                INSERT INTO Dim_DWH
                                          ↓
                                    حساب مدة التنفيذ
                                          ↓
                                     طباعة رسالة نجاح           
                                           ↓
                                          End

                                          ولو حصل Error
                                             ↓
                                            CATCH
                                            ↓
                                        طباعة تفاصيل الخطأ 

                  ====================================================*/



