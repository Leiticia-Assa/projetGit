global with sharing class InwiB2C_OperationHistory implements vlocity_cmt.VlocityOpenInterface {


    global Boolean invokeMethod(String methodName, Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
            
        Boolean result = true;
            
        try{
            
            if(methodName.equals('AddOperationHistory')){
                System.debug('Success! the method AddOperationHistory was called' );
                AddOperationHistory(inputMap, outMap, options);

            }else{
            
            }                              
            
        } catch(Exception e){System.debug('An unexpected error has occurred: ' + e.getMessage());result = false;
                    
        }
             
        return result;
                  
   }

    
    public static void AddOperationHistory(Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
            

        Decimal MontantDouble;
        Date NewExpirationDate;
        Date LastExpirationDate;
        String Mdn =  (String)options.get('Mdn'); System.debug(Mdn);
        String SubscriptionId =  (String)options.get('SubscriptionId'); System.debug(SubscriptionId);
        String AssetID =  (String)options.get('AssetID'); System.debug(AssetID);
        String LibelleBalance =  (String)options.get('LibelleBalance'); System.debug(LibelleBalance);
        //Date NewExpirationDate =  (Date)options.get('NewExpirationDate'); System.debug(NewExpirationDate);
        //Date LastExpirationDate =  (Date)options.get('LastExpirationDate'); System.debug(LastExpirationDate);
        if (String.isNotBlank((String)options.get('NewExpirationDate')))
        	NewExpirationDate =  Date.valueOf((String)options.get('NewExpirationDate')); System.debug(NewExpirationDate);
        if (String.isNotBlank((String)options.get('LastExpirationDate')))
        	LastExpirationDate =  Date.valueOf((String)options.get('LastExpirationDate')); System.debug(LastExpirationDate);
        //String MontantOperation =  (String)options.get('MontantOperation'); System.debug(MontantOperation);
        //MontantDouble = decimal.valueOf(MontantOperation);
        Datetime DateOperation =  DateTime.now();
        String ActionOperation =  (String)options.get('ActionOperation'); System.debug(ActionOperation);
        String SubActionOperation =  (String)options.get('SubActionOperation'); System.debug(SubActionOperation);
        String StatutOperation =  (String)options.get('StatutOperation'); System.debug(StatutOperation);
        String ErrorCodeOperation =  (String)options.get('ErrorCodeOperation'); System.debug(ErrorCodeOperation);
        String canal =  (String)options.get('Canal'); System.debug(canal);
        String TypeAction =  (String)options.get('TypeAction'); System.debug(TypeAction);
        String TypeModification =  (String)options.get('TypeModification'); System.debug(TypeModification);
        String SousProduitIN =  (String)options.get('SousProduitIN'); System.debug(SousProduitIN);
        String Partenaire =  (String)options.get('Partenaire'); System.debug(Partenaire);
        String Commentaire =  (String)options.get('Commentaire'); System.debug(Commentaire);
        String Description= (String)options.get('Description'); System.debug(Commentaire);
        
        if (TypeAction == 'inwiB2C_RechargeManuelle' && MontantDouble != null && TypeModification != 'inwiB2C_ModificationDateExpiration' )
        {
            MontantDouble = decimal.valueOf((String)options.get('MontantOperation'));
        }
        else
            MontantDouble = (Decimal)options.get('MontantOperation');

        String UserId = UserInfo.getUserId();
        //String SubActionOperation =  (String)options.get('SubActionOperation'); System.debug(SubActionOperation);

        try{

            INWIB2C_HIST_ACTION_LINE__c HistoriqueAction = new INWIB2C_HIST_ACTION_LINE__c ();
            HistoriqueAction.inwiB2C_Mdn__c = Mdn;
            HistoriqueAction.inwiB2C_SubscriptionId__c = SubscriptionId;
            HistoriqueAction.inwiB2C_ASSETID__c = AssetID;
            HistoriqueAction.InwiB2C_LibelleBalance__c = LibelleBalance;
            HistoriqueAction.inwiB2C_Montant__c = MontantDouble;
            HistoriqueAction.inwiB2C_Date__c = DateOperation ; 
            HistoriqueAction.inwiB2C_Action__c = ActionOperation;
            HistoriqueAction.inwiB2C_SUBACTION__c = SubActionOperation;
            HistoriqueAction.inwiB2C_STATUT__c = StatutOperation;
            HistoriqueAction.inwiB2C_ERRORCODE__c = ErrorCodeOperation;
            HistoriqueAction.inwiB2C_Canal__c = canal;
            HistoriqueAction.inwiB2C_TypeAction__c = TypeAction;
            HistoriqueAction.inwiB2C_TypeModification__c = TypeModification;
            HistoriqueAction.inwiB2C_Sous_Produit_IN_Id__c = SousProduitIN;
            HistoriqueAction.InwiB2C_NewExpirationDate__c = NewExpirationDate;
            HistoriqueAction.InwiB2C_LastExpirationDate__c = LastExpirationDate;
            HistoriqueAction.inwib2c_Partenaire__c = Partenaire;
            HistoriqueAction.Commentaire__c = Commentaire;
            //HistoriqueAction.InwiB2C_Description__c = Description;
            Insert HistoriqueAction;


        }catch(DmlException e) {System.debug('An unexpected error has occurred: ' + e.getMessage());
}


    }
}