public with sharing class CalloutLWC {
   
    @AuraEnabled
    public static string callout1(){
        // some Apex callout
        return 'callout 1';
    }

    @AuraEnabled
    public static string callout2(String parameter1){
        // some Apex callout
        if(parameter1=='callout 1'){
        return 'callout 2';
        }
        return 'call'
    }
    
    
    
    
    
    
    
    
    
    
    @AuraEnabled
    public static Map<String,List<Contact>> callout3(){
        List<Account> accounts = [Select Id,(Select Id,Name from Contacts) from Account where Id IN (Select AccountId from Contact)];
        Map<String,List<Contact>> mapByAccount = new Map<String,List<Contact>>();
        for(Account ac:accounts){
            mapByAccount.put(ac.Id,ac.Contacts);
        }
        return mapByAccount;
    }
}