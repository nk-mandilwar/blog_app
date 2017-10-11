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
//= require jquery.infinite-pages
//= require social-share-button
//= require_tree .

$(document).ready(function() {
  toAddShowMoreButton();
  subscribeButtonOnClick();
  $(document).scroll(function(){
    findPostionOfInfiniteScrolling();
  });
  timeOut();
});

var timeOut = function(){
  setTimeout(function(){
    $('.notice').html('');
  }, 4000);
};

var subscribeButtonOnClick = function(){
  $(document).on('click', '.subscriber-button', function(){
    $('.subscribe').hide();
    $('.subscriber-form').show();
  });
};

var findPostionOfInfiniteScrolling = function(){
  var $myElt       = $('#infinite_scrolling');
      $window      = $(window);
      myTop        = $myElt.offset().top;
      windowTop    = $window.scrollTop();
      windowBottom = windowTop + $window.height();
  if (myTop > windowTop && myTop < windowBottom) {
    $('#link_to_next_page').trigger('click');
  }
};
