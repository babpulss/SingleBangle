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

//	$('*').mouse_wheel();

	$("#dropdown").on("click", () => {
		$(".dropmenu").toggle("slow");
	})


//	var typingIdx=0; 
//	var liIndex = 0;
//	var liLength = $("#typing-txt>ul>li").length;

//	// 타이핑될 텍스트를 가져온다 
//	var typingTxt = $("#typing-txt>ul>li").eq(liIndex).text(); 
//	//liIndex 인덱스로 구분해 한줄씩 가져옴

//	typingTxt=typingTxt.split(""); // 한글자씩 잘라 배열로만든다

//	var tyInt = setInterval(typing,300); // 반복동작 

//	function typing(){ 
//	$(".typing ul li").removeClass("on");
//	$(".typing ul li").eq(liIndex).addClass("on");
//	//현재 타이핑되는 문장에만 커서 애니메이션을 넣어준다.

//	if(typingIdx<typingTxt.length){ // 타이핑될 텍스트 길이만큼 반복 
//	$(".typing ul li").eq(liIndex).append(typingTxt[typingIdx]); // 한글자씩 이어준다. 
//	typingIdx++; 
//	} else{ //한문장이끝나면
//	if(liIndex<liLength-1){
//	//다음문장으로  가기위해 인덱스를 1증가
//	liIndex++; 
//	//다음문장을 타이핑하기위한 셋팅
//	typingIdx=0;
//	typingTxt = $("#typing-txt>ul>li").eq(liIndex).text(); 

//	//다음문장 타이핑전 1초 쉰다
//	clearInterval(tyInt);
//	//타이핑종료

//	tyInt = setInterval(typing,300);

//	}
//	} 
//	}  
	var typingBool = false; 
	var typingBool1 =false;
	var typingIdx=0; 
	var liIndex = 0;
	var liIndex2 = 0;
	var liLength = $(".typing-txt1>ul>li").length;
	var liLength2 = $(".typing-txt2>ul>li").length;
	var del = -1;
	var repeatInt= null;
	var tyInt = null;

	// 타이핑될 텍스트를 가져온다 
	var typingTxt = $(".typing-txt1>ul>li").eq(liIndex).text(); 
	typingTxt=typingTxt.split(""); // 한글자씩 자른다. 

	if(typingBool==false){ 
		// 타이핑이 진행되지 않았다면 
		typingBool=true; 
		tyInt = setInterval(typing,200); // 첫번재 반복동작 
	} 

	function typing(){ 
		if(typingIdx<typingTxt.length){ 

			// 타이핑될 텍스트 길이만큼 반복 
			$(".typing>ul>li").removeClass("on")
			$(".typing ul li").eq(liIndex).addClass("on")
			$(".typing ul li").eq(liIndex).append(typingTxt[typingIdx]); 
			// 한글자씩 이어준다. 
			typingIdx++; 
			if(typingIdx == typingTxt.length){
				if(liIndex==2){
					clearInterval(tyInt) ;
					setTimeout(function(){
						$(".typing>ul>li").removeClass("on")
					},500);
				} else{
					//첫번째 단어가 써지면 1분쉰다.

					clearInterval(tyInt);
					setTimeout(function(){
						tyInt = setInterval(typing,200);
					},200);
				}
			}
		} else{ 
			//한문장이끝나면
			if(liIndex==1 && typingBool1==false){
				if(-typingTxt.length-1 < del ){
					//한글자씩 지운다.
					$(".typing ul li").eq(liIndex).html(typingTxt.slice(0, del))
					del--;
				}else{

					//변수초기화 
					typingIdx=0;
					del= -1;
					typingTxt = $(".typing-txt2>ul>li").eq(liIndex2).text(); 
					liIndex2++;
					if(liIndex2 == liLength2 ){
						typingBool1=true;
					}

					//1분후 다음분장 타이핑 
					clearInterval(tyInt);
					setTimeout(function(){
						tyInt = setInterval(typing,200);
					},200);
				}
			}else{
				typingIdx=0;
				if(liIndex <= liLength-1){
					liIndex++;
				}
				typingTxt = $(".typing-txt1>ul>li").eq(liIndex).text(); 

			}
		} 
	} 

});
