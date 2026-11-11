/*==============================================================
PROJECT      : HeavyPowerNutrition Data Warehouse
PURPOSE      : Create Data Warehouse Database & Core Tables
LAYER        : Data Warehouse (DWH)
DESCRIPTION  :
- Create Data Warehouse Database
- Create Dimension Tables
- Create Fact Tables
- Support Reporting & Analytics Layer
==============================================================*/

/*==============================================================
STEP 1: CREATE DATA WAREHOUSE DATABASE
==============================================================*/

CREATE DATABASE HeavyPowerNutrition_DWH;
GO

USE HeavyPowerNutrition_DWH;
GO

/*==============================================================
DIMENSION TABLE: DIM_CUSTOMERS

```
PURPOSE:
    Store customer attributes and geographical information
```

==============================================================*/

CREATE TABLE Dim_Customers
(
  CustomerKey     INT           NOT NULL
, Customer        VARCHAR(200)  NOT NULL
, BusinessType    VARCHAR(200)  NOT NULL

-- Geography Attributes
, CityName        VARCHAR(200)  NOT NULL
, StateCode       VARCHAR(3)    NOT NULL
, StateName       VARCHAR(200)  NOT NULL
, CountryName     VARCHAR(200)  NOT NULL

-- Regional Attributes
, Region          VARCHAR(200)  NOT NULL
, Continent       VARCHAR(200)  NOT NULL


);
GO

/*==============================================================
DIMENSION TABLE: DIM_PRODUCT

PURPOSE:
    Store product hierarchy and product details

==============================================================*/

CREATE TABLE Dim_Product
(
  ProductKey             INT           NOT NULL
, ProductName            NVARCHAR(50)  NOT NULL
, ProductSubcategoryKey  NVARCHAR(50)  NOT NULL

-- Product Attributes
, Size                   NVARCHAR(50)  NOT NULL
, Detail                 NVARCHAR(50)  NOT NULL

-- Product Hierarchy
, SubcategoryName        NVARCHAR(50)  NOT NULL
, CategoryName           NVARCHAR(50)  NOT NULL

);
GO

/*==============================================================
FACT TABLE: FACT_SALES

PURPOSE:
    Store sales transactions and financial metrics

==============================================================*/

CREATE TABLE Fact_Sales
(
  SalesOrderNumber      NVARCHAR(50)  NOT NULL
, CustomerKey           INT           NOT NULL

-- Date Attributes
, OrderDate             DATE          NOT NULL
, DueDate               DATE          NOT NULL
, ShipDate              DATE          NOT NULL

-- Sales Metrics
, OrderQuantity         INT           NOT NULL
, UnitPrice             FLOAT         NOT NULL
, DiscountAmount        FLOAT         NOT NULL
, Discount_Percentage   FLOAT         NOT NULL
, Discount_Value        FLOAT         NOT NULL
, Net_Sales             FLOAT         NOT NULL
, UnitCost              FLOAT         NOT NULL

);
GO

/*==============================================================
FACT TABLE: FACT_RETURNS

PURPOSE:
    Store returned products and return-related measures

==============================================================*/

CREATE TABLE Fact_Returns
(
  CustomerKey        INT           NOT NULL
, ProductKey         INT           NOT NULL

-- Date Attributes
, OrderDate          DATE          NOT NULL
, ReturnDate         DATE          NOT NULL

-- Return Metrics
, ReturnQuantity     INT           NOT NULL
, ReturnAmount       FLOAT         NOT NULL
, UnitPrice          FLOAT         NOT NULL

-- Transaction Reference
, SalesOrderNumber   NVARCHAR(50)  NULL

);
GO

/*==============================================================
END OF DATA WAREHOUSE STRUCTURE
==============================================================*/



