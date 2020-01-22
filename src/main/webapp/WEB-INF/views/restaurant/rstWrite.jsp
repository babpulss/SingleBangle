<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" 
			integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" 
			crossorigin="anonymous">
		
		<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" 
			integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" 
			crossorigin="anonymous"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" 
			integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" 
			crossorigin="anonymous"></script>
	
		<title>혼밥/혼술 글 작성</title>
        <style>
            *{
                box-sizing: border-box;
            }
            #frmContainer, #btnContainer{
                width: 500px;
                margin: auto;
            }
            
            #titleArea{
                padding: 0px;
            }
            #title{
                border: 1px solid #dadada;
                background-color: #f7f7f7;
                width: 100%;
                height: 40px;
                font-size: 18px;
            }

            .writeBox{
                border: 1px solid #b2b2b2;
                margin-bottom: 40px;
            }
            
            .removeArea{
                text-align: right;
                padding: 0px;
            }
            .removeBtn{
                border: none;
                cursor: pointer;
                color: #e05252;
                background-color: white;
                line-height: 20px;
                font-size: 30px;
            }

            .filesArea{
                text-align: center;
            }
            .filesLabel{
                border: 2px dashed #0085cb;
                border-radius: 5px;
                cursor: pointer;
                color: #0085cb;
                background-color: white;
                width: 100px;
                line-height: 50px;
                margin-bottom: 25px;
            }
            .filesLabel:hover{
                background-color: #cceeff;
            }

            .imgArea{
                border-top: 1px dashed #b2b2b2;
                border-bottom: 1px dashed #b2b2b2;
                height: 405px;
                line-height: 400px;
                text-align: center;
                padding: 0px;
                margin-bottom: 30px;
            }
            .imgs{
            	max-width: 400px;
            	max-height: 400px;
            }

            .contentsArea{
                padding: 0px;
            }
            .contentsLabel{
                font-size: 12px;
                margin-bottom: 0px;
            }
            .contentsTmp{
                border: 1px solid #dadada;
                background-color: #f7f7f7;
                width: 100%;
                height: 100px;
                overflow-y: scroll;
            }
            .contents{
                width: 100%;
                resize: none;
            }

            #addArea{
                text-align: center;
            }
            #addBtn{
                border: 2px dashed #0085cb;
                border-radius: 5px;
                cursor: pointer;
                color: #0085cb;
                background-color: white;
                width: 200px;
                height: 100px;
                font-size: 30px;
            }
            #addBtn:hover{
                background-color: #cceeff;
            }
            
            #submitArea{
                text-align: center;
            }
            .btns{
                border: none;
                border-radius: 5px;
                cursor: pointer;
                color: white;
                background-color: #0085cb;
                width: 100px;
                height: 40px;
                font-size: 16px;
            }
            #cancelBtn{
                background-color: #e05252;
            }
        </style>
    </head>
    <body>
    	<c:choose>
            <c:when test="${loginInfo==null}">
                <script>
                    alert("로그인 후 이용하실 수 있습니다.");
                    location.href="${pageContext.request.contextPath}/member/login.mem";
                </script>		
            </c:when>
		</c:choose>
    
        <br><br><br>
        <form action="${pageContext.request.contextPath}/restaurant/rstWriteProc.rst" method="post" id="frm" enctype="multipart/form-data" onsubmit="return validCheck()">
           
            <div id="frmContainer">
                <div class="container" id="titleBox">
                    <div class="row">
                        <div class="col-12" id="titleArea">
                            <input type="text" id="title" name="title" placeholder=" 제목" >
                        </div>
                    </div>
                </div>
                <br>

                <div class="container writeBox">
                    <br>
                    <div class="row">
                        <div class="col-12 filesArea">
                            <label class="filesLabel">사진 선택</label>
                            <input type="file" class="files" name="files" hidden>
                        </div>
                        <div class="col-12 imgArea">
                            <img src="" alt="" class="imgs">
                        </div>
                        <div class="col-12 contentsArea">
                            <label class="contentsLabel"><b>사진에 대한 설명을 작성하세요. (생략 가능)</b></label>
                            <div class="contentsTmp" contenteditable="true"></div>
                            <textarea class="contents" name="contents" placeholder=" 내용" hidden></textarea>
                        </div>
                    </div>
                </div>
            </div>

            <div id="btnContainer">
                <div class="container" id="addBox">
                    <div class="row">
                        <div class="col-12" id="addArea">
                            <button type="button" id="addBtn">추가 입력</button>
                        </div>
                    </div>
                </div>
                <hr>

                <div class="container" id="submitBox">
                    <div class="row">
                        <div class="col-12" id="submitArea">
                            <input type="submit" class="btns" id="submitBtn" value="작성">
                            <button type="button" class="btns" id="cancelBtn">취소</button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
        <br><br><br>

        <script>
            // 라벨을 클릭하면 숨겨진 input[type="file"]이 클릭되게 하는 함수
            $("#frmContainer").on("click", ".filesLabel", function(){
                var labelNum = $(".filesLabel").index(this);
                console.log("라벨 번호 : " + labelNum);
                $($(".files")[labelNum]).click();
//                $($(this).parent().children(".files")[labelNum]).click();
            })



