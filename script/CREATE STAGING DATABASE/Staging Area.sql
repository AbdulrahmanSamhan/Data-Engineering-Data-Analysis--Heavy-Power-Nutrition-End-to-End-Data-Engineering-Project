/*============================================================
    CREATE STAGING DATABASE
============================================================*/

CREATE DATABASE HeavyPowerNutrition_SA;
GO

USE HeavyPowerNutrition_SA;
GO


/*============================================================
    STORED PROCEDURE: spGetDataFromOLTP

    Purpose:
    --------
    Extract data from OLTP Database (HeavyPowerNutrition)
    and load it into Staging Area without any transformation.

    ETL Phase:
    ----------
    Extract & Load to Staging Area
============================================================*/

CREATE PROCEDURE spGetDataFromOLTP
AS
BEGIN

    SET NOCOUNT ON;

    /*========================================================
        STEP 1: DROP EXISTING STAGING TABLES
    ========================================================*/

    IF OBJECT_ID('HeavyPowerNutrition_SA..Customer', 'U') IS NOT NULL
        DROP TABLE HeavyPowerNutrition_SA..Customer;

    IF OBJECT_ID('HeavyPowerNutrition_SA..Geography', 'U') IS NOT NULL
        DROP TABLE HeavyPowerNutrition_SA..Geography;

    IF OBJECT_ID('HeavyPowerNutrition_SA..Region', 'U') IS NOT NULL
        DROP TABLE HeavyPowerNutrition_SA..Region;

    IF OBJECT_ID('HeavyPowerNutrition_SA..Product', 'U') IS NOT NULL
        DROP TABLE HeavyPowerNutrition_SA..Product;

    IF OBJECT_ID('HeavyPowerNutrition_SA..ProductSubcategory', 'U') IS NOT NULL
        DROP TABLE HeavyPowerNutrition_SA..ProductSubcategory;

    IF OBJECT_ID('HeavyPowerNutrition_SA..ProductCostHistory', 'U') IS NOT NULL
        DROP TABLE HeavyPowerNutrition_SA..ProductCostHistory;

    IF OBJECT_ID('HeavyPowerNutrition_SA..SalesDetails', 'U') IS NOT NULL
        DROP TABLE HeavyPowerNutrition_SA..SalesDetails;

    IF OBJECT_ID('HeavyPowerNutrition_SA..SalesHeader', 'U') IS NOT NULL
        DROP TABLE HeavyPowerNutrition_SA..SalesHeader;

    IF OBJECT_ID('HeavyPowerNutrition_SA..SalesReturns', 'U') IS NOT NULL
        DROP TABLE HeavyPowerNutrition_SA..SalesReturns;


    /*========================================================
        STEP 2: LOAD CUSTOMER DIMENSION DATA
    ========================================================*/

    SELECT *
    INTO HeavyPowerNutrition_SA..Customer
    FROM HeavyPowerNutrition..Customer;

    SELECT *
    INTO HeavyPowerNutrition_SA..Geography
    FROM HeavyPowerNutrition..Geography;

    SELECT *
    INTO HeavyPowerNutrition_SA..Region
    FROM HeavyPowerNutrition..Region;


    /*========================================================
        STEP 3: LOAD PRODUCT DIMENSION DATA
    ========================================================*/

    SELECT *
    INTO HeavyPowerNutrition_SA..Product
    FROM HeavyPowerNutrition..Product;

    SELECT *
    INTO HeavyPowerNutrition_SA..ProductSubcategory
    FROM HeavyPowerNutrition..ProductSubcategory;

    SELECT *
    INTO HeavyPowerNutrition_SA..ProductCostHistory
    FROM HeavyPowerNutrition..ProductCostHistory;


    /*========================================================
        STEP 4: LOAD FACT TABLES
    ========================================================*/

    SELECT *
    INTO HeavyPowerNutrition_SA..SalesDetails
    FROM HeavyPowerNutrition..SalesDetails;

    SELECT *
    INTO HeavyPowerNutrition_SA..SalesHeader
    FROM HeavyPowerNutrition..SalesHeader;

    SELECT *
    INTO HeavyPowerNutrition_SA..SalesReturns
    FROM HeavyPowerNutrition..SalesReturns;

END;
GO


    /*========================================================
        OLTP Database
              ↓
            Extract
               ↓
           Staging Area
    ========================================================*/


