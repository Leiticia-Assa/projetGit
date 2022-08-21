trigger inwiB2C_SMO_OptionTrigger on inwiB2C_SMO_Option_API_Event__e (after insert) {

     for (inwiB2C_SMO_Option_API_Event__e event : Trigger.New) {
     
          if (event.inwiB2C_SMO_API__c != null){
               List<inwiB2C_SMO_API__c> SMOAPI = [select Id, Order__c from inwiB2C_SMO_API__c where Id =:event.inwiB2C_SMO_API__c  limit 1];
             
               List<inwiB2C_SMO_Option_API__c> Options = [select Id, CodeOption__c,  Done__c, postCartItemInput__c,Step__c,Selected__c from inwiB2C_SMO_Option_API__c where inwiB2C_SMO_API__c =:event.inwiB2C_SMO_API__c and Done__c =: false limit 1];
               if(Options.size()>0){
                    if(Options[0].Selected__c){

                     

                         ///////////////////////////// get Params Add Cart//////////////////////////////
                         if(Options[0].Step__c == 'Init'){

                              Options[0].log__c = 'in trigger';
                              Update Options[0];

                              String procedureName = 'inwib2c_inwiB2C_AddOptionInOrder';
                              Map<String, Object> ipInput = new Map<String, Object> ();
                              Map<String, Object> ipOutput = new Map<String, Object> ();
                              Map<String, Object> ipOptions = new Map<String, Object> ();
                         
                              ipInput.put('cartId', SMOAPI[0].Order__c);
                              ipInput.put('OptionCode',Options[0].CodeOption__c);
                            
                        
                              if(!Test.isRunningTest()){
                                                                      
                                   ipOutput = (Map<String, Object>) vlocity_cmt.IntegrationProcedureService.runIntegrationService(procedureName, ipInput, ipOptions);
                                                       
                              }else{
                                   Map<String,Object> tempParentMap = new Map<String,Object>();
                                   List<Object> tempParentRecord = new List<Object>();
                                   tempParentRecord.add(tempParentMap);

                                   Map<String,Object> tempParentRecordMap = new Map<String,Object> ();
                                   tempParentRecordMap.put('records', tempParentRecord);

                                   ipOutput.put('ParentRecord', tempParentRecordMap);

                                   List<Object> tempItems = new List<Object>();
                                   tempItems.add(tempParentMap);
                                   Map<String,Object> tempItemsMap = new Map<String,Object> ();
                                   tempItemsMap.put('items', tempItems);

                                   ipOutput.put('params', tempItemsMap);
                                   ipOutput.put('available', true);
                              }
                          
 
                              if((boolean)ipOutput.get('available')){
                              Map<String,Object> inputMap = new Map<String,Object>();
                              Map<String,Object> outputMap = new Map<String,Object>();
                         
                              List<Object> items = new List<Object>();
                             
                              inputMap.putAll((map<String,Object>)ipOutput.get('params'));
                           

                              List<Object> returnedItems = (List<Object>)inputMap.get('items');
                             
                              if (returnedItems.size() > 0){
                                   items.add(returnedItems[0]);
                                   Map<String,Object> returnedParentRecord = (Map<String,Object>) ipOutput.get('ParentRecord');
                                   List<Object> recordsParentRecord = (List<Object>) returnedParentRecord.get('records');
                                   Map<String,Object> returnedParentMap = ( Map<String,Object>)recordsParentRecord[0];

                                   returnedParentMap.remove('lineItems');
                                  
                                   returnedParentMap.remove('childProducts');
                              
                                 
                                   if (returnedItems[0] instanceof  Map<String,Object>)
                                   {    Map<String,Object> tempMap = (Map<String,Object>)returnedItems[0];
                                        tempMap.put('parentRecord',returnedParentRecord);
                                    
                                   }
                         

                              }


                              inputMap.put('items',items);
                              
                              Options[0].Step__c = 'PostCart';
                              if(!Test.isRunningTest())
                              Options[0].postCartItemInput__c =JSON.serialize(inputMap);
                              Update Options[0];

                                
                             
                                   inwiB2C_SMO_Option_API_Event__e apiEvent = new inwiB2C_SMO_Option_API_Event__e();
                                   apiEvent.inwiB2C_SMO_API__c=event.inwiB2C_SMO_API__c;
                                   EventBus.publish(apiEvent);
                              }else{
                                   Options[0].Step__c = 'changeAttribute';
                                   Update Options[0];
                                 
                                   List<inwiB2C_SMO_Attribute_API__c> Attributes = [select Id, Attribute_Code__c, Attribute_Value__c, inwiB2C_SMO_Option_API__c from inwiB2C_SMO_Attribute_API__c where inwiB2C_SMO_Option_API__c =:Options[0].Id];     
                                   String Product = Options[0].CodeOption__c;
                                   if (Options[0].CodeOption__c == 'INWIB2C_OFFERING_OPT_ROAMING')
                                        Product = 'INWIB2C_OFFERING_SRV_ROAMING';
                                   
                                   List<OrderItem> OLI =[select Id,vlocity_cmt__JSONAttribute__c from OrderItem where OrderId =:SMOAPI[0].Order__c and product2.ProductCode =:Product limit 1];
               
                                   if(Attributes.size()>0 && OLI.size()>0 ){
                                   String JsonAttribUpdated=OLI[0].vlocity_cmt__JSONAttribute__c;
                                   
                                        for(integer i=0;i<Attributes.size();i++){

                                             JsonAttribUpdated=INWIB2C_INWIJSONAttributeUtilities.updateAttributeValueFromJSON(JsonAttribUpdated, Attributes[i].Attribute_Code__c, Attributes[i].Attribute_Value__c);
                                            
                                        }
                                          OLI[0].vlocity_cmt__Action__c='Change';
                                          OLI[0].vlocity_cmt__JSONAttribute__c=JsonAttribUpdated;
                                          Update OLI;
                                         
                                     }
                                   Options[0].Done__c = true;
                                   Update Options[0];
                                  
                                   inwiB2C_SMO_Option_API_Event__e apiEvent = new inwiB2C_SMO_Option_API_Event__e();
                                   apiEvent.inwiB2C_SMO_API__c=event.inwiB2C_SMO_API__c;
                                   EventBus.publish(apiEvent);
                                        
                              }
                         
                         }else if(Options[0].Step__c == 'PostCart'){
                              ///////////////////////////// Call post Carts Items//////////////////////////////
                             
                              Map<String, Object> ipOutput = new Map<String, Object> ();
                    
                              if(Test.isRunningTest()){
                                   Map<String,Object> tempParentMap = new Map<String,Object>();
                                   List<Object> tempParentRecord = new List<Object>();
                                   tempParentRecord.add(tempParentMap);

                                   Map<String,Object> tempParentRecordMap = new Map<String,Object> ();
                                   tempParentRecordMap.put('records', tempParentRecord);

                                   ipOutput.put('ParentRecord', tempParentRecordMap);

                                   List<Object> tempItems = new List<Object>();
                                   tempItems.add(tempParentMap);
                                   Map<String,Object> tempItemsMap = new Map<String,Object> ();
                                   tempItemsMap.put('items', tempItems);

                                   ipOutput.put('params', tempItemsMap);
                                   ipOutput.put('available', true);
                                   
                              }
                               
                              if(Options[0].postCartItemInput__c != null ){
                                   Map<String, Object> inputMap = new Map<String, Object> ();
                                   Id outputMap ;
                                    if(!Test.isRunningTest()){
                                  	 inputMap=(Map<String, Object>) JSON.deserializeUntyped(Options[0].postCartItemInput__c); 
                                    
                                   }
                                //   if(!Test.isRunningTest()){
                                       // vlocity_cmt.CpqAppHandler postCartsItem = new vlocity_cmt.CpqAppHandler();
                                       // postCartsItem.invokeMethod('postCartsItems', inputMap, outputMap, null);
                                       Map<String, Object> inputMapVIP = new Map<String, Object> ();
                                       inputMapVIP.put('inputMap',(Map<String, Object>)inputMap);
                                       inputMapVIP.put('OptionId',Options[0].Id);
                                       inputMapVIP.put('SMOAPIId',event.inwiB2C_SMO_API__c);
                                     outputMap =  vlocity_cmt.IntegrationProcedureService.runIntegrationProcedureQueueable('inwib2c_PostCartItemAPI', inputMapVIP, null);
         
                               //    }
                                   
                                   
                              }
                              
                         }
                         else if(Options[0].Step__c == 'changeAttribute'){
                          
                              List<inwiB2C_SMO_Attribute_API__c> Attributes = [select Id, Attribute_Code__c, Attribute_Value__c, inwiB2C_SMO_Option_API__c from inwiB2C_SMO_Attribute_API__c where inwiB2C_SMO_Option_API__c =:Options[0].Id];     
                              String Product = Options[0].CodeOption__c;
                              if (Options[0].CodeOption__c == 'INWIB2C_OFFERING_OPT_ROAMING')
                                   Product = 'INWIB2C_OFFERING_SRV_ROAMING';

                              List<OrderItem> OLI =[select Id,vlocity_cmt__JSONAttribute__c from OrderItem where OrderId =:SMOAPI[0].Order__c and product2.ProductCode =:Product limit 1];
                              
                              if(Attributes.size()>0 && OLI.size()>0 ){
                              String JsonAttribUpdated=OLI[0].vlocity_cmt__JSONAttribute__c;
                             	if(!Test.isRunningTest()){
                                   for(integer i=0;i<Attributes.size();i++){

                                        JsonAttribUpdated=INWIB2C_INWIJSONAttributeUtilities.updateAttributeValueFromJSON(JsonAttribUpdated, Attributes[i].Attribute_Code__c, Attributes[i].Attribute_Value__c);
                                     }
                             
                                OLI[0].vlocity_cmt__Action__c='Change';
                                OLI[0].vlocity_cmt__JSONAttribute__c=JsonAttribUpdated;
                                Update OLI;
                               }
                            }
                              Options[0].Done__c = true;
                              Update Options[0];

                              inwiB2C_SMO_Option_API_Event__e apiEvent = new inwiB2C_SMO_Option_API_Event__e();
                              apiEvent.inwiB2C_SMO_API__c=event.inwiB2C_SMO_API__c;
                              EventBus.publish(apiEvent);
                         }
                    }else {
                         List<OrderItem> OLI =new List<OrderItem>();
                         if (Options[0].CodeOption__c == 'INWIB2C_OFFERING_OPT_ROAMING')
                              OLI = [select Id from OrderItem where OrderId =:SMOAPI[0].Order__c AND Product2.ProductCode in ('INWIB2C_OFFERING_OPT_ROAMING','INWIB2C_OFFERING_SRV_ROAMING')];
                     
                         else
                              OLI = [select Id from OrderItem where OrderId =:SMOAPI[0].Order__c AND Product2.ProductCode =:Options[0].CodeOption__c limit 1];
                       
                          if(OLI.size() > 0){
                             for(integer i=0;i<OLI.size();i++){
                                   String procedureName = 'inwib2c_InwiB2C_DisconnectOLI';
                                   Map<String, Object> mapInput = new Map<String, Object> ();
                                   Map<String, Object> mapOutput = new Map<String, Object> ();
                                   Map<String, Object> mapOptions = new Map<String, Object> ();
                                   mapInput.put('action','Disconnect');
                                   mapInput.put('ItemId',OLI[i].Id);
                                   mapOutput = (Map<String, Object>) vlocity_cmt.IntegrationProcedureService.runIntegrationService(procedureName, mapInput, mapOptions);
             
                             }
                        }
                         Options[0].Done__c = true;
                         Update Options[0];
                         inwiB2C_SMO_Option_API_Event__e apiEvent = new inwiB2C_SMO_Option_API_Event__e();
                         apiEvent.inwiB2C_SMO_API__c=event.inwiB2C_SMO_API__c;
                         EventBus.publish(apiEvent);
                    }

               }
               else {
			   List<OrderItem> OLI =[select Id from OrderItem where OrderId =:SMOAPI[0].Order__c and vlocity_cmt__Action__c != :'Existing' limit 1];
                         
                 
                    if(OLI.size()>0){
                         
 		 				///call checkout
                                Map<String, Object> inputMap = new Map<String, Object> ();
                                Map<String, Object> outputMap = new Map<String, Object> ();
                                Map<String, Object> optionsMap = new Map<String, Object> ();
                                
                                inputMap.put('Id',SMOAPI[0].Order__c);
                                optionsMap.put('useQueueableApexRemoting',true);
                    
                               outputMap = (Map <String, Object>) vlocity_cmt.IntegrationProcedureService.runIntegrationService('inwib2c_CheckoutOrderAPI', inputMap, optionsMap);
                              // System.debug('CheckoutResponse');
                       
                        /* Map<String, Object> inputMap = new Map<String, Object> ();
                         Map<String, Object> outputMap = new Map<String, Object> ();
                         Map<String, Object> optionsMap = new Map<String, Object> ();

                         
                         inputMap.put('cartId',SMOAPI[0].Order__c);
                         inputMap.put('ContextId',SMOAPI[0].Order__c);
                         inputMap.put('methodName','checkout');
                         
                         vlocity_cmt.CpqAppHandler submitOrderCartsItem = new vlocity_cmt.CpqAppHandler();
                         submitOrderCartsItem.invokeMethod('checkout', inputMap, outputMap, null);
                        */
                                        
                    }
                    else{
					         Order Ord=[ select Id from Order where Id =:SMOAPI[0].Order__c limit 1];
                        if (Ord != null)
                        {
                              Ord.inwiB2C_Statut__c='inwiB2C_Annulee';
                              Update Ord;
                              
                              inwiB2C_BusinessEvent__c eventB= new inwiB2C_BusinessEvent__c();
                              eventB.inwiB2C_OrderId__c = SMOAPI[0].Order__c;
                              eventB.inwiB2C_Statut__c='inwiB2C_Annulee';
                              insert eventB;

                         }
					}
                    
       
               }
          }
     }
}