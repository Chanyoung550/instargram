<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%> --%>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal" />
</sec:authorize>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Photogram</title>

<!-- jquery -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- Style -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources//css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources//css/feed.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources//css/explore.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources//css/profile.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources//css/upload.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources//css/profileSetting.css">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources//images/insta.svg">

<!-- Fontawesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<!-- Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@100;200;300;400;500;600;700&display=swap" rel="stylesheet">

</head>

<body>
	<input type="hidden" id="principal-id" value="${principal.user.id}"/>
	<input type="hidden" id="principal-username" value="${principal.user.username}"/>
	
	<header class="header">
		<div class="container">
			<a href="/image/feed" class="logo">
				<img src="${pageContext.request.contextPath}/resources/images/logo.png">
			</a>
			<nav class="navi">
				<ul class="navi-list">
					<li class="navi-item">
						<a href="/image/feed"><!-- 메인페이지로 이동하는 a태그 -->
							<i class="fas fa-home"></i><!-- 메인페이지 이미지 -->
						</a>
					</li>
					<li class="navi-item">
						<a href="/image/explore"><!-- 종아요 순으로 게시글이 나오는 페이지로 이동하는 a태그 -->
							<i class="far fa-compass"></i><!-- 좋아요 페이지 이미지 -->
						</a>
					</li>
					<li class="navi-item" >
						<a id="profile_page" href="#" ><!-- 자신의 프로필 페이지로 이동하는 a태그 -->
							<i class="far fa-user"></i><!-- 프로필 페이지 이미지 -->
						</a>
					</li>
					<li class="navi-item">
						<a class="modi" data-toggle="modal" href="#myModal4"><!-- 로그아웃 모달창을 띄우는 a태그 -->
							<i class="fas fa-cog"></i><!-- 환경설정 이미지 -->
						</a>
					</li>
				</ul>
				<script>//프로필로 이동할때 로그인 되어있는 상태여야만 본인의 프로필로 갈수 있음
					$('#profile_page').click(function(){
						var checklogin = "${login.user_id}";
						console.log(checklogin);
						if(checklogin !== ""){//세션에 로그인이 되어있는지 확인
							location.href="/user/profile?user_id="+checklogin;//로그인이 되어있는 프로필 페이지로 이동
						}
						else{
							alert('로그인을 해주세요')
							location.href="/login";//로그인이 되어있지 않으면 로그인 페이지로 이동
						}
					});
				</script>
			</nav>
		</div>
	</header>
	
	        <!-- Menu Modal -->
  <div class="modal fade" id="myModal4" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title" >메뉴</h4>
          <button type="button" class="close" data-dismiss="modal">×</button>
        </div>
        <div class="modal-body">
        <c:if test="${login.user_id == null }"><!-- 로그인이 되어있지 않으면 로그인페이지로 이동하는 a태그 출력 -->
        	<a href="/login">로그인</a>
        </c:if>
        <c:if test="${login.user_id != null }"><!-- 로그인이 되어있으면 로그아웃하는  a태그 출력 -->
        	<a href="/logout">로그아웃</a>
        </c:if>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>