Drop table Build;
Create table Build(Build_id NCHAR(50),[Status] NCHAR(50), Branch NCHAR(50),Start_Time NCHAR(50),End_Time NCHAR(50),Build_started_by NCHAR(50),Repository NCHAR(50))
SELECT Build_id ,[Status] , Branch ,Start_Time,End_Time ,Build_started_by ,Repository FROM OPENROWSET(
    BULK  'Blob/output_Final.json',
    DATA_SOURCE = 'MyAzureBlobStorage31',
     SINGLE_CLOB
     ) AS DataFile
 CROSS APPLY OPENJSON(BulkColumn)
 WITH (Build_id NCHAR(50),[Status] NCHAR(50), Branch NCHAR(50),Start_Time NCHAR(50),End_Time NCHAR(50),Build_started_by NCHAR(50),Repository NCHAR(50)) as BuildDetail
INSERT INTO Build with (TABLOCK) (Build_id ,[Status] , Branch ,Start_Time,End_Time ,Build_started_by ,Repository)
 SELECT Build_id ,[Status] , Branch ,Start_Time,End_Time ,Build_started_by ,Repository FROM OPENROWSET(
    BULK  'Blob/output_Final.json',
    DATA_SOURCE = 'MyAzureBlobStorage31',
     SINGLE_CLOB
     ) AS DataFile
 CROSS APPLY OPENJSON(BulkColumn)
 WITH (Build_id NCHAR(50),[Status] NCHAR(50), Branch NCHAR(50),Start_Time NCHAR(50),End_Time NCHAR(50),Build_started_by NCHAR(50),Repository NCHAR(50)) as BuildDetail
