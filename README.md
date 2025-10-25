# Supply Chain & Logistics Intelligence Platform

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white) 
![AWS](https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazon-aws&logoColor=white) ![Tableau](https://img.shields.io/badge/Tableau-E97627?style=for-the-badge&logo=tableau&logoColor=white)

##  Project Overview

This project is an end-to-end simulation of a modern data analytics platform for a global supply chain fictional company. It involves designing a relational database, deploying it on a cloud service (AWS RDS), generating realistic data, performing in-depth analysis with SQL, and building a suite of interactive business intelligence dashboards in Tableau.

Business Problem: The company lacked visibility into inventory levels, supplier performance, customer behavior, and operational efficiency, leading to stockouts, delayed deliveries, and missed revenue opportunities.

Solution: Designed and deployed a cloud-based analytics platform with real-time dashboards providing actionable insights for decision-makers.

**[ View the Live Interactive Dashboards on Tableau Public](https://public.tableau.com/app/profile/rishitha.g.m/viz/Supplychain_Database_Analysis/Dashboard1)**

---

##  Technical Architecture

The project follows a standard, scalable analytics architecture. Data is centrally stored in a managed cloud database, which serves as the single source for the analytical front-end (Tableau), ensuring consistency and reliability.

* **Data Storage (Backend):** A **PostgreSQL** relational database hosted on **Amazon Web Services (AWS) RDS**. This provides a secure, scalable, and production-ready foundation.
* **Data Transformation:** A set of four optimized **SQL Views** were created within the database. These views pre-join and pre-calculate complex metrics, simplifying the connection for BI tools and ensuring consistent business logic.
* **Data Visualization (Frontend):** Four interactive dashboards built in **Tableau**, connected **live** to the PostgreSQL views in AWS. This allows for near real-time analysis.


---

##  Project Workflow

The project was executed in five distinct phases, mirroring a real-world analytics project lifecycle.

### 1. Database Design & Schema Creation
* **What:** A relational database schema with 14 tables was designed to model the complex entities of a supply chain, including suppliers, products, inventory, purchases, sales, and shipments.
* **How:** The schema was normalized to the Third Normal Form (3NF) to ensure data integrity. The `schema.sql` script defines all tables, primary/foreign keys, constraints, and performance-enhancing indexes.
* **Why:** A well-designed schema is the foundation of any reliable data platform. Normalization prevents data anomalies, and indexes ensure that analytical queries can run efficiently.

### 2. Data Generation & ETL
* **What:** A synthetic dataset of over 50,000 records was generated to simulate three years of business operations (2022-2024).
* **How:** Using advanced PostgreSQL functions like `generate_series` and `RANDOM()`, the `data.sql` script populates the database with logically consistent data, including sequential dates and varied product orders.
* **Why:** The data was designed to include trends and variations necessary to derive actionable business insights.

### 3. Advanced SQL Analysis & Views
* **What:** A portfolio of 10+ complex SQL queries was written to answer specific business questions. To optimize the Tableau connection, the core logic was consolidated into four powerful database views defined in `views.sql`.
* **How:** The queries utilize a wide range of SQL skills, including multi-table `JOIN`s, window functions (`LAG`), Common Table Expressions (CTEs), and conditional logic (`CASE`).
* **Why:** This phase translates business questions into technical queries and extracts meaningful information. The views act as a semantic layer, providing clean, pre-processed data sources for visualization.

### 4. Data Visualization & Dashboarding
* **What:** Four interactive dashboards were created in Tableau to present insights to different business stakeholders like Executives, Inventory Managers, Marketing, and Product Teams.
* **How:** Tableau was connected **live** to the SQL views in the AWS database. Dashboards were built with a focus on user experience, incorporating global filters, drill-downs, and interactive actions.
* **Why:** Effective data visualization tells a clear story, allowing non-technical users to understand complex trends, identify problems, and make data-driven decisions.
---


##  Tableau Dashboard Showcase

Four distinct dashboards were created, each tailored to a specific business function.

### 1. Executive Sales Dashboard
**Target Audience:** C-Suite, Sales Leadership
Provides a high-level overview of key business KPIs, including revenue trends, top customers, and regional performance.

### 2. Inventory Management Dashboard
**Target Audience:** Supply Chain Managers, Warehouse Operations
An operational dashboard to monitor stock levels, identify items needing urgent restock, and visualize the financial value of inventory across warehouses.

### 3. Customer Analytics Dashboard
**Target Audience:** Marketing, Sales Strategy
A deep-dive into customer behavior, featuring RFM segmentation, a breakdown of customer status (Active, At Risk), and a ranked list of the most valuable customers.

### 4. Product Performance Dashboard
**Target Audience:** Product Management, Merchandising
An analytical tool to assess product profitability, compare category performance, and identify top-selling items using a "magic quadrant" profitability matrix.

---

##  How to Run This Project

To set up and run this project, you will need:
* An AWS Account
* A PostgreSQL client (like DBeaver)
* Tableau (Public or Desktop)

**Steps:**
1.  **Set up AWS RDS:** Create a new PostgreSQL instance on AWS RDS. Configure its security group to allow connections from your current IP address on port 5432.
2.  **Connect DBeaver:** Connect your SQL client to the RDS instance using the endpoint, username, and password.
3.  **Create Schema & Views:** Execute the `01-database/schema.sql` script, This will create all tables.
4.  **Load Data:** Execute the `01-database/data.sql` script to populate the database and the `02-sql-queries/views.sql` script. This will create all views.
5.  **Connect Tableau:** Open the `.twbx` file from the `04-tableau` folder. Tableau will prompt you to edit the connection. Enter your own AWS RDS credentials to connect the dashboard to your live database.

---

##  Project Folder Structure
supplychain_Database_Project/
 01-database/
 -  schema.sql
 -  data.sql
 02-sql queries/
 03-sql outputs/
 04-tableau/
  - DASHBOARD1_customer analytics dashboard.twb
  -  DASHBOARD2_sales analytics dashboard.twb
  -  DASHBOARD3_product analytics dashboard.twb
  -  DASHBOARD4_inventory analytics dashboard.twb
 05-documentation/
    screenshots/           
      README.md
