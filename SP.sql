IF EXISTS (SELECT CM.contactmechanismid 
           FROM   cms.partycontactmechanisms PCM 
                  INNER JOIN cms.contactmechanisms CM 
                          ON PCM.contactmechanismid = CM.contactmechanismid 
                  INNER JOIN cms.persontypes PT 
                          ON PCM.persontypeid = PT.persontypeid 
                  INNER JOIN cms.persons P 
                          ON PT.personid = P.personid 
           WHERE  P.firstname LIKE '%Abc%' 
                  AND P.lastname LIKE '%Def%' 
                  AND PCM.partycontacttypename = 'Assistant Email' 
                --  AND CM.valuetext LIKE '%edef@fhcrc.org%'
				) 
  BEGIN 
      IF EXISTS (SELECT CM.contactmechanismid 
                 FROM   cms.partycontactmechanisms PCM 
                        INNER JOIN cms.contactmechanisms CM 
                                ON PCM.contactmechanismid = CM.contactmechanismid 
                        INNER JOIN cms.persontypes PT 
                                ON PCM.persontypeid = PT.persontypeid 
                        INNER JOIN cms.persons P 
                                ON PT.personid = P.personid 
                 WHERE  P.firstname LIKE '%Abc%' 
                        AND P.lastname LIKE '%Def%' 
                        AND PCM.partycontacttypename = 'Assistant Email' 
                       -- AND CM.valuetext LIKE '%edef@fhcrc.org%' 
                        AND pcm.contactmechanismid = (SELECT TOP 1 CM.contactmechanismid 
                                                      FROM   cms.contactmechanisms CM 
                                                      WHERE  CM.valuetext = 'edef@fhcrc.org'
                                                             AND CM.contacttype = 'Email')) 
        BEGIN 
            PRINT 'record already updated for abc def in partycontactmechanisms ' 
        END 
      ELSE 
        BEGIN 
            BEGIN TRAN t1; 

            UPDATE [CMS].[partycontactmechanisms] 
            SET    contactmechanismid = (SELECT TOP 1 CM.contactmechanismid 
                                         FROM   cms.contactmechanisms CM 
                                         WHERE  CM.valuetext = 'edef@fhcrc.org' 
                                                AND CM.contacttype = 'Email') 
            WHERE  partycontactmechanismid = (SELECT TOP 1 PCM.[partycontactmechanismid] 
                                              FROM   cms.partycontactmechanisms PCM 
                                                     INNER JOIN cms.persontypes PT 
                                                             ON PCM.persontypeid = PT.persontypeid
                                                     INNER JOIN cms.persons P 
                                                             ON PT.personid = P.personid 
                                              WHERE  P.firstname LIKE '%Abc%' 
                                                     AND P.lastname LIKE '%Def%' 
                                                     AND partycontacttypename = 'Assistant Email')

            IF ( @@ERROR > 0 ) 
              BEGIN 
                  ROLLBACK TRAN t1; 

                  PRINT 'An error has occurred while updating the PartryCONTACTMECHANISM edef@fhcrc.org .';
              END 
            ELSE 
              BEGIN 
                  COMMIT TRAN t1; 

                  PRINT 'PartyContactMechanisms UPDATED FOR Abc Def' 
              END 
        END 
  END 
ELSE 
  BEGIN 
      PRINT 'Record Abc Def not present in Partry Contact Mechanism ' 
  END 

