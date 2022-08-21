public class InwiB2C_ManageConfPromotionLWC {
    public InwiB2C_ManageConfPromotionLWC() {

    }


    @AuraEnabled()
    public static list<inwiB2C_scop_determinant__c> get_scop_determinant(string idPromotion){
        List<inwiB2C_scop_determinant__c> lst = new List<inwiB2C_scop_determinant__c>(
            [SELECT Id, Name,
                (SELECT Id, Name,
                    inwiB2C_code_attribute__c,
                    inwiB2C_Code_Produit__c,
                    inwiB2C_field__c,
                    inwiB2C_scope__c ,
                    toLabel(inwiB2C_scope__c) scopevalue,
            
                    inwiB2C_Valeur_attribut__c,
                    inwiB2C_value__c
                FROM Determinants__r
                ORDER BY CreatedDate DESC),
            toLabel(inwiB2C_Canal__c),
            inwiB2C_Promotion_discount__c,
            InwiB2C_type_acte_de_gestion__c,
            InwiB2C_Type_d_inclution__c
         FROM inwiB2C_scop_determinant__c 
         WHERE inwiB2C_Promotion_discount__c = :idPromotion 
         ORDER BY CreatedDate DESC]);
        return lst;
    }

    @AuraEnabled
    public static list<inwiB2C_promotion_result__c> get_promotion_result(string idPromotion){
        return  new List<inwiB2C_promotion_result__c>(
            [SELECT Id, Name,
            inwiB2C_code_attribute__c,
            inwiB2C_percent__c,
            inwiB2C_Promotion_discount__c,
            inwiB2C_Result_type__c,
            inwiB2C_type_de_prix__c,
            inwiB2C_valeur_attribut__c,
            toLabel(inwiB2C_Result_type__c) resultTypeLabel,
            toLabel(inwiB2C_type_de_prix__c) typePrixLabel
         FROM inwiB2C_promotion_result__c 
         WHERE inwiB2C_Promotion_discount__c = :idPromotion 
         ORDER BY CreatedDate DESC]);
    }




    @AuraEnabled
    public static list<inwiB2C_applied_product__c> get_applied_product(string idPromotion){
        return  new List<inwiB2C_Applied_Product__c>(
            [SELECT Id, Name,
            inwiB2C_Libelle_du_produit__c,
            inwiB2C_Code_Produit__c
         FROM inwiB2C_Applied_Product__c 
         WHERE inwiB2C_Promotion_discount__c = :idPromotion 
         ORDER BY CreatedDate DESC]);
    }



    @AuraEnabled
    public static list<inwiB2C_determinant__c> get_determinant(string idScopDeterminant){
        List<inwiB2C_determinant__c> lst = new List<inwiB2C_determinant__c>([SELECT Id, Name,
        inwiB2C_code_attribute__c,
        inwiB2C_Code_Produit__c,
        inwiB2C_field__c,
        inwiB2C_scope__c ,
        toLabel(inwiB2C_scope__c) scopevalue,

        inwiB2C_Valeur_attribut__c,
        inwiB2C_value__c
         FROM inwiB2C_determinant__c 
         WHERE inwiB2C_scope_determinant__c = :idScopDeterminant 
         ORDER BY CreatedDate DESC]);
        return lst;
    }
   

}