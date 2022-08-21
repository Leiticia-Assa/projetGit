trigger inwib2c_cession_ligne on Order(before update ){
    // Ce trigger permet de faire le checkout et la modif du billing account des orderitems
    // only for order changement de titulaire et regroupement de compte

    List<String> data = new List<String>();
    for (Order newOrder : Trigger.new ){
        // get order before update
        Order oldOrder = Trigger.oldMap.get(newOrder.ID);

        if ((oldOrder.inwiB2C_TypeActeDeGestion__c == 'inwiB2C_ChangementTitulaire' || oldOrder.inwiB2C_TypeActeDeGestion__c == 'inwiB2C_RegroupementCompte') && newOrder.inwiB2C_Statut__c == 'inwiB2C_ValideeBO' && newOrder.inwiB2C_Statut__c != oldOrder.inwiB2C_Statut__c){
            data.add((String) newOrder.Id);
        }
    }
    System.debug(data);
    if (!data.isEmpty()){
        inwib2c_checkout_update_orderitems.callVIP(data);
    }
}