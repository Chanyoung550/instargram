<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>

<!--인기 게시글-->
<main class="popular">
	<div class="exploreContainer">

		<!--인기게시글 갤러리(GRID배치)-->
		<div class="popular-gallery">
			<c:forEach var="photo" items="${photo}">
				<div class="p-img-box">
					<a href="/user/profile?user_id=${photo.photo_id}&follow_user=${login.user_id}"> <img src="${photo.photothumb}" alt=""><!-- 인기 게시글의 사진 출력 및 사진을 올린사람의 프로필로 이동하는 a태그 -->
					</a>
				</div>
			</c:forEach>
		</div>
	</div>
</main>
<%@ include file="../layout/footer.jsp"%>