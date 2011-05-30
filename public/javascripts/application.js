$(document).ready(function() {

  // Set buttons UI
  $("[id$='_submit'], .button").button();

})

function deleteRecord(params)
{
  $.loading(params.title);
  auth = '&authenticity_token=' + encodeURI($('[name="csrf-token"]').attr('content'));


	$.ajax({
		url: params.url,
		type: 'POST',
		data: '_method=DELETE' + auth,
		dataType: 'js',
    complete: function(xhr) {
      $.finished('Record Deleted');
      $('#row-' + xhr.responseText).fadeOut();
    }
	});
}
