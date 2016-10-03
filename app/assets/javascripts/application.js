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
      
      var comment_id = findId("#comment_", $(this).attr('id'));
          hide_id = findId("#hide_", $(this).attr('id'));
      
      $(comment_id).toggle();
      $(this).hide();
      $(hide_id).show();
    });
  };

  var hide1TextOnClick = function(){
    $(document).on('click', '.hide1', function() {

      var comment_id = findId("#comment_", $(this).attr('id'));
          reply_id = findId("#reply_", $(this).attr('id'));
      
      $(comment_id).toggle();
      $(this).hide();
      $(reply_id).show();
    });
  };

  var showMore = function(){
    $(document).on('click', '.show-more', function(){
      var id = $(this).attr('id').split("e")[1];
          show_id = "show_" + id;
      $("#"+show_id).css("max-height", document.getElementById(show_id).scrollHeight);
      $("#show_less_"+id).show();
      $(this).hide(); 
    });
  };

  var showLess = function(){
    $(document).on('click', '.read-less', function(){
      var id = $(this).attr('id').split("_")[2];
          show_id = "show_" + id;
          position = $("#"+show_id).position();
      $("#"+show_id).css("max-height", 100);
      $("#show_more"+id).show();
      $(this).hide();
      window.scrollTo(position.left, position.top); 
    });
  };

  var warning = function() {
    $(document).on('click', '#warning', function(){
      $('.alert-msg').html('Sign in to read more...');
      timeOut();
    });
  }; 

  replyTextOnClick();
  hide1TextOnClick();
  toAddShowMoreButton();
  showMore();
  showLess();
  warning();    
});

var findId = function(id_initial, id){
  return (id_initial + id.split("_")[1]);
}

var timeOut = function(){
  setTimeout(function(){
    $('.notice').html('');
  }, 4000);
}

var toAddShowMoreButton = function(){
  var content = $('.show-less-content');
  for (var i = 0; i < content.length; ++i) {
    var id = $(content[i]).attr('id').split('_')[1];
        scrollHeight = content[i].scrollHeight;
        clientHeight = content[i].clientHeight;
    if( scrollHeight > clientHeight){
      $("#show_more"+id).show();
    }
  }
}

timeOut();  