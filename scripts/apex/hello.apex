
List<Invoice__c> invoices = new List<Invoice__c>();
for(Integer i=0;i<=10;i++){
Invoice__c inv = new Invoice__c(Name='Invoice '+i);
invoices.add(inv);
}
insert invoices;

List<Invoice_Line_Item__c> invoices = new List<Invoice_Line_Item__c>();
for(Integer i=0;i<=30;i++){
Invoice_Line_Item__c inv = new Invoice_Line_Item__c(Name='Invoice Line Item 3.'+i,Invoice__c='a2AGC00000F2U562AF');
invoices.add(inv);
}
insert invoices;

delete [Select Id,Name from Invoice_Line_Item__c where Invoice__c='a2AGC00000F2U562AF'];