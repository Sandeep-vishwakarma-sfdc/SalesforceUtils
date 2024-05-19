
# Salesforce Interview

## Dynamic Apex
> Example of Getting Account Field
<<<<<<< HEAD
System.debug(Account.sObjectType.getDescribe().fields.getMap().get('Name').getDescribe().getName());// 
=======
```
System.debug(Account.sObjectType.getDescribe().fields.getMap().get('Name').getDescribe().getName());// Name
>>>>>>> 1af9390dbf8f0da69c7942faef0d8eb9b39a4a9f
System.debug(Schema.sObjectType.Account.fields.Name.getsObjectField());// Name
```

> Example of getting record type id
```
System.debug(Schema.SObjectType.Order.getRecordTypeInfosByName().get('Promotional Cart').getRecordTypeId());
```



LWC
- import {showToastEvent} from 'lightning/platformShowToastEvent'
- import {NavigationMixin} from 'lightning/navigation'

this.dispatchEvent(new showToastEvent({title:'',message:'',variant:''}))

Map<List<String>,List<String>> = new Map<List<String>,List<String>>();

String objectName = 'Account';
String ApiName = Schema.getGlobalDescribe().get(objectName).getDescribe().getName();



String objectApiName = 'Account';

Map<String,Schema.sObjectField> fieldMap = Schema.getGlobalDescribe().get(objectApiName).getDescribe().fields.getMap();
for(String key:fieldMap.keySet()){
    Schema.sObjectField field = fieldMap.get(key);
    System.debug(field.getDescribe().getName());
}

Schema.getGlobalDescribe().get(objectApiName).getDescribe().fields.getMap().get('status__c').getDescribe().getName();

String recordTypeId = Schema.getGlobalDescribe().get(objectApiName).getDescribe().getRecordTypeInfosByName().get('Customer').getRecordTypeId();





























