$(document).ready(function () {  
    //Toggle the User Notification Preferences when NotifyGroup changes    
    $('#NotifyGroup').change(function() {
        ToggleUserNotificationPreferences($('#NotifyGroup').val() === 'Electronic');        
    });

    //Initialize the state of the User notification preferences based on the existing value
    if ($('#NotifyGroup').length)
    {
        ToggleUserNotificationPreferences($('#NotifyGroup').val() === 'Electronic')
    }

    $("body").on("click", "a[data-notification-check]", handleNotificationCheckboxes);
});

function handleNotificationCheckboxes() {
    var notificationType = $(this).attr('data-notification-check');
    var checkAll = $(this).attr('data-notification-action') === 'all';
    var preferencesTable = $(this).closest('Table');
    preferencesTable.find('input[name^=Notification_][name$=_' + notificationType + ']').prop('checked', checkAll);
}


function ToggleUserNotificationPreferences(enabled) {
    //The notication preference was changed. Set the Request Pickup and Request shipped checkboxes to disabled/enabled
    $('#NotificationPreferences input[name^=Notification_RequestPickup]').attr('disabled', !enabled);
    $('#NotificationPreferences input[name^=Notification_RequestShipped]').attr('disabled', !enabled);  
}
