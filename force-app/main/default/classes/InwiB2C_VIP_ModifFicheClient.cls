public with sharing class InwiB2C_VIP_ModifFicheClient {

  @InvocableMethod
  public static void callVIP(List<Id> accountIdList){
    system.debug('AccountId'+accountIdList);

    system.debug('AccountId Size '+ accountIdList.size());
  
    for (Id  accountId : accountIdList) {

      InwiB2C_VIP_ModifFicheClient.execCallVIP(accountId);
      InwiB2C_VIP_ModifFicheClient.execCallVIPIMX(accountId);
      InwiB2C_VIP_ModifFicheClient.updateName(accountId);
               
    } 
  }

  @future(callout=true)
  public static void execCallVIP(Id accountId){

    System.debug('in execCallVIP');

    Map<String, Object> ipInput = new Map<String, Object>();
    ipInput.put('AccountId', accountId);
    Map<String, Object> ipOptions = new Map<String, Object>();
    Map <String, Object> output =  (Map <String, Object>)(vlocity_cmt.IntegrationProcedureService.runIntegrationService('inwib2c_InwiB2C_BSCSModifyBillingCustomer', ipInput, ipOptions));
    System.debug('BSCS - Debug output if success');
    System.debug(output);

  }
  @future(callout=true)
  public static void execCallVIPIMX(Id accountId){

    System.debug('in execCallVIPIMX');

    Map<String, Object> ipInput = new Map<String, Object>();
    ipInput.put('AccountId', accountId);
    Map<String, Object> ipOptions = new Map<String, Object>();
    Map <String, Object> output =  (Map <String, Object>)(vlocity_cmt.IntegrationProcedureService.runIntegrationService('inwib2c_InwiB2C_IMXhandlePaymentRecovryCustomer', ipInput, ipOptions));
    System.debug('IMX - Debug output if success');
    System.debug(output);

  }
public static void updateName(Id accountId){
  
  List<Account> accountList = [Select Id, Name from Account where Id=:accountId];
  List<InwiB2C_Demande__c> demandeList = [Select Name, InwiB2C_Account__c,FullName__c,InwiB2C_Statut__c from InwiB2C_Demande__c where InwiB2C_Account__c=:accountId];
  
  String statut;
  for(Account account: accountList){
    for(InwiB2C_Demande__c demande: demandeList){
      account.Name = demande.FullName__c;
      statut=demande.InwiB2C_Statut__c;
    }
  }
  if(statut=='Validé'){
    update accountList;

  }
  
}
}