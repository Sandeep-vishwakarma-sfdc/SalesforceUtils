
# Salesforce Interview

## Dynamic Apex
System.debug(Account.sObjectType.getDescribe().fields.getMap().get('Name').getDescribe().getName());// Name
System.debug(Schema.sObjectType.Account.fields.Name.getsObjectField());// Name
System.debug(Schema.SObjectType.Order.getRecordTypeInfosByName().get('Promotional Cart').getRecordTypeId());

