
# Salesforce Interview

## Dynamic Apex
> Example of Getting Account Field
```
System.debug(Account.sObjectType.getDescribe().fields.getMap().get('Name').getDescribe().getName());// Name
System.debug(Schema.sObjectType.Account.fields.Name.getsObjectField());// Name
```

> Example of getting record type id
```
System.debug(Schema.SObjectType.Order.getRecordTypeInfosByName().get('Promotional Cart').getRecordTypeId());
```


