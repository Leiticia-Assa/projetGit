@isTest
public class InwiB2C_Test_UpdateAccount {
@isTest(SeeAllData=true)
    static void MethodTestPositive() {
        
      Account Acc =new Account(name='356623026584884' ,Inwib2c_VIP__c=true );
        insert acc;
        if (acc.Inwib2c_VIP__c=true){
            
            InwiB2C_Account_VIP__c AccVIP =new InwiB2C_Account_VIP__c(name=acc.name, InwiB2C_FirstName__c=acc.vlocity_cmt__PersonContactId__r.FirstName,
 InwiB2C_LastName__c=acc.vlocity_cmt__PersonContactId__r.LastName,InwiB2C_CIN__c=acc.vlocity_cmt__PersonContactId__r.InwiB2C_CIN__c
             );
        insert AccVIP;
        }
        
        
        
       Account Acc2 =new Account(name='35584884' ,Inwib2c_VIP__c=false );
        vlocity_cmt__Subscription__c  SubVIPUpdate=new vlocity_cmt__Subscription__c(Inwib2c_Num_ro_de_la_ligne__c = '2166661',
        Name = 'test3',
       vlocity_cmt__SubscriptionNumber__c = '320',
        inwib2c_vip__c=false);

        
        insert acc2;
        insert SubVIPUpdate;

        acc2.Inwib2c_VIP__c=true;
                       update acc2;

        if (acc2.Inwib2c_VIP__c=true){
            
            InwiB2C_Account_VIP__c AccVIP2 =new InwiB2C_Account_VIP__c(name=acc.name, InwiB2C_FirstName__c=acc.vlocity_cmt__PersonContactId__r.FirstName,
 InwiB2C_LastName__c=acc.vlocity_cmt__PersonContactId__r.LastName,InwiB2C_CIN__c=acc.vlocity_cmt__PersonContactId__r.InwiB2C_CIN__c );
        insert AccVIP2;
            
        }
        
        InwiB2C_Account_VIP__c AccVIP3 =new InwiB2C_Account_VIP__c(name=acc.name, InwiB2C_FirstName__c=acc.vlocity_cmt__PersonContactId__r.FirstName,
 InwiB2C_LastName__c=acc.vlocity_cmt__PersonContactId__r.LastName,InwiB2C_CIN__c=acc.vlocity_cmt__PersonContactId__r.InwiB2C_CIN__c );
        insert AccVIP3;
        
               Account Acc3 =new Account(name='356626584884' ,Inwib2c_VIP__c=true );
        insert acc3;
        acc3.Inwib2c_VIP__c=false;
        update acc3;
        if(Acc3.name==AccVIP3.name && acc3.Inwib2c_VIP__c==false ){
            
            SubVIPUpdate.Inwib2c_VIP__c=false;
            update SubVIPUpdate;
        }

        
             
             
         //}
         
          
    }}