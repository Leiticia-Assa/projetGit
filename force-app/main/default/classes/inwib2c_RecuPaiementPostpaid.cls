public with sharing class inwib2c_RecuPaiementPostpaid{
    public Map<String, Object> output{ get; set; }

    public String keys{ get; set; }

    public String code_transaction{ get; set; }

    public String date_facture{ get; set; }

    public String mode_paiement{ get; set; }

    public List<Map<String, Object>> lignes{ get; set; }

    public Decimal total_ttc{ get; set; }

    public inwib2c_RecuPaiementPostpaid(){
        Map<String, Object> input = new Map<String, Object>();
        // Call vip
        input.put('orderid', Apexpages.currentPage().getParameters().get('orderid'));
        output = (Map<String, Object>)(vlocity_cmt.IntegrationProcedureService.runIntegrationService('inwib2c_recu_paiment_postpaid', input, null));
        System.debug(output);
        // Get response keys
        for (String item : output.keySet()){
            keys = keys + item + '-';
        }
        System.debug(keys);

        // get lignes & keys
        List<Map<String, Object>> temp = new List<Map<String, Object>>();
        Decimal prix = 0;
        List<Object> entriesArray = (List<Object>)output.get('datafms');
        for (Object inidividualEntries : entriesArray){
            String ligne_key = '';
            Map<String, Object> ind = (Map<String, Object>)inidividualEntries;
            System.debug(ind);
            for (String item : ind.keySet()){
                ligne_key = ligne_key + item;
            }
            ind.put('keys', ligne_key);
            code_transaction = (String) ind.get('reference');
            mode_paiement = (String) ind.get('mode_paiement');
            date_facture = (String) ind.get('date');
            prix = prix + (Decimal) ind.get('montant');
            ind.put('reference', 'FMS' + ind.get('reference') );

            temp.add(ind);
        }
        lignes = temp;
        total_ttc = prix ;

        System.debug(code_transaction);
        System.debug(date_facture);
        System.debug(lignes);
    }

}