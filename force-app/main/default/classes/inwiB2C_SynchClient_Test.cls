@isTest(SeeAllData=true)
public with sharing class inwiB2C_SynchClient_Test {
    @isTest(SeeAllData=true)
    static void testVip(){    
        InwiB2C_Pays__c testPays = new InwiB2C_Pays__c();
        testPays.Name = 'test pays';        
        insert testPays;

        String idPays = testPays.Id;
        InwiB2C_Region__c testRegion = new InwiB2C_Region__c();
        testRegion.Name = 'test Region';
        testRegion.Pays__c = idPays;
        insert testRegion;


        String idRegsion = testRegion.Id;
        inwiB2C_Ville__c testVille = new inwiB2C_Ville__c();
        testVille.Name = 'test ville';
        testVille.InwiB2C_Region__c = idRegsion;
        insert testVille;

        String idVille = testVille.Id;

        InwiB2C_Address__c testAddress = new InwiB2C_Address__c();
        testAddress.InwiB2C_Adresse__c = 'test';
        testAddress.Name = 'Maroc Tanger,Tetouan LARACHE';
        testAddress.InwiB2C_Type_d_adresse__c = 'domicile';
        testAddress.inwiB2C_Ville__c = idVille;
        testAddress.InwiB2C_Pays__c = idPays;
        testAddress.InwiB2C_Region__c = idRegsion;
        testAddress.InwiB2C_Code_Postale__c = '16500';
        insert testAddress;

        String idAddress = testAddress.Id;

        //
        Contact testContact = new Contact();
        testContact.Birthdate=Date.newInstance(1995, 12, 9);
        testContact.Email='test@gmail.com';
        testContact.Fax='212555555555';
        testContact.Phone='212555555555';
        testContact.HomePhone='212555555555';
        testContact.FirstName='Test';
        testContact.LastName='Test';
        testContact.InwiB2C_Langue_Pr_f_r_e__c='Français';
        testContact.Salutation='Madame';
        testContact.InwiB2C_Niveau_d_tudes__c='Analphabète';
        testContact.InwiB2C_Anciennet__c='00 <= < 01';
        testContact.InwiB2C_Type_CIN__c='Passeport';
        insert testContact;
        String idContact = testContact.Id; 
        //
        Account testAccount = new Account();
        testAccount.Name='Test Account';
        testAccount.inwiB2C_managedInSF__c= true;
        testAccount.Inwib2c_VIP_Choix_principal_op_rateur__c= 'Autres';
        testAccount.Inwib2c_Abonnement_fixe__c=  'Autre';
        testAccount.vlocity_cmt__PersonContactId__c= idContact;
        testAccount.InwiB2C_Address__c= idAddress;
        testAccount.Inwib2c_Segment_valeur__c= 'Bronze';
        testAccount.Inwib2c_Segment_march__c= 'Particulier';
        insert testAccount;
        Test.StartTest(); 
        Map<String, Object> response = (Map<String, Object>)vlocity_cmt.IntegrationProcedureService.runIntegrationService('inwib2c_INWIB2C_getFicheClient',
            new Map<String, Object>{
                'AccountId' => testAccount.Id
            }, new Map<String, Object>());
        Test.StopTest();
        //System.assertEquals('joe@vlocity.com', response.get('ContactEmail'));
    }

    @isTest(SeeAllData=true)
    static  void testVip2(){
        List<Sync_Client__e> data = new List <Sync_Client__e>(); 
        
        InwiB2C_Pays__c testPays = new InwiB2C_Pays__c();
        testPays.Name = 'test pays';        
        insert testPays;

        String idPays = testPays.Id;
        InwiB2C_Region__c testRegion = new InwiB2C_Region__c();
        testRegion.Name = 'test Region';
        testRegion.Pays__c = idPays;
        insert testRegion;


        String idRegsion = testRegion.Id;
        inwiB2C_Ville__c testVille = new inwiB2C_Ville__c();
        testVille.Name = 'test ville';
        testVille.InwiB2C_Region__c = idRegsion;
        insert testVille;

        String idVille = testVille.Id;

        InwiB2C_Address__c testAddress = new InwiB2C_Address__c();
        testAddress.InwiB2C_Adresse__c = 'test';
        testAddress.Name = 'Maroc Tanger,Tetouan LARACHE';
        testAddress.InwiB2C_Type_d_adresse__c = 'domicile';
        testAddress.inwiB2C_Ville__c = idVille;
        testAddress.InwiB2C_Pays__c = idPays;
        testAddress.InwiB2C_Region__c = idRegsion;
        testAddress.InwiB2C_Code_Postale__c = '16500';
        insert testAddress;

        String idAddress = testAddress.Id;

        //
        Contact testContact = new Contact();
        testContact.Birthdate=Date.newInstance(1995, 12, 9);
        testContact.Email='test@gmail.com';
        testContact.Fax='212555555555';
        testContact.Phone='212555555555';
        testContact.HomePhone='212555555555';
        testContact.FirstName='Test';
        testContact.LastName='Test';
        testContact.InwiB2C_Langue_Pr_f_r_e__c='Français';
        testContact.Salutation='Madame';
        testContact.InwiB2C_Niveau_d_tudes__c='Analphabète';
        testContact.InwiB2C_Anciennet__c='00 <= < 01';
        testContact.InwiB2C_Type_CIN__c='Passeport';
        insert testContact;
        String idContact = testContact.Id; 
        //
        Account testAccount = new Account();
        testAccount.Name='Test Account';
        testAccount.inwiB2C_managedInSF__c= true;
        testAccount.Inwib2c_VIP_Choix_principal_op_rateur__c= 'Autres';
        testAccount.Inwib2c_Abonnement_fixe__c=  'Autre';
        testAccount.vlocity_cmt__PersonContactId__c= idContact;
        testAccount.InwiB2C_Address__c= idAddress;
        testAccount.Inwib2c_Segment_valeur__c= 'Bronze';
        testAccount.Inwib2c_Segment_march__c= 'Particulier';
        insert testAccount;
        Sync_Client__e testSynchroAccount = new Sync_Client__e(AccountId__c = testAccount.Id);
        data.add(testSynchroAccount);

        //
        Contact testContact2 = new Contact();
        testContact2.Birthdate=Date.newInstance(1995, 12, 9);
        testContact2.Email='test@gmail.com';
        testContact2.Fax='212555555555';
        testContact2.Phone='212555555555';
        testContact2.HomePhone='212555555555';
        testContact2.FirstName='Test';
        testContact2.LastName='Test';
        testContact2.InwiB2C_Langue_Pr_f_r_e__c='Français';
        testContact2.Salutation='Mademoiselle';
        testContact2.InwiB2C_Niveau_d_tudes__c='Ecole coranique';
        testContact2.InwiB2C_Anciennet__c='Dummy';
        testContact2.InwiB2C_Type_CIN__c='Carte de séjour';
        insert testContact2;
        //
        Account testAccount2 = new Account();
        testAccount2.Name='Test Account';
        testAccount2.inwiB2C_managedInSF__c= true;
        testAccount2.Inwib2c_VIP_Choix_principal_op_rateur__c= 'Qualité réseau';
        testAccount2.Inwib2c_Abonnement_fixe__c=  'Fixe IAM';
        testAccount2.vlocity_cmt__PersonContactId__c= testContact2.Id;
        testAccount2.InwiB2C_Address__c= idAddress;
        testAccount2.Inwib2c_Segment_valeur__c= 'Compte_Ferme';
        testAccount2.Inwib2c_Segment_march__c= 'Compte_Ferme';
        insert testAccount2;
        Sync_Client__e testSynchroAccount2 = new Sync_Client__e(AccountId__c = testAccount2.Id);
        data.add(testSynchroAccount2);

        //
        Contact testContact3 = new Contact();
        testContact3.Birthdate=Date.newInstance(1995, 12, 9);
        testContact3.Email='test@gmail.com';
        testContact3.Fax='212555555555';
        testContact3.Phone='212555555555';
        testContact3.HomePhone='212555555555';
        testContact3.FirstName='Test';
        testContact3.LastName='Test';
        testContact3.InwiB2C_Langue_Pr_f_r_e__c='Français';
        testContact3.Salutation='Mademoiselle';
        testContact3.InwiB2C_Niveau_d_tudes__c='Primaire pas terminé';
        testContact3.InwiB2C_Anciennet__c='SANS';
        testContact3.InwiB2C_Type_CIN__c='ONG';
        insert testContact3;
        //
        Account testAccount3 = new Account();
        testAccount3.Name='Test Account';
        testAccount3.inwiB2C_managedInSF__c= true;
        testAccount3.Inwib2c_VIP_Choix_principal_op_rateur__c= 'Prix';
        testAccount3.Inwib2c_Abonnement_fixe__c=  'Fixe Meditel';
        testAccount3.vlocity_cmt__PersonContactId__c= testContact3.Id;
        testAccount3.InwiB2C_Address__c= idAddress;
        testAccount3.Inwib2c_Segment_valeur__c= 'Entreprise';
        testAccount3.Inwib2c_Segment_march__c= 'Dealer';
        insert testAccount3;
        Sync_Client__e testSynchroAccount3 = new Sync_Client__e(AccountId__c = testAccount3.Id);
        data.add(testSynchroAccount3);

         //
         Contact testContact4 = new Contact();
         testContact4.Birthdate=Date.newInstance(1995, 12, 9);
         testContact4.Email='test@gmail.com';
         testContact4.Fax='212555555555';
         testContact4.Phone='212555555555';
         testContact4.HomePhone='212555555555';
         testContact4.FirstName='Test';
         testContact4.LastName='Test';
         testContact4.InwiB2C_Langue_Pr_f_r_e__c='Français';
         testContact4.Salutation='Mademoiselle';
         testContact4.InwiB2C_Niveau_d_tudes__c='Primaire terminé';
         testContact4.InwiB2C_Anciennet__c='01 <= < 02';
         testContact4.InwiB2C_Type_CIN__c='Association';
         insert testContact4;
         //
         Account testAccount4 = new Account();
         testAccount4.Name='Test Account';
         testAccount4.inwiB2C_managedInSF__c= true;
         testAccount4.Inwib2c_VIP_Choix_principal_op_rateur__c= 'Réputation de l’opérateur';
         testAccount4.Inwib2c_Abonnement_fixe__c=  'Fixe prépayé bayn';
         testAccount4.vlocity_cmt__PersonContactId__c= testContact4.Id;
         testAccount4.InwiB2C_Address__c= idAddress;
         testAccount4.Inwib2c_Segment_valeur__c= 'FM6';
         testAccount4.Inwib2c_Segment_march__c= 'Entreprise';
         insert testAccount4;
         Sync_Client__e testSynchroAccount4 = new Sync_Client__e(AccountId__c = testAccount4.Id);
         data.add(testSynchroAccount4);

          //
          Contact testContact5 = new Contact();
          testContact5.Birthdate=Date.newInstance(1995, 12, 9);
          testContact5.Email='test@gmail.com';
          testContact5.Fax='212555555555';
          testContact5.Phone='212555555555';
          testContact5.HomePhone='212555555555';
          testContact5.FirstName='Test';
          testContact5.LastName='Test';
          testContact5.InwiB2C_Langue_Pr_f_r_e__c='Français';
          testContact5.Salutation='Mademoiselle';
          testContact5.InwiB2C_Niveau_d_tudes__c='Secondaire 1r cycle pas terminé';
          testContact5.InwiB2C_Anciennet__c='02 <= < 05';
          testContact5.InwiB2C_Type_CIN__c='ESE';
          insert testContact5;
          //
          Account testAccount5 = new Account();
          testAccount5.Name='Test Account';
          testAccount5.inwiB2C_managedInSF__c= true;
          testAccount5.Inwib2c_VIP_Choix_principal_op_rateur__c= 'Réputation de l’opérateur';
          testAccount5.Inwib2c_Abonnement_fixe__c=  'Aucun';
          testAccount5.vlocity_cmt__PersonContactId__c= testContact5.Id;
          testAccount5.InwiB2C_Address__c= idAddress;
          testAccount5.Inwib2c_Segment_valeur__c= 'Gold';
          testAccount5.Inwib2c_Segment_march__c= 'Grandes téléboutiques';
          insert testAccount5;
          Sync_Client__e testSynchroAccount5 = new Sync_Client__e(AccountId__c = testAccount5.Id);
          data.add(testSynchroAccount5);

          //
          Contact testContact6 = new Contact();
          testContact6.Birthdate=Date.newInstance(1995, 12, 9);
          testContact6.Email='test@gmail.com';
          testContact6.Fax='212555555555';
          testContact6.Phone='212555555555';
          testContact6.HomePhone='212555555555';
          testContact6.FirstName='Test';
          testContact6.LastName='Test';
          testContact6.InwiB2C_Langue_Pr_f_r_e__c='Français';
          testContact6.Salutation='Mademoiselle';
          testContact6.InwiB2C_Niveau_d_tudes__c='Secondaire 1r cycle terminé';
          testContact6.InwiB2C_Anciennet__c='05 <= < 10';
          testContact6.InwiB2C_Type_CIN__c='Ambassade';
          insert testContact6;
          //
          Account testAccount6 = new Account();
          testAccount6.Name='Test Account';
          testAccount6.inwiB2C_managedInSF__c= true;
          testAccount6.Inwib2c_VIP_Choix_principal_op_rateur__c= 'Réputation de l’opérateur';
          testAccount6.Inwib2c_Abonnement_fixe__c=  'Aucun';
          testAccount6.vlocity_cmt__PersonContactId__c= testContact6.Id;
          testAccount6.InwiB2C_Address__c= idAddress;
          testAccount6.Inwib2c_Segment_valeur__c= 'Gold';
          testAccount6.Inwib2c_Segment_march__c= 'Grandes téléboutiques';
          insert testAccount6;
          Sync_Client__e testSynchroAccount6 = new Sync_Client__e(AccountId__c = testAccount6.Id);
          data.add(testSynchroAccount6);

          //
          Contact testContact7 = new Contact();
          testContact7.Birthdate=Date.newInstance(1995, 12, 9);
          testContact7.Email='test@gmail.com';
          testContact7.Fax='212555555555';
          testContact7.Phone='212555555555';
          testContact7.HomePhone='212555555555';
          testContact7.FirstName='Test';
          testContact7.LastName='Test';
          testContact7.InwiB2C_Langue_Pr_f_r_e__c='Français';
          testContact7.Salutation='Mademoiselle';
          testContact7.InwiB2C_Niveau_d_tudes__c='Secondaire 2d cycle pas terminé';
          testContact7.InwiB2C_Anciennet__c='10 <= < 20';
          testContact7.InwiB2C_Type_CIN__c='Ambassade';
          insert testContact7;
          //
          Account testAccount7 = new Account();
          testAccount7.Name='Test Account';
          testAccount7.inwiB2C_managedInSF__c= true;
          testAccount7.Inwib2c_VIP_Choix_principal_op_rateur__c= 'Réputation de l’opérateur';
          testAccount7.Inwib2c_Abonnement_fixe__c=  'Aucun';
          testAccount7.vlocity_cmt__PersonContactId__c= testContact7.Id;
          testAccount7.InwiB2C_Address__c= idAddress;
          testAccount7.Inwib2c_Segment_valeur__c= '1 mois';
          testAccount7.Inwib2c_Segment_march__c= 'Ligne_Test';
          insert testAccount7;
          Sync_Client__e testSynchroAccount7 = new Sync_Client__e(AccountId__c = testAccount7.Id);
          data.add(testSynchroAccount7);

          //
          Contact testContact8 = new Contact();
          testContact8.Birthdate=Date.newInstance(1995, 12, 9);
          testContact8.Email='test@gmail.com';
          testContact8.Fax='212555555555';
          testContact8.Phone='212555555555';
          testContact8.HomePhone='212555555555';
          testContact8.FirstName='Test';
          testContact8.LastName='Test';
          testContact8.InwiB2C_Langue_Pr_f_r_e__c='Français';
          testContact8.Salutation='Mademoiselle';
          testContact8.InwiB2C_Niveau_d_tudes__c='Secondaire 2d cycle terminé';
          testContact8.InwiB2C_Anciennet__c='20 <= < 30';
          testContact8.InwiB2C_Type_CIN__c='Ambassade';
          insert testContact8;
          //
          Account testAccount8 = new Account();
          testAccount8.Name='Test Account';
          testAccount8.inwiB2C_managedInSF__c= true;
          testAccount8.Inwib2c_VIP_Choix_principal_op_rateur__c= 'Réputation de l’opérateur';
          testAccount8.Inwib2c_Abonnement_fixe__c=  'Aucun';
          testAccount8.vlocity_cmt__PersonContactId__c= testContact8.Id;
          testAccount8.InwiB2C_Address__c= idAddress;
          testAccount8.Inwib2c_Segment_valeur__c= '2 mois';
          testAccount8.Inwib2c_Segment_march__c= 'Petites téléboutiques';
          insert testAccount8;
          Sync_Client__e testSynchroAccount8 = new Sync_Client__e(AccountId__c = testAccount8.Id);
          data.add(testSynchroAccount8);

          //
          Contact testContact9 = new Contact();
          testContact9.Birthdate=Date.newInstance(1995, 12, 9);
          testContact9.Email='test@gmail.com';
          testContact9.Fax='212555555555';
          testContact9.Phone='212555555555';
          testContact9.HomePhone='212555555555';
          testContact9.FirstName='Test';
          testContact9.LastName='Test';
          testContact9.InwiB2C_Langue_Pr_f_r_e__c='Français';
          testContact9.Salutation='Mademoiselle';
          testContact9.InwiB2C_Niveau_d_tudes__c='Supérieur pas terminé';
          testContact9.InwiB2C_Anciennet__c='30 >=';
          testContact9.InwiB2C_Type_CIN__c='Ambassade';
          insert testContact9;
          //
          Account testAccount9 = new Account();
          testAccount9.Name='Test Account';
          testAccount9.inwiB2C_managedInSF__c= true;
          testAccount9.Inwib2c_VIP_Choix_principal_op_rateur__c= 'Réputation de l’opérateur';
          testAccount9.Inwib2c_Abonnement_fixe__c=  'Aucun';
          testAccount9.vlocity_cmt__PersonContactId__c= testContact9.Id;
          testAccount9.InwiB2C_Address__c= idAddress;
          testAccount9.Inwib2c_Segment_valeur__c= '3 mois';
          testAccount9.Inwib2c_Segment_march__c= 'Super Dealer';
          insert testAccount9;
          Sync_Client__e testSynchroAccount9 = new Sync_Client__e(AccountId__c = testAccount9.Id);
          data.add(testSynchroAccount9);
        
        
        Test.startTest();
         List <Database.SaveResult> sresult = EventBus.publish(data);
        Test.stopTest();
        

    }

    
}