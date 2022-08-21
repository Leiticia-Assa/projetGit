public with sharing class InwiB2C_CallSynchroAccountVip {

    @future(callout=true)
    public static void callVIP(String input)
    {
            Map<String, Object> data = (Map<String, Object>) JSON.deserializeUntyped(input);
            Map <String, Object> output =  (Map <String, Object>) (vlocity_cmt.IntegrationProcedureService.runIntegrationService('Inwi_InwiB2C_synchoCustomer', data, null));
            System.debug('callVIP - Debug output if success');
            System.debug(json.serialize(output));
    }
}