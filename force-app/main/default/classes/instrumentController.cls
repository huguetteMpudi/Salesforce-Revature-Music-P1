public with sharing class instrumentController {
    
    //Variable declarations
    public Music_Product__c currentProduct {get; set; }
    public transient Integer totalOrders;
    public List<Revature_Music_Class__c> classes = new List<Revature_Music_Class__c>();

    //Gets the ID of the passed object and finds the instrument of that ID
    public instrumentController() {
        ID instrumentID = ApexPages.CurrentPage().getParameters().get('id');
        this.currentProduct = [SELECT name, description__c, Estimated_Quantity__c, Image__c FROM Music_Product__c WHERE id=:instrumentID LIMIT 1];
        system.debug('Created');
    }

    //Done
    public string getName(){

        system.debug('Calling name get');

        return this.currentProduct.name;

    }

    //Description needs to be added by Max
    public string getDescription(){

        system.debug('Calling name get');

        return this.currentProduct.description__c;

    }

    //Gets the total number of orders
    //Needs to account for the different fields from order
    public integer getTotalOrders(){

        totalOrders = [SELECT COUNT() FROM Music_Product_Order__c WHERE Music_Product_Purchased_1__c=:currentProduct.id OR Music_Product_Purchased_2__c=:currentProduct.id OR Music_Product_Purchased_3__c=:currentProduct.id];
        return totalOrders;

    }

    //Gets all of the classes associated with that instrument
    //Needs to have instruments added to classes by Max
    public List<Revature_Music_Class__c> getClasses(){

        this.classes = [SELECT name, instrument_offered__c FROM Revature_Music_Class__c WHERE Revature_Music_Class__c.instrument_offered__c = :this.currentProduct.name];
        return classes;

    }

    public decimal getTotalSupply(){

        return this.currentProduct.Estimated_Quantity__c;

    }

}