IF EXISTS (SELECT CM.contactmechanismid 
           FROM   cms.partycontactmechanisms PCM 
                  INNER JOIN cms.contactmechanisms CM 
                          ON PCM.contactmechanismid = CM.contactmechanismid 
                  INNER JOIN cms.persontypes PT 
                          ON PCM.persontypeid = PT.persontypeid 
                  INNER JOIN cms.persons P 
                          ON PT.personid = P.personid 
           WHERE  P.firstname LIKE '%Ghi%' 
                  AND P.lastname LIKE '%Jkl%' 
                  AND PCM.[partycontacttypename] = 'Email' 
                  --AND CM.valuetext LIKE '%ljkl1@som.umarylandgmail.com%') 
				  )
  BEGIN 
      IF EXISTS (SELECT CM.contactmechanismid 
                 FROM   cms.partycontactmechanisms PCM 
                        INNER JOIN cms.contactmechanisms CM 
                                ON PCM.contactmechanismid = CM.contactmechanismid 
                        INNER JOIN cms.persontypes PT 
                                ON PCM.persontypeid = PT.persontypeid 
                        INNER JOIN cms.persons P 
                                ON PT.personid = P.personid 
                 WHERE  P.firstname LIKE '%Ghi%' 
                        AND P.lastname LIKE '%Jkl%' 
                        AND PCM.[partycontacttypename] = 'Email' 
                       -- AND CM.valuetext LIKE '%ljkl1@som.umarylandgmail.com%' 
                        AND pcm.contactmechanismid = (SELECT TOP 1 CM.contactmechanismid 
                                                      FROM   cms.contactmechanisms CM 
                                                      WHERE  CM.valuetext = 'ljkl1@som.umarylandgmail.com'
                                                             AND CM.contacttype = 'Email')) 
        BEGIN 
            PRINT 'record already updated for ghi jkl in partycontactmechanisms ' 
        END 
      ELSE 
        BEGIN 
            BEGIN TRAN t2; 

            UPDATE [CMS].[partycontactmechanisms] 
            SET    contactmechanismid = (SELECT TOP 1 CM.contactmechanismid 
                                         FROM   cms.contactmechanisms CM 
                                         WHERE  CM.valuetext = 'ljkl1@som.umarylandgmail.com' 
                                                AND CM.contacttype = 'Email') 
            WHERE  partycontactmechanismid = (SELECT TOP 1 PCM.[partycontactmechanismid] 
                                              FROM   cms.partycontactmechanisms PCM 
                                                     INNER JOIN cms.persontypes PT 
                                                             ON PCM.persontypeid = PT.persontypeid
                                                     INNER JOIN cms.persons P 
                                                             ON PT.personid = P.personid 
                                              WHERE  P.firstname LIKE '%Ghi%' 
                                                     AND P.lastname LIKE '%Jkl%' 
                                                     AND pcm.partycontacttypename = 'Email') 

            IF ( @@ERROR > 0 ) 
              BEGIN 
                  ROLLBACK TRAN t2; 

                  PRINT 'An error has occurred while updating the PartryCONTACTMECHANISM Ghi Jkl .';
              END 
            ELSE 
              BEGIN 
                  COMMIT TRAN t2; 

                  PRINT 'PartyContactMechanisms UPDATED FOR Ghi Jkl' 
              END 
        END 
  END 
ELSE 
  BEGIN 
      PRINT 'Record Ghi Jkl does not exist in Party Contact Mechanisms' 
  END 

