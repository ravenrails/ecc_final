$(document).ready(function() {

  // Set buttons UI
  $("[id$='_submit'], .button").button();

})

function deleteRecord(params)
{
  $.loading(params.title);

	$.ajax({
		url: params.url,
		type: 'POST',
		data: $('#auth-form').serialize() + '&_method=DELETE',
		dataType: 'js',
    complete: function(xhr) {
      $.finished('Record Deleted');
      $('#row-' + xhr.responseText).fadeOut();
    }
	});
}
