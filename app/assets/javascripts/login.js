(function() {
   var po = document.createElement('script');
   po.type = 'text/javascript';
   po.async = true;
   po.src = 'https://apis.google.com/js/client:plusone.js?onload=render';
   var s = document.getElementsByTagName('script')[0];
   s.parentNode.insertBefore(po, s);
  })();

var GPLUS_API = {

  authResult: null,
  // Store result and fire send to server
  recordAuthResult: function(authResult) {
    this.authResult = authResult;
    this.sendCodeToServer();
  },
  // send auth result to server and handle look and feel
  sendCodeToServer: function() {
    if (this.authResult['status']['signed_in']) {
    // Update the app to reflect a signed in user
    // Hide the sign-in button now that the user is authorized, for example:
      // $('#signinButton').toggle();
      $.ajax({
        url: "/sessions",
        type: "POST",
        beforeSend: function(xhr) {
          xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')
        )},
        data: {auth_token: this.authResult},
        immediate: true,
        success: function(){
          window.location = '/';
        }
      });
    }
  }
};
// Register listeners
$(document).ready(function() {
  $('#logout').click(function() {
    GPLUS_API.disconnect();
  });
});

function signInCallback(authResult) {
  GPLUS_API.recordAuthResult(authResult);
}
