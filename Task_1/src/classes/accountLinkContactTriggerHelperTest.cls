/**
 * Created by User on 11.12.2018.
 */
@IsTest
public with sharing class accountLinkContactTriggerHelperTest {

    @TestSetup
    static void createUser(){
        Profile CloneUserProfile = [SELECT Id FROM Profile WHERE Name='Clone Standard User'];
        User CloneUser = new User(Alias = 'clonus', Email='artyom124@testorg.com',
                EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
                LocaleSidKey='en_US', ProfileId = CloneUserProfile.Id,
                TimeZoneSidKey='America/Los_Angeles', UserName='CloneStandardUser@testorg.com');
        insert CloneUser;
        Profile AdminProfile = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        User AdminUser = new User(Alias = 'susadm', Email='artyom124@testorg.com',
                EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
                LocaleSidKey='en_US', ProfileId = AdminProfile.Id,
                TimeZoneSidKey='America/Los_Angeles', UserName='SystemAdministrator@testorg.com');
        insert AdminUser;

        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 10; i++){
            accounts.add(new Account(
                    Name = 'Tester' + i
            ));
        }
        insert accounts;

    }

    @IsTest
    static void TestAddAccount(){

        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i < 10; i++){
            contacts.add(new Contact(LastName = 'Tester' + i));
        }
        User StandartUser = [SELECT Id FROM User Where UserName='CloneStandardUser@testorg.com'];
        System.runAs(StandartUser){

            insert contacts;
        }
        Account assertAccount = [SELECT Id FROM Account WHERE Name = 'Tester1'];
        Contact assertContact = [SELECT AccountId FROM Contact WHERE Name = 'Tester1'];
        System.assertEquals(assertContact.AccountId, assertAccount.Id);
    }
    @IsTest
    static void TestAddListAccount(){

        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i < 10; i++){
            contacts.add(new Contact(LastName = 'Tester' + i));
        }
        User StandartUser = [SELECT Id FROM User Where UserName='CloneStandardUser@testorg.com'];
        System.runAs(StandartUser){

            insert contacts;
        }
        List<Account> assertListAccount = new List<Account>([SELECT Id
                                                            FROM Account
                                                            WHERE Name LIKE 'Tester%'
                                                                    LIMIT 15]);
        List<Contact> assertListContact = new List<Contact>([SELECT AccountId
                                                                FROM Contact
                                                                WHERE Name LIKE 'Tester%'
                                                                    LIMIT 15]);
        for (Integer i; i < assertListAccount.size(); i++){
            System.assertEquals(assertListContact.get(i).AccountId, assertListAccount.get(i).Id);
        }

    }




    }