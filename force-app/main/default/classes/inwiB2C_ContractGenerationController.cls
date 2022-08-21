public with sharing class inwiB2C_ContractGenerationController{
    public String idOrder{ get; set; }

    public String idContract{ get; set; }

    public String isVIVS{ get; set; }

    public String isdealer{ get; set; }

    public String contractDate{ get; set; }

    public Decimal prixSIMHome{ get; set; }

    public Decimal FMS{ get; set; }

    public Decimal RecurringPrice{ get; set; }

    public String isfromjson{ get; set; }

    public Decimal PrixSIM{ get; set; }

    public List<Integer> loopList{ get; set; }

    String procedureName = 'inwib2c_InwiB2C_GetContractInformationsByOrderId';
    Map<String, Object> ipInput = new Map<String, Object>();
    public Map<String, Object> ipOutput{ get; set; }

    Map<String, Object> ipOptions = new Map<String, Object>();
    public List<Map<String, Object>> dataArticlesNonSerialise{ get; set; }

    public Decimal PrixSIMRP{ get; set; }

    public Decimal PrixTerminalRP{ get; set; }

    public String keys{ get; set; }

    public String keysOffers{ get; set; }

    public String keysTerminal{ get; set; }

    public String keysMP{ get; set; }

    public String keysArticles{ get; set; }

    public String ModeDePaiement{ get; set; }

    public Integer mpSize{ get; set; }

    public String typeActeDecision{ get; set; }

    public inwiB2C_ContractGenerationController(){

        // Get params
        idOrder = Apexpages.currentPage().getParameters().get('orderid');
        idContract = Apexpages.currentPage().getParameters().get('contractid');
        isVIVS = Apexpages.currentPage().getParameters().get('isvivs');
        isdealer = Apexpages.currentPage().getParameters().get('dealer') == 'true' ? 'dealer' : '';
        isfromjson = Apexpages.currentPage().getParameters().get('isfromjson');

        //for test class
        Map<String, Object> CSSubscriberIdentityModule = new Map<String, Object>();
        List<Map<String, Object>> CSSubscriberIdentityModuleList = new List<Map<String, Object>>();
        Map<String, Object> articlenonserialise = new Map<String, Object>();
        List<Map<String, Object>> articlenonserialiseList = new List<Map<String, Object>>();


        System.debug('ID ORDER IS :' + idOrder);
        System.debug('ID isdealer IS :' + isdealer);

        // Call VPI


        //ipInput.put('IsVIVS', isVIVS);
        if (idOrder != null){
            procedureName = 'inwib2c_InwiB2C_GetContractInformationsByOrderId';
            ipInput.put('OrderId', idOrder);
        } else if (idContract != null && isVIVS == 'true'){
            procedureName = 'inwib2c_InwiB2C_GetContractInformationsVivs';
            ipInput.put('ContractId', idContract);
            ipInput.put('Isdealer', isdealer);
        } else{
            procedureName = 'inwib2c_InwiB2C_GetContractInformationsByContractId';
            ipInput.put('ContractId', idContract);

        }
        System.debug('ID procedureName IS :' + procedureName);
        System.debug('ID ipInput IS :' + ipInput);

        if (!Test.isRunningTest()){
            if (isfromjson == 'true'){
                Map<String, Object> root = (Map<String, Object>)JSON.deserializeUntyped(Apexpages.currentPage().getParameters().get('thejson'));
                root.put('isPorta', false);
                root.put('isSAV', false);
                root.put('isAcqui', true);

                // Offre
                List<Map<String, Object>> data = new List<Map<String, Object>>();
                try{
                    for (Object instance : (List<Object>)root.get('offre')){
                        data.add((Map<String, Object>)instance);
                    }
                } catch (Exception e){

                }

                root.put('offre', data);

                // Terminal
                List<Map<String, Object>> data_terminal = new List<Map<String, Object>>();
                try{
                    for (Object instance : (List<Object>)root.get('Terminal')){
                        data_terminal.add((Map<String, Object>)instance);
                    }
                } catch (Exception e){

                }

                root.put('Terminal', data_terminal);
                root.put('getFullAddress', (String) root.get('Adresse'));
                ipOutput = root;
            } else{
                ipOutput = (Map<String, Object>)(vlocity_cmt.IntegrationProcedureService.runIntegrationService(procedureName, ipInput, ipOptions));
            }
        } else{
            CSSubscriberIdentityModule.put('PrixSIMhome', 0);
            CSSubscriberIdentityModule.put('FormuleChoisie', 'Offre acquisition_84001');
            CSSubscriberIdentityModule.put('TypeOffe', 'Offre TicTac Sim Seule');
            CSSubscriberIdentityModule.put('PrixSIM', 0);
            CSSubscriberIdentityModule.put('ICCSIM', '19555555555555');
            CSSubscriberIdentityModule.put('TypeLigne', 'NORMAL');
            CSSubscriberIdentityModule.put('NumLigne', '0671176098');

            CSSubscriberIdentityModuleList.add(CSSubscriberIdentityModule);

            articlenonserialise.put('quantity', 1);
            articlenonserialise.put('codeProduit', 'Offre TicTac Sim Seule');
            articlenonserialise.put('prix', 0);


            articlenonserialiseList.add(articlenonserialise);
            String jsonText = '{"AccountName" :"Djamel","CodePostal" :"18500", "NumContrat" :"CTR-00002555", "dateContract" :"22-08-2020", "Adresse" :"Rue 15 casa Maroc", "TitulaireCompte" :"Monsieur", "dateNaissance" :"02-05-2000", "Email" :"Djamel@gmail.com", "POS" :"Agence CASA 2", "getFullAddress" :"Rue 15 casa Maroc", "Ville" :"CASA", "NomTitulaire" :"OUAMER", "NumIdentifiant" :"CIN5555", "PrenomTitulaire" :"Djamel", "TypeIdent" :"PASSPORT", "TypeContrat" :"Type", "isSAV" :false, "IsPorta" :false, "isAcqui" :true, "offre": [{ "ICCSIM":"851263845621321320", "prixSIMHome": 50,"NumLigne":"212977777777", "PrixSIM":"20", "FormuleChoisie":"formule1", "TypeOffe":"TIC TAC" },{ "ICCSIM":"851263845621321320", "NumLigne":"212988888888", "PrixSIM":"50", "FormuleChoisie":"formule2", "TypeOffe":"HOME" }], "Terminal": [{ "TypeMiseDispo": "Vente", "prixTerminal": 50, "NumSerieTerminal": "555444444444445555","ModeleTerminal_new": "modele1" }], "articleNonSerailise":[ { "quantity": 1, "codeProduit": "Offre TicTac Sim+Terminal", "prix": 20 }, { "quantity": 1, "codeProduit": "Offre TicTac Sim+Terminal", "prix": 50 } ],  "numerosPorter": [ { "operateur": "WIN", "NumIdentifiant": "BH45545", "TypeIdent": "Passort", "NomTitulaire": "test", "PrenomTitulaire": "1012" } ] }';

            Map<String, Object> root = (Map<String, Object>)JSON.deserializeUntyped(jsonText);
            root.put('isPorta', false);
            root.put('isSAV', false);
            root.put('isAcqui', true);
            List<Map<String, Object>> data = new List<Map<String, Object>>();
            for (Object instance : (List<Object>)root.get('offre')){
                data.add((Map<String, Object>)instance);

            }
            root.put('offre', data);

            List<Map<String, Object>> data_terminal = new List<Map<String, Object>>();
            for (Object instance : (List<Object>)root.get('Terminal')){
                data_terminal.add((Map<String, Object>)instance);
            }
            root.put('Terminal', data_terminal);

            List<Map<String, Object>> data_article = new List<Map<String, Object>>();
            for (Object instance : (List<Object>)root.get('articleNonSerailise')){
                data_article.add((Map<String, Object>)instance);
            }
            root.put('articleNonSerailise', data_article);
            List<Map<String, Object>> data_numerosPorter = new List<Map<String, Object>>();
            for (Object instance : (List<Object>)root.get('numerosPorter')){
                data_numerosPorter.add((Map<String, Object>)instance);
            }
            root.put('numerosPorter', data_numerosPorter);
            ipOutput = root;
            //ipOutput.put('response', '{ "checkAddress": false, "getFullAddress": "52532532 20 rue bernoussi Chaouia Ouardigha BEJAAD", "getAddress": "52532532 20 rue bernoussi", "isAcqui": false, "isSAV": true, "TypeContrat": "Formulaire SAV", "CodePostal": 20250, "Ville": "BEJAAD", "articleNonSerailise": [ { "quantity": 1, "codeProduit": "Offre TicTac Sim Seule", "prix": 0 } ], "offre": [ { "PrixSIMhome": 20, "FormuleChoisie": "Offre acquisition_84001", "TypeOffe": "Offre TicTac Sim Seule", "PrixSIM": 0, "ICCSIM": "19555555555555", "TypeLigne": "NORMAL", "NumLigne": "0671176098" } ], "AgentName": "Islam Hamoudi 5", "POSCODE": "CPD12", "typeActeDecision": "inwiB2C_Rehabilitation", "totalTTC": 0, "CodeAgent": "CPD12", "OrderNumber": "00002803", "isPorta": false, "POS": "Agence 1 - CPP01001", "numerosPorter": [ { "operateur": "WIN", "NumIdentifiant": "FJ251364", "TypeIdent": "Carte dIdentité Nationale", "NomTitulaire": "KANTAS", "PrenomTitulaire": "HIND" } ], "Email": "test@inwi.ma", "dateNaissance": "2000-04-07", "TypeIdent": "Carte dIdentité Nationale", "NumIdentifiant": "FJ251364", "NomTitulaire": "KANTAS", "PrenomTitulaire": "HIND", "TitulaireCompte": "Madame" }');
        }

        for (String item : ipOutput.keySet()){
            keys = keys + item;
        }

        // Put Offer keys in string
        try{
            List<Map<String, Object>> offers = (List<Map<String, Object>>)ipOutput.get('offre');
            for (String item_offer : offers[0].keySet()){
                System.debug('OFFRE EST : ' + item_offer);
                keysOffers = keysOffers + item_offer;
            }
        } catch (Exception e){


        }

        // Remove offer from type offer
        try{
            List<Object> entriesArray = new List<Object>();
            entriesArray = (List<Object>)ipOutput.get('offre');
            for (Object inidividualEntries : entriesArray){
                Map<String, Object> ind = (Map<String, Object>)inidividualEntries;
                if (ind.get('PrixSIM') != null){
                    PrixSIM = PrixSIM + (Decimal) ind.get('PrixSIM');
                }
                if (ind.get('prixSIMHome') != null){
                    prixSIMHome = prixSIMHome + (Decimal) ind.get('prixSIMhome');
                }
            }
        } catch (Exception e){


        }

        try{
            List<Object> offers = new List<Object>();
            offers = (List<Object>)ipOutput.get('offre');
            for (Object item_offer : offers){
                Map<String, Object> ind = (Map<String, Object>)item_offer;
                String TypeOffe = (String) ind.get('TypeOffe');
                if (TypeOffe.contains('Offre') || TypeOffe.contains('Forfait')){
                    TypeOffe = TypeOffe.replace('Offre', '');
                    TypeOffe = TypeOffe.replace('offre', '');
                    TypeOffe = TypeOffe.replace('Forfait', '');
                    TypeOffe = TypeOffe.replace('forfait', '');
                    ind.put('TypeOffe', TypeOffe);
                }


                String icc = (String) ind.get('ICCSIM');
                ind.put('ICCSIM', icc.substring(0, 18));
            }
        } catch (Exception e){


        }

        try{
            List<Map<String, Object>> offers = (List<Map<String, Object>>)ipOutput.get('offre');
            for (String item_offer : offers[0].keySet()){
                keysOffers = keysOffers + item_offer;
            }
        } catch (Exception e){


        }

        try{
            List<Map<String, Object>> termials = (List<Map<String, Object>>)ipOutput.get('Terminal');
            for (String item_terminal : termials[0].keySet()){
                keysTerminal = keysTerminal + item_terminal;
            }
        } catch (Exception e){


        }

        try{
            List<Map<String, Object>> articleNonSerailise = (List<Map<String, Object>>)ipOutput.get('articleNonSerailise');
            for (String item_articleNonSerailise : articleNonSerailise[0].keySet()){
                keysArticles = keysArticles + item_articleNonSerailise;
            }
        } catch (Exception e){


        }

        // Adresse remove null
        try{
            String Adresse = (String) ipOutput.get('getFullAddress');
            Adresse = Adresse.replace('NULL', ' ');
            Adresse = Adresse.replace('null', ' ');
            Adresse = Adresse.replace('Null', ' ');
            ipOutput.put('getFullAddress', Adresse);
        } catch (Exception e){


        }

        // typeActeDecision
        typeActeDecision = '';
        try{
            typeActeDecision = (String) ipOutput.get('typeActeDecision');
        } catch (Exception e){


        }

        System.debug('keys' + keys);
        System.debug('keysOffers' + keysOffers);
        System.debug('keysTerminal' + keysTerminal);

        // MP Size
        mpSize = 0;
        try{
            List<Map<String, Object>> mp = (List<Map<String, Object>>)ipOutput.get('numerosPorter');
            mpSize = mp.size();
        } catch (Exception e){


        }

        try{
            List<Map<String, Object>> numeroporter = (List<Map<String, Object>>)ipOutput.get('numerosPorter');
            for (String item_numeroporter : numeroporter[0].keySet()){
                keysMP = keysMP + item_numeroporter;
            }
        } catch (Exception e){


        }

        // Article non sérialisé dataArticlesNonSerialise
        PrixSIMRP = 0;
        try{
            List<Map<String, Object>> ls1 = new List<Map<String, Object>>();
            List<Map<String, Object>> data = new List<Map<String, Object>>();

            // if(!Test.isRunningTest()) {
            //      data = ( List<Map <String, Object>> ) ipOutput.get('articleNonSerailise');
            // }
            // else
            // {
            //     data =  articlenonserialiseList;
            // }
            data = (List<Map<String, Object>>)ipOutput.get('articleNonSerailise');
            for (Object item_dataRP : data){
                Map<String, Object> ind = (Map<String, Object>)item_dataRP;
                PrixSIMRP = PrixSIMRP + (Decimal) ind.get('prix');
                String codeProduit = (String) ind.get('codeProduit');

                Boolean exist = false;
                for (Object item_list : ls1){
                    Map<String, Object> ind_item = (Map<String, Object>)item_list;
                    String codeProduit_item = (String) ind_item.get('codeProduit');
                    if (codeProduit_item == codeProduit){
                        exist = true;
                        ind_item.put('quantity', (Decimal) ind_item.get('quantity') + 1);
                        break;
                    }
                }

                if (exist == false){
                    Map<String, Object> ind_new = new Map<String, Object>();
                    ind_new.put('quantity', (Decimal) ind.get('quantity'));
                    ind_new.put('codeProduit', (String) ind.get('codeProduit'));
                    ls1.add(ind_new);
                }

            }
            dataArticlesNonSerialise = new List<Map<String, Object>>(ls1);
        } catch (Exception e){


        }
        // Prix terminal
        PrixTerminalRP = 0;
        try{
            List<Map<String, Object>> termialsRP = (List<Map<String, Object>>)ipOutput.get('Terminal');
            for (Object item_termialsRP : termialsRP){
                Map<String, Object> ind = (Map<String, Object>)item_termialsRP;
                PrixTerminalRP = PrixTerminalRP + (Decimal) ind.get('prixTerminal');
            }
        } catch (Exception e){

        }

        //
        loopList = new List<Integer>{ 0, 1, 2 };

        // Prix Sim &  prix Sim home
        PrixSIM = 0;
        prixSIMHome = 0;
        FMS = 0;
        RecurringPrice = 0;
        try {
            List<Object> entriesArray = new List<Object>();
            entriesArray = (List<Object>)ipOutput.get('offre');
            for (Object inidividualEntries : entriesArray){
                Map<String, Object> ind = (Map<String, Object>)inidividualEntries;
                if (ind.get('PrixSIM') != null){
                    PrixSIM = PrixSIM + (Decimal) ind.get('PrixSIM');
                }
                if (ind.get('PrixSIMhome') != null){
                    prixSIMHome = prixSIMHome + (Decimal) ind.get('PrixSIMhome');
                }
                if (ind.get('fms') != null){
                    FMS = FMS + (Decimal) ind.get('fms');
                }
                if (ind.get('recurring_charge') != null){
                    RecurringPrice = RecurringPrice + (Decimal) ind.get('recurring_charge');
                }
            }
        } catch (Exception e){


        }


        System.debug('PrixSIM' + PrixSIM);
        System.debug('prixSIMHome' + prixSIMHome);

        // Convert birthday
        try{
            Date d;
            if (!Test.isRunningTest()){
                d = (Date) ipOutput.get('dateNaissance');
            } else{
                d = Date.valueOf('1994-12-02');
            }
            String month = String.valueOf(d.month());
            if (String.valueOf(d.month()).length() == 1){
                month = '0' + d.month();
            }
            String day = String.valueOf(d.day());
            if (String.valueOf(d.day()).length() == 1){
                day = '0' + d.day();
            }
            String dateF = day + '-' + month + '-' + d.year();
            ipOutput.put('dateNaissance', dateF);
            System.debug(dateF);
        } catch (Exception e){

        }


        // Convert contract date
        Date currentDate = date.today();
        String currentMonth = String.valueOf(currentDate.month());
        if (String.valueOf(currentDate.month()).length() == 1){
            currentMonth = '0' + currentDate.month();
        }
        String currentDay = String.valueOf(currentDate.day());
        if (String.valueOf(currentDate.day()).length() == 1){
            currentDay = '0' + currentDate.day();
        }
        contractDate = currentDay + '-' + currentMonth + '-' + currentDate.year();
        System.debug(contractDate);

        // Mode de paiement
        ModeDePaiement = '';
        try{
            if (ipOutput.get('ModeDePaiement') == 'inwiB2C_EnEspece')
                ModeDePaiement = 'Espèce';
            else if (ipOutput.get('ModeDePaiement') == 'inwiB2C_E-paiement')
                ModeDePaiement = 'E-Paiement';
            else if (ipOutput.get('ModeDePaiement') == 'inwiB2C_TPE')
                ModeDePaiement = 'TPE';
        } catch (Exception e){


        }

        System.debug('ModeDePaiement' + ModeDePaiement);
        System.debug('IP Output: ' + ipOutput);
        System.debug('IP Output: ' + ipOutput);
    }

    public static String formatDate(Date d){
        return d.year() + '-' + d.month() + '-' + d.day();
    }

}