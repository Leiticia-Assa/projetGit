global with sharing class InwiB2C_Offre{

 @AuraEnabled(cacheable=true)
 global static List<Inwib2c_Offre__c> getOffres(Date dated_offre,Date datef_offre){

           if(dated_offre !=null && datef_offre!=null){
         
               
            return [SELECT Id,InwiB2C_Id_de_l_offre__c,
            Name,
            Inwib2c_Detail_de_l_offre__c,
            Inwib2c_Date_de_d_but__c,
            Inwib2c_Date_de_fin__c,
            InwiB2C_Statut_Offre__c
            FROM Inwib2c_Offre__c
            where 
                    Inwib2c_Date_de_fin__c >=:dated_offre and Inwib2c_Date_de_d_but__c <=:datef_offre
         //  Inwib2c_Date_de_d_but__c<=:dated_offre and  Inwib2c_Date_de_fin__c>=:datef_offre
            order by Inwib2c_Date_de_d_but__c desc 
            Limit 100];
 

           }
     
     else{ 
               
        
            return [SELECT Id,InwiB2C_Id_de_l_offre__c,
            Name,
            Inwib2c_Detail_de_l_offre__c,
            Inwib2c_Date_de_d_but__c,
            Inwib2c_Date_de_fin__c,
            InwiB2C_Statut_Offre__c
            FROM Inwib2c_Offre__c
            order by Inwib2c_Date_de_d_but__c desc 
            Limit 100];
           }
        
          
      
    }

}