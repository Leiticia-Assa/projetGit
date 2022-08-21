@isTest
public class InwiB2C_Test_UpdateSubscription {
@isTest(SeeAllData=true)
    static void MethodTestPositive() {
        
     vlocity_cmt__Subscription__c testSubscription = new vlocity_cmt__Subscription__c();
        testSubscription.Inwib2c_Num_ro_de_la_ligne__c = '212600000021';
        testSubscription.Name = 'Test';
       testSubscription.vlocity_cmt__SubscriptionNumber__c = 	'212600000021';
        testSubscription.inwib2c_vip__c=true;
        Insert testSubscription;
        if (testSubscription.inwib2c_vip__c=true){
            
            InwiB2C_Subscription_VIP__c Subricption = new InwiB2C_Subscription_VIP__c(Inwib2c_Num_ro_de_la_ligne__c = testSubscription.name,
                    Name=testSubscription.name,
                    InwiB2C_Subscription_Number__c=testSubscription.vlocity_cmt__SubscriptionNumber__c,
                     InwiB2C_Account_VIP__c=testSubscription.vlocity_cmt__AccountId__c                                                 
                    );
        }
        
        
        
       vlocity_cmt__Subscription__c testSubscription2 = new vlocity_cmt__Subscription__c();
        testSubscription2.Inwib2c_Num_ro_de_la_ligne__c = '21261';
        testSubscription2.Name = 'Test2';
        testSubscription2.vlocity_cmt__SubscriptionNumber__c = 	'212';
        testSubscription2.inwib2c_vip__c=false;
        Insert testSubscription2;
        testSubscription2.inwib2c_vip__c=true;
        testSubscription2.inwiB2C_managedInSF__c = true;
        //testSubscription2.Inwib2c_Num_ro_de_la_ligne__c = '212655334499';
        update testSubscription2;
        testSubscription2.Inwib2c_Num_ro_de_la_ligne__c = '212655334499';
        update testSubscription2;
        testSubscription2.Inwib2c_ICC__c = '123345252626262662';
        update testSubscription2;
        testSubscription2.InwiB2C_Id_profil__c = 'ProfileIdTest';
        update testSubscription2;
        

        if (testSubscription2.inwib2c_vip__c=true){
            
            InwiB2C_Subscription_VIP__c Subricption2 = new InwiB2C_Subscription_VIP__c(Inwib2c_Num_ro_de_la_ligne__c = testSubscription2.Inwib2c_Num_ro_de_la_ligne__c,
                    Name=testSubscription2.name,
                    InwiB2C_Subscription_Number__c=testSubscription2.vlocity_cmt__SubscriptionNumber__c
                    );
            insert Subricption2;
        }
        
             
             
         //}
         
          
    }}