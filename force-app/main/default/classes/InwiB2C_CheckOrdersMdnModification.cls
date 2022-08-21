global with sharing class InwiB2C_CheckOrdersMdnModification implements vlocity_cmt.VlocityOpenInterface {


        global Boolean invokeMethod(String methodName, Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
                
            Boolean result = true;
                
            try{
                
                if(methodName.equals('CheckOrderBeforeMdnChange')){
                    System.debug('Success! the method CheckOrderBeforeMdnChange was called' );
                    CheckOrderBeforeMdnChange(inputMap, outMap, options);
    
                } else{
                
                }                              
                
            } catch(Exception e){System.debug('An unexpected error has occurred: ' + e.getMessage());result = false;
                        
            }
                 
            return result;
                      
       }
    
    
        public static void CheckOrderBeforeMdnChange(Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
                
    
            String IdSubscription =  (String)options.get('SubscriptionId'); System.debug(IdSubscription);
            String MdnType =  (String)options.get('typeNumero'); System.debug(MdnType);
            String CycledeFacturation =  (String)options.get('CycledeFacturation'); System.debug(CycledeFacturation);
            Boolean ifStillOrdersGold = false;
            Boolean ifStillOrderOther = false;
            DateTime GoldOrdersLimitTime = DateTime.now().AddDays(-90);

            Date firstDayOfMonth = System.Today().toStartOfMonth();
            Date NextMonth = System.Today().addMonths(1);
            Date PreviousMonth = System.Today().addMonths(-1);
            
            DateTime firstDayOfMonthDateTime = DateTime.newInstance(firstDayOfMonth.year(), firstDayOfMonth.month(), firstDayOfMonth.day());
            DateTime lastDayOfMonthDateTime = firstDayOfMonth.addMonths(1).addDays(-1);
            DateTime Date18Current = DateTime.newInstance(firstDayOfMonth.year(), firstDayOfMonth.month(), 18);
            DateTime Date18Previous = DateTime.newInstance(firstDayOfMonth.year(), PreviousMonth.month(), 18);
            DateTime Date18Next = DateTime.newInstance(firstDayOfMonth.year(), NextMonth.month(), 18);
    
    
            inwiB2C_OrderSubscription__c[] CurrentOrders = [select id, InwiB2C_Date_et_heure_Order__c,InwiB2C_Statut_Order__c, inwiB2C_Subscription__c from inwiB2C_OrderSubscription__c  where inwiB2C_Subscription__c = :IdSubscription and inwiB2C_Order__r.inwiB2C_TypeActeDeGestion__c  = 'inwiB2C_ModificationDeNumero' ];

            if (CurrentOrders.size() > 0) 
            {
             
                if (MdnType == 'Gold')
                {
                    for (inwiB2C_OrderSubscription__c item : CurrentOrders )
                    {
                        if (item.InwiB2C_Date_et_heure_Order__c > GoldOrdersLimitTime )
                        {
                            System.debug('HERE A CASE WHERE ORDER IS NEW '+ item.InwiB2C_Date_et_heure_Order__c);
                            ifStillOrdersGold = true;
                            //break;
                        }
                        else
                        {
                            System.debug('HERE NOT '+item.InwiB2C_Date_et_heure_Order__c);
                        }
                    }
                }
                else 
                {
                    System.debug('OTHER THAN GOLD ');

                    for (inwiB2C_OrderSubscription__c item : CurrentOrders )
                    {
                        if (CycledeFacturation == '01')
                        {
                            if (item.InwiB2C_Date_et_heure_Order__c > firstDayOfMonthDateTime )
                            {
                                System.debug('HERE A CASE WHERE ORDER IS NEW '+ item.InwiB2C_Date_et_heure_Order__c);
                                ifStillOrderOther = true;
                            }
                        }
                        else if (date.today().day() > 18)
                        {
                            if (item.InwiB2C_Date_et_heure_Order__c > Date18Current )
                            {
                                System.debug('HERE A CASE WHERE ORDER IS NEW '+ item.InwiB2C_Date_et_heure_Order__c);
                                ifStillOrderOther = true;
                            }
                        }
                        else
                        {
                            if (item.InwiB2C_Date_et_heure_Order__c > Date18Previous )
                            {
                                System.debug('HERE A CASE WHERE ORDER IS NEW '+ item.InwiB2C_Date_et_heure_Order__c);
                                ifStillOrderOther = true;
                            }
                        }
                    }
                }
            }
            System.debug('FINAL RESULT GOLD: '+ifStillOrdersGold+ ' OTHER: '+ifStillOrderOther );
            outMap.put('ifStillOrderOther', ifStillOrderOther);
            outMap.put('ifStillOrdersGold', ifStillOrdersGold);
           
    }
    }