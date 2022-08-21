/*B-0162 MANSRim 11/01/2021 Begin*/

@isTest
public class InwiB2C_Test_create_Case {
    @isTest(SeeAllData=true)
static void MethodTestPositive()
{
    
    Map<String,Object> outMap = new  Map<String,Object>();
    Map<String,Object> outMapCommunity = new  Map<String,Object>();

    Map<String,Object> options = new  Map<String,Object>();
    Map<String,Object> optionsCommunity = new  Map<String,Object>();

    Map<String,Object> inputMap = new  Map<String,Object>();
    Map<String,Object> inputMapCommunity = new  Map<String,Object>();

    
  string TypeRecCom ='Inwib2c_Reclamation';
        String TypesCom ='Inwib2c_Reclamation' ;
        String CategorieCom = 'Inwib2c_Reseau_Reclamation' ;
        String TypeSpecialiteCom = 'InwiB2C_Roaming' ;
        String DetailCom ='Réception' ;
        String DescriptifCom ='deskkkc' ;
        String RecapitulatifCom = 'recapbnnnnn jnj' ;
        //String SourceCom = ' '  ;
        String SubscriptionIdCom ='a4k2z0000004CjlAAE' ;
        String ContIdCom = '0032z000001gMqFAAU' ;
        String AccIdCom ='0012z000002cxRmAAI' ;
        String  BillingAccIdCom ='0012z000002cxWAAAY' ;  
    
    
    
    
    
    
   
    string TypeRec ='Inwib2c_Reclamation';
        String Types ='Inwib2c_Reclamation' ;
        String Categorie = 'Inwib2c_Reseau_Reclamation' ;
        String TypeSpecialite = 'InwiB2C_Roaming' ;
        String Detail ='Réception' ;
        String Descriptif ='desc' ;
        String Recapitulatif = 'recap' ;
        String Source = 'Appel_entrant'  ;
        String SubscriptionId ='a4k2z0000004COAAA2' ;
        String ContId = '0032z000001FVmdAAG' ;
        String AccId ='0012z000002LEanAAG' ;
        String  BillingAccId ='0012z000002av4iAAA' ;
  //  String profileName = [SELECT Name FROM Profile WHERE name ='Inwi POS'];
          Id profileId=userinfo.getProfileId();
    
                //  Id profileIdC='0052z000000RDsDAAW';


          Id sysAdminProfileId=[Select Id,Name from Profile where Name='Inwi POS'].Id;

// if(UserInfo.getProfileId() == '00e80000001SQTxAAA'){  
         if(profileId != sysAdminProfileId){


     //if (profileName!='Inwi POS'){
    options.put( 'TypeRec',TypeRec );   
    options.put( 'Type',Types );
    options.put( 'Categorie',Categorie );
    options.put( 'TypeSpecialite',TypeSpecialite );
    options.put( 'Detail',Detail );
    options.put( 'Descriptif',Descriptif );
    options.put( 'Recapitulatif',Recapitulatif );
    options.put( 'Source',Source);
    options.put( 'SubscriptionId',SubscriptionId );
    options.put( 'ContId',ContId );
    options.put( 'AccId',AccId );
    options.put( 'BillingAccId',BillingAccId );
               
     }
    //Id p = [select id from profile where name='Inwi POS'].id;

    
    
    
    
    
     //system.runAs(u) {
            // statements to be executed by this test user.
        
   //if  (profileId == sysAdminProfileId) {
   
        
       Profile p = [select id from profile where name='Inwi POS' limit 1];
       ID pname = p.Id;
        Account acc = [SELECT id, name FROM Account WHERE name = 'Inwi' limit 1];
    String Acco=acc.id;
       
       UserRole portalRole = [Select Id From UserRole Where PortalType = 'None' Limit 1];

        Contact con = new Contact(LastName ='testCon',AccountId = Acco);
        insert con;  
                  
        User user = new User(alias = 'test123', email='test123@noemail.com',
                emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                localesidkey='en_US', profileid = pname, country='United States',IsActive =true,
                ContactId = con.Id,
                timezonesidkey='America/Los_Angeles', username='tester@noemail.com');
       
        insert user;
        system.runAs(user) {
            // statements to be executed by this test user.
        
 
        
        
        
        
        
    optionsCommunity.put( 'TypeRec',TypeRecCom );   
    optionsCommunity.put( 'Type',TypesCom );
    optionsCommunity.put( 'Categorie',CategorieCom );
    optionsCommunity.put( 'TypeSpecialite',TypeSpecialiteCom );
    optionsCommunity.put( 'Detail',DetailCom );
    optionsCommunity.put( 'Descriptif',DescriptifCom);
    optionsCommunity.put( 'Recapitulatif',RecapitulatifCom );
    optionsCommunity.put( 'Source','Visite client au PDV');
    optionsCommunity.put( 'SubscriptionId',SubscriptionIdCom );
    optionsCommunity.put( 'ContId',ContIdCom );
    optionsCommunity.put( 'AccId',AccIdCom);
    optionsCommunity.put( 'BillingAccId',BillingAccIdCom );
              InwiB2C_CreateCase clsC = new InwiB2C_CreateCase(); 

        boolean result2 = clsC.invokeMethod('creationCase',inputMapCommunity, outMapCommunity, optionsCommunity);
   //System.assertEquals(true,result2);
     }

    
               
   InwiB2C_CreateCase cls = new InwiB2C_CreateCase();
    
   boolean result = cls.invokeMethod('creationCase',inputMap, outMap, options); 
       //System.assertEquals(true, result);

   
  
      //  System.debug('La valeur de outMap' + inputMap);
  //  System.debug('La valeur de outMap' + outMap);
  

    
    
    
    
    
    
  
    
    
    
    
           
}

}
/*B-0162 MANSRim 11/01/2021 End*/