public class OpenCaseCount implements Database.Batchable<SObject>, Database.Stateful,Schedulable  {
    
    
    
    public Integer SumOpen = 0;
    public Integer SumTotal = 0;
    
    public Database.QueryLocator start(Database.BatchableContext BC){
        //return Database.getQueryLocator([SELECT Id, Status FROM Case WHERE Status != 'Closed']);
        return Database.getQueryLocator([SELECT Id, Status FROM Case]);
    }

    public void execute(SchedulableContext context) {
        Database.executeBatch(new OpenCaseCount());
    }
    
    
    
    public void execute(Database.BatchableContext BC, List<Case> scope){
      
        for(Case s : scope){
            SumTotal++;
            if (s.Status != 'Closed')
            {
                SumOpen++; 
            }
        }
   }



    public void finish(Database.BatchableContext BC){
        
        //This handles sending the email
        Messaging.reserveSingleEmailCapacity(1);
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {'nickgalipi@gmail.com'};
        email.setToAddresses(toAddresses);
        email.setSubject('Open Case Count');
        email.setPlainTextBody('There are ' + SumOpen + ' open cases and ' + SumTotal + 'Total cases');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
        System.debug('There are ' + SumOpen + ' open cases and ' + SumTotal + 'Total cases');
    }
}