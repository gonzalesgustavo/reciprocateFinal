$(document).ready(function(){
	$('#users-search #term').on('keyup', function(){
		const jqxhr = $.get(
			$('#users-search').attr("action"),
			{term: $('#users-search #term').val()},
			function(){
				let result = $("#user-result").html();
				if(!result){
					$("#users-search #term").popover({
						content: "no results found",
						placement: "bottom",
						html: true,
						trigger: "focus"
					});
				} else{
					$("#users-search #term").popover({
						content: $("#user-result"),
						placement: "bottom",
						html: true,
						trigger: "focus"
					});
				}
				$("#users-search #term").popover("show");
			}/*end of */
		);
	});
});