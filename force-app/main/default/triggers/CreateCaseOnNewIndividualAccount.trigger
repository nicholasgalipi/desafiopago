trigger CreateCaseOnNewIndividualAccount on Account (after insert) {

    List<Case> casesToAdd = new List<Case>();

    RecordType recordTypeIdIndividual = [SELECT Id,name FROM RecordType WHERE Name = 'Pessoa Fisica' AND SObjectType = 'Account' LIMIT 1];

    for(Account acc : Trigger.new){
        if(acc.RecordTypeId == recordTypeIdIndividual.Id){
            Case myCase = new Case();
            myCase.Subject = 'Auto created case';
            myCase.AccountId = acc.Id;
            casesToAdd.add(myCase);
        }
    }


    insert casesToAdd;
}