/**
 * Created by User on 11.12.2018.
 */

trigger accountLinkContact on Contact (before insert) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            accountLinkContactTriggerHelper.beforeInsert(Trigger.new);
        }
    }
}