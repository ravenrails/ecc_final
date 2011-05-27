var defaultMsgDiv = 'msg_div';
var defaultErr = 'Error occured while processing request. Please contact the administrator.';

$.extend({
	Msgs: function(ndx, a, b) {
		var msgs = new Array();
		a = a || 'This field';
		b = b || '';

		msgs['required'] = a + ' is required.';
		msgs['unique'] = a + ' must contain a unique value.';
		msgs['match'] = a + ' does not match ' + b + '.';
		msgs['validDate'] = a + ' must contain a valid date.';
		msgs['dateFormat'] = a + ' must be in ' + b + ' format';
		msgs['validEmail'] = a + ' must contain a valid email address.';
		msgs['minLength'] = a + ' must be at least ' + b + ' characters in length.';
		msgs['maxLength'] = a + ' cannot exceed ' + b + ' characters in length.';
		msgs['exactLength'] = a + ' must be exactly ' + b + ' characters in length.';
		msgs['max'] = a + ' cannot be more than ' + b + '.';
		msgs['min'] = a + ' cannot be less than ' + b + '.';
		msgs['integer'] = a + ' must be an integer.';
		msgs['decimal'] = a + ' must contain a decimal number.';
		msgs['image'] = a + ' must be an image.';
		msgs['afterDate'] = a + ' must be after ' + b + '.';
		msgs['validUrl'] = a + ' must contain a valid URL.';

		return msgs[ndx];
	},

	/**
	 * Generic dialog boxes
	 */
	genericDialog: function(div, callback) {
		$('#' + div).dialog({
			resizable: false,
			height: 'auto',
			modal: true,
			buttons: {
				'No': function() {
					$(this).dialog('close');
				},
				'Yes': function() {
					eval(callback);
					$(this).dialog('close');
				}
			},
			close: function() {
				$(this).dialog('destroy');
				$('#' + div).addClass('hidden');

			}
		}).removeClass('hidden');
	},

	confirmDelete: function(url, title, callback, div) {
		div = div || 'ddelete';
		title = title || '';
    callback = callback || 'deleteRecord({ title:"' + title + '", url:"' + url + '"})';

		$('#' + div).attr('title', title);
		$.genericDialog(div, callback);
	},

	loading: function(title) {
		$('#dloading').removeClass('hidden');
		$('#dfinished').addClass('hidden');

		$('#dprocessing').dialog({
			resizable: false,
			closeOnEscape: false,
			height: 170,
      title: title,
			modal: true,
			open: function() {
				$('a.ui-dialog-titlebar-close').addClass('hidden');
			},
			close: function() {
				$(this).dialog('destroy');
				$('#dprocessing').addClass('hidden');
			}
		}).removeClass('hidden');
	},

	finished: function(html, iconClass, callback) {
		callback = callback || null;

		$('#dprocessing').dialog('option', 'buttons', {
			'Close': function() {
				if (callback != null) eval(callback);
				$(this).dialog('close');
			}
		});

		$('#dloading').addClass('hidden');
		$('#ficon').addClass(iconClass);
		$('#fmsg').html(html);
		$('#dfinished').removeClass('hidden');
	}
});

