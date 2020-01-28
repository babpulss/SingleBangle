<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link rel="stylesheet" href="/css/nav.css">
<link rel="stylesheet" href="/css/footer.css">

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-serialize-object/2.5.0/jquery.serialize-object.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<style>
.hidden {
	display: none;
	width: 0px;
}

.image-upload-wrap {
	margin-top: 20px;
	border: 4px dashed #1FB264;
	position: relative;
}

.image-dropping, .image-upload-wrap:hover {
	background-color: #1FB264;
	border: 4px dashed #ffffff;
}

.file-upload-content {
	display: none;
	text-align: center;
}

.file-upload-input {
	position: absolute;
	margin: 0;
	padding: 0;
	width: 100%;
	height: 100%;
	outline: none;
	opacity: 0;
	cursor: pointer;
}
</style>
<script>
        var div =
        	"<div class='contentInput'>               			<div class='btnDel col-sm-push-9'>              			<button type='button' class='btn btn-danger' onclick='deleteContents(this)'>삭제</button>  			</div>                 <div class='form-group hidden'>                   			<label class='form-control-label' for='inputSuccess1'>이미지 제목</label>                			<input type='text' class='form-control imgTitle' name='imgTitle' required>                   			<div class='valid-feedback'>Success! You've done it.</div>                    			<div class='invalid-feedback'>No, you missed this one.</div>                 </div>        			<div class='form-group'>                     <label class='form-control-label' for='inputSuccess2'>이미지</label>    			<div class='imgDiv'>                      			<input type='file' class='form-control' name='img' onchange='readURL(this)' accept='image/jpeg, image/png' required>  			<img class='img-thumbnail' src='#' alt='your image' style='display: none' />                        			<div class='valid-feedback'>Success! You've done it.</div>                        			<div class='invalid-feedback'>No, you missed this one.</div>                     </div>                 </div>                 <div class='form-group hidden'>                  			<label class='form-control-label' for='inputSuccess3'>이미지 설명</label>               			<textarea class='form-control imgContent' name='imgContent' required></textarea>                 			<div class='valid-feedback'>Nice! You got this one!</div>                  			<div class='invalid-feedback'>Sorry, you missed this one.</div>                 </div>      			<hr>             </div> "; 
        	function readURL(input) {
            if (input.files && input.files[0]) {
                var fileType = input.files[0].type;
                var reg = /image\/(png|jpeg|jpg)/;
                if (fileType.match(reg)) {
                    //jpg, png
                    var reader = new FileReader();
                    var img = $(input).next("img");
                    reader.onload = function(e) {
                        $(img).attr('src', e.target.result);
                        $(img).css('display', 'inline');
                        $(input).css('display', 'none');

                        $(input).parent(".imgDiv").parent(".form-group").prev("div").css('display', 'inline'); //이미지 제목
                        $(input).parent(".imgDiv").parent(".form-group").next("div").css('display', 'inline'); //이미지 제목

                        /* $('#image_section').attr('src', e.target.result);
                         $('#dd').css('display', 'none');
                         $('#image_section').css('display', 'block');
                         $(".hidden").css('display', 'inline');*/

                    }
                    reader.readAsDataURL(input.files[0]);
                } else {
                    //이미지 아님
                    alert("jpg, jpeg, png 파일만 등록 가능합니다.")
                    $(input).val("");
                }
            }
        }

        function deleteContents(input) {
            $(input).parent(".btnDel").parent(".contentInput").remove();
        }

        $(function() {
            $("#btnSubmit").click(function(event) {
                var contentsSize = $(".contentInput").length;
               if (contentsSize > 0) {
                    // Fetch form to apply custom Bootstrap validation
                    var form = $("#myForm");
                    if (form[0].checkValidity() === false) {
                        event.preventDefault()
                        event.stopPropagation()
                    }
                    form.addClass('was-validated');
                    // Perform ajax submit here...
                   	//form.submit();
                 } else {
                    alert("작성한 내용이 없습니다. 내용을 추가해주세요.");
                    return false;
                } 

            })

            $("#btnAdd").on("click", function() {
                $("#btnDiv").before(div);
            })
            
            $("#inputTitle").on("input", function() {
			 	var inputTitle = $("#inputTitle").val();
			 	if(inputTitle.length > 50){
			 		alert("제목은 50자 미만으로만 작성 가능합니다.")
			 		$("#inputTitle").val("");
			 	}
			})

			// 내용 길이 유효성 검사
            $(".container").on("input", ".imgTitle", function(){
               var contentsNum = $(".imgTitle").index(this);
               console.log("내용 번호 : " + contentsNum);
               
               var contents = $(this).html();
               var contentsRegex = /^[\w\W]{0,300}$/;
               var contentsResult = contentsRegex.exec(contents);
               
               if(contentsResult != null){
                  $($(".imgTitle")[contentsNum]).html("");
                  validContents = 1;
               }           
            })
        })

    </script>
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
	<jsp:include page="/resources/jsp/nav.jsp" />
	<div id="mainWrapper">
		<form class="container" action="housWriterProc" method="POST"
			id="myForm" enctype="multipart/form-data">
			<div class="contents">
				<div class="form-group">
					<label class="form-control-label" for="inputSuccess3">제목</label> 
					<input id="inputTitle" type="text" class="form-control" name="title" required>
					<div class="valid-feedback">Success! You've done it.</div>
					<div class="invalid-feedback">No, you missed this one.</div>
				</div>
				<hr>
				<div class="contentInput">
					<div class="btnDel col-sm-push-9">
						<button type="button" class="btn btn-danger"
							onclick="deleteContents(this)">삭제</button>
					</div>
					<div class="form-group hidden">
						<label class="form-control-label" for="inputSuccess1">이미지
							제목</label> <input type="text" class="form-control imgTitle" name="imgTitle"
							required>
						<div class="valid-feedback">Success! You've done it.</div>
						<div class="invalid-feedback">No, you missed this one.</div>
					</div>
					<div class="form-group">
						<label class="form-control-label" for="inputSuccess2">이미지</label>
						<div class="imgDiv">
							<input type="file" class="form-control" name="img"
								onchange="readURL(this)" accept="image/jpeg, image/png" required>
							<img class="img-thumbnail" src="#" alt="your image"
								style="display: none" />
							<div class="valid-feedback">Success! You've done it.</div>
							<div class="invalid-feedback">No, you missed this one.</div>
						</div>
					</div>
					<div class="form-group hidden">
						<label class="form-control-label" for="inputSuccess3">이미지
							설명</label>
						<textarea class="form-control imgContent" name="imgContent" required></textarea>
						<div class="valid-feedback">Nice! You got this one!</div>
						<div class="invalid-feedback">Sorry, you missed this one.</div>
					</div>
					<hr>
				</div>
			</div>

			<div id="btnDiv">
				<button type="button" class="btn btn-secondary" id="btnAdd">추가</button>
				<button type="submit" class="btn btn-secondary" id="btnSubmit">Try
					It!</button>
			</div>
		</form>
		<hr>
		<!--    <form class="container">
        <div class="form-group">
            <label class="form-control-label" for="inputSuccess3">Input with <code>is-valid</code></label>
            <input type="text" class="form-control is-valid" id="inputSuccess3">
            <div class="valid-feedback">Success! You've done it.</div>
        </div>
    </form>-->
	</div>
	<jsp:include page="/resources/jsp/footer.jsp" />
</body>

</html>
