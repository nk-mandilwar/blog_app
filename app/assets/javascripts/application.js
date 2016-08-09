// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .
$(document).ready(function() {

   $('.reply').on('click', function() {
    $("#comment_" + ($(this).attr('id').split("_")[1])).toggle();
  });

  $('.comment-reply').on('click', function() {
    $("#reply_div" + ($(this).attr('id').split("_")[1])).toggle();
  });   
});

// var incr = (function () {
//     var i = 1;
//     return function () {
//         return i++;
//     }
// })();
  //   i = incr()
    // if( i % 2 == 1)      
  //     document.getElementById(reply_id).innerHTML = "Replies";
    // else
    //  document.getElementById(reply_id).innerHTML = "Hide";