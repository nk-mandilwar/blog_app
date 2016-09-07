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
 
  var replyTextOnClick = function(){
    $(document).on('click', '.reply', function(){
      
      var comment_id = find_id("#comment_", $(this).attr('id'));
      var hide_id = find_id("#hide_", $(this).attr('id'));
      
      $(comment_id).toggle();
      $(this).hide();
      $(hide_id).show();
    });
  };

  var hide1TextOnClick = function(){
    $(document).on('click', '.hide1', function() {

      var comment_id = find_id("#comment_", $(this).attr('id'));
      var reply_id = find_id("#reply_", $(this).attr('id'));
      
      $(comment_id).toggle();
      $(this).hide();
      $(reply_id).show();
    });
  };

  var commentReplyOnClick = function(){
    $(document).on('click', '.comment-reply', function() {
      var reply_div_id = find_id("#reply_div", $(this).attr('id'));
      $(reply_div_id).toggle();
    });
  };
  
  replyTextOnClick();
  hide1TextOnClick();
  commentReplyOnClick(); 
});


function find_id(id_initial, id){
  return (id_initial + id.split("_")[1]);
}
