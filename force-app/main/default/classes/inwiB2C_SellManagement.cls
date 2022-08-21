global with sharing  class inwiB2C_SellManagement implements vlocity_cmt.VlocityOpenInterface {


    global Boolean invokeMethod(String methodName, Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
            
        Boolean result = true;
            
        try{
            
            if(methodName.equals('getOffreSell')){
                getOffreSell(inputMap, outMap, options);
            
             // your implementation, use outMap to send response back to OmniScript                                                                  
            
            }
        } catch(Exception e){
                       
            result = false;
                    
        }
             
        return result;
                  
   }


    public static void getOffreSell(Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
       
       
        try{

        String MDN = (String) inputMap.get('mdn');
        
        Date currentDate = Date.today();
        String idProfile =  (String) inputMap.get('idprofile');
        String accid =  (String) inputMap.get('accid');
        
        //String agent =  (String) inputMap.get('agent');
      //  String idcase =  (String) inputMap.get('idcase');
        
        
        List<InwiB2C_offre_ciblee__c> offreCiblees = [SELECT id,inwib2c_mdn__c,inwib2c_priorite__c,inwib2c_date_debut__c,inwib2c_date_fin__c,inwib2c_argumentaire__c,inwib2c_description__c,inwib2c_id_campagne__c,inwib2c_date_de_modification__c,inwib2c_points__c FROM InwiB2C_offre_ciblee__c WHERE (InwiB2C_Date_debut__c < :currentDate AND InwiB2C_Date_fin__c > :currentDate AND InwiB2C_MDN__c = :MDN) ORDER BY InwiB2C_Priorite__c  LIMIT 50000];

        List<InwiB2C_offre_eligible__c> offreEligibles = [SELECT id,inwib2c_priorite__c,inwib2c_date_debut__c,inwib2c_date_fin__c,inwib2c_id_profil__c,inwib2c_argumentaire__c,inwib2c_description__c,inwib2c_id_campagne__c,inwib2c_date_de_modification__c,inwib2c_points__c FROM InwiB2C_offre_eligible__c WHERE (InwiB2C_Date_debut__c < :currentDate AND InwiB2C_Date_fin__c > :currentDate AND InwiB2C_Id_profil__c = :idProfile) ORDER BY InwiB2C_Priorite__c  LIMIT 50000];
        
        List<InwiB2C_generique__c> offreGeneriques = [SELECT id,inwib2c_priorite__c,inwib2c_date_debut__c,inwib2c_date_fin__c,inwib2c_argumentaire__c,inwib2c_description__c,inwib2c_date_de_modification__c,inwib2c_points__c FROM InwiB2C_generique__c WHERE (InwiB2C_Date_debut__c < :currentDate AND InwiB2C_Date_fin__c > :currentDate ) ORDER BY InwiB2C_Priorite__c  LIMIT 50000];
        

        // récupération de la liste des ID des offres Generiques
        List<String> idsOffreGeneriques = new List<String>();

        List<String> idsOffreCiblees = new List<String>();
        List<String> idsOffreEligibles = new List<String>();

        for (InwiB2C_generique__c offreGenerique : offreGeneriques){
            idsOffreGeneriques.add(offreGenerique.Id);
        }


        for (InwiB2C_offre_ciblee__c offreCiblee : offreCiblees){
            idsOffreCiblees.add(offreCiblee.Id);
        }
        for (InwiB2C_offre_eligible__c offreEligible : offreEligibles){
            idsOffreEligibles.add(offreEligible.Id);
        }

        System.debug('idsOffreCiblees');    
        System.debug(idsOffreCiblees);


        System.debug('idsOffreEligibles');    
        System.debug(idsOffreEligibles);


        // Récupération de toutes les réponses pour les offres génériques
        List<InwiB2C_data_offre_sell__c> proposedOffreGeneriques =  [SELECT id,LastModifiedDate,InwiB2C_Id_offre_proposee_generique__c,inwib2c_motif__c,inwib2c_retour_client__c FROM InwiB2C_data_offre_sell__c WHERE (InwiB2C_Id_Client__c =:accid AND InwiB2C_Id_offre_proposee_generique__c IN :idsOffreGeneriques) ORDER BY LastModifiedDate DESC];

        List<InwiB2C_data_offre_sell__c> proposedOffreCiblees =     [SELECT id,LastModifiedDate,InwiB2C_Id_offre_proposee_ciblee__c,inwib2c_motif__c,inwib2c_retour_client__c FROM InwiB2C_data_offre_sell__c WHERE (InwiB2C_Id_offre_proposee_ciblee__c IN :idsOffreCiblees) ORDER BY LastModifiedDate DESC];
        List<InwiB2C_data_offre_sell__c> proposedOffreEligibles =   [SELECT id,LastModifiedDate,InwiB2C_Id_offre_proposee_eligible__c,inwib2c_motif__c,inwib2c_retour_client__c FROM InwiB2C_data_offre_sell__c WHERE (InwiB2C_Id_offre_proposee_eligible__c IN :idsOffreEligibles ) ORDER BY LastModifiedDate DESC];

        // création d'une MAP avec ID de l'offre générique comme clé
        Map<String, InwiB2C_data_offre_sell__c> proposedOffreGeneriquesMap = new Map<String, InwiB2C_data_offre_sell__c>();

        Map<String, InwiB2C_data_offre_sell__c> proposedOffreCibleesMap = new Map<String, InwiB2C_data_offre_sell__c>();
        Map<String, InwiB2C_data_offre_sell__c> proposedOffreEligiblesMap = new Map<String, InwiB2C_data_offre_sell__c>();


        // Parcours de toutes les réponses des offres génériques 
        for (InwiB2C_data_offre_sell__c proposedOffreGenerique : proposedOffreGeneriques){

            // Si l'id de l'offre -générique est présent dans la Map, vérifier que c'est bien la derniere réponse qui se trouve comme seconde partie de la MAP
            if (proposedOffreGeneriquesMap.containsKey(proposedOffreGenerique.InwiB2C_Id_offre_proposee_generique__c)){

                InwiB2C_data_offre_sell__c inMapProposedOffreGenerique = proposedOffreGeneriquesMap.get(proposedOffreGenerique.InwiB2C_Id_offre_proposee_generique__c);

                if (proposedOffreGenerique.LastModifiedDate > inMapProposedOffreGenerique.LastModifiedDate){
                    proposedOffreGeneriquesMap.remove(proposedOffreGenerique.InwiB2C_Id_offre_proposee_generique__c);
                    proposedOffreGeneriquesMap.put(proposedOffreGenerique.InwiB2C_Id_offre_proposee_generique__c, proposedOffreGenerique );
                }

            }else{
                proposedOffreGeneriquesMap.put(proposedOffreGenerique.InwiB2C_Id_offre_proposee_generique__c, proposedOffreGenerique );
            }

        }



        for (InwiB2C_data_offre_sell__c proposedOffreCiblee : proposedOffreCiblees){
            if (proposedOffreCibleesMap.containsKey(proposedOffreCiblee.InwiB2C_Id_offre_proposee_ciblee__c)){
                InwiB2C_data_offre_sell__c inMapProposedOffreCiblee = proposedOffreCibleesMap.get(proposedOffreCiblee.InwiB2C_Id_offre_proposee_ciblee__c);
                if (proposedOffreCiblee.LastModifiedDate > inMapProposedOffreCiblee.LastModifiedDate){
                    proposedOffreCibleesMap.remove(proposedOffreCiblee.InwiB2C_Id_offre_proposee_ciblee__c);
                    proposedOffreCibleesMap.put(proposedOffreCiblee.InwiB2C_Id_offre_proposee_ciblee__c, proposedOffreCiblee );
                }
            }else{
                proposedOffreCibleesMap.put(proposedOffreCiblee.InwiB2C_Id_offre_proposee_ciblee__c, proposedOffreCiblee );
            }
        }
        
        for (InwiB2C_data_offre_sell__c proposedOffreEligible : proposedOffreEligibles){
            if (proposedOffreEligiblesMap.containsKey(proposedOffreEligible.InwiB2C_Id_offre_proposee_eligible__c)){
                InwiB2C_data_offre_sell__c inMapProposedOffreEligibles = proposedOffreEligiblesMap.get(proposedOffreEligible.InwiB2C_Id_offre_proposee_eligible__c);
                if (proposedOffreEligible.LastModifiedDate > inMapProposedOffreEligibles.LastModifiedDate){
                    proposedOffreEligiblesMap.remove(proposedOffreEligible.InwiB2C_Id_offre_proposee_eligible__c);
                    proposedOffreEligiblesMap.put(proposedOffreEligible.InwiB2C_Id_offre_proposee_eligible__c, proposedOffreEligible );
                }
            }else{
                proposedOffreEligiblesMap.put(proposedOffreEligible.InwiB2C_Id_offre_proposee_eligible__c, proposedOffreEligible );
            }

        }


        List<Object> outputResultGeneric = new List<Object>();

        List<Object> outputResultCiblee = new List<Object>();
        List<Object> outputResultEligible = new List<Object>();

        for (InwiB2C_generique__c offreGenerique : offreGeneriques){
            Map<String, String> elemnt =  new Map<String, String>();
                 
            elemnt.put('Id', offreGenerique.id );
            elemnt.put('points', String.valueOf(offreGenerique.inwib2c_points__c) );
            elemnt.put('Priorite', String.valueOf(offreGenerique.inwib2c_priorite__c) );
            elemnt.put('Description', offreGenerique.inwib2c_description__c );
            elemnt.put('DateDebut', String.valueOf(offreGenerique.inwib2c_date_debut__c) );
            elemnt.put('DateFin', String.valueOf(offreGenerique.inwib2c_date_fin__c) );
            elemnt.put('Argumentaire', offreGenerique.inwib2c_argumentaire__c );

            for (Id key : proposedOffreGeneriquesMap.keySet()){
                InwiB2C_data_offre_sell__c var = proposedOffreGeneriquesMap.get(key);
                if(var.InwiB2C_Id_offre_proposee_generique__c == offreGenerique.Id){
                    elemnt.put('dateModification', String.valueOf(var.LastModifiedDate) );
                    elemnt.put('RetourClient', var.inwib2c_retour_client__c );
                    elemnt.put('Motif', var.inwib2c_motif__c );
                }
            }
            outputResultGeneric.add(elemnt);

        }


        for (InwiB2C_offre_ciblee__c  offreCiblee : offreCiblees){
            Map<String, String> elemnt =  new Map<String, String>();
                 
            elemnt.put('Id', offreCiblee.id );
            elemnt.put('IdCampagne', offreCiblee.InwiB2C_Id_campagne__c );
            elemnt.put('points', String.valueOf(offreCiblee.inwib2c_points__c) );
            elemnt.put('Priorite',      String.valueOf(offreCiblee.inwib2c_priorite__c) );
            elemnt.put('Description',   offreCiblee.inwib2c_description__c );
            elemnt.put('DateDebut', String.valueOf(offreCiblee.inwib2c_date_debut__c) );
            elemnt.put('DateFin', String.valueOf(offreCiblee.inwib2c_date_fin__c) );
            elemnt.put('Argumentaire', offreCiblee.inwib2c_argumentaire__c );

            for (Id key : proposedOffreCibleesMap.keySet()){
                InwiB2C_data_offre_sell__c var = proposedOffreCibleesMap.get(key);

                if(var.InwiB2C_Id_offre_proposee_ciblee__c == offreCiblee.Id){
                    elemnt.put('dateModification', String.valueOf(var.LastModifiedDate) );
                    elemnt.put('RetourClient', var.inwib2c_retour_client__c );
                    elemnt.put('Motif', var.inwib2c_motif__c );
                }
            }
            outputResultCiblee.add(elemnt);
        }


        for (InwiB2C_offre_eligible__c  offreEligible : offreEligibles){
            Map<String, String> elemnt =  new Map<String, String>();
            
            elemnt.put('Id', offreEligible.id );
            elemnt.put('IdCampagne', offreEligible.InwiB2C_Id_campagne__c );
            elemnt.put('IdProfil', idProfile );
            elemnt.put('points', String.valueOf(offreEligible.inwib2c_points__c) );
            elemnt.put('Priorite', String.valueOf(offreEligible.inwib2c_priorite__c) );
            elemnt.put('Description', offreEligible.inwib2c_description__c );
            elemnt.put('DateDebut', String.valueOf(offreEligible.inwib2c_date_debut__c) );
            elemnt.put('DateFin', String.valueOf(offreEligible.inwib2c_date_fin__c) );
            elemnt.put('Argumentaire', offreEligible.inwib2c_argumentaire__c );

            for (Id key : proposedOffreEligiblesMap.keySet()){
                InwiB2C_data_offre_sell__c var = proposedOffreEligiblesMap.get(key);

                if(var.InwiB2C_Id_offre_proposee_eligible__c == offreEligible.Id){
                    elemnt.put('dateModification', String.valueOf(var.LastModifiedDate) );
                    elemnt.put('RetourClient', var.inwib2c_retour_client__c );
                    elemnt.put('Motif', var.inwib2c_motif__c );
                }
            }
            outputResultEligible.add(elemnt);

        }

       outMap.put('offresGeneric',outputResultGeneric);

       outMap.put('offresCiblee',outputResultCiblee);
       outMap.put('offresEligible',outputResultEligible);

       outMap.put('sizeOfCiblee',outputResultCiblee.size());
       outMap.put('sizeOfEligible',outputResultEligible.size());
       outMap.put('sizeOfGeneric',outputResultGeneric.size());

   } catch(DmlException e) {
        System.debug('An unexpected error has occurred: ' + e.getMessage());
    }
        
    }


        

    




    
}