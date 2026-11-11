/*============================================================
    STAGING AREA
    DENORMALIZATION LAYER

    Purpose:
    --------
    Create business-friendly views by joining normalized
    staging tables into dimensional and fact structures.

    Database:
    ---------
    HeavyPowerNutrition_SA
============================================================*/

USE HeavyPowerNutrition_SA;
GO

/*=====================================
    Refresh Staging Data
=====================================*/
EXEC spGetDataFromOLTP;
GO


/*============================================================
    DIMENSION VIEW: CUSTOMER

    Purpose:
    --------
    Denormalize Customer, Geography, and Region data
    into a single Customer Dimension View.
============================================================*/

ALTER VIEW vwDim_Customer   -- ALTER TABLE BECOUSE ADD ADDTION COLOMN NAME "COUNTRY
AS
SELECT
    c.CustomerKey,
    c.Customer,
    c.BusinessType,

    -- Geography Attributes
    g.CityName,
    g.StateCode,
    g.StateName,
    g.CountryName,

    -- Region Attributes
    r.Region,
    r.Continent

FROM Customer c
LEFT JOIN Geography g
    ON c.GeographyKey = g.GeographyKey
LEFT JOIN Region r
    ON g.RegionKey = r.RegionKey;
GO


/*============================================================
    DIMENSION VIEW: PRODUCT

    Purpose:
    --------
    Denormalize Product and Product Subcategory data
    into a single Product Dimension View.
============================================================*/

CREATE VIEW vwDim_Product
AS

SELECT
      p.ProductKey
    , p.ProductName
    , p.ProductSubcategoryKey
    , p.Size
    , p.Detail

    -- Product Hierarchy
    , psc.SubcategoryName
    , psc.CategoryName

FROM Product p

LEFT JOIN ProductSubcategory psc
       ON p.ProductSubcategoryKey = psc.ProductSubcategoryKey;

GO


/*============================================================
    FACT VIEW: SALES

    Purpose:
    --------
    Create a Sales Fact View containing:
        - Sales Information
        - Discount Metrics
        - Net Sales
        - Product Cost

    Business Logic:
    ---------------
    1. Discount Percentage
       = Discount Amount / Total Amount

    2. Discount Value
       = Allocate order discount proportionally
         to each order line

    3. Net Sales
       = Line Sales Amount - Allocated Discount

============================================================*/

CREATE VIEW vwFact_Sales
AS

SELECT

      SH.SalesOrderNumber
    , SH.CustomerKey

    -- Dates
    , SH.OrderDate
    , SH.DueDate
    , SH.ShipDate

    -- Sales Metrics
    , SD.OrderQuantity
    , SD.UnitPrice

    -- Header Discount
    , SH.DiscountAmount


    /*--------------------------------------------------------
        Discount Percentage

        Formula:
        Discount Amount / Total Order Amount
    --------------------------------------------------------*/

    , ROUND(
        SH.DiscountAmount / SH.TotalAmount
      , 3
      ) AS Discount_Percentage


    /*--------------------------------------------------------
        Discount Value

        Allocate order-level discount to each line
        based on line contribution to total order.
    --------------------------------------------------------*/

    , ROUND(
          SH.DiscountAmount
        * (SD.ExtendedAmount / SH.TotalAmount)
      , 3
      ) AS Discount_Value


    /*--------------------------------------------------------
        Net Sales

        Net Sales = Sales Amount - Allocated Discount
    --------------------------------------------------------*/

    , ROUND(
          SD.ExtendedAmount
        - (
            SH.DiscountAmount
            * (SD.ExtendedAmount / SH.TotalAmount)
          )
      , 3
      ) AS Net_Sales


    /*--------------------------------------------------------
        Product Cost
    --------------------------------------------------------*/

    , PCH.UnitCost

FROM SalesDetails SD
LEFT JOIN SalesHeader SH
        ON SD.SalesHeaderKey = SH.SalesHeaderKey
LEFT JOIN Customer c
       ON SH.CustomerKey = c.CustomerKey
LEFT JOIN Geography g
       ON c.GeographyKey = g.GeographyKey
LEFT JOIN ProductCostHistory PCH
       ON PCH.CountryCode = g.CountryCode
      AND PCH.MonthNo     = MONTH(SH.OrderDate)
      AND PCH.Year        = YEAR(SH.OrderDate)
      AND PCH.ProductKey  = SD.ProductKey;

GO


/*============================================================
    FACT VIEW: RETURNS

    Purpose:
    --------
    Create Returns Fact View to analyze:
        - Return Quantity
        - Return Amount
        - Returned Products
        - Customer Returns
============================================================*/

CREATE VIEW vwFact_Returns
AS

SELECT

      re.CustomerKey
    , re.OrderDate
    , re.ProductKey

    -- Return Metrics
    , re.ReturnQuantity
    , re.ReturnAmount

    -- Return Details
    , re.ReturnDate
    , re.SalesOrderNumber
    , re.UnitPrice

FROM SalesReturns re;

GO



/*-------------------------------------------
USE HeavyPowerNutrition_SA;
GO

SELECT *
FROM sys.tables;

USE HeavyPowerNutrition_SA;
GO

SELECT name
FROM sys.procedures;

USE HeavyPowerNutrition_SA;
GO

EXEC spGetDataFromOLTP;

SELECT name
FROM sys.tables;
---------------------------------------------*/
