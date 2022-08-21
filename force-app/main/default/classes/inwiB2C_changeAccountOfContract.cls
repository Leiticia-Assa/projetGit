global with sharing  class inwiB2C_changeAccountOfContract implements vlocity_cmt.VlocityOpenInterface{
    public inwiB2C_changeAccountOfContract() {

    }

    global Boolean invokeMethod(String methodName, Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
        Boolean result = true;
        try{
            if(methodName.equals('changeAccountOfContract_OS'))
                changeAccountOfContract_OS(inputMap, outMap, options);
            else if(methodName.equals('attachmentsAssignment_OS'))
                attachmentsAssignment_OS(inputMap, outMap, options);
    
            else {
                System.debug('there\'s No Method with this name : '+methodName);                 

                result = false;     

            }                              
        } catch(Exception e){
			           
            result = false;     
        }

        return result;

   }


   public static void attachmentsAssignment_OS(Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {

    try {

        String idOld = (String) inputMap.get('idoldrecord');
        String idNew = (String) inputMap.get('idnewrecord');
        String oldBusinessReferenceType = (String) inputMap.get('oldbrt');
        String newBusinessReferenceType = (String) inputMap.get('newbrt');

        InwiB2C_AttachmentsManagement.attachmentsAssignment(idOld,idNew,oldBusinessReferenceType,newBusinessReferenceType);

    } catch (Exception e) {
        System.debug('Exception: '+ e);                 

    } finally {
        
    }
   }

   public static void changeAccountOfContract_OS(Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {

    try {

        Map<String,Object> linkingInput = (Map<String,Object>) inputMap.get('linkingInput');

        String idContractStr = (String) linkingInput.get('idContract');
        Id idContract;
        if(idContractStr.equals('')) idContract = null;
        else idContract = Id.valueOf(idContractStr);


        String idAccountStr =  (String) linkingInput.get('idAccount');
        Id idAccount;
        if(idAccountStr.equals('')) idAccount = null;
        else idAccount = Id.valueOf(idAccountStr);
    
        Id returnedId = inwiB2C_changeAccountOfContract.changeAccountOfContract(idContract,idAccount);
    
        System.debug('returnedId: '+returnedId);                 
        outMap.put('returnedId', returnedId);
    
    } catch (Exception e) {
        outMap.put('returnedId', null);
        System.debug('Exception: '+e);                 

    } finally {
        
    }

   }
   
    public static Id changeAccountOfContract(Id idContract,Id idAccount) {

        Contract oldContract = [SELECT 

        AccountId,vlocity_cmt__ActiveContractVersionId__c,InwiB2C_Address__c,InwiB2C_Agence_d_identification__c,InwiB2C_Ancien_n_de_ligne__c,vlocity_cmt__IsAutoRenew__c,Canal_d_identification__c,InwiB2C_Categorie_client__c,InwiB2C_Choix_principal_op_rateur__c,InwiB2C_Civilite__c,InwiB2C_Code_bayn_shop__c,InwiB2C_Commentaires__c,CompanySignedId,CompanySignedDate,CurrencyIsoCode,vlocity_cmt__ContractGroupId__c,Name,OwnerId,RecordTypeId,vlocity_cmt__ContractReferenceNumber__c,StartDate,ContractTerm,vlocity_cmt__ContractType__c,CustomerSignedId,CustomerSignedDate,CustomerSignedTitle,InwiB2C_Date_changement_statut_Numerique__c,InwiB2C_Date_changement_statut_Physique__c,InwiB2C_Date_CRM__c,InwiB2C_Date_de_desidentification__c,InwiB2C_Date_de_la_commande__c,InwiB2C_Date_de_naissance__c,InwiB2C_Date_de_reception_de_dossier__c,InwiB2C_Date_de_souscription__c,InwiB2C_date_d_identification__c,Description,InwiB2C_Distributeur_Identification__c,InwiB2C_Distributeur__c,InwiB2C_Distributeur_Agence_idntfc__c,vlocity_cmt__LastDocumentBatchJobError__c,vlocity_cmt__LastDocumentBatchJobId__c,vlocity_cmt__LastDocumentBatchJobStatus__c,InwiB2C_Echange_express__c,InwiB2C_Email__c,InwiB2C_Entreprise__c,vlocity_cmt__ExpirationReason__c,vlocity_cmt__ExpiredContractId__c,InwiB2C_Figure_dans_l_annuaire_WANA__c,InwiB2C_ICC2__c,vlocity_cmt__IsFrameContract__c,vlocity_cmt__LocaleCode__c,vlocity_cmt__LastDocuSignEnvelopeId__c,vlocity_cmt__LastDocuSignEnvelopeStatus__c,vlocity_cmt__LastDocuSignJobId__c,InwiB2C_Lien_vers_la_fiche_Dealer__c,InwiB2C_Lien_vers_la_fiche_Distributeur__c,InwiB2C_MDN_Dealer__c,InwiB2C_Motif_incompletude_Numeriqu__c,InwiB2C_Motif_incompletude_Physique__c,InwiB2C_Motif_de_non_conformit__c,InwiB2c_Nom__c,
        InwiB2C_Num_CIN__c,InwiB2C_Numero_Terminal__c,InwiB2C_N_Ligne__c,vlocity_cmt__OpportunityId__c,vlocity_cmt__OrderId__c,vlocity_cmt__OriginalContractId__c,OwnerExpirationNotice,vlocity_cmt__ParentContractId__c,InwiB2C_Patente__c,InwiB2C_Point_de_vente_CMD__c,InwiB2C_Point_de_vente_Identification__c,InwiB2C_Porta__c,InwiB2C_Possession_Fixe__c,InwiB2C_Possession_Internet__c,InwiB2C_Possession_Mobile__c,Pricebook2Id,vlocity_cmt__PriceListId__c,InwiB2C_Prix_de_Vente__c,inwiB2C_Profession__c,InwiB2C_Profil_Gratuit__c,InwiB2c_Prenom__c,vlocity_cmt__QuoteId__c,InwiB2C_Registre_de_commerce__c,vlocity_cmt__RenewalStartDate__c,vlocity_cmt__AutoRenewObjectCreation__c,vlocity_cmt__RenewalNotification__c,vlocity_cmt__RenewalNotificationTerm__c,InwiB2C_Segmentation__c,InwiB2C_Segmentation2__c,vlocity_cmt__SendRenewalNotification__c,InwiB2C_Sexe__c,InwiB2C_Signature_PDV__c,inwiB2C_Solde_Initital__c,InwiB2C_Source_de_reception__c,SpecialTerms,Status,InwiB2C_statut_contrat__c,InwiB2C_Statut_Contrat_Num_rique__c,InwiB2C_Statut_d_identification__c,InwiB2C_Statut_Dossier__c,Subscription__c,InwiB2C_Subscription_contract__c,vlocity_cmt__TerminateDate__c,vlocity_cmt__TerminationReason__c,vlocity_cmt__TerminationType__c,InwiB2C_Type_CIN__c,InwiB2C_Telephone_contact__c,InwiB2C_Usage_internet__c        
        
        FROM Contract WHERE Id=:idContract];

        if(idAccount==null || idContract==null){

            System.debug('Error in the input of changeAccountOfContract method in the class inwiB2C_changeAccountOfContract');                 
            System.debug('No record has been affected');                 

            return null;
        }
        else if(oldContract.AccountId==idAccount){
            System.debug('The contract has already the same Account');                 
            System.debug('No contract created:'+idContract);                 

            
            return idContract;
        }else{


        Contract newContract = new Contract();
        newContract=oldContract.clone();

        String status = oldContract.Status;
        System.debug('befre::status: ' + status);                 
        System.debug('befre::oldContract.Status: ' + oldContract.Status);                 
        System.debug('befre::newContract.Status: ' + newContract.Status);                 

        newContract.AccountId = idAccount;
        newContract.Status = null;
        newContract.OwnerId = UserInfo.getUserId() ;

        insert newContract;

        System.debug('after::status: ' + status);                 
        System.debug('after::oldContract.Status: ' + oldContract.Status);                 
        System.debug('after::newContract.Status: ' + newContract.Status);                 

        if(status!=null){
            newContract.Status = status;
            update newContract;
        }


        ContentDocumentLink[] files = [select id,ContentDocumentId,LinkedEntityId from ContentDocumentLink where LinkedEntityId=:idContract];        
        List<ContentDocumentLink> listFilesToInsert = new List<ContentDocumentLink>();
            for(ContentDocumentLink file : files) {
                ContentDocumentLink newclnk = file.clone();
                newclnk.LinkedEntityId=newContract.Id;
                listFilesToInsert.add(newclnk);
        }
        insert listFilesToInsert;

        InwiB2C_Subscription_contract__c[] subsC = [select Id,InwiB2C_MDN__c,Name from InwiB2C_Subscription_contract__c where InwiB2C_Contract__c=:idContract];        
        List<InwiB2C_Subscription_contract__c> listSubConToUpdate = new List<InwiB2C_Subscription_contract__c>();
            for(InwiB2C_Subscription_contract__c subC : subsC) {
                subC.InwiB2C_Contract__c = newContract.Id;
                listSubConToUpdate.add(subC);
        }
        update listSubConToUpdate;

        vlocity_cmt__Subscription__c[] subs = [select Id,Inwib2c_Num_ro_de_la_ligne__c,Name from vlocity_cmt__Subscription__c where InwiB2C_Contract__c=:idContract];        
        List<vlocity_cmt__Subscription__c> listSubToUpdate = new List<vlocity_cmt__Subscription__c>();
            for(vlocity_cmt__Subscription__c sub : subs) {
                sub.InwiB2C_Contract__c = newContract.Id;

                System.debug('sub.Inwib2c_Num_ro_de_la_ligne__c: ' + sub.Inwib2c_Num_ro_de_la_ligne__c);                 
                System.debug('subsC[0].InwiB2C_MDN__c: ' + subsC[0].InwiB2C_MDN__c);                 

                if(sub.Inwib2c_Num_ro_de_la_ligne__c==subsC[0].InwiB2C_MDN__c){

                    sub.vlocity_cmt__AccountId__c = idAccount;

                    // START CORRECTION B-3328 AMINE 08/02/22
                    try {
                        Asset[] assets1 = [select id from Asset where vlocity_cmt__SubscriptionId__c = :sub.id];        
                        System.debug('assets1: ' + assets1);                 
                    
                    
                        Asset[] assets2 = [select id from Asset where vlocity_cmt__ParentItemId__c  = :assets1[0].id];        
                        System.debug('assets2: ' + assets2);                 
                    
                    
                    
                        vlocity_cmt__InventoryItemDecompositionRelationship__c[] var_InventoryItemDecompositionRelationship = [select  vlocity_cmt__DestinationInventoryItemId__c from vlocity_cmt__InventoryItemDecompositionRelationship__c 
                                                                                                                                where vlocity_cmt__SourceAssetId__c in :assets2];        
                        System.debug('var_InventoryItemDecompositionRelationship: ' + var_InventoryItemDecompositionRelationship);                 
                    
                    
                    /*
                         vlocity_cmt__InventoryItem__c[] var_InventoryItem = [select id from vlocity_cmt__InventoryItem__c 
                                                                                                 where id in :var_InventoryItemDecompositionRelationship.vlocity_cmt__DestinationInventoryItemId__c];        
                          System.debug('var_InventoryItem: ' + var_InventoryItem);                 
                    */
                    
                    delete var_InventoryItemDecompositionRelationship;
                    } catch (Exception e) {
                        System.debug('ExceptionDeleteInventoryItemDecompositionRelationship : ' + e);                 

                    } finally {
                        
                    }
                    // END CORRECTION B-3328 AMINE 08/02/22

                }

                listSubToUpdate.add(sub);
        }
        update listSubToUpdate;

/*
        Order[] orders = [select Id,Name from Order where ContractId=:idContract];        
        List<Order> listOrdersToUpdate = new List<Order>();
        for(Order order : orders) {
            order.ContractId = newContract.Id;
            listOrdersToUpdate.add(order);
        }
        update listOrdersToUpdate;
*/

      //  delete oldContract;


      System.debug('Id.valueOf(idContract): ' + Id.valueOf(idContract));                 
      System.debug('Id.valueOf(newContract.Id): ' + Id.valueOf(newContract.Id));                 

      InwiB2C_AttachmentsManagement.attachmentsAssignment(Id.valueOf(idContract),Id.valueOf(newContract.Id),'CONTRACT','CONTRACT');

        System.debug('id newContract: ' + newContract.Id);                 

        return newContract.Id;

        }
    } 
 /*
    @future(callout = true)
        static void attachmentsAssignment(String idOldContract, String idNewContract) {

        Map <String, Object> retreiveListInput = new Map <String, Object> ();
        Map <String, Object> retreiveListOptions = new Map <String, Object> ();
  
        retreiveListInput.put('businessReferenceType', 'ORDER');
        retreiveListInput.put('businessReference', idOldContract);
  
  
        Map <String, Object> retreiveListOutput = new Map <String, Object>();
  

        retreiveListOutput =(Map <String, Object>) vlocity_cmt.IntegrationProcedureService.runIntegrationService('inwib2c_retreiveListDocument',
         retreiveListInput, retreiveListOptions);

         System.debug('retreiveListOutput:');                 
         System.debug(retreiveListOutput);                 



        if(retreiveListOutput.get('success')==false){
            System.debug('success:'+retreiveListOutput.get('success'));                 
            System.debug('error:'+retreiveListOutput.get('error'));                 
        }else{
            System.debug('retreiveListOutput.get(documents):');                 
            System.debug(retreiveListOutput.get('documents'));                 
        }


         System.debug('typeof retreiveListOutput::'+inwiB2C_changeAccountOfContract.getType(retreiveListOutput));                 
         System.debug('typeof retreiveListOutput.get(documents)::'+inwiB2C_changeAccountOfContract.getType(retreiveListOutput.get('documents')));                 

 
         for(Map <String, Object> doc : retreiveListOutput.get('documents')){
  
          Map <String, Object> InsertDocInput = new Map <String, Object> ();
          Map <String, Object> InsertDocOptions = new Map <String, Object> ();
          
  
          Map <String, Object> documentCharacteristic = new Map <String, Object> ();
          documentCharacteristic.put('businessReferenceType', 'ORDER');
          documentCharacteristic.put('businessReference', idNewContract);
  
  
          InsertDocInput.put('documentID', idNewContract);
          InsertDocInput.put('documentCharacteristic', documentCharacteristic);
  
  
          vlocity_cmt.IntegrationProcedureService.runIntegrationService('InwiB2C_InsertIndexDocument',
           InsertDocInput, InsertDocOptions);
    
         }
  
  */
  


    }