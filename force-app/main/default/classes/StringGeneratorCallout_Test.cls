@IsTest
public with sharing class StringGeneratorCallout_Test {
    @TestSetup
    static void testSetup() {
        Account account = new Account(Name = 'Test Name');
        insert account;
    }

    @IsTest
    static void doStringRandomizerCallout_UnitTest() {
        String expectedString = HttpGeneratorMock.RANDOM_STRING;
        Account account = [SELECT Id FROM Account LIMIT 1];

        Test.setMock(HttpCalloutMock.class, new HttpGeneratorMock());
        Test.startTest();
        String response = StringGeneratorCallout.doStringRandomizerCallout(account.Id);
        Test.stopTest();

        System.assertEquals(response, expectedString, 'String mismatch');
    }
}
