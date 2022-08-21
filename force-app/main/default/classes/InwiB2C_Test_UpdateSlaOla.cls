/*B-0162 RMA 11/01/2021 BEGIN*/
@isTest
public class InwiB2C_Test_UpdateSlaOla {
    @isTest
    static void MethodTestPositive() {
        /*B-0584 ZME 29.01.2021 BEGIN*/
        Profile profileTestUserVIP = [SELECT Id FROM Profile WHERE Name='SC Agent VIP Int']; 

        /*Profile profileTestUserVIP = new Profile();
        profileTestUserVIP.Name = 'SC Agent VIP Int';
        insert profileTestUserVIP;*/

        User userTestVIP = new User(Alias = 'VIP', Email='TestUserVIP@inwiB2cDevOrg.com', EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                                    ProfileId = profileTestUserVIP.Id, TimeZoneSidKey='America/Los_Angeles', UserName='VIPTestUser@inwiB2cDevOrg.com');
        System.runAs(userTestVIP){
            case caseUserTestVIP =new case(Type='Inwib2c_Reclamation',
                                           Description='Réclamation',
                                           Subject='Réclamation',
                                           origin='Appel entrant',
                                           status ='Ouvert',
                                           Inwib2c_Cat_gorie__c='Inwib2c_Recharge_Reclamation',
                                           InwiB2C_TypeSpecialite__c='Envoi SMS'
                                          );
            insert caseUserTestVIP;
        }
        Profile profileTestUserFraude = [SELECT Id FROM Profile WHERE Name='Fraude Int']; 
        /*Profile profileTestUserFraude = new Profile();
        profileTestUserFraude.Name = 'Fraude Int';
        insert profileTestUserFraude;*/
        User userTestFraude = new User(Alias = 'Fraude', Email='TestUserFraude@inwiB2cDevOrg.com', EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                                       ProfileId = profileTestUserFraude.Id, TimeZoneSidKey='America/Los_Angeles', UserName='FraudeTestUser@inwiB2CDevOrg.com');
        System.runAs(userTestFraude){
            case caseUserTestFraude =new case(Type='Inwib2c_Reclamation',
                                              Description='Réclamation',
                                              Subject='Réclamation',
                                              origin='Appel entrant',
                                              status ='Ouvert',
                                              Inwib2c_Cat_gorie__c=' Inwib2c_Recharge_Reclamation',
                                              InwiB2C_TypeSpecialite__c='Envoi SMS');
            insert caseUserTestFraude;
        }
        /*B-0584 ZME 29.01.2021 END*/
        
        vlocity_cmt__Subscription__c sub =new vlocity_cmt__Subscription__c(InwiB2C_MEI__c='356623026584884' ,
                                                                           Inwib2c_Type_de_forfait__c='Mobile' ,Inwib2c_ICC__c='892128510050195818', Inwib2c_type_de_sim__c='GSM',
                                                                           Inwib2c_SegmentLigne__c='Premium',vlocity_cmt__SubscriptionNumber__c='212080634558',Name='test'
                                                                          );
        insert sub;
        String idSouscription= sub.id;
        
        vlocity_cmt__Subscription__c sub1 =new vlocity_cmt__Subscription__c(InwiB2C_MEI__c='356623026584884' ,
                                                                            Inwib2c_Type_de_forfait__c='Mobile' ,Inwib2c_ICC__c='892128510050195818', Inwib2c_type_de_sim__c='GSM',
                                                                            Inwib2c_SegmentLigne__c='Platinium',vlocity_cmt__SubscriptionNumber__c='212008063458',Name='teste'
                                                                           );
        insert sub1;
        String idSouscription1= sub1.id;
        
        vlocity_cmt__Subscription__c sub2 =new vlocity_cmt__Subscription__c(InwiB2C_MEI__c='356623026584884' ,
                                                                            Inwib2c_Type_de_forfait__c='Mobile' ,Inwib2c_ICC__c='892128510050195818', Inwib2c_type_de_sim__c='GSM',
                                                                            Inwib2c_SegmentLigne__c='Gold',vlocity_cmt__SubscriptionNumber__c='2120804563458',Name='tests'
                                                                           );
        insert sub2;
        String idSouscription2= sub2.id;
        
        vlocity_cmt__Subscription__c sub3 =new vlocity_cmt__Subscription__c(InwiB2C_MEI__c='356623026584884' ,
                                                                            Inwib2c_Type_de_forfait__c='Mobile' ,Inwib2c_ICC__c='892128510050195818', Inwib2c_type_de_sim__c='GSM',
                                                                            Inwib2c_SegmentLigne__c='Iron',vlocity_cmt__SubscriptionNumber__c='21208048563458',Name='testss'
                                                                           );
        insert sub3;
        String idSouscription3= sub3.id;
        
        vlocity_cmt__Subscription__c sub4 =new vlocity_cmt__Subscription__c(InwiB2C_MEI__c='356623026584884' ,
                                                                            Inwib2c_Type_de_forfait__c='Mobile' ,Inwib2c_ICC__c='892128510050195818', Inwib2c_type_de_sim__c='GSM',
                                                                            Inwib2c_SegmentLigne__c='Silver',vlocity_cmt__SubscriptionNumber__c='21208504563458',Name='tessts'
                                                                           );
        insert sub4;
        String idSouscription4= sub4.id;
        
        case case1=new case(Type='Inwib2c_Reclamation' ,Description='A' ,Subject='B', origin='Appel entrant',status ='Ouvert'
                            ,InwiB2C_TypeSpecialite__c='Envoi SMS',Inwib2c_Cat_gorie__c=' Inwib2c_Reseau_Reclamation',
                            Inwib2c_IMEI_terminal__c='aa',Inwib2c_Model_article__c='ss',Inwib2c_Code_article__c='ss',INWIB2C_Recapitulatif__c='aeassa',
                            Inwib2c_MEID_Pack_SIM__c='ss',InwiB2C_SegmentClient__c='dff',vlocity_cmt__SubscriptionId__c=idSouscription);
        insert case1;
        
        case case2=new case(Type='Inwib2c_Reclamation' ,Description='A' ,Subject='B', origin='Appel entrant',status ='Ouvert'
                            ,InwiB2C_TypeSpecialite__c='Envoi SMS',Inwib2c_Cat_gorie__c=' Inwib2c_Reseau_Reclamation',
                            Inwib2c_IMEI_terminal__c='aa',Inwib2c_Model_article__c='ss',Inwib2c_Code_article__c='ss',INWIB2C_Recapitulatif__c='aeassa',
                            Inwib2c_MEID_Pack_SIM__c='ss',InwiB2C_SegmentClient__c='dff',vlocity_cmt__SubscriptionId__c=idSouscription1);
        insert case2;
        
        case case3=new case(Type='Inwib2c_Reclamation' ,Description='A' ,Subject='B', origin='Appel entrant',status ='Ouvert'
                            ,InwiB2C_TypeSpecialite__c='Envoi SMS',Inwib2c_Cat_gorie__c=' Inwib2c_Reseau_Reclamation',
                            Inwib2c_IMEI_terminal__c='aa',Inwib2c_Model_article__c='ss',Inwib2c_Code_article__c='ss',INWIB2C_Recapitulatif__c='aeassa',
                            Inwib2c_MEID_Pack_SIM__c='ss',InwiB2C_SegmentClient__c='dff',vlocity_cmt__SubscriptionId__c=idSouscription2);
        insert case3;
        
        case case4=new case(Type='Inwib2c_Reclamation' ,Description='A' ,Subject='B', origin='Appel entrant',status ='Ouvert'
                            ,InwiB2C_TypeSpecialite__c='Envoi SMS',Inwib2c_Cat_gorie__c=' Inwib2c_Reseau_Reclamation',
                            Inwib2c_IMEI_terminal__c='aa',Inwib2c_Model_article__c='ss',Inwib2c_Code_article__c='ss',INWIB2C_Recapitulatif__c='aeassa',
                            Inwib2c_MEID_Pack_SIM__c='ss',InwiB2C_SegmentClient__c='dff',vlocity_cmt__SubscriptionId__c=idSouscription3);
        insert case4;
        
        case case5=new case(Type='Inwib2c_Reclamation' ,Description='A' ,Subject='B', origin='Appel entrant',status ='Ouvert'
                            ,InwiB2C_TypeSpecialite__c='Envoi SMS',Inwib2c_Cat_gorie__c=' Inwib2c_Reseau_Reclamation',
                            Inwib2c_IMEI_terminal__c='aa',Inwib2c_Model_article__c='ss',Inwib2c_Code_article__c='ss',INWIB2C_Recapitulatif__c='aeassa',
                            Inwib2c_MEID_Pack_SIM__c='ss',InwiB2C_SegmentClient__c='dff',vlocity_cmt__SubscriptionId__c=idSouscription4);
        insert case5;
        
        case case6=new case(Type='Inwib2c_Reclamation' ,Description='A' ,Subject='B', origin='Appel entrant',status ='Ouvert'
                            ,InwiB2C_TypeSpecialite__c='Envoi SMS',Inwib2c_Cat_gorie__c=' Inwib2c_Couverture',
                            Inwib2c_IMEI_terminal__c='aa',Inwib2c_Model_article__c='ss',Inwib2c_Code_article__c='ss',INWIB2C_Recapitulatif__c='aeassa',
                            Inwib2c_MEID_Pack_SIM__c='ss',InwiB2C_SegmentClient__c='dff',vlocity_cmt__SubscriptionId__c=idSouscription4);
        insert case6;
        
        case case7=new case(Type='Inwib2c_Reclamation' ,Description='A' ,Subject='B', origin='Appel entrant',status ='Ouvert'
                            ,InwiB2C_TypeSpecialite__c='Envoi SMS',Inwib2c_Cat_gorie__c=' Inwib2c_Couverture',
                            Inwib2c_IMEI_terminal__c='aa',Inwib2c_Model_article__c='ss',Inwib2c_Code_article__c='ss',INWIB2C_Recapitulatif__c='aeassa',
                            Inwib2c_MEID_Pack_SIM__c='ss',InwiB2C_SegmentClient__c='dff',vlocity_cmt__SubscriptionId__c=idSouscription);
        insert case7;
        
        case case8=new case(Type='Inwib2c_Reclamation' ,Description='A' ,Subject='B', origin='Appel entrant',status ='Ouvert'
                            ,InwiB2C_TypeSpecialite__c='Envoi SMS',Inwib2c_Cat_gorie__c=' Inwib2c_Couverture',
                            Inwib2c_IMEI_terminal__c='aa',Inwib2c_Model_article__c='ss',Inwib2c_Code_article__c='ss',INWIB2C_Recapitulatif__c='aeassa',
                            Inwib2c_MEID_Pack_SIM__c='ss',InwiB2C_SegmentClient__c='dff',vlocity_cmt__SubscriptionId__c=idSouscription2);
        insert case8;
        
        case case9=new case(Type='Inwib2c_Reclamation' ,Description='A' ,Subject='B', origin='Appel entrant',status ='Ouvert'
                            ,InwiB2C_TypeSpecialite__c='Envoi SMS',Inwib2c_Cat_gorie__c=' Inwib2c_Recharge_Reclamation',
                            Inwib2c_IMEI_terminal__c='aa',Inwib2c_Model_article__c='ss',Inwib2c_Code_article__c='ss',INWIB2C_Recapitulatif__c='aeassa',
                            Inwib2c_MEID_Pack_SIM__c='ss',InwiB2C_SegmentClient__c='dff',vlocity_cmt__SubscriptionId__c=idSouscription);
        insert case9;
        
        case case10=new case(Type='Inwib2c_Reclamation' ,Description='A' ,Subject='B', origin='Appel entrant',status ='Ouvert'
                             ,InwiB2C_TypeSpecialite__c='Envoi SMS',Inwib2c_Cat_gorie__c=' Inwib2c_Recharge_Reclamation',
                             Inwib2c_IMEI_terminal__c='aa',Inwib2c_Model_article__c='ss',Inwib2c_Code_article__c='ss',INWIB2C_Recapitulatif__c='aeassa',
                             Inwib2c_MEID_Pack_SIM__c='ss',InwiB2C_SegmentClient__c='dff',vlocity_cmt__SubscriptionId__c=idSouscription2);
        insert case10;
        
        case case11=new case(Type='Inwib2c_Reclamation' ,Description='A' ,Subject='B', origin='Appel entrant',status ='Ouvert'
                             ,InwiB2C_TypeSpecialite__c='Envoi SMS',Inwib2c_Cat_gorie__c=' Inwib2c_Recharge_Reclamation',
                             Inwib2c_IMEI_terminal__c='aa',Inwib2c_Model_article__c='ss',Inwib2c_Code_article__c='ss',INWIB2C_Recapitulatif__c='aeassa',
                             Inwib2c_MEID_Pack_SIM__c='ss',InwiB2C_SegmentClient__c='dff',vlocity_cmt__SubscriptionId__c=idSouscription3);
        insert case11;
        
        case case12=new case(Type='Inwib2c_Reclamation' ,Description='A' ,Subject='B', origin='Appel entrant',status ='Ouvert'
                             ,InwiB2C_TypeSpecialite__c='Envoi SMS',Inwib2c_Cat_gorie__c=' Inwib2c_Facturation_Reclamation',
                             Inwib2c_IMEI_terminal__c='aa',Inwib2c_Model_article__c='ss',Inwib2c_Code_article__c='ss',INWIB2C_Recapitulatif__c='aeassa',
                             Inwib2c_MEID_Pack_SIM__c='ss',InwiB2C_SegmentClient__c='dff',vlocity_cmt__SubscriptionId__c=idSouscription);
        insert case12;
        
        case case13=new case(Type='Inwib2c_Reclamation' ,Description='A' ,Subject='B', origin='Appel entrant',status ='Ouvert'
                             ,InwiB2C_TypeSpecialite__c='Envoi SMS',Inwib2c_Cat_gorie__c=' Inwib2c_Gestion_Compte_Client_Reclamation',
                             Inwib2c_IMEI_terminal__c='aa',Inwib2c_Model_article__c='ss',Inwib2c_Code_article__c='ss',INWIB2C_Recapitulatif__c='aeassa',
                             Inwib2c_MEID_Pack_SIM__c='ss',InwiB2C_SegmentClient__c='dff',vlocity_cmt__SubscriptionId__c=idSouscription);
        insert case13;
        
        case case14=new case(Type='Inwib2c_Reclamation' ,Description='A' ,Subject='B', origin='Appel entrant',status ='Ouvert'
                             ,InwiB2C_TypeSpecialite__c='Envoi SMS',Inwib2c_Cat_gorie__c=' Inwib2c_Gestion_Compte_Client_Reclamation',
                             Inwib2c_IMEI_terminal__c='aa',Inwib2c_Model_article__c='ss',Inwib2c_Code_article__c='ss',INWIB2C_Recapitulatif__c='aeassa',
                             Inwib2c_MEID_Pack_SIM__c='ss',InwiB2C_SegmentClient__c='dff',vlocity_cmt__SubscriptionId__c=idSouscription2);
        insert case14;
        
        case case15=new case(Type='Inwib2c_Reclamation' ,Description='A' ,Subject='B', origin='Appel entrant',status ='Ouvert'
                             ,InwiB2C_TypeSpecialite__c='Envoi SMS',Inwib2c_Cat_gorie__c=' Inwib2c_Gestion_Compte_Client_Reclamation',
                             Inwib2c_IMEI_terminal__c='aa',Inwib2c_Model_article__c='ss',Inwib2c_Code_article__c='ss',INWIB2C_Recapitulatif__c='aeassa',
                             Inwib2c_MEID_Pack_SIM__c='ss',InwiB2C_SegmentClient__c='dff',vlocity_cmt__SubscriptionId__c=idSouscription4);
        insert case15;
        
        case case16=new case(Type='Inwib2c_Reclamation' ,Description='A' ,Subject='B', origin='Appel entrant',status ='Ouvert'
                             ,InwiB2C_TypeSpecialite__c='Envoi SMS',Inwib2c_Cat_gorie__c=' Inwib2c_Assistance_service _Reclamation',
                             Inwib2c_IMEI_terminal__c='aa',Inwib2c_Model_article__c='ss',Inwib2c_Code_article__c='ss',INWIB2C_Recapitulatif__c='aeassa',
                             Inwib2c_MEID_Pack_SIM__c='ss',InwiB2C_SegmentClient__c='dff',vlocity_cmt__SubscriptionId__c=idSouscription);
        insert case16;
        
        case case17=new case(Type='Inwib2c_Reclamation' ,Description='A' ,Subject='B', origin='Appel entrant',status ='Ouvert'
                             ,InwiB2C_TypeSpecialite__c='Envoi SMS',Inwib2c_Cat_gorie__c=' Inwib2c_Assistance_service _Reclamation',
                             Inwib2c_IMEI_terminal__c='aa',Inwib2c_Model_article__c='ss',Inwib2c_Code_article__c='ss',INWIB2C_Recapitulatif__c='aeassa',
                             Inwib2c_MEID_Pack_SIM__c='ss',InwiB2C_SegmentClient__c='dff',vlocity_cmt__SubscriptionId__c=idSouscription1);
        insert case17;
        
        
    }
}
/*B-0162 RMA 11/01/2021 END*/