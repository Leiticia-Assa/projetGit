public with sharing class inwib2c_RecuPaiementTerminal{
    public Map<String, Object> output{ get; set; }

    public String keys{ get; set; }

    public String code_transaction{ get; set; }
    public String mode_paiement{ get; set; }

    public List<Map<String, Object>> lignes{ get; set; }

    public Decimal total_ttc{ get; set; }

    public Decimal price{ get; set; }

    public inwib2c_RecuPaiementTerminal(){
        Map<String, Object> input = new Map<String, Object>();
        // Call vip
        input.put('orderid', Apexpages.currentPage().getParameters().get('orderid'));
        output = (Map<String, Object>)(vlocity_cmt.IntegrationProcedureService.runIntegrationService('inwib2c_recu_paiement_terminal', input, null));
        System.debug(output);
        // Get response keys
        for (String item : output.keySet()){
            keys = keys + item + '-';
        }
        System.debug(keys);

        // get lignes & keys
        List<Map<String, Object>> temp = new List<Map<String, Object>>();
        Decimal prix = 0;
        List<Object> entriesArray = (List<Object>)output.get('terminaux');
        for (Object inidividualEntries : entriesArray){
            String ligne_key = '';
            Map<String, Object> ind = (Map<String, Object>)inidividualEntries;
            System.debug(ind);
            for (String item : ind.keySet()){
                ligne_key = ligne_key + item;
            }
            ind.put('keys', ligne_key);
            prix = (Decimal) (prix + (Decimal) ind.get('price'));
            if (entriesArray.size() == 1){
                price = (Decimal) ind.get('price');
            }
            code_transaction = ind.get('code_transaction') <> null ? (String) ind.get('code_transaction') : '';
            mode_paiement = ind.get('mode_paiement') <> null ? (String) ind.get('mode_paiement') : '';
            temp.add(ind);
        }
        lignes = temp;

        total_ttc = (Decimal) prix;

        System.debug(code_transaction);
        System.debug(lignes);
    }

}