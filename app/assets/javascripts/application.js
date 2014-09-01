// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .

// login
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
      document.getElementById('signinButton').setAttribute('style', 'display: none');
      $.ajax({
        url: "/",
        type: "POST",
        beforeSend: function(xhr) {
          xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')
        )},
        data: {auth_token: authResult},
        immediate: true,
        success: function(){
          // window.location = '/';
          $("#username").slideToggle().css("margin-left", ".4em");
        }
      });
    }
}

// logout
$(document).ready(function(){
  $(".logout").click(function (e){
    e.preventDefault();
    // console.log(gapi.auth.signOut);
    gapi.auth.signOut();
  })
})