global with sharing  class inwiB2C_ContractPickListManagement  implements vlocity_cmt.VlocityOpenInterface {
    global Boolean invokeMethod(String methodName, Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
        Boolean result = true;
        try{
            if(methodName.equals('gePicklistValues'))
                gePicklistValues(inputMap, outMap, options);        
            else {} 
        }
         catch(Exception e){
            result = false;
        }
        return result;
   }


    public static void gePicklistValues(Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
            
        Map < String, List <Map<String,String>>> picklistValues =
        new Map < String, List <Map<String,String>> > ();
        
        List <Map<String,String>> Choixprincipaloperateur = new List <Map<String,String>>();
        for (PickListEntry pe : Contract.InwiB2C_Choix_principal_op_rateur__c.getDescribe().getPicklistValues())
        Choixprincipaloperateur.add(new Map<String,String>{
            'value'=>pe.getValue(),
            'label'=>pe.getLabel()
        });
        picklistValues.put('Choixprincipaloperateur', Choixprincipaloperateur);


        List <Map<String,String>> Motif_incompletude_Physique = new List <Map<String,String>>();
        for (PickListEntry pe : Contract.InwiB2C_Motif_incompletude_Physique__c.getDescribe().getPicklistValues())
        Motif_incompletude_Physique.add(new Map<String,String>{
            'value'=>pe.getValue(),
            'label'=>pe.getLabel()
        });
        picklistValues.put('Motif_incompletude_Physique', Motif_incompletude_Physique);

        List <Map<String,String>> Source_de_reception = new List <Map<String,String>>();
        for (PickListEntry pe : Contract.InwiB2C_Source_de_reception__c.getDescribe().getPicklistValues())
        Source_de_reception.add(new Map<String,String>{
            'value'=>pe.getValue(),
            'label'=>pe.getLabel()
        });
        picklistValues.put('Source_de_reception', Source_de_reception);

        List <Map<String,String>> Type_CIN = new List <Map<String,String>>();
        for (PickListEntry pe : Contract.InwiB2C_Type_CIN__c.getDescribe().getPicklistValues())
        Type_CIN.add(new Map<String,String>{
            'value'=>pe.getValue(),
            'label'=>pe.getLabel()
        });
        picklistValues.put('Type_CIN', Type_CIN);

        List <Map<String,String>> Categorie_client = new List <Map<String,String>>();
        for (PickListEntry pe : Contract.InwiB2C_Categorie_client__c.getDescribe().getPicklistValues())
        Categorie_client.add(new Map<String,String>{
            'value'=>pe.getValue(),
            'label'=>pe.getLabel()
        });
        picklistValues.put('Categorie_client', Categorie_client);

        List <Map<String,String>> Segmentation = new List <Map<String,String>>();
        for (PickListEntry pe : Contract.InwiB2C_Segmentation__c.getDescribe().getPicklistValues())
        Segmentation.add(new Map<String,String>{
            'value'=>pe.getValue(),
            'label'=>pe.getLabel()
        });
        picklistValues.put('Segmentation', Segmentation);

        List <Map<String,String>> Segmentation2 = new List <Map<String,String>>();
        for (PickListEntry pe : Contract.InwiB2C_Segmentation2__c.getDescribe().getPicklistValues())
        Segmentation2.add(new Map<String,String>{
            'value'=>pe.getValue(),
            'label'=>pe.getLabel()
        });
        picklistValues.put('Segmentation2', Segmentation2);

        List <Map<String,String>> Possession_Fixe = new List <Map<String,String>>();
        for (PickListEntry pe : Contract.InwiB2C_Possession_Fixe__c.getDescribe().getPicklistValues())
        Possession_Fixe.add(new Map<String,String>{
            'value'=>pe.getValue(),
            'label'=>pe.getLabel()
        });
        picklistValues.put('Possession_Fixe', Possession_Fixe);

        List <Map<String,String>> Possession_Internet = new List <Map<String,String>>();
        for (PickListEntry pe : Contract.InwiB2C_Possession_Internet__c.getDescribe().getPicklistValues())
        Possession_Internet.add(new Map<String,String>{
            'value'=>pe.getValue(),
            'label'=>pe.getLabel()
        });
        picklistValues.put('Possession_Internet', Possession_Internet);

        List <Map<String,String>> Possession_Mobile = new List <Map<String,String>>();
        for (PickListEntry pe : Contract.InwiB2C_Possession_Mobile__c.getDescribe().getPicklistValues())
        Possession_Mobile.add(new Map<String,String>{
            'value'=>pe.getValue(),
            'label'=>pe.getLabel()
        });
        picklistValues.put('Possession_Mobile', Possession_Mobile);
/*
        List <Map<String,String>> Distributeur = new List <Map<String,String>>();
        for (PickListEntry pe : Contract.InwiB2C_Distributeur__c.getDescribe().getPicklistValues())
        Distributeur.add(new Map<String,String>{
            'value'=>pe.getValue(),
            'label'=>pe.getLabel()
        });
        picklistValues.put('Distributeur', Distributeur);

        List <Map<String,String>> Point_de_vente = new List <Map<String,String>>();
        for (PickListEntry pe : Contract.InwiB2C_Point_de_vente__c.getDescribe().getPicklistValues())
        Point_de_vente.add(new Map<String,String>{
            'value'=>pe.getValue(),
            'label'=>pe.getLabel()
        });
        picklistValues.put('Point_de_vente', Point_de_vente);
*/

        /*
        List <Map<String,String>> Signature_PDV = new List <Map<String,String>>();
        for (PickListEntry pe : Contract.InwiB2C_Signature_PDV__c.getDescribe().getPicklistValues())
        Signature_PDV.add(new Map<String,String>{
            'value'=>pe.getValue(),
            'label'=>pe.getLabel()
        });
        picklistValues.put('Signature_PDV', Signature_PDV);

*/
        List <Map<String,String>> Statut_Dossier = new List <Map<String,String>>();
        for (PickListEntry pe : Contract.InwiB2C_Statut_Dossier__c.getDescribe().getPicklistValues())
        Statut_Dossier.add(new Map<String,String>{
                'value'=>pe.getValue(),
                'label'=>pe.getLabel()
            });
        picklistValues.put('Statut_Dossier', Statut_Dossier);
        
        List <Map<String,String>> Motif_incompletude_Numeriqu = new List <Map<String,String>>();
        for (PickListEntry pe : Contract.InwiB2C_Motif_incompletude_Numeriqu__c.getDescribe().getPicklistValues())
        Motif_incompletude_Numeriqu.add(new Map<String,String>{
                'value'=>pe.getValue(),
                'label'=>pe.getLabel()
            });
        picklistValues.put('Motif_incompletude_Numeriqu', Motif_incompletude_Numeriqu);


        List <Map<String,String>> Motif_de_non_conformit = new List <Map<String,String>>();
        for (PickListEntry pe : Contract.InwiB2C_Motif_de_non_conformit__c.getDescribe().getPicklistValues())
        Motif_de_non_conformit.add(new Map<String,String>{
                'value'=>pe.getValue(),
                'label'=>pe.getLabel()
            });
        picklistValues.put('Motif_de_non_conformit', Motif_de_non_conformit);

        List <Map<String,String>> Sexe = new List <Map<String,String>>();
        for (PickListEntry pe : Contract.InwiB2C_Sexe__c.getDescribe().getPicklistValues())
        Sexe.add(new Map<String,String>{
                'value'=>pe.getValue(),
                'label'=>pe.getLabel()
            });
        picklistValues.put('Sexe', Sexe);

        List <Map<String,String>> statut_contrat = new List <Map<String,String>>();
        for (PickListEntry pe : Contract.InwiB2C_statut_contrat__c.getDescribe().getPicklistValues())
        statut_contrat.add(new Map<String,String>{
                'value'=>pe.getValue(),
                'label'=>pe.getLabel()
            });
        picklistValues.put('statut_contrat', statut_contrat);

        List <Map<String,String>> Profil_Gratuit = new List <Map<String,String>>();
        for (PickListEntry pe : Contract.InwiB2C_Profil_Gratuit__c.getDescribe().getPicklistValues())
        Profil_Gratuit.add(new Map<String,String>{
                'value'=>pe.getValue(),
                'label'=>pe.getLabel()
            });
        picklistValues.put('Profil_Gratuit', Profil_Gratuit);

        List <Map<String,String>> Statut_Contrat_Num_rique = new List <Map<String,String>>();
        for (PickListEntry pe : Contract.InwiB2C_Statut_Contrat_Num_rique__c.getDescribe().getPicklistValues())
        Statut_Contrat_Num_rique.add(new Map<String,String>{
                'value'=>pe.getValue(),
                'label'=>pe.getLabel()
            });
        picklistValues.put('Statut_Contrat_Num_rique', Statut_Contrat_Num_rique);


        
        List <Map<String,String>> statutIdentification = new List <Map<String,String>>();
        for (PickListEntry pe : Contract.InwiB2C_Statut_d_identification__c.getDescribe().getPicklistValues())
        statutIdentification.add(new Map<String,String>{
                'value'=>pe.getValue(),
                'label'=>pe.getLabel()
            });
        picklistValues.put('statutIdentification', statutIdentification);





        List <Map<String,String>> Type_d_adresse = new List <Map<String,String>>();
        for (PickListEntry pe : InwiB2C_Address__c.InwiB2C_Type_d_adresse__c.getDescribe().getPicklistValues())
        Type_d_adresse.add(new Map<String,String>{
                'value'=>pe.getValue(),
                'label'=>pe.getLabel()
            });
        picklistValues.put('Type_d_adresse', Type_d_adresse);
/*
        List <Map<String,String>> Pays = new List <Map<String,String>>();
        for (PickListEntry pe : InwiB2C_Address__c.InwiB2C_Pays__c.getDescribe().getPicklistValues())
        Pays.add(new Map<String,String>{
                'value'=>pe.getValue(),
                'label'=>pe.getLabel()
            });
        picklistValues.put('Pays', Pays);


        List <Map<String,String>> Region = new List <Map<String,String>>();
        for (PickListEntry pe : InwiB2C_Address__c.InwiB2C_Region__c.getDescribe().getPicklistValues())
        Region.add(new Map<String,String>{
                'value'=>pe.getValue(),
                'label'=>pe.getLabel()
            });
        picklistValues.put('Region', Region);


        List <Map<String,String>> Ville = new List <Map<String,String>>();
        for (PickListEntry pe : InwiB2C_Address__c.InwiB2C_Ville__c.getDescribe().getPicklistValues())
        Ville.add(new Map<String,String>{
                'value'=>pe.getValue(),
                'label'=>pe.getLabel()
            });
        picklistValues.put('Ville', Ville);


        List <Map<String,String>> Quartier = new List <Map<String,String>>();
        for (PickListEntry pe : InwiB2C_Address__c.InwiB2C_Quartier__c.getDescribe().getPicklistValues())
        Quartier.add(new Map<String,String>{
                'value'=>pe.getValue(),
                'label'=>pe.getLabel()
            });
        picklistValues.put('Quartier', Quartier);

*/



    outMap.put('picklistValues', picklistValues);



    }

   

  
}