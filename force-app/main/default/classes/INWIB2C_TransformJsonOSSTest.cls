/*ILA INWIB2C-PHASE2 18.06.2021 BEGIN*/
@isTest
public class INWIB2C_TransformJsonOSSTest {
    static testMethod void TransformJsonOSS()
{
    String DRJson='{"relatedParty":[{"TYPE_LIGNE":"B2CPRE"}],"id":"a3625000000ESWVAA4","user":"djamel.lekhbassene@devph02.com","resourceRef":[{"OFFER_TYPE":"0","VPN_GROUP":"VPN","PARAMETER_OCS":"1","VMS_PROFILE":"9991122444","DESTINATION":"506","OCSID":"ocsid","LANG":"FR","KI":"KI","IMSI":"IMSI","OLD_MSISDN":"provorigin","MSISDN":"finalm","OLD_INPROFILE":"old-profil","INPROFILE":"4490"}],"serviceOrderItem":[{"serviceRefOrValue":{"characteristic":{"SERVICE_LEVEL_OUT":{"code":"SERVICE_LEVEL_OUT","value":"SR0"},"SERVICE_LEVEL_IN":{"code":"SERVICE_LEVEL_IN","value":"ALLOWED"}}},"action":"ADD","code":"VOICE"},{"action":"ADD","code":"USSD"},{"action":"ADD","code":"MMS"},{"action":"ADD","code":"CLIP"},{"action":"ADD","code":"CLIR"},{"action":"ADD","code":"CALL_TRANSFER_LEVEL"},{"serviceRefOrValue":{"characteristic":{"SMS_OUT":{"code":"SMS_OUT","value":"ALLOWED"},"SMS_IN":{"code":"SMS_IN","value":"ALLOWED"}}},"action":"ADD","code":"SMS"},{"action":"ADD","code":"CAMEL"},{"action":"ADD","code":"VOLTE"},{"action":"ADD","code":"CALLWAIT"},{"serviceRefOrValue":{"characteristic":{"IROAM_SERVICE_LEVEL":{"code":"IROAM_SERVICE_LEVEL","value":"Roaming Voix+SMS+Data"}}},"action":"ADD","code":"IROAM"},{"action":"ADD","code":"DATA"}],"uuid":"418fd216-fae7-8161-b260-37c36aac3a8d"}';
    //String DRJson='{"serviceOrderItem": [{"code": "CAMEL","action": "ADD"},{"code": "VOLTE","action": "NOP"}],"relatedParty": [{"TYPE_LIGNE": "B2CPRE"}],"resourceRef": {"ICCID": "892128510050200964","IMSI": "604050400053933","OLD_OCSID": "IN1","OCSID": "IN1","OLD_MSISDN": "INWIB2C_ATT_RT_MSISDN_PROVISIONAL"},"action": "MOD","reason": "ORDER_CUSTOMIZATION","id": "a3625000000ETCQAA4"}';
    Map<String, Object> input = (Map<String, Object>)JSON.deserializeUntyped(DRJson);
    Map<String,Object> output = new Map<String,Object>();
    Map<String,Object> options = new Map<String,Object>();
    INWIB2C_TransformJsonOSS.invokeMethod('TransformOssJson',input,output,options);

}
        static testMethod void TransformJsonOSSSMO()
{
    String DRJson='{"resourceRef":{"OLD_MSISDN":"INWIB2C_ATT_RT_MSISDN_PROVISIONAL","OCSID":"IN1","OLD_OCSID":"IN1","IMSI":"604050400053933","ICCID":"892128510050200964"}}';
    Map<String, Object> input = (Map<String, Object>)JSON.deserializeUntyped(DRJson);
    Map<String,Object> output = new Map<String,Object>();
    Map<String,Object> options = new Map<String,Object>();
    INWIB2C_TransformOSSSMO.invokeMethod('TransformOssJson',input,output,options);

}
           static testMethod void TransformJsonOSSSPN()
{
    String DRjson='{"serviceOrder":{"orderItem":[{"targetoperator":"INWI","type":"PORTABILITY","action":"create","serviceRefOrValue":[{"supportingResource":[{"PROVISIONAL_MSISDN":"212648060891","FINAL_MSISDN":"212767676767","CSOFFER_TYPE":"MOBILE"}],"relatedParty":[{"cSIndividualName":{"lastName":"KANTAS","firstName":"HIND"},"birthDate":"2000-04-07","cSPostalAddress":{"country_code":"MAR","region":"Region de l\'Oriental","city":"AGHBAL","line1":"Adresse","postalCode":"11"},"TYPE_LIGNE":"B2C","cSIdentification":{"code":"H98"},"id":"a6Y25000000D3PjEAK"}]}],"creationDate":"2021-05-26T17:35:39.000Z","captureID":"801250000027qiVAAQ","sourceoperator":"MAROCTELECOM","lifeCycleStatus":"APOR","Id":"a6Y25000000D3PjEAK"}]}}';
    Map<String, Object> input = (Map<String, Object>)JSON.deserializeUntyped(DRJson);
    Map<String,Object> output = new Map<String,Object>();
    Map<String,Object> options = new Map<String,Object>();
    INWIB2C_TransformJSONSPN.invokeMethod('TransformOssJson',input,output,options);

}
}
/*ILA INWIB2C-PHASE2 18.06.2021 END*/