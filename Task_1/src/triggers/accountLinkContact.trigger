/**
 * Created by User on 11.12.2018.
 */

trigger accountLinkContact on Contact (after insert) {
    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            accountLinkContactTriggerHelper.afterInsert(Trigger.new);
        }
    }
}