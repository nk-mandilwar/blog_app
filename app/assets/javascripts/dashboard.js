var toAddShowMoreButton = function(){
  var content = $('.show-less-content');
  for (var i = 0; i < content.length; ++i) {
    var id = $(content[i]).attr('id').split('_')[1];
        scrollHeight = content[i].scrollHeight;
        clientHeight = content[i].clientHeight;
    if( scrollHeight > clientHeight){
      $("#show_more_"+id).show();
    }
  }
};

var showMore = function(){
  $(document).on('click', '.show-more', function(){
    var id = $(this).attr('id').split("_")[2];
        show_id = "show_" + id;
    $("#"+show_id).css("max-height", document.getElementById(show_id).scrollHeight);
    $("#show_less_"+id).show();
    $(this).hide();
  });
};

var showLess = function(){
  $(document).on('click', '.read-less', function(){
    var id = $(this).attr('id').split("_")[2];
        show_id = "#show_" + id;
        position = $(show_id).position();
    $(show_id).css("max-height", 100);
    $("#show_more_"+id).show();
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

showMore();
showLess();
warning();
