(function() {
   var po = document.createElement('script');
   po.type = 'text/javascript';
   po.async = true;
   po.src = 'https://apis.google.com/js/client:plusone.js?onload=render';
   var s = document.getElementsByTagName('script')[0];
   s.parentNode.insertBefore(po, s);
  })();

function signinCallback(authResult) {
  if (authResult['status']['signed_in']) {
    // Update the app to reflect a signed in user
    // Hide the sign-in button now that the user is authorized, for example:
    $('#signinButton').css({'display': 'none'});
    $.ajax({
      url: "/sessions",
      type: "POST",
      beforeSend: function(xhr) {
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')
      )},
      data: {auth_token: authResult},
      immediate: true,
      success: function(){
        $("#username").slideToggle();
      }
    });
  }
}


// logout
$(document).ready(function(){
  $(".logout").click(function (e){
    e.preventDefault();
    console.log(gapi.auth.signOut);
    gapi.auth.signOut();
  })
})