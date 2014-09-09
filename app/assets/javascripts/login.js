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

  /**
   * Record the result of an authorization attempt by storing the result
   * and firing an event.
   *
   * @param {Object} authResult the authorization result receieved.
   */
  recordAuthResult: function(authResult) {
    this.authResult = authResult;
    this.sendCodeToServer();
  },

  /**
   * Send the `code` from the authResult to the server to initiation the one
   * time code flow.  When finished, display the user's name in the nav bar.
   */
  sendCodeToServer: function() {
    if (this.authResult['status']['signed_in']) {
    // Update the app to reflect a signed in user
    // Hide the sign-in button now that the user is authorized, for example:
      $('#signinButton').toggle();

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

/**
 * Register the click handler for the logout link.
 */
$(document).ready(function() {
  GPLUS_API.authResult = GPLUS_API.authResult || {};
  GPLUS_API.authResult.access_token = GPLUS_API.authResult.access_token || $('[data-access-token]').attr('data-access-token');
  $('#logout').click(function() {
    GPLUS_API.disconnect();
  });
});
function signInCallback(authResult) {
  GPLUS_API.recordAuthResult(authResult);
}
