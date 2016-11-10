var replyTextOnClick = function(){
  $(document).on('click', '.reply', function(){
    var comment_id = findId("#comment_", $(this).attr('id'));
        hide_id = findId("#hide_", $(this).attr('id'));
    $(comment_id).toggle();
    $(this).hide();
    $(hide_id).show();
  });
};

var hiddenTextOnClick = function(){
  $(document).on('click', '.no-display', function() {
    var comment_id = findId("#comment_", $(this).attr('id'));
        reply_id = findId("#reply_", $(this).attr('id'));
    $(comment_id).toggle();
    $(this).hide();
    $(reply_id).show();
  });
};

var findId = function(id_initial, id){
  return (id_initial + id.split("_")[1]);
}

replyTextOnClick();
hiddenTextOnClick();