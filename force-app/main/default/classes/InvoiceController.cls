public with sharing class InvoiceController {
    @AuraEnabled(cacheable=true)
    public static List<InvoiceWrapper> getInvoicesWithLineItems() {
        List<Invoice__c> invoices = [SELECT Id, Name FROM Invoice__c LIMIT 100];

        Map<Id, List<Invoice_Line_Item__c>> invoiceMap = new Map<Id, List<Invoice_Line_Item__c>>();
        List<InvoiceWrapper> invoiceWrappers = new List<InvoiceWrapper>();

        for (Invoice__c invoice : invoices) {
            List<Invoice_Line_Item__c> lineItems = [SELECT Id, Name FROM Invoice_Line_Item__c WHERE Invoice__c = :invoice.Id LIMIT 10];
            invoiceMap.put(invoice.Id, lineItems);

            List<LineItemWrapper> lineItemWrappers = new List<LineItemWrapper>();
            for (Invoice_Line_Item__c item : lineItems) {
                lineItemWrappers.add(new LineItemWrapper(item.Id, item.Name));
            }

            invoiceWrappers.add(new InvoiceWrapper(invoice.Id, invoice.Name, lineItemWrappers));
        }

        return invoiceWrappers;
    }

    @AuraEnabled
    public static List<LineItemWrapper> loadMoreLineItems(Id invoiceId, Integer offset) {
        List<Invoice_Line_Item__c> lineItems = [SELECT Id, Name FROM Invoice_Line_Item__c WHERE Invoice__c = :invoiceId LIMIT 10 OFFSET :offset];
        List<LineItemWrapper> lineItemWrappers = new List<LineItemWrapper>();
        for (Invoice_Line_Item__c item : lineItems) {
            lineItemWrappers.add(new LineItemWrapper(item.Id, item.Name));
        }
        return lineItemWrappers;
    }

    public class InvoiceWrapper {
        @AuraEnabled public String id { get; set; }
        @AuraEnabled public String name { get; set; }
        @AuraEnabled public List<LineItemWrapper> lineItems { get; set; }
        public InvoiceWrapper(String id, String name, List<LineItemWrapper> lineItems) {
            this.id = id;
            this.name = name;
            this.lineItems = lineItems;
        }
    }

    public class LineItemWrapper {
        @AuraEnabled public String id { get; set; }
        @AuraEnabled public String name { get; set; }
        public LineItemWrapper(String id, String name) {
            this.id = id;
            this.name = name;
        }
    }
}
