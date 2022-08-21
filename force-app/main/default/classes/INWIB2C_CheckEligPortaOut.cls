/*DLE INWIB2C-PHASE2 04.05.2021 Begin*/
//API Check eligibilité portabilité out
@RestResource(urlMapping='/CheckEligPortaOut')
global with sharing class INWIB2C_CheckEligPortaOut {

     @HttpPost
    global static void Checkeligibilite(){
        RestRequest req = RestContext.request;
        RestResponse res = Restcontext.response;
        res.addHeader('charset', 'UTF-8 Server');
        res.addHeader('Content-Type', 'application/json');
        Integer code;
        String result;
        String statut;
        string isOK='';
        string errorCode='';
        string errorMessage='';
        string description='';
        string uuid;
        string portemdnin;
        string mdn;
        string status ='';
        boolean Verif= false;
	    	Map<String, Object> Mapreq = (Map<String,Object>)JSON.deserializeUntyped(req.requestBody.toString());
        Map<String, Object> Maplevel1 = (Map<String,Object>)Mapreq.get('CSPortabilityOrder');
        Map<String, Object> Maplevel11 = (Map<String,Object>)Mapreq.get('CSOperationInfo'); 
        List<Object> ListMdn = (List<Object>)Maplevel1.get('PortedNumber');
        //respense
       
        List<Map<string, Object>> listaMap = new List<Map<string, Object>>(); 
        Map<String, Object>  CSOperationResultInfo = new Map<String, Object> ();
        map<string , Object> CSPortabilityOrder = new Map<String, Object> ();
        map<string,Object> resplevel0 = new Map<String, String> ();
        map<string,Object> resplevel1 = new Map<String, Object> ();
        map<string,Object> resplevel2 = new Map<String, Object> ();
        //req
        String customerSegment = String.valueOf(Maplevel1.get('customerSegment'));
        String customerIdentityType = String.valueOf(Maplevel1.get('customerIdentityType'));
        String customerIdentityNumber = String.valueOf(Maplevel1.get('customerIdentityNumber'));
        String customerAccountID = String.valueOf(Maplevel1.get('customerAccountID'));
        String uuidin = String.valueOf(Maplevel11.get('uuid'));
        string idin  = String.valueOf(Maplevel1.get('id'));
        string jsonstring;
        string typepiece;
         /*TraceApi DLE 11/10/2021 Begin*/
        String statutAppel;
        InwiB2C_Trace_API__c trace=new InwiB2C_Trace_API__c();
        trace.InwiB2C_API_Name__c='WS02';
        trace.InwiB2C_request_body__c=req.requestBody.toString();
        trace.InwiB2C_uuid__c=uuidin;
        trace.InwiB2C_Object_Number__c=idin;
        /*TraceApi DLE 11/10/2021 End*/
        if (customerIdentityType=='NID')
        {
          customerIdentityType='Carte d\'Identité Nationale' ;
       } else {
         if (customerIdentityType=='PASSPORT') {
          customerIdentityType='Passeport' ;
         }else {
           if (customerIdentityType=='STAY_CARD') {
            customerIdentityType='Carte de séjour' ;
           }else {
                 if (customerIdentityType=='ASSO') {
                  customerIdentityType='Association' ;
             }else {
               if (customerIdentityType=='ESE') {
                customerIdentityType='Entreprise' ;
               }else {
                 if (customerIdentityType=='AMB') {
   
                  customerIdentityType='AMB Ambassade' ;
                 }
               }
             }
           }
         }
       }

  try
        {
    
             if (customerSegment !='' && customerIdentityType !=''&& customerIdentityNumber !=''
               && customerSegment!=' ' && customerIdentityType!=' '&& customerIdentityNumber!=' ')
               {  
          //chek Mdn
     for (Object PortedMdn : ListMdn) {
         Map<String, Object> MapMdn = (Map<String, Object>)PortedMdn;
         portemdnin = String.valueOf(MapMdn.get('mdn'));
         Map<String, Object>  PortedNumber = new Map<String, Object> ();
         //check si mdn existe 
         list <Asset> listnoninstalledasset = [ select AccountId,  Account.vlocity_cmt__PersonContactId__c from asset  where vlocity_cmt__SubscriptionId__r.Inwib2c_Num_ro_de_la_ligne__c =:portemdnin];
         list <Asset> listinstalledasset = [ select AccountId,  Account.vlocity_cmt__PersonContactId__c from asset  where vlocity_cmt__SubscriptionId__r.Inwib2c_Num_ro_de_la_ligne__c =:portemdnin and vlocity_cmt__SubscriptionId__r.inwiB2C_LegacyStatus__c <> 'EXPIRED'];
       
         if (listinstalledasset.size()>0)
        {   
      //recupérer l'id client de la souscription
         Asset ListAsset = [ select AccountId,  Account.vlocity_cmt__PersonContactId__c from asset  where vlocity_cmt__SubscriptionId__r.Inwib2c_Num_ro_de_la_ligne__c =:portemdnin and vlocity_cmt__SubscriptionId__r.inwiB2C_LegacyStatus__c <> 'EXPIRED' LIMIT 1];
         contact listContact = [select  FirstName, LastName,InwiB2C_CIN__c,InwiB2C_Type_CIN__c   from contact where id =:ListAsset.Account.vlocity_cmt__PersonContactId__c];
        

         // verifier si client est identifié
        If (listContact.LastName.Substring (0, 3) == '212' ||
            listContact.FirstName == 'DUMMY' ||
          customerIdentityNumber.Substring(0, 2) == 'XX' ) {
          PortedNumber.put('mdn',portemdnin);
          PortedNumber.put('status',0);
          PortedNumber.put('errorCode','4005');
          PortedNumber.put('errorMessage','Client non identifié');
          PortedNumber.put('description','Client non identifié');   
              
           } Else
                  If (customerIdentityNumber !=  listContact.InwiB2C_CIN__c ||
                  customerIdentityType != listContact.InwiB2C_Type_CIN__c) {
          PortedNumber.put('mdn',portemdnin);
          PortedNumber.put('status',0);
          PortedNumber.put('errorCode','4003');
          PortedNumber.put('errorMessage','Non correspondance du couple Numéro d\'Identifiant' + customerIdentityNumber + 'du client et Numéro de Désignation '+portemdnin);
          PortedNumber.put('description','Non correspondance du couple Numéro d\'Identifiant ' + customerIdentityNumber +  'du client et Numéro de Désignation ' +portemdnin);   
              }
                   
            Else
            {
         PortedNumber.put('mdn',portemdnin);
         PortedNumber.put('status',1);
         Verif = True;
                      
                  }
        
       }
         else
        
        if  (listnoninstalledasset.size()>0 && listinstalledasset.size()==0)
          {
          PortedNumber.put('mdn',portemdnin);
          PortedNumber.put('status',0);
          PortedNumber.put('errorCode','4001');
          PortedNumber.put('errorMessage','Numéro résilié et effectivement non opérationnel');
          PortedNumber.put('description','Numéro résilié et effectivement non opérationnel');   
              
              }
         else
              if  (listnoninstalledasset.size()==0 && listinstalledasset.size()==0)
                  {
          PortedNumber.put('mdn',portemdnin);
          PortedNumber.put('status',0);
          PortedNumber.put('errorCode','4002');
          PortedNumber.put('errorMessage','Numéro non géré par l\'OPD');
          PortedNumber.put('description','Numéro non géré par l\'OPD');   
                   }
  
         listaMap.add(PortedNumber);
         
     }
   //construction de la reponse
                 If (Verif == True) {
                  CSOperationResultInfo.put ('isOK','1');
                  CSPortabilityOrder.put ('id',idin);
               /*TraceApi DLE 11/10/2021 Begin*/
       statutAppel='OK';
 /*TraceApi DLE 11/10/2021 End*/
      }
   Else
       {
          CSOperationResultInfo.put ('isOK','0');
          CSOperationResultInfo.put ('errorCode','0000');
          CSOperationResultInfo.put ('errorMessage','Tous les numéros ne sont pas éligibles!');
          CSOperationResultInfo.put ('uuid',uuidin);
          CSPortabilityOrder.put ('id',idin);
             /*TraceApi DLE 11/10/2021 Begin*/
       statutAppel='KO';
 /*TraceApi DLE 11/10/2021 End*/
           
          }
                   
                   
       }
            else
      {
   
          CSOperationResultInfo.put ('isOK','0');
          CSOperationResultInfo.put ('errorCode','0000');
          CSOperationResultInfo.put ('errorMessage','Les informations customerIdentityNumber et  et  customerIdentityType Ou N° de Compte sont obligatoires.');
          CSOperationResultInfo.put ('uuid',uuidin);
          CSPortabilityOrder.put ('id',idin);
          /*TraceApi DLE 11/10/2021 Begin*/
       statutAppel='KO';
 /*TraceApi DLE 11/10/2021 End*/
      }  
                          
        //resp

        resplevel1.put('id',idin);    
        resplevel1.put('PortedNumber',listaMap);  
        resplevel2.put('CSPortabilityOrder',resplevel1);
        resplevel2.put('CSOperationResultInfo',CSOperationResultInfo);
        
             jsonstring = JSON.serialize(resplevel2);
            
        }catch(DmlException e)
        {
    				System.debug('An unexpected error has occurred: ' + e.getMessage());
				}
        res.responseBody = blob.valueOf(jsonstring);
        res.statusCode = 200;
        
 /*TraceApi DLE 11/10/2021 Begin*/
    trace.InwiB2C_Response__c=res.responseBody.toString();
    trace.InwiB2C_Status__c=statutAppel;
        insert trace;
   /*TraceApi DLE 11/10/2021 end*/
        
                }
}
    
/*DLE INWIB2C-PHASE2 04.05.2021 End*/