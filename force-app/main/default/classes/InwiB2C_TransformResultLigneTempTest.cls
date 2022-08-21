@isTest
public class InwiB2C_TransformResultLigneTempTest {
        static testMethod void TransformJsonOSS()
{
    String DRJson = '{"properties":[[{"value":"212707747578","name":"mdn_tmp"},{"value":"ExpirÃ©","name":"statut"},{"value":"","name":"Date_creation"}],[{"value":"212707727474","name":"mdn_tmp"},{"value":"ExpirÃ©","name":"statut"},{"value":"","name":"Date_creation"}],[{"value":"212707727473","name":"mdn_tmp"},{"value":"ExpirÃ©","name":"statut"},{"value":"","name":"Date_creation"}]],"mdn":"212648027821"}';
    Map<String, Object> input = (Map<String, Object>)JSON.deserializeUntyped(DRJson);
    Map<String,Object> output = new Map<String,Object>();
    Map<String,Object> options = new Map<String,Object>();
    InwiB2C_TransformResultLigneTemp.invokeMethod('TransformOssJson',input,output,options);

}
}