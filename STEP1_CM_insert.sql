IF EXISTS (SELECT * 
           FROM   [CMS].[contactmechanisms] CM 
           WHERE  CM.valuetext LIKE '%abc@gmail.com%') 
  BEGIN 
      PRINT 'User already have the email (abc@gmail.com) IN ContactMechanisms'; 
  END 
ELSE 
  BEGIN 
      BEGIN TRAN t1 

      INSERT INTO cms.contactmechanisms 
                  ([tenantid], 
                   [uniqueid], 
                   [contacttype], 
                   [valuetext], 
                   [recordstatus], 
                   [createdby], 
                   [updatedby]) 
      VALUES      (1, 
                   Newid(), 
                   'Email', 
                   'abc@gmail.com', 
                   'Active', 
                   'def@gmail.com, 
                   'def@gmail.com) 

      IF ( @@ERROR > 0 ) 
        BEGIN 
            ROLLBACK TRAN t1; 

            PRINT 'An error has occurred while inserting the CONTACTMECHANISM abc@gmail.com .';
        END 
      ELSE 
        BEGIN 
            COMMIT TRAN t1; 

            PRINT 'CONTACTMECHANISM abc@gmail.com IS INSERTED'; 
        END 
  END 

IF EXISTS (SELECT * 
           FROM   [CMS].[contactmechanisms] CM 
           WHERE  CM.valuetext LIKE '%ghi@gmail.com%') 
  BEGIN 
      PRINT 'User already have the email (ghi@gmail.com) IN [ContactMechanisms]';
  END 
ELSE 
  BEGIN 
      BEGIN TRAN t2 

      INSERT INTO cms.contactmechanisms 
                  ([tenantid], 
                   [uniqueid], 
                   [contacttype], 
                   [valuetext], 
                   [recordstatus], 
                   [createdby], 
                   [updatedby]) 
      VALUES      (1, 
                   Newid(), 
                   'Email', 
                   'ghi@gmail.com', 
                   'Active', 
                   'def@gmail.com, 
                   'def@gmail.com) 

      IF ( @@ERROR > 0 ) 
        BEGIN 
            ROLLBACK TRAN t2; 

            PRINT 'An error has occurred while inserting the CONTACTMECHANISM ghi@gmail.com .';
        END 
      ELSE 
        BEGIN 
            COMMIT TRAN t2; 

            PRINT 'IN CONTACTMECHANISM ghi@gmail.com IS INSERTED'; 
        END 
  END 

IF NOT EXISTS (SELECT * 
               FROM   [CMS].[contactmechanisms] CM 
               WHERE  CM.valuetext LIKE '%jkl@gmail.com%') 
  BEGIN 
      BEGIN TRAN t3; 

      INSERT INTO cms.contactmechanisms 
                  ([tenantid], 
                   [uniqueid], 
                   [contacttype], 
                   [valuetext], 
                   [recordstatus], 
                   [createdby], 
                   [updatedby]) 
      VALUES      (1, 
                   Newid(), 
                   'Email', 
                   'jkl@gmail.com', 
                   'Active', 
                   'def@gmail.com, 
                   'def@gmail.com) 

      IF ( @@ERROR > 0 ) 
        BEGIN 
            ROLLBACK TRAN t3; 

            PRINT 'An error has occurred while inserting the CONTACTMECHANISM jkl@gmail.com .';
        END 
      ELSE 
        BEGIN 
            COMMIT TRAN t3; 

            PRINT 'IN CONTACTMECHANISM jkl@gmail.com IS INSERTED'; 
        END 
  END 
ELSE 
  BEGIN 
      PRINT 'User already have the email (jkl@gmail.com) IN [ContactMechanisms]'; 
  END 

IF EXISTS (SELECT CM.contactmechanismid 
           FROM   cms.partycontactmechanisms PCM 
                  INNER JOIN cms.contactmechanisms CM 
                          ON PCM.contactmechanismid = CM.contactmechanismid 
                  INNER JOIN cms.persontypes PT 
                          ON PCM.persontypeid = PT.persontypeid 
                  INNER JOIN cms.persons P 
                          ON PT.personid = P.personid 
           WHERE  P.firstname LIKE '%Jon%' 
                  AND P.lastname LIKE '%Rock%' 
                  AND PCM.[partycontacttypename] = 'Email' 
                  AND CM.valuetext LIKE '%mno@gmail.com%') 
  BEGIN 
      PRINT 'User already have the email (mno@gmail.com) IN [PartyContactMechanisms]';
  END 
ELSE 
  BEGIN 
      BEGIN TRAN t4 

      DELETE cms.partycontactmechanisms 
      FROM   cms.partycontactmechanisms PCM 
             INNER JOIN cms.contactmechanisms CM 
                     ON PCM.contactmechanismid = CM.contactmechanismid 
             INNER JOIN cms.persontypes PT 
                     ON PCM.persontypeid = PT.persontypeid 
             INNER JOIN cms.persons P 
                     ON PT.personid = P.personid 
      WHERE  P.firstname LIKE '%jon%' 
             AND P.lastname LIKE '%rock%' 
             AND PCM.[partycontacttypename] IN ( 'Email', 'Email #2' ) 
             AND CM.valuetext LIKE '%pqr@gmail.com%' 

      IF ( @@ERROR > 0 ) 
        BEGIN 
            ROLLBACK TRAN t4; 

            PRINT 'An error has occurred while deleteing the PartyContactMechanisms pqr@gmail.com .';
        END 
      ELSE 
        BEGIN 
            COMMIT TRAN t4; 

            PRINT 'USER JON ROCK WITH pqr@gmail.com HAVE BEEN DELETED IN PartyContactMechanisms';
        END 
  END 

