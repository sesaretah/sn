function startFcm(event) {
  
  const messaging = firebase.messaging();
  messaging.usePublicVapidKey("BNs_ZAWxjHh1dnyFGZPirlxTus_SgmMhbJVGD2I3GajkpQm76VG25fJP-l9yYQp1H91tslOWdMXcEFeEyv0VHvY");
  messaging.requestPermission().then(function() {
    console.log('Notification permission granted.');
  }).catch(function(err) {
    console.log('Unable to get permission to notify.', err);
  });

  messaging.getToken().then(function(currentToken) {
    if (currentToken) {
      console.log(currentToken);
    } else {
      // Show permission request.
      console.log('No Instance ID token available. Request permission to generate one.');
      // Show permission UI.
      updateUIForPushPermissionRequired();
      setTokenSentToServer(false);
    }
  }).catch(function(err) {
    console.log('An error occurred while retrieving token. ', err);
    //showToken('Error retrieving Instance ID token. ', err);
    setTokenSentToServer(false);
  });
  messaging.onMessage(function(payload) {
    new Noty({
        type: 'alert',
        theme    : 'relax',
        timeout: 2000,
        layout: 'bottomLeft',
        text: payload.notification.title + ': ' + payload.notification.body
    }).show();

    console.log('Message received. ', payload);
  });
}

$(document).on('turbolinks:load', startFcm)
