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
//= require jquery.raty
//= require ratyrate
//= require bootstrap-sprockets
//= require tinymce-jquery
//= require social-share-button
//= require_tree .

$(document).ready(function() {

  $('.reply').on('click', function() {
    $("#comment_" + ($(this).attr('id').split("_")[1])).toggle();
    $(this).hide();
    $("#hide_" + ($(this).attr('id').split("_")[1])).show();
  });

  $('.hide1').on('click', function() {
    $("#comment_" + ($(this).attr('id').split("_")[1])).toggle();
    $(this).hide();
    $("#reply_" + ($(this).attr('id').split("_")[1])).show();
  });

  $('.comment-reply').on('click', function() {
    $("#reply_div" + ($(this).attr('id').split("_")[1])).toggle();
    // hide_reply_div();
  });

  // function hide_reply_div(){
  //   $('.add-reply').on('click', function(){
  //   });
  //   $('body').on('click', function() {
  //     $('.add-reply').hide();
  //   });
  // }



  // $("#search-form input").keyup(function() {
  //   $.get($("#search-form").attr("action"), $("#search-form").serialize(), null, "script");
  //   return false;
  // });  

  // $("#search-post input").keyup(function() {
  //   $.get($("#search-post").attr("action"), $("#search-post").serialize(), null, "script");
  //   return false;
  // });  
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