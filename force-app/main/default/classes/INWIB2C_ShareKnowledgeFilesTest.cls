@IsTest
public class INWIB2C_ShareKnowledgeFilesTest {
    static testmethod void init(){

        Knowledge__kav article = new Knowledge__kav();
        article.Title='Test';
        article.UrlName='Test';
        insert article;
        
        ContentVersion contentVersion = new ContentVersion(
          Title = 'Penguins',
          PathOnClient = 'Penguins.jpg',
          VersionData = Blob.valueOf('Test Content'),
          IsMajorVersion = true
        );
        insert contentVersion;    
        List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument];
        test.startTest();
        //create ContentDocumentLink  record 
        ContentDocumentLink cdl = New ContentDocumentLink();
        cdl.LinkedEntityId = article.id;
        cdl.ContentDocumentId = documents[0].Id;
        cdl.shareType = 'V';
        insert cdl;
        test.stopTest();
        //System.assertEquals(1, documents.size());
    }
}