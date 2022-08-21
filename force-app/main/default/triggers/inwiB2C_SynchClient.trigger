/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-17-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
trigger inwiB2C_SynchClient on Sync_Client__e (after insert) {

        List<Id> createByIdList = new  List<Id> ();
        for (Sync_Client__e event : Trigger.New){
            if (! createByIdList.contains(event.CreatedById)){
                createByIdList.add(event.CreatedById);
            }
        }

        List<User>  userList= [SELECT ID, Profile.Name FROM User where id in :createByIdList];

        Map <Id, String> userMap = new Map <Id, String>();

        for (User user: userList){
            userMap.put(user.Id, user.Profile.Name);
        }



        for (Sync_Client__e event : Trigger.New) {

            String userProfile = userMap.get(event.CreatedById);
            System.debug('userProfile: ' + userProfile);

            if (!(userProfile.equals('Integration')))  {

                System.debug('received event: ');
                System.debug(json.serialize(event)); // 
                // Get Fiche client 
                Map <String, Object> ipInputDR = new Map <String, Object> ();
                Map <String, Object> ipOptionsDR = new Map <String, Object> ();
                ipInputDR.put('AccountId', event.AccountId__c);
                Map <String, Object> ipOutputDR =  (Map <String, Object>) (vlocity_cmt.IntegrationProcedureService.runIntegrationService('inwib2c_INWIB2C_getFicheClient', ipInputDR, ipOptionsDR));
                System.debug('ipOutputDR'); // 
                System.debug(json.serialize(ipOutputDR)); // 
                

                //    IBParty  // 
                Map<String, Object> IBParty = new Map<String, Object>();
                IBParty.put('partyId', ipOutputDR.get('AccountNumber'));

                //
                Map<String, Object> Individual = new Map<String, Object>();
                String nationality = 'MAR';
                if ((String) ipOutputDR.get('nationality') != 'Maroc') nationality = 'Other';
                Individual.put('nationality', nationality);
                Individual.put('maritalStatus', ipOutputDR.get('familySituation')); // 

                //
                Map<String, Object> IndividualNamedUsing = new Map<String, Object>();
                String qualifications = 'M';
                if ((String) ipOutputDR.get('civility') == 'Madame') {
                    qualifications = 'MME';
                } else if ((String) ipOutputDR.get('civility') == 'Mademoiselle') {
                    qualifications = 'MLLE';
                } 
                IndividualNamedUsing.put('legalName', ipOutputDR.get('firstName'));
                IndividualNamedUsing.put('familyNames', ipOutputDR.get('lastName'));
                IndividualNamedUsing.put('qualifications', qualifications);
                Individual.put('IndividualNamedUsing', IndividualNamedUsing);

                //
                Individual.put('ib_BirthDate', ipOutputDR.get('birthdate'));
                String ib_language = 'ARA';
                if ((String) ipOutputDR.get('favoriteLanguage') != 'Arabe') {
                    ib_language = 'FRA';
                }
                Individual.put('ib_language',ib_language );
                // NIVEAU D'ÉTUDE
                String levelOfStudies = '';
                String levelOfStudies_string = (String) ipOutputDR.get('levelOfStudies');
                switch on levelOfStudies_string {
                    when 'Analphabète'  {
                        levelOfStudies = '1';
                    }
                    when 'Ecole coranique'  {
                        levelOfStudies = '2';
                    }
                    when 'NSP/NRP'  {
                        levelOfStudies = '11';
                    }
                    when 'Primaire pas terminé'  {
                        levelOfStudies = '3';
                    }
                    when 'Primaire terminé'  {
                        levelOfStudies = '4';
                    }
                    when 'Secondaire 1r cycle pas terminé'  {
                        levelOfStudies = '5';
                    }
                    when 'Secondaire 1r cycle terminé'  {
                        levelOfStudies = '6';
                    }
                    when 'Secondaire 2d cycle pas terminé'  {
                        levelOfStudies = '7';
                    }
                    when 'Secondaire 2d cycle terminé'  {
                        levelOfStudies = '8';
                    }
                    when 'Supérieur pas terminé'  {
                        levelOfStudies = '9';
                    }
                    when 'Supérieur terminé'  {
                        levelOfStudies = '10';
                    }
                }
                Individual.put('ib_studyLevel', levelOfStudies);
                Individual.put('ib_profile', null);
                Individual.put('ib_login', null);
                // choix de l’opérateur
                String primaryOperatorChoice = '';
                String primary_operator_choice = (String) ipOutputDR.get('primaryOperatorChoice');
                if (primary_operator_choice.contains('Réputation')) {
                    primaryOperatorChoice = 'REPU';
                }
                switch on primary_operator_choice {
                    when 'Autres'  {
                        primaryOperatorChoice = 'AUTR';
                    }
                    when 'Prix'  {
                        primaryOperatorChoice = 'PRIX';
                    }
                    when 'Qualité réseau'  {
                        primaryOperatorChoice = 'QALI';
                    }
                }
                Individual.put('ib_operatorChoice', primaryOperatorChoice);
                Individual.put('ib_hasACar', 'N');
                String ib_internetUse = 'NON';
                if (ipOutputDR.get('internetSubscription') != 'Aucun') {
                    ib_internetUse = 'OUI';
                }
                Individual.put('ib_internetUse', ib_internetUse);
                String netSubscription = '';
                String netSubscription_string = (String) ipOutputDR.get('internetSubscription');
                switch on netSubscription_string {
                    when '3G IAM'  {
                        netSubscription = '3GIA';
                    }
                    when '3G Meditel'  {
                        netSubscription = '3GME';
                    }
                    when '3G WANA'  {
                        netSubscription = '3GWA';
                    }
                    when 'ADSL IAM'  {
                        netSubscription = 'ADSI';
                    }
                    when 'Aucun'  {
                        netSubscription = 'AUCU';
                    }
                    when 'AUTRE'  {
                        netSubscription = 'AUTR';
                    }
                }
                Individual.put('ib_hasInternetSubscription', netSubscription);
                // 
                String fixSubscription = '';
                String fixSubscription_string = (String) ipOutputDR.get('fixSubscription');
                switch on fixSubscription_string {
                    when 'Autre'  {
                        fixSubscription = 'AUTR';
                    }
                    when 'Fixe IAM'  {
                        fixSubscription = 'FIXI';
                    }
                    when 'Fixe Meditel'  {
                        fixSubscription = 'FIXM';
                    }
                    when 'Fixe prépayé bayn'  {
                        fixSubscription = 'FIXP';
                    }
                    when 'Aucun'  {
                        fixSubscription = 'AUCU';
                    }
                }
                Individual.put('ib_hasFixPhone', fixSubscription);
                Individual.put('ib_hasACreditCard','N' );
                Individual.put('ib_housingType', null);
                Individual.put('ib_mobility', null);
                Individual.put('ib_travelFrequency', 0);
                Individual.put('ib_interests', null);
                Individual.put('ib_childsCount', 0);
                Individual.put('ib_income', ipOutputDR.get('revenus'));
                Individual.put('ib_hasPC', 'NON');

                IBParty.put('Individual', Individual);

                //
                Map<String, Object> addressobject = (Map<String, Object>) ipOutputDR.get('addressobject');
                Map<String, Object> UrbanPropertyAddress = new Map<String, Object>();
                String quartier = addressobject.get('quartierName') != null ? ((String)  addressobject.get('quartierName')).toLowercase() : addressobject.get('PrecisionQuartier') != null ? ((String)  addressobject.get('PrecisionQuartier')).toLowercase() : '';
                UrbanPropertyAddress.put('ib_id', '9999999999999999999999999999999');
                UrbanPropertyAddress.put('streetNrFirst', null);
                UrbanPropertyAddress.put('streetNrFirstSuffix', null);
                UrbanPropertyAddress.put('streetNrLast', null);
                UrbanPropertyAddress.put('streetNrLastSuffix', null);
                UrbanPropertyAddress.put('streetName', null);
                UrbanPropertyAddress.put('postcode',  ipOutputDR.get('postalCode'));
                UrbanPropertyAddress.put('postalAddress', ipOutputDR.get('address'));
                UrbanPropertyAddress.put('ib_postalAddress', null);
                UrbanPropertyAddress.put('ib_countryCode', nationality);
                UrbanPropertyAddress.put('streetNrLastSuffix', null);
                UrbanPropertyAddress.put('ib_unbundlingStatus', null);
                UrbanPropertyAddress.put('ib_IAMLegalName', null);
                UrbanPropertyAddress.put('ib_IAMFamilyNames', null);
                UrbanPropertyAddress.put('locality', addressobject.get('villeName') );
                UrbanPropertyAddress.put('ib_state', quartier);
                UrbanPropertyAddress.put('ib_Region', addressobject.get('regionName'));
                UrbanPropertyAddress.put('ib_IAMAddress', null);

                Map<String, Object> ND = new Map<String, Object>();
                ND.put('id', 'ND');
                ND.put('value', '');

                Map<String, Object> POTENTIAL_DEPLOYMENT_DATE = new Map<String, Object>();
                POTENTIAL_DEPLOYMENT_DATE.put('id', 'POTENTIAL_DEPLOYMENT_DATE');
                POTENTIAL_DEPLOYMENT_DATE.put('value', null);

                UrbanPropertyAddress.put('IBAttribute', new List<Map<String, Object>> {ND, POTENTIAL_DEPLOYMENT_DATE});

                IBParty.put('UrbanPropertyAddress', UrbanPropertyAddress);

                //
                Map<String, Object> IBContact = new Map<String, Object>();
                IBContact.put('TelephoneNumber', ipOutputDR.get('phone'));
                IBContact.put('ib_telephoneFixe', ipOutputDR.get('telephone'));
                IBContact.put('FaxNumber', ipOutputDR.get('fax'));
                IBContact.put('EmailContact', ipOutputDR.get('mail'));

                IBParty.put('IBContact', IBContact);

                //
                Map<String, Object> IBPartyIdentification = new Map<String, Object>();
                IBPartyIdentification.put('ib_cin', ipOutputDR.get('idCard'));
                // Type CIN
                String ib_type = 'CNI';
                String ib_type_string = (String) ipOutputDR.get('typeID');
                switch on ib_type_string {
                    when 'Passeport'  {
                        ib_type = 'PASP';
                    }
                    when 'Carte de séjour'  {
                        ib_type = 'CARTE';
                    }
                    when 'ONG'  {
                        ib_type = 'ONG';
                    }
                    when 'Association'  {
                        ib_type = 'ASSO';
                    }
                    when 'ESE'  {
                        ib_type = 'ESE';
                    }
                    when 'Ambassade'  {
                        ib_type = 'AMB';
                    }
                    
                }
                
                IBPartyIdentification.put('ib_type', ib_type);
                IBPartyIdentification.put('is_from_ocr', 'Non');

                IBParty.put('IBPartyIdentification', IBPartyIdentification);

                //
                Map<String, Object> IBIndividualPost = new Map<String, Object>();
                IBIndividualPost.put('profession', ipOutputDR.get('profession'));
                IBIndividualPost.put('businessField', ipOutputDR.get('activityArea'));
                // L’ancienneté client
                String seniority = '';
                String seniority_string = (String) ipOutputDR.get('seniority');
                switch on seniority_string {
                    when 'Dummy'  {
                        seniority = 'DUM';
                    }
                    when 'SANS'  {
                        seniority = 'SANS';
                    }
                    when '00 <= < 01'  {
                        seniority = '0001';
                    }
                    when '01 <= < 02'  {
                        seniority = '0102';
                    }
                    when '02 <= < 05'  {
                        seniority = '0205';
                    }
                    when '05 <= < 10'  {
                        seniority = '0510';
                    }
                    when '10 <= < 20'  {
                        seniority = '1020';
                    }
                    when '20 <= < 30'  {
                        seniority = '2030';
                    }
                    when '30 >='  {
                        seniority = '3000';
                    }
                }
                IBIndividualPost.put('hireDate', seniority);

                IBParty.put('IBIndividualPost', IBIndividualPost);

                //
                String segmentMarche = '';
                String segment_marche = (String) ipOutputDR.get('segmentMarche');
                switch on segment_marche {
                    when 'Particulier'  {
                        segmentMarche = 'C';
                    }
                    when 'Compte_Ferme'  {
                        segmentMarche = 'CTF';
                    }
                    when 'Dealer'  {
                        segmentMarche = 'D';
                    }
                    when 'Entreprise'  {
                        segmentMarche = 'ENT';
                    }
                    when 'Grandes téléboutiques'  {
                        segmentMarche = 'GT';
                    }
                    when 'Ligne_Test'  {
                        segmentMarche = 'LNT';
                    }
                    when 'Petites téléboutiques'  {
                        segmentMarche = 'PT';
                    }
                    when 'Super Dealer'  {
                        segmentMarche = 'SD';
                    }
                    when 'Autres'  {
                        segmentMarche = 'SOHO';
                    }
                    when 'Taxiphones'  {
                        segmentMarche = 'T';
                    }
                }

                //
                String segmentValeur = '';
                String segment_valeur = (String) ipOutputDR.get('segmentValeur');
                switch on segment_valeur {
                    when 'Bronze'  {
                        segmentValeur = 'B';
                    }
                    when 'Compte_Ferme'  {
                        segmentValeur = 'CTF';
                    }
                    when 'Entreprise'  {
                        segmentValeur = 'ENT';
                    }
                    when 'FM6'  {
                        segmentValeur = 'FM6';
                    }
                    when 'Gold'  {
                        segmentValeur = 'G';
                    }
                    when '1 mois'  {
                        segmentValeur = 'M1';
                    }
                    when '2 mois'  {
                        segmentValeur = 'M2';
                    }
                    when '3 mois'  {
                        segmentValeur = 'M3';
                    }
                    when 'Premium'  {
                        segmentValeur = 'P';
                    }
                    when 'Fondation Med 6'  {
                        segmentValeur = 'O';
                    }
                    when 'Pro-Prépayé'  {
                        segmentValeur = 'PROP';
                    }
                    when 'Pro-postpayé'  {
                        segmentValeur = 'Pro';
                    }
                    when 'Risque Elevé'  {
                        segmentValeur = 'RE';
                    }
                    when 'Risque Moyen'  {
                        segmentValeur = 'RM';
                    }
                    when 'Risque Nul'  {
                        segmentValeur = 'RN';
                    }
                    when 'Silver'  {
                        segmentValeur = 'S';
                    }
                    when '1 semaine'  {
                        segmentValeur = 'S1';
                    }
                    when '2 semaine'  {
                        segmentValeur = 'S2';
                    }
                    when 'Salarié ONA'  {
                        segmentValeur = 'SO';
                    }
                    when 'Salarié Richbond'  {
                        segmentValeur = 'SR';
                    }
                    when 'VIP'  {
                        segmentValeur = 'V';
                    }
                }

                IBParty.put('ib_customerSegment1', segmentMarche);
                IBParty.put('ib_customerSegment2', segmentValeur);
                IBParty.put('ib_segmentScore', null);
                IBParty.put('ib_isLoyalty', false);
                IBParty.put('ib_referencement', null);
                IBParty.put('ib_businessCard', null);

                // 
                Map<String, Object> PREFERRED_CONTACT_CHANNEL = new Map<String, Object>();
                PREFERRED_CONTACT_CHANNEL.put('id', 'PREFERRED_CONTACT_CHANNEL');
                PREFERRED_CONTACT_CHANNEL.put('value', ipOutputDR.get('principalContact'));

                Map<String, Object> IS_ADSL_INTERESTED = new Map<String, Object>();
                IS_ADSL_INTERESTED.put('id', 'IS_ADSL_INTERESTED');
                IS_ADSL_INTERESTED.put('value', 'N');

                IBParty.put('IBAttribute', new List<Map<String, Object>> {PREFERRED_CONTACT_CHANNEL, IS_ADSL_INTERESTED});

                //    IBOperation  // 
                Map<String, Object> IBOperation = new Map<String, Object>();
                IBOperation.put('role', '');
                IBOperation.put('origin', 'SFB2C');
                IBOperation.put('user', 'achraf.belhaj');
                //
                Map <String, Object> ipInput = new Map <String, Object> ();
                Map <String, Object> ipOptions = new Map <String, Object> ();
                Map <String, Object> ipOutput =  (Map <String, Object>) (vlocity_cmt.IntegrationProcedureService.runIntegrationService('inwib2c_inwiB2C_GenerateUUID', ipInput, ipOptions));
                String uuid = (String) ipOutput.get('UUID');
                IBOperation.put('uuid',uuid);

                // Input Object
                Map<String, Object> input = new Map<String, Object>();
                input.put('IBOperation', IBOperation);
                input.put('IBParty', IBParty);
                input.put('ib_checkCINUnicity', true);

                system.debug(json.serialize(input));
                InwiB2C_CallSynchroAccountVip.callVIP(json.serialize(input));
            }
        }
}