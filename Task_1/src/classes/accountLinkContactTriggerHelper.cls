public with sharing class accountLinkContactTriggerHelper {

    public static void beforeInsert(List<Contact> contacts){

        Set<String> lName = new Set<String>();
        for (Contact ct : contacts){
            lName.add(ct.LastName);
        }

        List<Account> accounts = new List<Account>([
                SELECT Name,id
                FROM Account
                WHERE Name IN :lName
        ]);

        Map<String, Id> idMapAccoun = new Map<String, Id>();
        for (Account acc : accounts){
            idMapAccoun.put(acc.Name, acc.Id);
        }
        for (Contact c : contacts){
            if (idMapAccoun.containsKey(c.LastName)) {
                c.AccountId = idMapAccoun.get(c.LastName);
            }
        }


//        System.debug(contactsIdsByStrings);
//        System.debug(accounts1 + 'acc');
    }

}