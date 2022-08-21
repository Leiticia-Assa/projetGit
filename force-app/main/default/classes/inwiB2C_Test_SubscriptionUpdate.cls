/*B-0162 MANSRim 01/01/2021 Begin*/

@isTest 
public class inwiB2C_Test_SubscriptionUpdate 
{
    @isTest(SeeAllData=true)

        Static void testMethod2()

	{
                  //User user = [Select ManagerId from User where Id = '0052z000000Qco7AAC '];

        Account testAccount  = new Account ();
        testAccount.Name = 'TestOxygeneParam';
        testAccount.AccountNumber = '123456';
        Insert testAccount;
        
        vlocity_cmt__Subscription__c testSubscription = new vlocity_cmt__Subscription__c();
        testSubscription.vlocity_cmt__AccountId__c = testAccount.Id;
        testSubscription.Inwib2c_Num_ro_de_la_ligne__c = '212600000021';
        testSubscription.vlocity_cmt__SubscriptionNumber__c = 	'212600000021';
        Insert testSubscription;

        case case1 =new case(Type='Inwib2c_Reclamation' ,Description='A' ,Subject='B', origin='C',status ='Ouvert'
                             ,InwiB2C_TypeSpecialite__c='InwiB2C_Roaming',Inwib2c_Cat_gorie__c=' Inwib2c_Reseau_Reclamation',
                             Inwib2c_IMEI_terminal__c='aa',Inwib2c_Model_article__c='ss',Inwib2c_Code_article__c='ss',
                             Inwib2c_MEID_Pack_SIM__c='ss',InwiB2C_SegmentClient__c='dff',vlocity_cmt__SubscriptionId__c=testSubscription.Id);
        insert case1;
        string idCase=case1.id;
        string idSub=case1.vlocity_cmt__SubscriptionId__c;
      
        vlocity_cmt__Subscription__c testSubscription2 = new vlocity_cmt__Subscription__c();
        testSubscription2.vlocity_cmt__AccountId__c = testAccount.Id;
        testSubscription2.Inwib2c_Num_ro_de_la_ligne__c = '212600000022';
        testSubscription2.vlocity_cmt__SubscriptionNumber__c = 	'212600000022';
        Insert testSubscription2;
        
        case1.Type='Inwib2c_Modification';
        case1.Inwib2c_IMEI_terminal__c='dd';
        case1.vlocity_cmt__SubscriptionId__c=testSubscription2.Id;
        update case1;
        
          vlocity_cmt__Subscription__c SubscriptionRecord= [ select InwiB2C_MEI__c,Inwib2c_Type_de_forfait__c,    Inwib2c_ICC__c,
                                                          Inwib2c_type_de_sim__c, Inwib2c_SegmentLigne__c from vlocity_cmt__Subscription__c
                                                          where id = :idSub];
        
        case1.Inwib2c_IMEI_terminal__c  = SubscriptionRecord.InwiB2C_MEI__c;
        case1.Inwib2c_Model_article__c=SubscriptionRecord.Inwib2c_Type_de_forfait__c;
        case1.Inwib2c_Code_article__c=SubscriptionRecord.Inwib2c_ICC__c;
                case1.Inwib2c_MEID_Pack_SIM__c=SubscriptionRecord.Inwib2c_type_de_sim__c;

                case1.InwiB2C_SegmentClient__c=SubscriptionRecord.Inwib2c_SegmentLigne__c;

        
        
         Test.startTest();
			try{
                update SubscriptionRecord;

			}
			Catch(Exception ee){
			}	
         Test.stopTest();


      
        
        
         
		
    }

}
/*B-0162 MANSRim 01/01/2021 End */