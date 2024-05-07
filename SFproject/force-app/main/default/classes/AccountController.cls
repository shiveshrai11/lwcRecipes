public with sharing class AccountController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountList() {
        return [SELECT Id, Name, (SELECT Id,Name FROM Contacts)
        FROM Account
        WHERE Id IN (SELECT AccountId FROM Contact)
        WITH SECURITY_ENFORCED LIMIT 10
        ];
    }

    @AuraEnabled(cacheable=true)
    public static Account getSingleAccount() {
        return [
            SELECT Id, Name, Phone, Type
            FROM Account
            WITH SECURITY_ENFORCED
            LIMIT 1
        ];
    }
}
