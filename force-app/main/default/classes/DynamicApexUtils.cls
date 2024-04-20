public with sharing class DynamicApexUtils {
    /*
    @Description : Creating Record
        Map<String, Object> fields = new Map<String, Object>{
            'Name' => 'Test Account',
            'Industry' => 'Technology',
            'AnnualRevenue' => 1000000
        };
        DynamicApexUtils.createRecord('Account', fields);
    */
    public static void createRecord(String objectName, Map<String, Object> fields) {
        try {
            // Instantiate the object dynamically
            SObject newRecord = (SObject)Type.forName('Schema.' + objectName).newInstance();
            
            // Set field values dynamically
            for (String fieldName : fields.keySet()) {
                newRecord.put(fieldName, fields.get(fieldName));
            }
            
            // Insert the record
            insert newRecord;
            
            System.debug('Record created successfully: ' + newRecord);
        } catch (Exception e) {
            System.debug('Error creating record: ' + e.getMessage());
        }
    }

    /*
    List<String> customFields = DynamicApexUtils.getAllCustomFields('Account');
    System.debug('Custom Fields for Account object: ' + customFields);
    */
    public static List<String> getAllCustomFields(String objectName) {
        List<String> customFieldNames = new List<String>();
        try {
            // Get the Schema describe result for the object
            Schema.DescribeSObjectResult describeResult = Schema.getGlobalDescribe().get(objectName).getDescribe();
            
            // Iterate through all fields of the object
            for (Schema.SObjectField field : describeResult.fields.getMap().values()) {
                Schema.DescribeFieldResult fieldDescribe = field.getDescribe();
                
                // Check if the field is a custom field
                if (fieldDescribe.isCustom()) {
                    customFieldNames.add(fieldDescribe.getName());
                }
            }
        } catch (Exception e) {
            System.debug('Error retrieving custom fields: ' + e.getMessage());
        }
        return customFieldNames;
    }

    /*
    List<String> stagePicklistValues = DynamicPicklistValueRetriever.getPicklistValues('Opportunity', 'StageName');
    System.debug('Picklist values for StageName field of Opportunity object: ' + stagePicklistValues);
    */
    public static List<String> getPicklistValues(String objectName, String fieldName) {
        List<String> picklistValues = new List<String>();
        try {
            // Get the Schema describe result for the object
            Schema.DescribeSObjectResult describeResult = Schema.getGlobalDescribe().get(objectName).getDescribe();
            
            // Get the Schema describe result for the field
            Schema.DescribeFieldResult fieldDescribe = describeResult.fields.getMap().get(fieldName).getDescribe();
            
            // Check if the field is a picklist
            if (fieldDescribe.getType() == Schema.DisplayType.Picklist) {
                // Retrieve picklist values
                List<Schema.PicklistEntry> picklistEntries = fieldDescribe.getPicklistValues();
                for (Schema.PicklistEntry entry : picklistEntries) {
                    picklistValues.add(entry.getValue());
                }
            } else {
                System.debug('Field is not a picklist');
            }
        } catch (Exception e) {
            System.debug('Error retrieving picklist values: ' + e.getMessage());
        }
        return picklistValues;
    }

    /*
    Id recordTypeId = DynamicRecordTypeRetriever.getRecordTypeId('Opportunity', 'Your Record Type Name');
    System.debug('Record Type Id for Opportunity object and Your Record Type Name: ' + recordTypeId);
    */
    public static Id getRecordTypeId(String objectName, String recordTypeName) {
        Id recordTypeId;
        try {
            // Get the Schema describe result for the object
            Schema.DescribeSObjectResult describeResult = Schema.getGlobalDescribe().get(objectName).getDescribe();
            
            // Get the map of Record Type Infos
            Map<String, Schema.RecordTypeInfo> recordTypeInfoMap = describeResult.getRecordTypeInfosByName();
            
            // Check if the Record Type Name exists for the object
            if (recordTypeInfoMap.containsKey(recordTypeName)) {
                recordTypeId = recordTypeInfoMap.get(recordTypeName).getRecordTypeId();
            } else {
                System.debug('Record Type does not exist for the given Object and Record Type Name');
            }
        } catch (Exception e) {
            System.debug('Error retrieving Record Type Id: ' + e.getMessage());
        }
        return recordTypeId;
    }
}