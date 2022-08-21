public with sharing class inwiB2C_RecuPaiementInvoice{
    public Map<String, Object> output{ get; set; }
    public Map<String, Object> data{ get; set; }

    public string keys{ get; set; }



    public inwiB2C_RecuPaiementInvoice(){
        Map<String, Object> input = new Map<String, Object>();
        // Call vip
        input.put('accountId', Apexpages.currentPage().getParameters().get('accountId'));
        input.put('invoiceId', Apexpages.currentPage().getParameters().get('invoiceId'));

        output = (Map<String, Object>)(vlocity_cmt.IntegrationProcedureService.runIntegrationService('inwib2c_RecuPaiementInvoice', input, null));
        
      List<Object> entriesArray = (List<Object>)output.get('result');
                    System.debug('entriesArray'+entriesArray);

        for (Object inidividualEntries : entriesArray){
             keys = '';
            Map<String, Object> ind = (Map<String, Object>)inidividualEntries;
            System.debug(ind);
            data= new Map<String, object>();
            for (String item : ind.keySet()){
                keys = keys + item;
              System.debug(keys);

                data.put(item,ind.get(item));
                            System.debug(data);

            }
            
        }
    
    }
}