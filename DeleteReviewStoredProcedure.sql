USE [CMS] 

go 

/****** Object:  StoredProcedure [dbo].[sp_Delete_taskId_ReviewId]    Script Date: 06/20/2018 10:06:25 AM ******/ 
SET ansi_nulls ON 

go 

SET quoted_identifier ON 

go 

CREATE PROCEDURE [dbo].[sp_Delete_taskId_ReviewId](@ReviewName VARCHAR(200), 
                                             @ProtocolNumber VARCHAR(200)) 
AS 
  BEGIN 
      SET nocount ON; 
	  IF EXISTS(SELECT DISTINCT r.reviewid 
          FROM   cms.reviews r 
                 INNER JOIN cms.documentassociations d 
                         ON r.reviewid = d.reviewid 
                 INNER JOIN cms.protocols p 
                         ON p.protocolid = d.protocolid 
          WHERE  r.ReviewName = @ReviewName
                 AND p.protocolnumber = @ProtocolNumber) 
  BEGIN 
      BEGIN TRAN t1; 

      SELECT DISTINCT pt.persontaskid 
      INTO   #temp_persontasks 
      FROM   cms.persontasks pt 
             INNER JOIN cms.reviews r 
                     ON r.reviewid = pt.responseids 
                        AND pt.responsetype = 'Review' 
             INNER JOIN cms.documentassociations d 
                     ON d.reviewid = r.reviewid 
             INNER JOIN cms.protocols p 
                     ON p.protocolid = d.protocolid 
      WHERE  r.reviewname = @ReviewName 
             AND p.protocolnumber = @ProtocolNumber 

      SELECT DISTINCT t.taskid 
      INTO   #temp_tasks 
      FROM   cms.tasks t 
             INNER JOIN cms.persontasks pt 
                     ON t.taskid = pt.taskid 
             INNER JOIN cms.reviews r 
                     ON r.reviewid = pt.responseids 
                        AND pt.responsetype = 'Review' 
             INNER JOIN cms.documentassociations d 
                     ON d.reviewid = r.reviewid 
             INNER JOIN cms.protocols p 
                     ON p.protocolid = d.protocolid 
      WHERE  r.ReviewName = @ReviewName
             AND p.protocolnumber = @ProtocolNumber

      SELECT DISTINCT dp.documentpermissionid 
      INTO   #temp_docpermissions 
      FROM   cms.documentpermissions dp 
             INNER JOIN cms.documentassociations d 
                     ON d.documentassociationid = dp.documentassociationid 
             INNER JOIN cms.reviews r 
                     ON d.reviewid = r.reviewid 
      WHERE  r.ReviewName =@ReviewName

      SELECT DISTINCT s.documentsigntrackingid 
      INTO   #temp_docsigners 
      FROM   cms.documentsigners s 
             INNER JOIN cms.documentsigntrackings dt 
                     ON s.documentsigntrackingid = dt.documentsigntrackingid 
             INNER JOIN cms.documentassociations d 
                     ON d.documentassociationid = 
                        dt.documentassociationidaftersigning 
                        AND d.documentassociationid = 
                            dt.documentassociationidbeforesigning 
             INNER JOIN cms.reviews r 
                     ON d.reviewid = r.reviewid 
             INNER JOIN cms.protocols p 
                     ON p.protocolid = d.protocolid 
      WHERE  r.ReviewName =@ReviewName
             AND p.protocolnumber = @ProtocolNumber 

      SELECT DISTINCT dt.documentsigntrackingid 
      INTO   #temp_docsigntrack 
      FROM   cms.documentsigntrackings dt 
             INNER JOIN cms.documentsigners s 
                     ON s.documentsigntrackingid = dt.documentsigntrackingid 
             INNER JOIN cms.documentassociations d 
                     ON d.documentassociationid = 
                        dt.documentassociationidaftersigning 
                        AND d.documentassociationid = 
                            dt.documentassociationidbeforesigning 
             INNER JOIN cms.reviews r 
                     ON d.reviewid = r.reviewid 
             INNER JOIN cms.protocols p 
                     ON p.protocolid = d.protocolid 
      WHERE  r.ReviewName = @ReviewName
             AND p.protocolnumber = @ProtocolNumber 

      SELECT DISTINCT d.documentassociationid 
      INTO   #temp_docassociations 
      FROM   cms.documentassociations d 
             INNER JOIN cms.reviews r 
                     ON d.reviewid = r.reviewid 
      WHERE  r.ReviewName =@ReviewName

      SELECT DISTINCT rq.reviewid 
      INTO   #temp_reviewquestions 
      FROM   cms.reviewquestions rq 
             INNER JOIN cms.reviews r 
                     ON r.reviewid = rq.reviewid 
      WHERE  r.ReviewName =@ReviewName

      SELECT DISTINCT rc.reviewid 
      INTO   #temp_reviewcomments 
      FROM   cms.reviewcomments rc 
             INNER JOIN cms.reviews r 
                     ON r.reviewid = rc.reviewid 
      WHERE  r.ReviewName =@ReviewName 

      SELECT DISTINCT r.reviewid 
      INTO   #temp_reviews 
      FROM   cms.reviews r 
      WHERE  r.ReviewName= @ReviewName

      DELETE FROM cms.persontasks 
      WHERE  persontaskid IN (SELECT * 
                              FROM   #temp_persontasks) 

      print 'deleted person tasks'

      DELETE FROM cms.tasks 
      WHERE  taskid IN (SELECT * 
                        FROM   #temp_tasks) 

      PRINT 'deleted tasks' 

      DELETE FROM cms.documentpermissions 
      WHERE  documentpermissionid IN (SELECT * 
                                      FROM   #temp_docpermissions) 

      PRINT 'deleted documentpermissions' 

      DELETE FROM cms.documentsigners 
      WHERE  documentsigntrackingid IN (SELECT * 
                                        FROM   #temp_docsigners) 

      PRINT 'deleted documentsigners' 

      DELETE FROM cms.documentsigntrackings 
      WHERE  documentsigntrackingid IN (SELECT * 
                                        FROM   #temp_docsigntrack) 

      PRINT 'deleted documentsigntrackings' 

      DELETE FROM cms.documentassociations 
      WHERE  documentassociationid IN (SELECT * 
                                       FROM   #temp_docassociations) 

      PRINT 'deleted documentassociations' 

      DELETE FROM cms.reviewquestions 
      WHERE  reviewid IN (SELECT * 
                          FROM   #temp_reviewquestions) 

      PRINT 'deleted ReviewQuestions' 

      DELETE FROM cms.reviewcomments 
      WHERE  reviewid IN (SELECT * 
                          FROM   #temp_reviewcomments) 

      PRINT 'deleted reviewcomments' 

      DELETE FROM cms.reviews 
      WHERE  reviewid IN (SELECT * 
                          FROM   #temp_reviews) 

      PRINT 'deleted reviews' 

      IF ( @@ERROR > 0 ) 
        BEGIN 
            ROLLBACK TRAN t1; 

            PRINT 'An error has occurred while deleting review ID'; 
        END 
      ELSE 
        BEGIN 
            COMMIT TRAN t1; 

            PRINT 'deleted record successfully' 
        END 
  END 
ELSE 
  BEGIN 
      PRINT 'Review ID does not exists' 
  END 

  END