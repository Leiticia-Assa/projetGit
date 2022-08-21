@isTest
public class InwiB2C_RunCreateCustomerLegacyAPITest {

        public static testMethod void RunUpdateSubscriptionIPTest() {
        String InputTest = '{    "AccountIdSF": "0012500001WE76zAAD",    "customerInfo": {        "gender": "MME",        "nationality": "MAR",        "legalName": "Djamel",        "familyName": "Ikhebassene",        "birthDate": "12-12-1981",        "language": "ARA"    },    "address": {        "city": "Casablanca",        "address": "Sidi Maarouf",        "zipCode": "52000",        "region": "Grand Casablanca",        "countryCode": "MAR",        "principal": true,        "bilingAdress": false    },    "contact": {        "phoneNumber": "212638958385",        "email": "aaa@aaa.com"    },    "identification": {        "typeIdentity": "CIN",        "identityNumber": "D55880"    },    "individualPost": {        "attributes": {            "PREFERRED_CONTACT_CHANNEL": "SMS",            "IS_ADSL_INTERESTED": true        }    }}';
        InwiB2C_RunCreateCustomerLegacyAPI.RunCreateCustomerLegacyAPI(InputTest);

    }
    
}