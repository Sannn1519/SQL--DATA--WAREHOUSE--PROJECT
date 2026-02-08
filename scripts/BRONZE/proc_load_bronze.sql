/*
======================================================================================
Store Procedure: Load Bronze Layer (source--> bronze)
=======================================================================================
Script Purpose:
  This stored procedure loads data into the 'bronze' schema from external csv files.
  It perform the following actions:
  -> Truncate the bronze table before loading data
  -> uses the 'Bulk Insert' command to load datra from csv files to bronze tables.
Parameters:
    none.
    this stored procedure does not accept any parameters or return any value.

Usage Example:
        EXEC bronze.load_bronze;
=======================================================================================
*/

CREATE OR ALTER PROCEDURE Bronze.load_bronze as 
BEGIN
	DECLARE @START_TIME DATETIME,@END_TIME DATETIME,@BATCH_START_TIME DATETIME,@BATCH_END_TIME DATETIME
	BEGIN TRY
		SET @BATCH_START_TIME=GETDATE();
		print'=============================';
		print'loading bronze layer'
		print'=============================';

		print'-----------------------------';
		print'LOADING CRM TABLE'
		print'-----------------------------';

		SET @START_TIME=GETDATE()
		PRINT'>> TRUNCATING TABLE:BRONZE.crm_cust_info'

		TRUNCATE TABLE BRONZE.crm_cust_info; -- USE REASON BCZ IN FUTURE WE MAY WANT TO RELOAD THE DATA IN THIS TABLE AUTOMATICALLY USING A PIPELINE, IN THAT CASE WE CAN USE THIS TRUNCATE STATEMENT TO CLEAR THE TABLE BEFORE LOADING THE DATA
		PRINT'>> INSERTING DATA INTO :BRONZE.crm_cust_info'

		BULK INSERT BRONZE.crm_cust_info
		from 'C:\Users\mukes\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\cust_info.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '\n',
			TABLOCK
		);
		SET @END_TIME=GETDATE();
		PRINT'>> LOAD DURATION: '+CAST(DATEDIFF(SECOND,@START_TIME,@END_TIME) AS NVARCHAR)+' SECONDS '
		PRINT'--------------------------------';


		SET @START_TIME=GETDATE()
		TRUNCATE TABLE BRONZE.crm_prd_info; -- USE REASON BCZ IN FUTURE WE MAY WANT TO RELOAD THE DATA IN THIS TABLE AUTOMATICALLY USING A PIPELINE, IN THAT CASE WE CAN USE THIS TRUNCATE STATEMENT TO CLEAR THE TABLE BEFORE LOADING THE DATA
		BULK INSERT BRONZE.crm_prd_info
		from 'C:\Users\mukes\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\prd_info.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '\n',
			TABLOCK
		);
		SET @END_TIME=GETDATE();
		PRINT'>> LOAD DURATION: '+CAST(DATEDIFF(SECOND,@START_TIME,@END_TIME) AS NVARCHAR)+' SECONDS '
		PRINT'--------------------------------';


		SET @START_TIME=GETDATE()
		TRUNCATE TABLE BRONZE.crm_sales_details;-- USE REASON BCZ IN FUTURE WE MAY WANT TO RELOAD THE DATA IN THIS TABLE AUTOMATICALLY USING A PIPELINE, IN THAT CASE WE CAN USE THIS TRUNCATE STATEMENT TO CLEAR THE TABLE BEFORE LOADING THE DATA
		BULK INSERT BRONZE.crm_sales_details
		from 'C:\Users\mukes\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\sales_details.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '\n',
			TABLOCK
		);
		SET @END_TIME=GETDATE();
		PRINT'>> LOAD DURATION: '+CAST(DATEDIFF(SECOND,@START_TIME,@END_TIME) AS NVARCHAR)+' SECONDS '
		PRINT'--------------------------------';

		print'============================='
		print'loading bronze layer'
		print'============================='

		print'-----------------------------'
		print'LOADING CRM TABLE'
		print'-----------------------------'

		SET @START_TIME=GETDATE()
		TRUNCATE TABLE BRONZE.erp_cust_az12;-- USE REASON BCZ IN FUTURE WE MAY WANT TO RELOAD THE DATA IN THIS TABLE AUTOMATICALLY USING A PIPELINE, IN THAT CASE WE CAN USE THIS TRUNCATE STATEMENT TO CLEAR THE TABLE BEFORE LOADING THE DATA
		BULK INSERT BRONZE.erp_cust_az12
		from 'C:\Users\mukes\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\cust_az12.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '\n',
			TABLOCK
		);
		SET @END_TIME=GETDATE();
		PRINT'>> LOAD DURATION: '+CAST(DATEDIFF(SECOND,@START_TIME,@END_TIME) AS NVARCHAR)+' SECONDS '
		PRINT'--------------------------------';

		SET @START_TIME=GETDATE()
		TRUNCATE TABLE BRONZE.erp_loc_a101;-- USE REASON BCZ IN FUTURE WE MAY WANT TO RELOAD THE DATA IN THIS TABLE AUTOMATICALLY USING A PIPELINE, IN THAT CASE WE CAN USE THIS TRUNCATE STATEMENT TO CLEAR THE TABLE BEFORE LOADING THE DATA
		BULK INSERT BRONZE.erp_loc_a101
		from 'C:\Users\mukes\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\loc_a101.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '\n',
			TABLOCK
		);
		SET @END_TIME=GETDATE();
		PRINT'>> LOAD DURATION: '+CAST(DATEDIFF(SECOND,@START_TIME,@END_TIME) AS NVARCHAR)+' SECONDS '
		PRINT'--------------------------------';

		SET @START_TIME=GETDATE()
		TRUNCATE TABLE BRONZE.erp_px_cat_g1v2;-- USE REASON BCZ IN FUTURE WE MAY WANT TO RELOAD THE DATA IN THIS TABLE AUTOMATICALLY USING A PIPELINE, IN THAT CASE WE CAN USE THIS TRUNCATE STATEMENT TO CLEAR THE TABLE BEFORE LOADING THE DATA
		BULK INSERT BRONZE.erp_px_cat_g1v2
		from 'C:\Users\mukes\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\px_cat_g1v2.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '\n',
			TABLOCK
		);
		SET @END_TIME=GETDATE();
		PRINT'>> LOAD DURATION: '+CAST(DATEDIFF(SECOND,@START_TIME,@END_TIME) AS NVARCHAR)+' SECONDS '
		PRINT'--------------------------------';

		SET @BATCH_END_TIME=GETDATE();
		PRINT'-- TOTAL LOAD DURATION WHOLE BRONZE LAYER : '+CAST(DATEDIFF(SECOND,@BATCH_START_TIME,@BATCH_END_TIME) AS NVARCHAR)+' SECONDS '
		PRINT'--------------------------------';
END TRY

BEGIN CATCH 
	PRINT'========================================'
	PRINT'ERROR OCCURED DURING LOADING BRONZE LAYER'
	PRINT'ERROR MESSAGE'+ERROR_MESSAGE();
	PRINT'ERROR MESSAGE'+CAST(ERROR_NUMBER() AS NVARCHAR);
	PRINT'ERROR MESSAGE'+CAST (ERROR_STATE() AS NVARCHAR);

	PRINT'========================================'

	
END CATCH

END

