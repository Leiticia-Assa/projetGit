@isTest
public class InwiB2C_RunUpdateSubscriptionIPTest {

        public static testMethod void RunUpdateSubscriptionIPTest() {
        String InputTest = '{"CSOrder":{"handlingAction":null,"OrderResources":{"CSMobileDirectoryNumber":{"oldMdn":"212648061460","mdn":"212648061460"},"CSSubscriberIdentityModule":{"icc2":"892128510050204588","icc1":"892128510050204588"}},"CSOffer":{"oldMainNetworkOffer":null,"mainNetworkOffer":null,"subscriptionID":"INS00"}}}';
        InwiB2C_RunUpdateSubscriptionIP.RunUpdateSubscriptionIP(InputTest);

    }
    
}