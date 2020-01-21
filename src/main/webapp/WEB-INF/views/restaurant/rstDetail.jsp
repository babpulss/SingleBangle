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
                border-bottom: 1px solid #dadada;
                width: 100%;
                font-size: 18px;
                padding: 0px;
            }
            #dateArea{
            	width : 100%;
            	text-align: right;
            	font-size: 12px;
            	padding: 0px;
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
            .contents{
                border: 1px solid #dadada;
                background-color: #f7f7f7;
                width: 100%;
                height: 100px;
                overflow-y: scroll;
            }
            
            #btnArea{
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
            #backBtn{
                /* background-color: #e05252; */
            }
        </style>
    </head>
    <body>
        <br><br><br>
        
		<div id="frmContainer">
			<div class="container" id="titleBox">
				<div class="row">
					<div class="col-12" id="titleArea">
						<b>${dto.title}</b>
					</div>
					<div class="col-12" id="dateArea">
						<b>${dto.getFormedDate2()}</b>
					</div>
				</div>
			</div>
			<br>

			<c:choose>
				<c:when test="${filesList.size() > 0}">
					<c:forEach items="${filesList}" var="dto">
					<div class="container writeBox">
						<br>
						<div class="row">
							<div class="col-12 imgArea">
								<img src="/files/${dto.sysName}" alt="" class="imgs">
							</div>
							<div class="col-12 contentsArea">
								<label class="contentsLabel"><b>사진 설명</b></label>
								<div class="contents">${dto.contents}</div>
							</div>
						</div>
					</div>
					</c:forEach>
				</c:when>
			</c:choose>
		</div>

		<div id="btnContainer">
			<hr>
			<div class="container" id="btnBox">
				<div class="row">
					<div class="col-12" id="btnArea">
						<button type="button" class="btns" id="backBtn">돌아가기</button>
					</div>
				</div>
			</div>
		</div>
        <br><br><br>

        <script>
        	console.log("사진 개수 : " + ${filesList.size()});    
        
            $("#backBtn").on("click", function(){
                history.back();
            })
        </script>
    </body>
</html>