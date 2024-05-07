@isTest
public with sharing class AccountControllerTest {

    @isTest{SeeAllData=true}
    public static void testGetAccountList() {
        // Create test data
        List<Account> testAccounts = new List<Account>();
        for(Integer i=0; i<5; i++) {
            testAccounts.add(new Account(Name='Test Account ' + i));
        }
        insert testAccounts;

        List<Contact> testContacts = new List<Contact>();
        for(Integer i=0; i<10; i++) {
            testContacts.add(new Contact(AccountId=testAccounts[i % 5].Id, FirstName='Test', LastName='Contact ' + i));
        }
        insert testContacts;

        // Call the method to test
        Test.startTest();
        List<Account> result = AccountController.getAccountList();
        Test.stopTest();

        // Assertions
        System.assertEquals(5, result.size(), 'Expected 5 accounts');

        for(Account acc : result) {
            System.assertEquals(1, acc.Contacts.size(), 'Each account should have one contact');
        }
    }

    @isTest{SeeAllData=true}
    public static void testGetSingleAccount() {
        // Create test data
        Account testAccount = new Account(Name='Test Account', Phone='123-456-7890', Type='Customer');
        insert testAccount;

        // Call the method to test
        Test.startTest();
        Account result = AccountController.getSingleAccount();
        Test.stopTest();

        // Assertions
        System.assertEquals(testAccount.Id, result.Id, 'Incorrect Account Id');
        System.assertEquals(testAccount.Name, result.Name, 'Incorrect Account Name');
        System.assertEquals(testAccount.Phone, result.Phone, 'Incorrect Account Phone');
        System.assertEquals(testAccount.Type, result.Type, 'Incorrect Account Type');
    }
}
