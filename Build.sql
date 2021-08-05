Drop table Build;
Create table Build(Build_id NCHAR(50),Build_Started_By NCHAR(50), Time_Started NCHAR(50),Time_Elapsed NCHAR(50),Branch NCHAR(50),Repository NCHAR(50),Build_Pass_Fail NCHAR(50))
SELECT Build_id ,Build_Started_By , Time_Started,Time_Elapsed,Branch,Repository,Build_Pass_Fail FROM OPENROWSET(
    BULK  'Blob/output_Final.json',
    DATA_SOURCE = 'MyAzureBlobStorage30',
     SINGLE_CLOB
     ) AS DataFile
 CROSS APPLY OPENJSON(BulkColumn)
 WITH (Build_id NCHAR(50),Build_Started_By NCHAR(50), Time_Started NCHAR(50),Time_Elapsed NCHAR(50),Branch NCHAR(50),Repository NCHAR(50),Build_Pass_Fail NCHAR(50)) as BuildDetail
INSERT INTO Build with (TABLOCK) (Build_id ,Build_Started_By , Time_Started,Time_Elapsed,Branch,Repository,Build_Pass_Fail)
 SELECT Build_id ,Build_Started_By , Time_Started,Time_Elapsed,Branch,Repository,Build_Pass_Fail FROM OPENROWSET(
    BULK  'Blob/output_Final.json',
    DATA_SOURCE = 'MyAzureBlobStorage30',
     SINGLE_CLOB
     ) AS DataFile
 CROSS APPLY OPENJSON(BulkColumn)
 WITH (Build_id NCHAR(50),Build_Started_By NCHAR(50), Time_Started NCHAR(50),Time_Elapsed NCHAR(50),Branch NCHAR(50),Repository NCHAR(50),Build_Pass_Fail NCHAR(50)) as BuildDetail
