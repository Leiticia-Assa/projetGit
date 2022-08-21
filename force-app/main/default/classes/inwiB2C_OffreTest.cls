@isTest
public with sharing class inwiB2C_OffreTest {
    
    @isTest
    static void testOneoffre (){
    
        inwib2c_offre__c newoffre = new inwib2c_offre__c();
    
            Date today = Date.today();
            Date todayplusmonth = Date.today() ;
            newoffre.name = 'Offre Nouvel An';
            newoffre.Inwib2c_Detail_de_l_offre__c = 'SMS DATA Appel';
            newoffre.Inwib2c_Date_de_d_but__c = today;
            newoffre.Inwib2c_Date_de_fin__c = todayplusmonth;
            
            insert newoffre;

            Date datedebut = Date.newInstance(2020,1, 01);
            Date datefin = Date.newInstance(2021, 2, 10);
            List<inwib2c_offre__c> returnedoffre = InwiB2C_Offre.getOffres(datedebut,datefin);
        if(returnedoffre.size() > 0){
            System.assertEquals(newoffre.Name, returnedoffre[0].Name);
            System.assertEquals(newoffre.Inwib2c_Detail_de_l_offre__c, returnedoffre[0].Inwib2c_Detail_de_l_offre__c);
            System.assertEquals(newoffre.Inwib2c_Date_de_d_but__c, returnedoffre[0].Inwib2c_Date_de_d_but__c);
            System.assertEquals(newoffre.Inwib2c_Date_de_fin__c, returnedoffre[0].Inwib2c_Date_de_fin__c);
        }
    
    
    
        }
    
    }