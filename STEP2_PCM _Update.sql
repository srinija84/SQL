IF EXISTS (SELECT CM.contactmechanismid 
           FROM   cms.partycontactmechanisms PCM 
                  INNER JOIN cms.contactmechanisms CM 
                          ON PCM.contactmechanismid = CM.contactmechanismid 
                  INNER JOIN cms.persontypes PT 
                          ON PCM.persontypeid = PT.persontypeid 
                  INNER JOIN cms.persons P 
                          ON PT.personid = P.personid 
           WHERE  P.firstname LIKE '%Eva%' 
                  AND P.lastname LIKE '%Pokhrel%' 
                  AND PCM.partycontacttypename = 'Assistant Email' 
                --  AND CM.valuetext LIKE '%epokhrel@fhcrc.org%'
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
                 WHERE  P.firstname LIKE '%Eva%' 
                        AND P.lastname LIKE '%Pokhrel%' 
                        AND PCM.partycontacttypename = 'Assistant Email' 
                       -- AND CM.valuetext LIKE '%epokhrel@fhcrc.org%' 
                        AND pcm.contactmechanismid = (SELECT TOP 1 CM.contactmechanismid 
                                                      FROM   cms.contactmechanisms CM 
                                                      WHERE  CM.valuetext = 'epokhrel@fhcrc.org'
                                                             AND CM.contacttype = 'Email')) 
        BEGIN 
            PRINT 'record already updated for eva pokhrel in partycontactmechanisms ' 
        END 
      ELSE 
        BEGIN 
            BEGIN TRAN t1; 

            UPDATE [CMS].[partycontactmechanisms] 
            SET    contactmechanismid = (SELECT TOP 1 CM.contactmechanismid 
                                         FROM   cms.contactmechanisms CM 
                                         WHERE  CM.valuetext = 'epokhrel@fhcrc.org' 
                                                AND CM.contacttype = 'Email') 
            WHERE  partycontactmechanismid = (SELECT TOP 1 PCM.[partycontactmechanismid] 
                                              FROM   cms.partycontactmechanisms PCM 
                                                     INNER JOIN cms.persontypes PT 
                                                             ON PCM.persontypeid = PT.persontypeid
                                                     INNER JOIN cms.persons P 
                                                             ON PT.personid = P.personid 
                                              WHERE  P.firstname LIKE '%Eva%' 
                                                     AND P.lastname LIKE '%Pokhrel%' 
                                                     AND partycontacttypename = 'Assistant Email')

            IF ( @@ERROR > 0 ) 
              BEGIN 
                  ROLLBACK TRAN t1; 

                  PRINT 'An error has occurred while updating the PartryCONTACTMECHANISM epokhrel@fhcrc.org .';
              END 
            ELSE 
              BEGIN 
                  COMMIT TRAN t1; 

                  PRINT 'PartyContactMechanisms UPDATED FOR Eva Pokhrel' 
              END 
        END 
  END 
ELSE 
  BEGIN 
      PRINT 'Record Eva Pokhrel not present in Partry Contact Mechanism ' 
  END 

IF EXISTS (SELECT CM.contactmechanismid 
           FROM   cms.partycontactmechanisms PCM 
                  INNER JOIN cms.contactmechanisms CM 
                          ON PCM.contactmechanismid = CM.contactmechanismid 
                  INNER JOIN cms.persontypes PT 
                          ON PCM.persontypeid = PT.persontypeid 
                  INNER JOIN cms.persons P 
                          ON PT.personid = P.personid 
           WHERE  P.firstname LIKE '%LaShae%' 
                  AND P.lastname LIKE '%Green%' 
                  AND PCM.[partycontacttypename] = 'Email' 
                  --AND CM.valuetext LIKE '%lgreen1@som.umaryland.edu%') 
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
                 WHERE  P.firstname LIKE '%LaShae%' 
                        AND P.lastname LIKE '%Green%' 
                        AND PCM.[partycontacttypename] = 'Email' 
                       -- AND CM.valuetext LIKE '%lgreen1@som.umaryland.edu%' 
                        AND pcm.contactmechanismid = (SELECT TOP 1 CM.contactmechanismid 
                                                      FROM   cms.contactmechanisms CM 
                                                      WHERE  CM.valuetext = 'lgreen1@som.umaryland.edu'
                                                             AND CM.contacttype = 'Email')) 
        BEGIN 
            PRINT 'record already updated for lashae green in partycontactmechanisms ' 
        END 
      ELSE 
        BEGIN 
            BEGIN TRAN t2; 

            UPDATE [CMS].[partycontactmechanisms] 
            SET    contactmechanismid = (SELECT TOP 1 CM.contactmechanismid 
                                         FROM   cms.contactmechanisms CM 
                                         WHERE  CM.valuetext = 'lgreen1@som.umaryland.edu' 
                                                AND CM.contacttype = 'Email') 
            WHERE  partycontactmechanismid = (SELECT TOP 1 PCM.[partycontactmechanismid] 
                                              FROM   cms.partycontactmechanisms PCM 
                                                     INNER JOIN cms.persontypes PT 
                                                             ON PCM.persontypeid = PT.persontypeid
                                                     INNER JOIN cms.persons P 
                                                             ON PT.personid = P.personid 
                                              WHERE  P.firstname LIKE '%LaShae%' 
                                                     AND P.lastname LIKE '%Green%' 
                                                     AND pcm.partycontacttypename = 'Email') 

            IF ( @@ERROR > 0 ) 
              BEGIN 
                  ROLLBACK TRAN t2; 

                  PRINT 'An error has occurred while updating the PartryCONTACTMECHANISM LaShae Green .';
              END 
            ELSE 
              BEGIN 
                  COMMIT TRAN t2; 

                  PRINT 'PartyContactMechanisms UPDATED FOR LaShae Green' 
              END 
        END 
  END 
