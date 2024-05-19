public with sharing class AcoountTreeGrid {
    @AuraEnabled(cacheable=true)
    public static Map<Id, List<Contact>> getAccountsWithContacts() {
        
        List<Account> accounts = [SELECT Id, Name FROM Account LIMIT 100];

        Map<Id, List<Contact>> accountMap = new Map<Id, List<Contact>>();

        List<Contact> lineItems = [
            SELECT Id, Name, AccountId, Account.Name
            FROM Contact
            WHERE AccountId IN :accounts
            LIMIT 10
        ];

        for (Contact item : lineItems) {
            if (!accountMap.containsKey(item.AccountId)) {
                accountMap.put(item.AccountId, new List<Contact>());
            }
            accountMap.get(item.AccountId).add(item);
        }

        return accountMap;
    }

    @AuraEnabled
    public static List<Contact> loadMoreLineItems(Id accountId, Integer offset) {
        return [SELECT Id, Name FROM Contact WHERE AccountId = :accountId LIMIT 10 OFFSET :offset];
    }
}