@isTest
public class inwiB2C_Test_SellManagement {
    @isTest(SeeAllData=true)
    static void MethodTestPositive()
{
      Map<String,Object> outMap = new  Map<String,Object>();
     Map<String,Object> options = new  Map<String,Object>();
     Map<String,Object> inputMap = new  Map<String,Object>();
    
                Account accounttest = new Account(
                Name = 'Mohamed Test');
            insert accounttest;

    
            InwiB2C_offre_ciblee__c cible1= new InwiB2C_offre_ciblee__c(
                InwiB2C_Argumentaire__c='Forfait Série limitée 49dhs',
                InwiB2C_Description__c='illimité 149 dh plus',
                InwiB2C_Date_debut__c = Date.valueOf('2021-01-01'),
                InwiB2C_Date_fin__c = Date.valueOf('2021-03-13'),
                InwiB2C_MDN__c = '212767544777');
            insert cible1;
    
                InwiB2C_offre_ciblee__c cible2= new InwiB2C_offre_ciblee__c(
                InwiB2C_Argumentaire__c='Forfait Série limitée 49dhs',
                InwiB2C_Description__c='illimité 149 dh plus',
                InwiB2C_Date_debut__c = Date.valueOf('2021-01-01'),
                InwiB2C_Date_fin__c = Date.valueOf('2021-03-13'),
                InwiB2C_MDN__c = '212767544777');
            insert cible2;

    
    
                InwiB2C_offre_eligible__c eligible1 = new InwiB2C_offre_eligible__c(
                InwiB2C_Argumentaire__c='11Go 1h d appels 25 sms Facturation à la seconde Sans engagement.',
                InwiB2C_Description__c='illimité 99dh Plus',
                InwiB2C_Date_debut__c = Date.valueOf('2021-01-01'),
                InwiB2C_Date_fin__c = Date.valueOf('2021-03-13'),
                InwiB2C_Id_profil__c = '18711');
            insert eligible1;

        
            InwiB2C_offre_eligible__c eligible2= new InwiB2C_offre_eligible__c(
                InwiB2C_Argumentaire__c='illimité 149 dh plus',
                InwiB2C_Description__c='30 Go 3h d appels Appels illimités vers inwi',
                InwiB2C_Date_debut__c = Date.valueOf('2021-01-01'),
                InwiB2C_Date_fin__c = Date.valueOf('2021-03-13'),
                InwiB2C_Id_profil__c = '18711');
            insert eligible2;


    
                InwiB2C_generique__c generique1 = new InwiB2C_generique__c(
                InwiB2C_Argumentaire__c='Forfait Série limitée 49dhs',
                InwiB2C_Description__c='illimité 149 dh plus',
                InwiB2C_Date_debut__c = Date.valueOf('2021-01-01'),
                InwiB2C_Date_fin__c = Date.valueOf('2021-03-13'));
            insert generique1;
    
                    InwiB2C_generique__c generique2 = new InwiB2C_generique__c(
                InwiB2C_Argumentaire__c='Forfait Série limitée 49dhs',
                InwiB2C_Description__c='illimité 149 dh plus',
                InwiB2C_Date_debut__c = Date.valueOf('2021-01-01'),
                InwiB2C_Date_fin__c = Date.valueOf('2021-03-13'));
            insert generique2;


    
    String accid = accounttest.ID;
    
                InwiB2C_data_offre_sell__c dataoffresellcibleel = new InwiB2C_data_offre_sell__c(
                    InwiB2C_Retour_Client__c='Autres',
                	InwiB2C_Motif__c='Souhaite reflechir',
					InwiB2C_Id_Client__c=accid,
                    InwiB2C_Argumentaire__c='Forfait Série limitée 49dhs',
                    InwiB2C_Description__c='illimité 149 dh plus',
                    InwiB2C_Date_debut__c = Date.valueOf('2021-01-01'),
                    InwiB2C_Date_fin__c = Date.valueOf('2021-03-13'),
                    InwiB2C_Id_offre_proposee_ciblee__c =cible1.ID,
                    InwiB2C_MDN__c = '212767544777'
                );
            insert dataoffresellcibleel;
    
    
                    InwiB2C_data_offre_sell__c dataoffresellciblee2 = new InwiB2C_data_offre_sell__c(
                    InwiB2C_Retour_Client__c='Autres',
                	InwiB2C_Motif__c='Souhaite reflechir',
					InwiB2C_Id_Client__c=accid,
                    InwiB2C_Argumentaire__c='Forfait Série limitée 49dhs',
                    InwiB2C_Description__c='illimité 149 dh plus',
                    InwiB2C_Date_debut__c = Date.valueOf('2021-01-01'),
                    InwiB2C_Date_fin__c = Date.valueOf('2021-03-13'),
                    InwiB2C_Id_offre_proposee_ciblee__c =cible2.ID,
                    InwiB2C_MDN__c = '212767544777'
                );
            insert dataoffresellciblee2;

    
                            InwiB2C_data_offre_sell__c dataoffreselleligible1 = new InwiB2C_data_offre_sell__c(
                    InwiB2C_Retour_Client__c='Autres',
                	InwiB2C_Motif__c='Souhaite reflechir',
					InwiB2C_Id_Client__c=accid,
                    InwiB2C_Argumentaire__c='Forfait Série limitée 49dhs',
                    InwiB2C_Description__c='illimité 149 dh plus',
                    InwiB2C_Date_debut__c = Date.valueOf('2021-01-01'),
                    InwiB2C_Date_fin__c = Date.valueOf('2021-03-13'),
                        InwiB2C_Id_offre_proposee_eligible__c =eligible1.ID,
                    InwiB2C_MDN__c = '212767544777'
                );
            insert dataoffreselleligible1;
 
    
                                InwiB2C_data_offre_sell__c dataoffreselleligible2 = new InwiB2C_data_offre_sell__c(
                    InwiB2C_Retour_Client__c='Autres',
                	InwiB2C_Motif__c='Souhaite reflechir',
					InwiB2C_Id_Client__c=accid,
                    InwiB2C_Argumentaire__c='Forfait Série limitée 49dhs',
                    InwiB2C_Description__c='illimité 149 dh plus',
                    InwiB2C_Date_debut__c = Date.valueOf('2021-01-01'),
                    InwiB2C_Date_fin__c = Date.valueOf('2021-03-13'),
                        InwiB2C_Id_offre_proposee_eligible__c =eligible2.ID,
                    InwiB2C_MDN__c = '212767544777'
                );
            insert dataoffreselleligible2;


                    InwiB2C_data_offre_sell__c dataoffresellgeneric1 = new InwiB2C_data_offre_sell__c(
                    InwiB2C_Retour_Client__c='Autres',
                	InwiB2C_Motif__c='Souhaite reflechir',
					InwiB2C_Id_Client__c=accid,
                    InwiB2C_Argumentaire__c='Forfait Série limitée 49dhs',
                    InwiB2C_Description__c='illimité 149 dh plus',
                    InwiB2C_Date_debut__c = Date.valueOf('2021-01-01'),
                    InwiB2C_Date_fin__c = Date.valueOf('2021-03-13'),
                        InwiB2C_Id_offre_proposee_generique__c =generique1.ID,
                    InwiB2C_MDN__c = '212767544777'
                );
            insert dataoffresellgeneric1;

                        InwiB2C_data_offre_sell__c dataoffresellgeneric2 = new InwiB2C_data_offre_sell__c(
                    InwiB2C_Retour_Client__c='Autres',
                	InwiB2C_Motif__c='Souhaite reflechir',
					InwiB2C_Id_Client__c=accid,
                    InwiB2C_Argumentaire__c='Forfait Série limitée 49dhs',
                    InwiB2C_Description__c='illimité 149 dh plus',
                    InwiB2C_Date_debut__c = Date.valueOf('2021-01-01'),
                    InwiB2C_Date_fin__c = Date.valueOf('2021-03-13'),
                        InwiB2C_Id_offre_proposee_generique__c =generique2.ID,
                    InwiB2C_MDN__c = '212767544777'
                );
            insert dataoffresellgeneric2;
    
	String MDN='212767544777';
    String idProfile='18711';
  //  String accid='0012z000002LEanAAG';
    
    inputMap.put('mdn',MDN);
    inputMap.put('idprofile',idProfile);
    inputMap.put('accid',accid);



    inwiB2C_SellManagement cls = new inwiB2C_SellManagement(); 
       boolean result1 = cls.invokeMethod('getOffreSell',inputMap, outMap, options);
    System.assertEquals(true, result1);
}

}/* */