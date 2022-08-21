@IsTest
public class InwiB2C_CreateContractBulkBatchTest {

    @IsTest(seeAllData=true)
    public static void batchTest() {
        Test.startTest();
        
        //Get OrderItem of a correct mdn
        List<OrderItem> listMdnOrderItem = [SELECT Order.id, Order.OrderNumber,inwiB2C_Mdn__c FROM OrderItem WHERE order.inwiB2C_Statut__c not in ('inwiB2C_Annulee', 'inwiB2C_Activee') AND order.inwib2c_TypeDeLaCommande__c = 'inwiB2C_Acquisition' and inwiB2C_Mdn__c != '' limit 1];
        inwiB2C_CreateContractBulk__c testCCBulk = new inwiB2C_CreateContractBulk__c();
        testCCBulk.inwiB2C_Address__c = 'Address';
        testCCBulk.inwiB2C_BirthDate__c = Date.parse('01/01/1900');
        testCCBulk.inwiB2C_BusinessSegment__c = '';
        testCCBulk.inwiB2C_Canal__c = 'Dealer';
        testCCBulk.inwiB2C_City__c = 'Casablanca';
        testCCBulk.inwiB2C_CodeAgence__c = 'CPD01';
        testCCBulk.inwiB2C_CodeArticle__c = '000056826';
        testCCBulk.inwiB2C_CodeDistributeur__c = 'CPD01';
        testCCBulk.inwiB2C_ComplementAddress__c = '';
        testCCBulk.inwiB2C_CountryCode__c = 'MAR';
        testCCBulk.inwiB2C_FirstName__c = 'FirstName';
        testCCBulk.inwiB2C_Gender__c = 'M';
        testCCBulk.inwiB2C_Icc__c = '892128510050188115';
        testCCBulk.inwiB2C_imsi__c = '604050400041084';
        testCCBulk.inwiB2C_Ki__c = 'F97769DD8309EA44AD0EE2BBB7AB45CC';
        testCCBulk.inwiB2C_LastName__c = 'LastName';
        testCCBulk.inwiB2C_MdnDealer__c = '212648049518';
        testCCBulk.inwiB2C_Mdn__c = listMdnOrderItem[0].inwiB2C_Mdn__c;
        testCCBulk.inwiB2C_Ocerised__c = false;
        testCCBulk.inwiB2C_OcsId__c = 'IN2';
        testCCBulk.inwiB2C_PieceIdentite__c = 'CIN57098';
        testCCBulk.inwiB2C_PostCode__c = '20000';
        testCCBulk.inwiB2C_ProfileId__c = '618';
        testCCBulk.inwiB2C_Puk__c = '123456';
        testCCBulk.inwiB2C_SegmentLevel1__c = 'C';
        testCCBulk.inwiB2C_SegmentLevel2__c = '';
        testCCBulk.inwiB2C_State__c = '';
        testCCBulk.inwiB2C_Street__c = '';
        testCCBulk.inwiB2C_TypePieceIdentite__c = 'NID';
        testCCBulk.inwiB2C_User__c = '212648058729';
        testCCBulk.inwiB2C_uuid__c = '1234-5678-9012';
        testCCBulk.inwiB2C_StatutDeTraitement__c = 'inwiB2C_Nouveau';
        insert testCCBulk;
        
                //Get the id of the template order
        List<Order> ListOrderToClone = [SELECT id, accountid, contractid from Order where InwiB2C_Offre__c = 'Offre TicTac Sim Seule' and contractid !='' and accountid != '' limit 1];
        //List<inwiB2C_CreateContractBulk__c> ListCreateContractObj = [SELECT id from inwiB2C_CreateContractBulk__c limit 1];
        //Insert the id in the metadata
        //InwiB2C_IdOrderToClone__mdt newOrderId = new InwiB2C_IdOrderToClone__mdt(OrderId__c = '8014K000001kCMLQA2', Label= 'OrderId');
        
        Id bacthId = Database.executeBatch(new InwiB2C_CreateContractBulkBatch() , 2000 );
        Test.stopTest();
    }
}