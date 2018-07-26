USE [CMS] 

go 

/****** Object:  StoredProcedure [dbo].[sp_Delete_MeetingId]    Script Date: 5/17/2018 10:06:25 AM ******/ 
SET ansi_nulls ON 

go 

SET quoted_identifier ON 

go 

CREATE PROCEDURE [dbo].[Sp_delete_meetingid](@MeetingId      INTEGER, 
                                             @ProtocolNumber VARCHAR(200)) 
AS 
  BEGIN 
      SET nocount ON; 

      IF ( EXISTS(SELECT M.meetingid 
                  FROM   cms.protocols P 
                         INNER JOIN cms.meetings M 
                                 ON P.protocolid = M.protocolid 
                                    AND P.protocolid = P.protocolid 
                  WHERE  P.protocolnumber = @ProtocolNumber 
                         AND M.meetingid = @MeetingId) 
           AND (SELECT Count(*) 
                FROM   cms.protocols P 
                       INNER JOIN cms.meetings M 
                               ON P.protocolid = M.protocolid 
                                  AND P.protocolid = P.protocolid 
                WHERE  P.protocolnumber = @ProtocolNumber 
                       AND M.meetingid = @MeetingId) = 1 ) 
        BEGIN 
            BEGIN TRAN t1; 

            UPDATE d 
            SET    d.meetingid = NULL 
            FROM   cms.documentassociations d 
            WHERE  d.documentassociationid IN 
                   (SELECT DISTINCT d.documentassociationid 
                    FROM   cms.documentassociations d 
                           INNER JOIN cms.meetings M 
                                   ON D.meetingid = 
                                      M.meetingid 
                    WHERE  M.meetingid = @MeetingId 
                           AND M.protocolid = 
                               (SELECT P.protocolid 
                                FROM   cms.protocols P 
                                WHERE 
                               P.protocolnumber = 
                               @ProtocolNumber 
                               )) 

            PRINT 'MeetingId is updated to null' 

            DELETE cms.meetingrecommendations 
            FROM   cms.meetingrecommendations MR 
                   INNER JOIN cms.meetings M 
                           ON MR.meetingid = M.meetingid 
                   INNER JOIN cms.protocols P 
                           ON M.protocolid = P.protocolid 
            WHERE  M.meetingid = @MeetingId 
                   AND P.protocolid = (SELECT P.protocolid 
                                       FROM   cms.protocols P 
                                       WHERE  P.protocolnumber = @ProtocolNumber 
                                      ) 

            PRINT 'MeetingId is deleted in meetingrecommendations' 

            DELETE cms.meetinginvitees 
            FROM   cms.meetinginvitees 
                   INNER JOIN cms.meetings M 
                           ON cms.meetinginvitees.meetingid = M.meetingid 
                              AND cms.meetinginvitees.meetingid = M.meetingid 
                   INNER JOIN cms.protocols P 
                           ON M.protocolid = P.protocolid 
            WHERE  M.meetingid = @MeetingId 
                   AND P.protocolid = (SELECT P.protocolid 
                                       FROM   cms.protocols P 
                                       WHERE  P.protocolnumber = @ProtocolNumber 
                                      ) 

            PRINT 'MeetingId is deleted in meetinginvitees' 

            DELETE cms.meetings 
            FROM   cms.meetings M 
                   INNER JOIN cms.protocols P 
                           ON P.protocolid = M.protocolid 
                              AND P.protocolid = P.protocolid 
            WHERE  M.meetingid = @MeetingId 
                   AND P.protocolid = (SELECT P.protocolid 
                                       FROM   cms.protocols P 
                                       WHERE  P.protocolnumber = @ProtocolNumber 
                                      ) 

            PRINT 'MeetingId is deleted in meetings' 

            IF ( @@ERROR > 0 ) 
              BEGIN 
                  ROLLBACK TRAN t1; 

                  PRINT 'An error has occurred while deleting Meeting ID'; 
              END 
            ELSE 
              BEGIN 
                  COMMIT TRAN t1; 

                  PRINT 'deleted record successfully' 
              END 
        END 
      ELSE 
        BEGIN 
            PRINT 'Meeting ID does not exists' 
        END 
  END 