IF EXISTS (SELECT CM.contactmechanismid 
           FROM   cms.partycontactmechanisms PCM 
                  INNER JOIN cms.contactmechanisms CM 
                          ON PCM.contactmechanismid = CM.contactmechanismid 
                  INNER JOIN cms.persontypes PT 
                          ON PCM.persontypeid = PT.persontypeid 
                  INNER JOIN cms.persons P 
                          ON PT.personid = P.personid 
           WHERE  P.firstname LIKE '%Mno%' 
                  AND P.lastname LIKE '%Pqr%' 
                  AND PCM.partycontacttypename = 'Assistant Email' 
                 -- AND CM.valuetext LIKE '%lpqr7@jhmigmail.com%') 
				 )
  BEGIN 
      IF EXISTS (SELECT CM.contactmechanismid 
                 FROM   cms.partycontactmechanisms PCM 
                        INNER JOIN cms.contactmechanisms CM 
                                ON PCM.contactmechanismid = CM.contactmechanismid 
                        INNER JOIN cms.persontypes PT 
                                ON PCM.persontypeid = PT.persontypeid 
                        INNER JOIN cms.persons P 
                 WHERE  P.firstname LIKE '%Mno%' 
                        AND P.lastname LIKE '%Pqr%' 
                        AND PCM.partycontacttypename = 'Assistant Email' 
                      --  AND CM.valuetext LIKE '%lpqr7@jhmigmail.com%' 
                        AND pcm.contactmechanismid = (SELECT TOP 1 CM.contactmechanismid 
                                                      FROM   cms.contactmechanisms CM 
                                                      WHERE  CM.valuetext = 'lpqr7@jhmigmail.com'
                                                             AND CM.contacttype = 'Email')) 
        BEGIN 
            PRINT 'record already updated for mno ipqr in partycontactmechanisms ' 
        END 
      ELSE 
        BEGIN 
            BEGIN TRAN t3; 

            UPDATE [CMS].[partycontactmechanisms] 
            SET    contactmechanismid = (SELECT TOP 1 CM.contactmechanismid 
                                         FROM   cms.contactmechanisms CM 
                                         WHERE  CM.valuetext = 'lpqr7@jhmigmail.com' 
                                                AND CM.contacttype = 'Email') 
            WHERE  partycontactmechanismid = (SELECT TOP 1 PCM.[partycontactmechanismid] 
                                              FROM   cms.partycontactmechanisms PCM 
                                                     INNER JOIN cms.persontypes PT 
                                                             ON PCM.persontypeid = PT.persontypeid
                                                     INNER JOIN cms.persons P 
                                                             ON PT.personid = P.personid 
                                              WHERE  P.firstname LIKE '%Mno%' 
                                                     AND P.lastname LIKE '%Pqr%' 
                                                     AND partycontacttypename = 'Assistant Email')

            IF ( @@ERROR > 0 ) 
              BEGIN 
                  ROLLBACK TRAN t3; 

                  PRINT 'An error has occurred while updating the PartryCONTACTMECHANISM Mno Pqr .';
              END 
            ELSE 
              BEGIN 
                  COMMIT TRAN t3; 

                  PRINT 'PartyContactMechanisms UPDATED FOR Mno Pqr' 
              END 
        END 
  END 
ELSE 
  BEGIN 
      PRINT 'Record Mno Pqr does not exist in Party Contact Mechanisms' 
  END 

--updating email #2 to email 
IF EXISTS (SELECT CM.contactmechanismid 
           FROM   cms.partycontactmechanisms PCM 
                  INNER JOIN cms.contactmechanisms CM 
                          ON PCM.contactmechanismid = CM.contactmechanismid 
                  INNER JOIN cms.persontypes PT 
                          ON PCM.persontypeid = PT.persontypeid 
                  INNER JOIN cms.persons P 
                          ON PT.personid = P.personid 
           WHERE  P.firstname LIKE '%Stu%' 
                  AND P.lastname LIKE '%Vwx%' 
                  AND PCM.[partycontacttypename] = 'Email #2' 
                  AND CM.valuetext LIKE '%vwxl@nhlbi.gmail.com%') 
  BEGIN 
      BEGIN TRAN t4; 

      UPDATE [CMS].[partycontactmechanisms] 
      SET    [partycontacttypename] = 'Email' 
      WHERE  partycontactmechanismid = (SELECT TOP 1 PCM.[partycontactmechanismid] 
                                        FROM   cms.partycontactmechanisms PCM 
                                               INNER JOIN cms.persontypes PT 
                                                       ON PCM.persontypeid = PT.persontypeid 
                                               INNER JOIN cms.persons P 
                                                       ON PT.personid = P.personid 
                                        WHERE  P.firstname LIKE '%Stu%' 
                                               AND P.lastname LIKE '%Vwx%' 
                                               AND partycontacttypename = 'Email #2') 

      IF ( @@ERROR > 0 ) 
        BEGIN 
            ROLLBACK TRAN t4; 

            PRINT 'An error has occurred while updating the PartryCONTACTMECHANISM stu vwx .';
        END 
      ELSE 
        BEGIN 
            COMMIT TRAN t4; 

            PRINT 'PartyContactMechanisms UPDATED FOR stu vwx' 
        END 
  END 
ELSE 
  BEGIN 
      PRINT 'Record exists in Party Contact Mechanisms correctly for stu vwx' 
  END 

