// WAT to update users filed with no of Opportunities
// Solution : 
// Get All opportunities Owners
// Map user and related Opportunity
// update count

trigger OpportunityTrigger1 on Opportunity (After insert,After delete,After update) {
    List<Opportunity> opportunities = new List<Opportunity>();
    if(Trigger.isInsert || Trigger.isUpdate){
        opportunities.addAll(Trigger.new);
    }
    if(Trigger.isDelete){
        opportunities.addAll(Trigger.old);
    }
    OpportunityTriggerHandler.updateTotalOppotunityOnUser();
}

class OpportunityTriggerHandler{
    private static void updateTotalOppotunityOnUser(List<Opportunity> opportunities){
        List<Id> ownerIds = new List<Id>();
        for(Opportunity op:opportunities){
            ownerIds.add(op.ownerId);
        }
        List<Opportunity> allOpportunities = [select Id,Name from Opportunity where OwnerId In:ownerIds];
        Map<Id,List<Opportunity>> opportunityByUser = new Map<Id,List<Opportunity>>();
        for(Opportunity op:allOpportunities){
            if(!opportunityByUser.containsKey(op.ownerId)){
                opportunityByUser.put(op.ownerId,new List<Opportunity>());
            }
            opportunityByUser.get(op.ownerId).add(op);
        }
    }

    List<User> users = new List<User>();
    for(Id ownerId:opportunityByUser.keySet()){
        User u = new User();
        u.Id = ownerId;
        u.totalOpportunities__c = opportunityByUser.get(ownerId).size();
        users.add(u);
    }
    update users;
}

