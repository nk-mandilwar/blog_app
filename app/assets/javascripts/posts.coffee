$(document).ready ->
	$('.reply').on 'click', ->
		reply_id = $(this).attr('id')
		id_arr = reply_id.split "_"
		comment_div_id = "#comment_" + id_arr[1]
		$(comment_div_id).toggle()
	