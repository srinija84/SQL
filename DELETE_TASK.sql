 IF EXISTS(SELECT DISTINCT pt.PersonTaskId
 from cms.PersonTasks pt 
 where pt.url = 'URL') 

				  BEGIN 
      BEGIN TRAN t1; 

      delete from  cms.persontasks               
      WHERE  cms.persontasks.url = 'URL'

      delete from cms.tasks
	  where cms.tasks.uniqueid = 'abc' and cms.tasks.taskid = 123

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
