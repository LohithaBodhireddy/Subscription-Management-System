public class BatchSubscriptionRenewal implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator([SELECT Id, Name, End_Date__c, Status__c FROM Subscription__c WHERE Status__c = 'Active' AND End_Date__c = TODAY]);
    }

    public void execute(Database.BatchableContext BC, List<Subscription__c> scope) {
        for (Subscription__c sub : scope) {
            sub.Status__c = 'Renewed';
        }
        update scope;
    }

    public void finish(Database.BatchableContext BC) {
        System.debug('Batch Renewal Process Completed.');
    }
}
