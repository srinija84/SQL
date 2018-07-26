IF EXISTS (SELECT * 
           FROM   [CMS].[contactmechanisms] CM 
           WHERE  CM.valuetext LIKE '%lsimms7@jhmi.edu%') 
  BEGIN 
      PRINT 'User already have the email (lsimms7@jhmi.edu) IN ContactMechanisms'; 
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
                   'lsimms7@jhmi.edu', 
                   'Active', 
                   'skatikineni@tech-res.com', 
                   'skatikineni@tech-res.com') 

      IF ( @@ERROR > 0 ) 
        BEGIN 
            ROLLBACK TRAN t1; 

            PRINT 'An error has occurred while inserting the CONTACTMECHANISM lsimms7@jhmi.edu .';
        END 
      ELSE 
        BEGIN 
            COMMIT TRAN t1; 

            PRINT 'CONTACTMECHANISM lsimms7@jhmi.edu IS INSERTED'; 
        END 
  END 

IF EXISTS (SELECT * 
           FROM   [CMS].[contactmechanisms] CM 
           WHERE  CM.valuetext LIKE '%lgreen1@som.umaryland.edu%') 
  BEGIN 
      PRINT 'User already have the email (lgreen1@som.umaryland.edu) IN [ContactMechanisms]';
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
                   'lgreen1@som.umaryland.edu', 
                   'Active', 
                   'skatikineni@tech-res.com', 
                   'skatikineni@tech-res.com') 

      IF ( @@ERROR > 0 ) 
        BEGIN 
            ROLLBACK TRAN t2; 

            PRINT 'An error has occurred while inserting the CONTACTMECHANISM lgreen1@som.umaryland.edu .';
        END 
      ELSE 
        BEGIN 
            COMMIT TRAN t2; 

            PRINT 'IN CONTACTMECHANISM lgreen1@som.umaryland.edu IS INSERTED'; 
        END 
  END 

IF NOT EXISTS (SELECT * 
               FROM   [CMS].[contactmechanisms] CM 
               WHERE  CM.valuetext LIKE '%epokhrel@fhcrc.org%') 
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
                   'epokhrel@fhcrc.org', 
                   'Active', 
                   'skatikineni@tech-res.com', 
                   'skatikineni@tech-res.com') 

      IF ( @@ERROR > 0 ) 
        BEGIN 
            ROLLBACK TRAN t3; 

            PRINT 'An error has occurred while inserting the CONTACTMECHANISM epokhrel@fhcrc.org .';
        END 
      ELSE 
        BEGIN 
            COMMIT TRAN t3; 

            PRINT 'IN CONTACTMECHANISM epokhrel@fhcrc.org IS INSERTED'; 
        END 
  END 
ELSE 
  BEGIN 
      PRINT 'User already have the email (epokhrel@fhcrc.org) IN [ContactMechanisms]'; 
  END 

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
                  AND PCM.[partycontacttypename] = 'Email' 
                  AND CM.valuetext LIKE '%barbosal@nhlbi.nih.gov%') 
  BEGIN 
      PRINT 'User already have the email (barbosal@nhlbi.nih.gov) IN [PartyContactMechanisms]';
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
      WHERE  P.firstname LIKE '%luiz%' 
             AND P.lastname LIKE '%barbosa%' 
             AND PCM.[partycontacttypename] IN ( 'Email', 'Email #2' ) 
             AND CM.valuetext LIKE '%nemog@nhlbi.nih.gov%' 

      IF ( @@ERROR > 0 ) 
        BEGIN 
            ROLLBACK TRAN t4; 

            PRINT 'An error has occurred while deleteing the PartyContactMechanisms nemog@nhlbi.nih.gov .';
        END 
      ELSE 
        BEGIN 
            COMMIT TRAN t4; 

            PRINT 'USER LUIZ BARBOSA WITH nemog@nhlbi.nih.gov HAVE BEEN DELETED IN PartyContactMechanisms';
        END 
  END 