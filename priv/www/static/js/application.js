(function($) {
	"use strict";

	Kalendae.Input.prototype.defaults.format = "YYYY-MM-DD"; // XXX: hacky!?

	$("[data-popover-content]").each(function() {
		$(this).popover({
			title:  $(this).attr("data-popover-title") || "-",
			content: $(this).attr("data-popover-content") || "-",
			placement: "bottom"
		});
	});

	$("table").on("submit", "form", function(ev) {
		var form = $(this);
		var uri = form.attr("action");
		var data = $(this).serialize();
		var id = form.closest("tr").attr("id");
		if(!id) {
			return true;
		}
		var button = $("input[type=submit]", form).prop("disabled", true);
		$.post(uri, data, function(html, status, xhr) {
			var selector = "#" + id;
			var item = $(html).find(selector);
			$(selector).replaceWith(item);
			button.prop("disabled", false); // not actually necessary due to replacement
		});
		ev.preventDefault();
	});

}(jQuery));
