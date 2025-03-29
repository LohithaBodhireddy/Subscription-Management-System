public class SubscriptionManager {
    public static void processRenewals() {
        List<Subscription__c> subscriptions = [SELECT Id, Name, End_Date__c, Status__c, Customer_Email__c 
                                               FROM Subscription__c 
                                               WHERE Status__c = 'Active' AND End_Date__c = TODAY];
        
        for (Subscription__c sub : subscriptions) {
            sub.Status__c = 'Renewed';
            sendRenewalNotification(sub.Customer_Email__c, sub.Name);
        }
        update subscriptions;
    }

    public static void sendRenewalNotification(String email, String subscriptionName) {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] {email});
        mail.setSubject('Subscription Renewal Notice');
        mail.setPlainTextBody('Dear Customer, your subscription ' + subscriptionName + ' has been renewed.');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}
