@isTest
public class generateOrderTest
{
    public static ApexPages.StandardController stdCon = new ApexPages.StandardController(new order__c());
    public static GenerateOrderTempController1 con = new GenerateOrderTempController1(stdCon);
    @isTest
    public static void TestMethod1()
    {
       con.currentOrder.input__C='morning,1,2,3';
         Test.startTest();
       con.fetchDishes();
        Test.stopTest(); 
        System.assertEquals(con.currentOrder.output__c,'eggs, toast, coffee');
    }
     @isTest
    public static void TestMethod2()
    {
       con.currentOrder.input__C='morning';
        Test.startTest();
       con.fetchDishes();
        Test.stopTest(); 
       System.assertEquals(con.currentOrder.output__c,' Only morning or night is allowed');
    }
     @isTest
    public static void TestMethod3()
    {
       con.currentOrder.input__C='';
        Test.startTest();
       con.fetchDishes();
        Test.stopTest(); 
       System.assertEquals(con.currentOrder.output__c,'Minimum One order is required');
    }
     @isTest
    public static void TestMethod4()
    {
       con.currentOrder.input__C='morning,1,1';
        Test.startTest();
       con.fetchDishes();
        Test.stopTest(); 
       System.assertEquals(con.currentOrder.output__c,'Only one Entree (#1) order is allowed');
    }
     @isTest
	public static void TestMethod5()
    {
       con.currentOrder.input__C='morning,1,2,2,2,3';
        Test.startTest();
       con.fetchDishes();
        Test.stopTest(); 
       System.assertEquals(con.currentOrder.output__c,'Only one Side (#2) order is allowed');
    }
     @isTest
    public static void TestMethod6()
    {
       con.currentOrder.input__C='morning,1,2,3,4';
        Test.startTest();
       con.fetchDishes();
        Test.stopTest(); 
       System.assertEquals(con.currentOrder.output__c,'Desert(#4) is not available in the Morning');
    }
     @isTest
    public static void TestMethod7()
    {
       con.currentOrder.input__C='morning,1,2,3,3,3';
        Test.startTest();
       con.fetchDishes();
        Test.stopTest(); 
       System.assertEquals(con.currentOrder.output__c,'eggs, toast, coffee(x3)');
    }
     @isTest
    public static void TestMethod8()
    {
       con.currentOrder.input__C='night';
        Test.startTest();
       con.fetchDishes();
        Test.stopTest(); 
       System.assertEquals(con.currentOrder.output__c,'Minimum One order is required');
    }
     @isTest
    public static void TestMethod9()
    {
       con.currentOrder.input__C='night,1,1';
        Test.startTest();
       con.fetchDishes();
        Test.stopTest(); 
       System.assertEquals(con.currentOrder.output__c,'Only one Entree (#1) order is allowed');
    }
     @isTest
    public static void TestMethod10()
    {
       con.currentOrder.input__C='night,1,2,3,3,';
        Test.startTest();
       con.fetchDishes();
        Test.stopTest(); 
       System.assertEquals(con.currentOrder.output__c,'Only one Drink (#3) order is allowed');
    }
     @isTest
     public static void TestMethod11()
    {
       con.currentOrder.input__C='night,1,2,2,3';
        Test.startTest();
       con.fetchDishes();
        Test.stopTest(); 
       System.assertEquals(con.currentOrder.output__c,'Steak, potato(x2), wine');
    }
     @isTest
     public static void TestMethod12()
    {
       con.currentOrder.input__C='night,1,2,3,4,4';
       Test.startTest();
       con.fetchDishes();
        Test.stopTest(); 
       System.assertEquals(con.currentOrder.output__c,'Only one Desert (#4) order is allowed');
    }
    @isTest
	 public static void TestMethod14()
    {
       con.currentOrder.input__C='morning,5';
       Test.startTest();
       con.fetchDishes();
        Test.stopTest(); 
       System.assertEquals(con.currentOrder.output__c,'Only Menu Items 1, 2, 3,4 are allowed');
    }
    @isTest
	 public static void TestMethod15()
    {
       con.currentOrder.input__C='night,5';
       Test.startTest();
       con.fetchDishes();
        Test.stopTest(); 
       System.assertEquals(con.currentOrder.output__c,'Only Menu Items 1, 2, 3 are allowed');
    }    
    
    
    
}