//            var selectedFile;  // 선택된 파일 정보를 알기 위한 변수???
            $("#frmContainer").on("change", ".files", handleImg);

            // input[type="file"]에 선택된 사진을 미리 볼 수 있게 해주는 함수
            function handleImg(e){
                var filesNum = $(".files").index(this);
                console.log("폼 번호 : " + filesNum);

                var files = e.target.files;
                var filesArr = Array.prototype.slice.call(files);

                filesArr.forEach(function(f){
                    if(!f.type.match("image.*")){
                        alert("이미지 확장자만 가능합니다.");
                        return;
                    }

//                    selectedFile = f;
//                    console.log("선택된 파일 정보 : " + selectedFile);

                    var reader = new FileReader();
                    reader.onload = function(e){
                        $($(".imgs")[filesNum]).attr("src", e.target.result);
                    }
                    reader.readAsDataURL(f);
                })
            }



            // 업로드하는 사진의 크기를 조정해주는 함수
            /* $("img").each(function(){
                $(this).on("load", function(){
                    var imgWidth = this.naturalWidth;
                    var imgHeight = this.naturalHeight;
                    console.log("사진의 가로 길이 : " + imgWidth);
                    console.log("사진의 세로 길이 : " + imgHeight);
                    console.log("");

                    $(this).css("width", "");
                    $(this).css("height", "");

                    if(imgWidth < 400 && imgHeight < 400){
                        return;
                    }
                    else{
                        if(imgWidth > imgHeight){
                            $(this).css("width", "400px");
                        }
                        else{
                            $(this).css("height", "400px");
                        }
                    }
                })
            }) */


            
            // 동적으로 입력 양식을 추가해주는 함수
            $("#addBtn").on("click", function(){
                $("#frmContainer").append('<div class="container writeBox">' +
                                                '<div class="row">' + 
                                                    '<div class="col-12 removeArea">' +
                                                        '<button type="button" class="removeBtn">x</button>' +
                                                    '</div>' +
                                                '</div>' +
                                                '<div class="row">' +
                                                    '<div class="col-12 filesArea">' +
                                                        '<label class="filesLabel">사진 선택</label>' +
                                                        '<input type="file" class="files" name="files" hidden>' +
                                                    '</div>' +
                                                    '<div class="col-12 imgArea">' +
                                                        '<img src="" alt="" class="imgs">' +
                                                    '</div>' +
                                                    '<div class="col-12 contentsArea">' +
                                                        '<label class="contentsLabel"><b>사진에 대한 설명을 작성하세요. (생략 가능)</b></label>' +
                                                        '<div class="contentsTmp" contenteditable="true"></div>' +
                                                        '<textarea class="contents" name="contents" placeholder=" 내용" hidden></textarea>' +
                                                    '</div>' +
                                                '</div>' +
                                            '</div>');

                // 업로드하는 사진의 크기를 조정해주는 함수
                // 동적 요소에 포함된 사진에도 적용시키기 위해 append 해주는 함수 내부에 한번 더 정의함
                /* $("img").each(function(){
                    $(this).on("load", function(){
                        var imgWidth = this.naturalWidth;
                        var imgHeight = this.naturalHeight;
                        console.log("사진의 가로 길이 : " + imgWidth);
                        console.log("사진의 세로 길이 : " + imgHeight);
                        console.log("");

                        $(this).css("width", "");
                        $(this).css("height", "");

                        if(imgWidth < 400 && imgHeight < 400){
                            return;
                        }
                        else{
                            if(imgWidth > imgHeight){
                                $(this).css("width", "400px");
                            }
                            else{
                                $(this).css("height", "400px");
                            }
                        }
                    })
                }) */
            })
            
            
            
            // 추가된 폼을 삭제하는 함수
            $("#frmContainer").on("click", ".removeBtn", function(){
                $(this).closest(".writeBox").remove();
            })
            
            
            
            // 사진을 등록했는지 검사하는 함수
            function validCheck(){
                var title = $("#title").val();
            	var boxLength = $(".writeBox").length;
                
                if(title == ""){
                	alert("제목을 입력하세요.");
                	return false;
                }
                
                for(var i = 0; i < boxLength; i++){
                    if($($(".imgs")[i]).attr("src") == ""){
                        alert("입력하지 않은 사진란이 있습니다.");
                        return false;
                    }
                }
                
                for(var i = 0; i < boxLength; i++){
                    $($(".contents")[i]).val($($(".contentsTmp")[i]).html());
                }
                
                return confirm("글을 작성하시겠습니까?");
            }
            
            $("#cancelBtn").on("click", function(){
                var cancelConfirm = confirm("글 작성을 취소하시겠습니까?");
                
                if(cancelConfirm == true){
                	location.href="${pageContext.request.contextPath}/restaurant/rstList.rst";
                }
            })
        </script>
    </body>
</html>