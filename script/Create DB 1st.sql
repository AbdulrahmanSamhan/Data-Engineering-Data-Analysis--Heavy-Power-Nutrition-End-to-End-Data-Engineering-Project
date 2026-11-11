/*============================================================
    DATABASE VALIDATION & OWNER CONFIGURATION

    Database:
    ---------
    HeavyPowerNutrition

    Purpose:
    --------
    1. Verify data availability in source tables.
    2. Fix database owner issue after Restore.
    3. Validate current database owner.

============================================================*/


/*============================================================
    STEP 1: VERIFY SOURCE DATA

    Purpose:
    --------
    Ensure that source tables contain data before
    starting the ETL process.

============================================================*/

USE HeavyPowerNutrition;
GO

-- Validate Customer Data
SELECT *
FROM dbo.Customer;

-- Validate Sales Data
SELECT *
FROM dbo.SalesHeader;

GO


/*============================================================
    STEP 2: FIX DATABASE OWNER

    Purpose:
    --------
    Reassign the database owner to 'sa'.

    Why?
    ----
    After restoring a database from another server,
    the original owner may not exist on the current
    SQL Server instance, causing Error 15517 when
    opening Database Diagrams or executing certain
    database operations.

============================================================*/

USE HeavyPowerNutrition;
GO

ALTER AUTHORIZATION
ON DATABASE::HeavyPowerNutrition
TO sa;
GO


/*============================================================
    STEP 3: VERIFY DATABASE OWNER

    Purpose:
    --------
    Confirm that the database owner has been
    successfully changed.

============================================================*/

SELECT
      name
    , SUSER_SNAME(owner_sid) AS DatabaseOwner
FROM sys.databases
WHERE name = 'HeavyPowerNutrition';

GO