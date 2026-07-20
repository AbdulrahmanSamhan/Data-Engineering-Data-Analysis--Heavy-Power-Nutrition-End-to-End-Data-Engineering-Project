# Data-Engineering-Data-Analysis--Heavy-Power-Nutrition-End-to-End-Data-Engineering-Project
 Built a complete data pipeline for a Brazilian nutrition company. Extracted data from SQL Server, loaded it into a Staging Area, performed data transformation and denormalization, designed a Data Warehouse (Star Schema), and connected it to Power BI for analytics. GitHub was used for version control and centralized project management.

ممكن تحطه في GitHub بالشكل الاحترافي ده:

# Heavy Power Nutrition – End-to-End Data Engineering & Analytics Project

## Project Overview

This project is an end-to-end Data Engineering and Data Analytics solution developed for **Heavy Power Nutrition**, a Brazilian company specializing in sports nutrition and bodybuilding supplements.

The main objective of this project was to design and implement a complete data pipeline that transforms raw operational data into a centralized, analytics-ready environment for business intelligence and decision-making.

---

## Project Architecture

The project follows a modern Data Engineering workflow:

### 1. Data Extraction (OLTP Source)

The process starts by extracting data from the operational SQL Server database containing information about:

* Customers
* Products
* Sales Orders
* Returns
* Geographic Data
* Product Cost History

---

### 2. Staging Area (SA)

A dedicated **Staging Area** was created to store raw data extracted from the source system.

During this stage:

* Data was loaded as-is from the OLTP database.
* Stored Procedures were developed to automate the extraction process.
* Initial data validation was performed.

---

### 3. Data Transformation & Denormalization

To simplify reporting and improve analytical performance:

* Multiple normalized tables were combined into business-friendly views.
* Customer, Geography, and Region data were merged into a unified Customer Dimension View.
* Product and Product Category information were consolidated into a Product Dimension View.
* Sales and Returns views were created to support analytical requirements.

This layer acts as the transformation stage of the ETL process.

---

### 4. Data Warehouse (DWH)

A dimensional Data Warehouse was designed and implemented using a **Star Schema** architecture.

The warehouse contains:

#### Dimension Tables

* Dim_Customers
* Dim_Products
* Dim_Date

#### Fact Tables

* Fact_Sales
* Fact_Returns

Data loading procedures were developed to automate movement from the Staging Area into the Data Warehouse.

---

### 5. Automation & Orchestration

The entire pipeline was automated using SQL Server Stored Procedures.

Features include:

* Full Refresh Loading Strategy
* Error Handling using TRY/CATCH
* Execution Logging
* Load Duration Monitoring
* Automated Data Refresh

---

### 6. Business Intelligence & Analytics

The Data Warehouse was connected to **Microsoft Power BI** to build interactive dashboards and analytical reports.

Key business metrics include:

* Revenue
* Net Sales
* Gross Profit
* Discount Analysis
* Return Analysis
* Customer Performance
* Product Performance
* Geographic Performance

---

### 7. Version Control & Centralized Development

The complete project was integrated with **GitHub** to provide:

* Version Control
* Change Tracking
* Collaboration
* Centralized Project Management
* Documentation for every stage of the pipeline

This ensures that all Data Engineering, Data Warehouse, and Power BI development activities are maintained in a single centralized repository.

---

## Technologies Used

* SQL Server
* T-SQL
* Data Warehousing
* ETL Development
* Star Schema Modeling
* Power BI
* Git & GitHub

---

## Project Workflow

```text
OLTP Database
       │
       ▼
Staging Area (SA)
       │
       ▼
Transformation & Denormalization
       │
       ▼
Data Warehouse (DWH)
       │
       ▼
Power BI Dashboards
       │
       ▼
GitHub Repository
```

## Project Goal

The goal of this project is to demonstrate the complete lifecycle of a modern data platform, starting from raw transactional data and ending with actionable business insights through a scalable and centralized analytics solution.

---

**Author:** Abdulrahman Samhan

**Role:** Data Engineer & Data Analyst

**Project Type:** End-to-End Data Engineering & Business Intelligence Solution 🚀
