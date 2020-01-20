$(document).ready(function() { 

//	왼쪽 메뉴 토글
	$("#nav").on("click", function(e) {
		if ($("#rightSidebar")[0].style.display == "block") {
			$("#rightSidebar").delay(500);
			$("#rightSidebar")[0].style.display == "";
			$("#nav").removeClass("changeNav");
		}
		if ($("#sidebar").css("display") == "none") {
			$("#sidebar").fadeIn(500);
			$("#sidebar").css("position", "fixed");
			$("#nav").addClass("changeNav");
		} else {
			$("#sidebar").fadeOut(500);
			$("#nav").removeClass("changeNav");
		}
	});

//	오른쪽 메뉴 토글
	$("#rightLogin").on("click", function() {
		if ($("#sidebar")[0].style.display == "block") {
			$("#sidebar").delay(500);
			$("#sidebar")[0].style.display == "";
		}
		if ($("#rightSidebar").css("display") == "none") {
			$("#rightSidebar").fadeIn(500);
			$("#rightSidebar").css("position", "fixed");
		} else {
			$("#rightSidebar").fadeOut(500);
		}
	});

//	외부를 클릭했을 경우 메뉴 닫힘
	$(this).on("click", e => {
		if (!$(e.target).hasClass("sidebar")) {
			$("#sidebar").fadeOut(500);
			$("#sidebar")[0].style.display = "";
			$("#nav").removeClass("changeNav");
		}
		if (!$(e.target).hasClass("rightSidebar")) {
			$("#rightSidebar").fadeOut(500);
			$("#rightSidebar")[0].style.display = "";
		}
	});

	$.fn.extend({
		mouse_wheel: function () {
			$(this).on('mousewheel', function(e) {
				if (e.originalEvent.wheelDelta >= 120) {
					if ($("#rightSidebar")[0].style.display == "block" && $("#sidebar")[0].style.display == "") {
						$("#rightSidebar").scrollTop($("#rightSidebar").scrollTop() -50);
					} else if ($("#sidebar")[0].style.display == "block" && $("#rightSidebar")[0].style.display == "") {
						$("#sidebar").scrollTop($("#sidebar").scrollTop() -50);
					} else {
						$('html').scrollTop($('html').scrollTop() - 50);
					}
				} else if (e.originalEvent.wheelDelta <= -120) {
					if ($("#rightSidebar")[0].style.display == "block" && $("#sidebar")[0].style.display == "") {
						$("#rightSidebar").scrollTop($("#rightSidebar").scrollTop() + 50);
					} else if ($("#sidebar")[0].style.display == "block" && $("#rightSidebar")[0].style.display == "") {
						$("#sidebar").scrollTop($("#sidebar").scrollTop() + 50);
					} else {
						$("html").scrollTop($("html").scrollTop() + 50);
					} 
				}
				return false;
			});
		},
	});

	$('*').mouse_wheel();
});
