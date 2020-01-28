<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.js"></script>
<style>
	.story {
		overflow: hidden;
		text-overflow: ellipsis;
		display: -webkit-box;
		-webkit-line-clamp: 4; /* 라인수 */
		-webkit-box-orient: vertical;
		word-wrap: break-word;
		line-height: 1.2em;
		height: 4.8em;
		/* line-height 가 1.2em 이고 3라인을 자르기 때문에 height는 1.2em * 3 = 3.6em */
	}
	
	.video {
		text-align: center;
	}
</style>
<script type="text/javascript">
	function videoShow(title, videoId) {
		var tag = "#video_" + videoId;
		$(tag).html("");
		$(tag).empty();
		var iframe = "<iframe title='"
				+ title
				+ "'width='640' height='360'src='https://play-tv.kakao.com/embed/player/cliplink/"
				+ videoId
				+ "?service=kakao_tv' allowfullscreen frameborder='0' scrolling='no'allow='autoplay'> </iframe>"
		$(tag).prepend(iframe);
	}

	function videoHide(videoId) {
		var tag = "#video_" + videoId + " iframe";;
		$(tag).html("");
		$(tag).empty();
		$(tag).removeAttr("src");
	}
</script>
</head>
<body>
	<div class="cont"></div>
	<c:forEach items="${list}" var="dto">
		<div class="card mb-3" style="max-width: 540px;">
			<div class="row no-gutters">
				<div class="col-md-4">
					<img src="${dto.img}" class="card-img" alt="...">
				</div>
				<div class="col-md-8">
					<div class="card-body">
						<h5 class="card-title">${dto.title }</h5>
						<p class="card-text story">${dto.story}</p>
						<p class="card-text">
							<font style="color: red;">⭐ ${dto.grade}</font> <small class="text-muted">${dto.releaseDate}
								${dto.rate} </small>
						</p>
						<button type="button" class="btn btn-info"
							onclick="videoShow('${dto.title}', '${dto.videoId}');"
							data-toggle="modal" data-target=".bd-${dto.videoId}-modal-lg">더보기</button>

						<div class="modal fade bd-${dto.videoId}-modal-lg"
							id="staticBackdrop" data-backdrop="static" tabindex="-1"
							role="dialog" aria-labelledby="staticBackdropLabel"
							aria-hidden="true">
							<div class="modal-dialog modal-lg" role="document">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title" id="staticBackdropLabel">${dto.title}</h5>
										<button type="button" class="close"
											onclick="videoHide('${dto.videoId}');" data-dismiss="modal"
											aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
									</div>
									<div class="modal-body">
										<h5>포스터</h5>
										<img src="${dto.img}" alt="${dto.title}">
										<hr>
										<h5>줄거리</h5>
										<p>${dto.story}</p>
										<hr>
										<h5>예고편</h5>
										<div id="video_${dto.videoId}" class="video"></div>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-secondary"
											onclick="videoHide('${dto.videoId}');" data-dismiss="modal">닫기</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</c:forEach>

</body>
</html>