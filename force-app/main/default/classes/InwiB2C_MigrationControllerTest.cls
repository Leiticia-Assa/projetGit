@isTest
public class InwiB2C_MigrationControllerTest {
    @isTest
     public static void Test1() {
      String name = 'test';
      String cin = 'test';
      String mdn = 'test';
      String offre = 'test';
      String poscode = 'test';
      String numcomm = 'test';
      String oldoffer = 'test';
      String oldmontant = 'test';
      String newmontant = 'test';
      String datedefacturation = 'test';
      String typeModification = 'test';
    
      Test.StartTest();
      ApexPages.currentPage().getParameters().put('name',name);
      ApexPages.currentPage().getParameters().put('cin',cin);
      ApexPages.currentPage().getParameters().put('mdn',mdn);
      ApexPages.currentPage().getParameters().put('cin',cin);
      ApexPages.currentPage().getParameters().put('offre',offre);
      ApexPages.currentPage().getParameters().put('poscode',poscode);
      ApexPages.currentPage().getParameters().put('numcomm',numcomm);
      ApexPages.currentPage().getParameters().put('oldoffer',oldoffer);
      ApexPages.currentPage().getParameters().put('oldmontant',oldmontant);
      ApexPages.currentPage().getParameters().put('newmontant',newmontant);
      ApexPages.currentPage().getParameters().put('datedefacturation',datedefacturation);
      ApexPages.currentPage().getParameters().put('typeModification',typeModification);
       
      InwiB2C_ModificationMigration_Controller Migrationcontroller = new InwiB2C_ModificationMigration_Controller();
        		Test.StopTest();

        
    }
   

}