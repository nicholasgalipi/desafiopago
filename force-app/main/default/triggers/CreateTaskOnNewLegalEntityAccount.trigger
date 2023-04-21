trigger CreateTaskOnNewLegalEntityAccount on Account (after insert) {
    
    List<Task> tasksToAdd = new List<Task>();

    RecordType recordTypeIdLegalEntity = [SELECT Id,name FROM RecordType WHERE Name = 'Pessoa Juridica' AND SObjectType = 'Account' LIMIT 1];

    for(Account acc : Trigger.new){
        if(acc.RecordTypeId == recordTypeIdLegalEntity.Id){
            Task myTask = new Task();
            myTask.Subject = 'Auto created task';
            myTask.WhatId = acc.Id;
            tasksToAdd.add(myTask);
        }
    }


    insert tasksToAdd;
}