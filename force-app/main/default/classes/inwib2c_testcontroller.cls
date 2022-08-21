public with sharing class inwib2c_testcontroller {
    public String id {get; set;}
    public String name {get; set;}

    public inwib2c_testcontroller() {
        id = Apexpages.currentPage().getParameters().get('id');
        name = Apexpages.currentPage().getParameters().get('name');

    }
}