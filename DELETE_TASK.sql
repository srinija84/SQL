 IF EXISTS(SELECT DISTINCT pt.PersonTaskId
 from cms.PersonTasks pt 
 where pt.url = 'Document/DocumentPosting?selectedDocumentId=11278,11277,11276,11211,11165,11164,11163,11162,11161,11160,11159&&protocolName=17-0010&&CAdmin=Approved') 

				  BEGIN 
      BEGIN TRAN t1; 

      delete from  cms.persontasks               
      WHERE  cms.persontasks.url = 'Document/DocumentPosting?selectedDocumentId=11278,11277,11276,11211,11165,11164,11163,11162,11161,11160,11159&&protocolName=17-0010&&CAdmin=Approved'

      delete from cms.tasks
	  where cms.tasks.uniqueid = '1EA4BC98-6868-431E-BB26-F5A8B36F8AC8' and cms.tasks.taskid = 288

	IF ( @@ERROR > 0 ) 
        BEGIN 
            ROLLBACK TRAN t1; 

            PRINT 'An error has occurred while deleting task id'; 
        END 
      ELSE 
        BEGIN 
            COMMIT TRAN t1; 

            PRINT 'deleted record successfully' 
        END 
  END 
ELSE 
  BEGIN 
      PRINT 'task does not exists' 
  END 