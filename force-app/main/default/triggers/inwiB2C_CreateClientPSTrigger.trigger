trigger inwiB2C_CreateClientPSTrigger on inwiB2C_CreateClientPS_Evt__e (after insert) {

        String IP_CreateCustomerLegacy = 'Inwi_InwiB2C_CreateCustomerLegacyAPI';
        
        for(inwiB2C_CreateClientPS_Evt__e event : Trigger.new){

         //Build the Adress Node
         Map<String, Object> AdressObject = new Map<String, Object>();
         AdressObject.put('address', event.inwiB2C_address__c);
         AdressObject.put('bilingAdress', event.inwiB2C_billingAdress__c);
         AdressObject.put('city', event.inwiB2C_city__c);
         AdressObject.put('countryCode', event.inwiB2C_countryCode__c);
         AdressObject.put('principal', event.inwiB2C_principal__c);
         AdressObject.put('region', event.inwiB2C_region__c);
         AdressObject.put('zipCode', event.inwiB2C_zipCode__c);
         AdressObject.put('addr_filed2', event.InwiB2C_addrfiled2__c);
         AdressObject.put('state', event.InwiB2C_State__c);
         
         //Build the contactInfos Node
         Map<String, Object> contactInfos = new Map<String, Object>();
         contactInfos.put('email', event.inwiB2C_email__c);
         contactInfos.put('phone', event.inwiB2C_MDN__c);
         contactInfos.put('phoneNumber', event.InwiB2C_HomePhone__c);
         
         //Build the customerInfos Node
         Map<String, Object> customerInfos = new Map<String, Object>();
         customerInfos.put('birthDate', event.inwiB2C_birthDate__c);
         customerInfos.put('familyName', event.inwiB2C_familyName__c);
         customerInfos.put('gender', event.inwiB2C_gender__c);
         customerInfos.put('language', event.inwiB2C_language__c);
         customerInfos.put('legalName', event.inwiB2C_legalName__c);
         customerInfos.put('nationality', event.inwiB2C_nationality__c);
         
         customerInfos.put('activity_area', event.InwiB2C_activityarea__c);
         customerInfos.put('profession', event.InwiB2C_Profession__c);
         customerInfos.put('segment2', event.InwiB2C_segmentValeur__c);
         customerInfos.put('segment1', event.InwiB2C_segmentMarche__c);
         
         //Build the identificationClient Node
         Map<String, Object> identificationClient = new Map<String, Object>();
         identificationClient.put('identityNumber', event.inwiB2C_identityNumber__c);
         identificationClient.put('typeIdentity', event.inwiB2C_typeIdentity__c);

         //Build the individualPostAttributes Node
         Map<String, Object> individualPostAttributes = new Map<String, Object>();
         individualPostAttributes.put('IS_ADSL_INTERESTED', event.inwiB2C_IsADSLInterested__c);
         individualPostAttributes.put('PREFERRED_CONTACT_CHANNEL', event.inwiB2C_PREFERRED_CONTACT_CHANNEL__c);
         
         //Build the individualPost Node
         Map<String, Object> individualPost = new Map<String, Object>();
         individualPost.put('attributes',individualPostAttributes);

                 Map <String, Object> ipInput = new Map <String, Object> ();
                 Map <String, Object> ipOutput = new Map <String, Object> ();
                 Map <String, Object> ipOptions = new Map <String, Object> ();
                 
                 /* Populating input map for an Integration Procedure. Follow whatever structure your VIP expects */
                 ipInput.put('address',AdressObject);
                 ipInput.put('contact',contactInfos);
                 ipInput.put('customerInfo',customerInfos);
                 ipInput.put('identification',identificationClient);
                 ipInput.put('individualPost',individualPost);
                 ipInput.put('AccountIdSF',event.InwiB2C_AccountId__c);
                 System.debug('INPUT JO CREATE CUSTOMER PS: ' + event.InwiB2C_AccountId__c);
                 
                String inputSerialized = JSON.serialize(ipInput);
                system.debug('INPUT FOR inputSerialized : '+ inputSerialized);
                InwiB2C_RunCreateCustomerLegacyAPI.RunCreateCustomerLegacyAPI(inputSerialized);
                
                 /* Call the IP via runIntegrationService, and save the output to ipOutput 
                 ipOutput = (Map <String, Object>) vlocity_cmt.IntegrationProcedureService.runIntegrationService(IP_CreateCustomerLegacy, ipInput, ipOptions);
                 
                 System.debug('IP CREATE CUSTOMER OUTPUT : ' + ipOutput); 
                 */
                }
            
        }