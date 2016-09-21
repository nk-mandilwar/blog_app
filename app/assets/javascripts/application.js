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
//= require jquery.infinite-pages
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

  var content = document.getElementsByClassName('show-less-content');
  for (var i = 0; i < content.length; ++i) {
    var id = $(content[i]).attr('id').split('_')[1];
    var scrollHeight = content[i].scrollHeight;
    var clientHeight = content[i].clientHeight;
    if( scrollHeight > clientHeight){
      $("#show_more"+id).show();
    }
  }

  var showMore = function(){
    $(document).on('click', '.show-more', function(){
      var id = $(this).attr('id').split("e")[1];
      var show_id = "show_" + id;
      $("#"+show_id).css("max-height", document.getElementById(show_id).scrollHeight);
      $("#show_less_"+id).show();
      $(this).hide(); 
    });
  };

  var showLess = function(){
    $(document).on('click', '.read-less', function(){
      var id = $(this).attr('id').split("_")[2];
      var show_id = "show_" + id;
      $("#"+show_id).css("max-height", 100);
      $("#show_more"+id).show();
      $(this).hide();
      var position = $("#"+show_id).position();
      window.scrollTo(position.left, position.top); 
    });
  };

  showMore();
  showLess();

  var warning = function() {
    $(document).on('click', '#warning', function(){
      alert('Please Sign in or Sign up to read more')
    });
  }; 

  warning();    
});

function find_id(id_initial, id){
  return (id_initial + id.split("_")[1]);
}
