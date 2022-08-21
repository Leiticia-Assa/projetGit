public with sharing class inwib2c_contract_cession_controller{
    public List<Integer> loopList{ get; set; }
    public String keys{ get; set; }
    public Map<String, Object> ipOutput{ get; set; }
    public String keysOffers {get; set;}

    public inwib2c_contract_cession_controller(){
        loopList = new List<Integer>{ 0, 1, 2 };
        Map<String, Object> ipInput = new Map<String, Object>();
        ipInput.put('OrderId', Apexpages.currentPage().getParameters().get('orderid'));
        ipInput.put('SubId', Apexpages.currentPage().getParameters().get('subid'));
        ipOutput = (Map<String, Object>)(vlocity_cmt.IntegrationProcedureService.runIntegrationService('inwib2c_contract_changement_titulaire', ipInput, null));

        for (String item : ipOutput.keySet()){
            keys = keys + item;
        }

        // Put Offer keys in string
        try{
            List<Map<String, Object>> offers = (List<Map<String, Object>>)ipOutput.get('data');
            for (String item_offer : offers[0].keySet()){
                System.debug('OFFRE EST : ' + item_offer);
                keysOffers = keysOffers + item_offer;
            }
        } catch (Exception e){


        }
    }

}