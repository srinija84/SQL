IF ( EXISTS(SELECT pcm.partycontactmechanismid, 
                       cm.valuetext, 
                       pcm.partycontacttypename, 
                       pcm.contactmechanismid, 
                       PT.persontypeid, 
                       P.personid, 
                       p.firstname, 
                       p.lastname, 
                       pcm.partypairid, 
                       cm.contacttype, 
                       CM.contactmechanismid 
                FROM   cms.partycontactmechanisms PCM 
                       INNER JOIN cms.contactmechanisms CM 
                               ON PCM.contactmechanismid = CM.contactmechanismid 
                       INNER JOIN cms.persontypes PT 
                               ON PCM.persontypeid = PT.persontypeid 
                       INNER JOIN cms.persons P 
                               ON PT.personid = P.personid 
                WHERE  P.firstname LIKE '%Wyza%' 
                       AND P.lastname LIKE '%Margaret%') 
     AND (SELECT Count(*) 
          FROM   cms.partycontactmechanisms PCM 
                 INNER JOIN cms.contactmechanisms CM 
                         ON PCM.contactmechanismid = CM.contactmechanismid 
                 INNER JOIN cms.persontypes PT 
                         ON PCM.persontypeid = PT.persontypeid 
                 INNER JOIN cms.persons P 
                         ON PT.personid = P.personid 
          WHERE  P.firstname LIKE '%Wyza%' 
                 AND P.lastname LIKE '%Margaret%')  = 1 )
				   BEGIN 
      BEGIN TRAN t1; 

      DELETE partycontactmechanisms 
      FROM   cms.partycontactmechanisms 
             INNER JOIN cms.persontypes 
                     ON cms.partycontactmechanisms.persontypeid = cms.persontypes.persontypeid
             INNER JOIN cms.persons 
                     ON cms.persontypes.personid = cms.persons.personid 
      WHERE  persons.firstname LIKE '%Wyza%' 
             AND persons.lastname LIKE '%Margaret%' 

      PRINT 'PartyContactMechanisms DELETED FOR WYZA MARGARET' 

      DELETE partyaddresses 
      FROM   cms.partyaddresses 
             INNER JOIN cms.partypairs 
                     ON cms.partyaddresses.partypairid = cms.partypairs.partypairid 
             INNER JOIN cms.persontypes 
                     ON cms.partyaddresses.persontypeid = cms.persontypes.persontypeid 
                         OR cms.partypairs.ptyestablishedfromid = cms.persontypes.persontypeid
                            AND cms.partypairs.ptyestablishedtoid = cms.persontypes.persontypeid
             INNER JOIN cms.persons 
                     ON cms.persontypes.personid = cms.persons.personid 
      WHERE  persons.firstname LIKE '%Wyza%' 
             AND persons.lastname LIKE '%Margaret%' 

      PRINT 'PartyAddresses DELETED FOR WYZA MARGARET' 

      DELETE partypairs 
      FROM   cms.partypairs 
             INNER JOIN cms.persontypes 
                     ON cms.partypairs.ptyestablishedfromid = cms.persontypes.persontypeid 
                         OR cms.partypairs.ptyestablishedtoid = cms.persontypes.persontypeid 
             INNER JOIN cms.persons 
                     ON cms.persontypes.personid = cms.persons.personid 
      WHERE  persons.firstname LIKE '%Wyza%' 
             AND persons.lastname LIKE '%Margaret%' 

      PRINT 'PartyPairs DELETED FOR WYZA MARGARET' 

      DELETE persontypes 
      FROM   cms.persontypes 
             INNER JOIN cms.persons 
                     ON cms.persontypes.personid = cms.persons.personid 
      WHERE  persons.firstname LIKE '%Wyza%' 
             AND persons.lastname LIKE '%Margaret%' 

      PRINT 'PersonTypes DELETED FOR WYZA MARGARET' 

      DELETE cms.persons 
      FROM   cms.persons P 
      WHERE  P.firstname LIKE '%Wyza%' 
             AND P.lastname LIKE '%Margaret%' 

      PRINT 'Persons DELETED FOR WYZA MARGARET' 

      IF ( @@ERROR > 0 ) 
        BEGIN 
            ROLLBACK TRAN t1; 

            PRINT 'An error has occurred while deleting Wyza Margaret'; 
        END 
      ELSE 
        BEGIN 
            COMMIT TRAN t1; 

            PRINT 'deleted record successfully Wyza Margaret' 
        END 
  END 

ELSE 
  BEGIN 
      PRINT 'USER DOES NOT EXIST' 
  END 