ELSE 
  BEGIN 
      PRINT 'Record LaShae Green does not exist in Party Contact Mechanisms' 
  END 

IF EXISTS (SELECT CM.contactmechanismid 
           FROM   cms.partycontactmechanisms PCM 
                  INNER JOIN cms.contactmechanisms CM 
                          ON PCM.contactmechanismid = CM.contactmechanismid 
                  INNER JOIN cms.persontypes PT 
                          ON PCM.persontypeid = PT.persontypeid 
                  INNER JOIN cms.persons P 
                          ON PT.personid = P.personid 
           WHERE  P.firstname LIKE '%Latasha%' 
                  AND P.lastname LIKE '%Simms%' 
                  AND PCM.partycontacttypename = 'Assistant Email' 
                 -- AND CM.valuetext LIKE '%lsimms7@jhmi.edu%') 
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
                 WHERE  P.firstname LIKE '%Latasha%' 
                        AND P.lastname LIKE '%Simms%' 
                        AND PCM.partycontacttypename = 'Assistant Email' 
                      --  AND CM.valuetext LIKE '%lsimms7@jhmi.edu%' 
                        AND pcm.contactmechanismid = (SELECT TOP 1 CM.contactmechanismid 
                                                      FROM   cms.contactmechanisms CM 
                                                      WHERE  CM.valuetext = 'lsimms7@jhmi.edu'
                                                             AND CM.contacttype = 'Email')) 
        BEGIN 
            PRINT 'record already updated for latasha isimms in partycontactmechanisms ' 
        END 
      ELSE 
        BEGIN 
            BEGIN TRAN t3; 

            UPDATE [CMS].[partycontactmechanisms] 
            SET    contactmechanismid = (SELECT TOP 1 CM.contactmechanismid 
                                         FROM   cms.contactmechanisms CM 
                                         WHERE  CM.valuetext = 'lsimms7@jhmi.edu' 
                                                AND CM.contacttype = 'Email') 
            WHERE  partycontactmechanismid = (SELECT TOP 1 PCM.[partycontactmechanismid] 
                                              FROM   cms.partycontactmechanisms PCM 
                                                     INNER JOIN cms.persontypes PT 
                                                             ON PCM.persontypeid = PT.persontypeid
                                                     INNER JOIN cms.persons P 
                                                             ON PT.personid = P.personid 
                                              WHERE  P.firstname LIKE '%Latasha%' 
                                                     AND P.lastname LIKE '%Simms%' 
                                                     AND partycontacttypename = 'Assistant Email')

            IF ( @@ERROR > 0 ) 
              BEGIN 
                  ROLLBACK TRAN t3; 

                  PRINT 'An error has occurred while updating the PartryCONTACTMECHANISM Latasha Simms .';
              END 
            ELSE 
              BEGIN 
                  COMMIT TRAN t3; 

                  PRINT 'PartyContactMechanisms UPDATED FOR Latasha Simms' 
              END 
        END 
  END 
ELSE 
  BEGIN 
      PRINT 'Record Latasha Simms does not exist in Party Contact Mechanisms' 
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
           WHERE  P.firstname LIKE '%Luiz%' 
                  AND P.lastname LIKE '%Barbosa%' 
                  AND PCM.[partycontacttypename] = 'Email #2' 
                  AND CM.valuetext LIKE '%barbosal@nhlbi.nih.gov%') 
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
                                        WHERE  P.firstname LIKE '%Luiz%' 
                                               AND P.lastname LIKE '%Barbosa%' 
                                               AND partycontacttypename = 'Email #2') 

      IF ( @@ERROR > 0 ) 
        BEGIN 
            ROLLBACK TRAN t4; 

            PRINT 'An error has occurred while updating the PartryCONTACTMECHANISM luiz barbosa .';
        END 
      ELSE 
        BEGIN 
            COMMIT TRAN t4; 

            PRINT 'PartyContactMechanisms UPDATED FOR luiz barbosa' 
        END 
  END 
ELSE 
  BEGIN 
      PRINT 'Record exists in Party Contact Mechanisms correctly for luiz barbosa' 
  END 