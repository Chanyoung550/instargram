<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>

<main class="main">
	<section class="container">
		<!--전체 리스트 시작-->
			<article class="story-list" id="feed_list">
					<c:if test="${photocnt==0}">
						<div style="text-align:center;">
							<h1><strong>등록된 게시물이 없습니다.</strong></h1><br/>
							<h3><a href="/image/upload">(게시물 등록하기)</a></h3>
						</div>
					</c:if>
				<c:forEach var="photo" items="${photo}" varStatus="i"><!-- 로그인한 유저가 팔로우한 게시글을 등록한 순서대로 출력 -->
					<div class="story-list__item">
						<!--리스트 아이템 헤더영역-->
						<div class="sl__item__header">
							<a href="/user/profile?user_id=${photo.photo_id}&follow_user=${login.user_id}"  style="float:left;"><!-- 사진을 클릭하면 게시물을 올린 유저의 프로필로 이동 -->
								<div><img src="${photo.user_photothumb }" id="photo_url${i.getIndex() }"/><svg viewbox="0 0 110 110"><circle cx="55" cy="55" r="53" /></svg></div><!-- 게시물을 등록한 유저의 프로필사진을 출력 -->
							</a>
							<a href="/user/profile?user_id=${photo.photo_id}&follow_user=${login.user_id}"  style="float:left;"><!-- 아이디를 클릭하면 게시물을 올린 유저의 프로필로 이동 -->
								<strong><span style="margin-left:10px;">${photo.photo_id}</span></strong><!-- 게시물을 등록한 유저의 아이디 -->
							</a>
						</div>
						<!--헤더영역 end-->
						<!--게시물이미지 영역-->
						<div class="sl__item__img">
							<img src="${photo.photothumb}" /><!-- 등록한 게시물의 사진을 출력 -->
						</div>
						<!--게시물 내용 + 댓글 영역-->
						<div class="sl__item__contents">
							<!-- 하트모양 버튼 박스 -->
							<c:forEach var="like" items="${result}"><!-- 좋아요를 눌렀는지 확인하는 foreach문 -->
							<c:set var="lpno" value="${like.pno }"/><!-- likey 테이블에서 가져온 게시물번호 -->
							<c:set var="ppno" value="${photo.pno }"/><!-- photo 테이블에서 가져온 게시물 번호 -->
								<c:if test="${lpno==ppno}"><!-- likey테이블에서 가져온 게시물번호와 photo테이블에서 가져온 게시물번호가 같으면 실행 -->
									<div class="sl__item__contents__icon" >
										<c:choose>
                                    		<c:when test="${like.likecnt==0}"><!-- 좋아요가 카운트되지 않으면 실행 -->
											<button><i class="far fa-heart" id="like_icon${i.getIndex()}"></i></button><!-- 좋아요 버튼 -->
										</c:when>
                                    	<c:otherwise><!-- 좋아요가 카운트되면 실행 -->
											<button><i class="fas fa-heart active" id="like_icon2${i.getIndex()}"></i></button><!-- 좋아요 취소 버튼 -->
										</c:otherwise>
										</c:choose>  
									</div>
								</c:if>
							</c:forEach>
							<!-- 하트모양 버튼 박스 end -->
							<!--좋아요-->
							<span class="like"><b id="like_count">${photo.photo_like}</b>likes</span><!-- 누적 좋아요 수를 출력 -->
							<!--좋아요end-->
							<script>
								$('#like_icon${i.getIndex()}').click(function(){//좋아요버튼을 누르면 실행되는 ajax
									var like_user="${login.user_id}";
									var pno = ${photo.pno};
									if(like_user!="" || like_user!=null){//로그인이 되어있으면 실행
										$.ajax({
											type:"POST",//post방식
											url:"/likeupdate",
											data: {
												like_user : like_user,//로그인되 유저의 아이디
												pno : pno//게시물의 번호
											},
											dataType:"text",
											success:function(result){//ajax가 성공하면 실행
												location.reload();//reload
											}
										});
									}
									else{//로그인이 되어있지 않으면 실행
										alert('로그인해주세요');
										location.href="/login";
									}
								});
								$('#like_icon2${i.getIndex()}').click(function(){//좋아요 취소 버튼을 누르면 실행되는 ajax
									var like_user="${login.user_id}";
									var pno = ${photo.pno};
									if(like_user!="" || like_user!=null){//로그인이 되어있으면 실행
										$.ajax({
											type:"POST",//post방식
											url:"/likedelete",
											data: {
												like_user : like_user,//로그인되 유저의 아이디
												pno : pno//게시물의 번호
											},
											dataType:"text",
											success:function(result){//ajax가 성공하면 실행
												location.reload();//reload
											}
										});
									}
									else{//로그인이 되어있지 않으면 실행
										alert('로그인해주세요');
										location.href="/login";
									}
								});
							</script>
							<!--게시글내용-->
							<div class="sl__item__contents__content">
								<p>${photo.photo_content}</p><!-- 게시물에 등록한 content를 출력 -->
							</div>
							<!--게시글내용end-->
							
							<!-- 댓글 들어오는 박스 -->
					  		<c:forEach var="com" items="${comment}" varStatus="c"><!-- 메인에 출력되는 게시물의 댓글리스트를 돌리는foreach문 -->
					  			<input type="hidden" name="rno" id="cno${c.getIndex()}" value="${com.cno }"><!-- 댓글의 번호를 히든에 담음 -->
								<div id="comment-list">
						  			<div class="sl__item__contents__comment" id="comment">
							  			<c:set var="compno" value="${com.pno}"/><!-- comment 테이블의 게시물 번호를 세팅 -->
							  			<c:set var="pno" value="${photo.pno}"/><!-- photo테이블의 게시물 번호를 세팅 -->
						  					<c:if test="${compno==pno}"><!-- comment테이블의 게시물번호와 photo테이블의 게시물번호가 일치하면 실행 -->
											    <p><b>${com.comment_user } :</b>${com.comment_content }</p><!-- 댓글을 쓴 유저의 아이디와 댓글을 출력 -->
											    <c:set var="loginid" value="${login.user_id }"/><!-- 로그인 유저아이디를 세팅 -->
											    <c:set var="comid" value="${com.comment_user}"/><!-- comment테이블의 유저 아이디를 세팅 -->
											    <c:if test="${loginid == comid}"><!-- 로그인된 유저아이디와 comment테이블의 유저아이디가 같으면 실행 -->
								  			    	<button ><i class="fas fa-times" id="comment_delete${c.getIndex() }"></i></button><!-- 댓글 삭제 버튼 -->
											    </c:if>
											</c:if>
									 </div>
								</div>
								<script>
									$('#comment_delete${c.getIndex() }').click(function(){//댓글삭제 ajax
										var comment_user = "${login.user_id}";//로그인된 유저아이디
										var cno = parseInt($('#cno${c.getIndex()}').val());//삭제하려는 댓글의 번호
										if(comment_user!="" || comment_user!=null){//로그인이 되어있으면 실행
											$.ajax({
												type:"POST",//post방식
												url:"/commnetdelete",
												data: {
													cno : cno
												},
												dataType:"text",
												success:function(result){//ajax가 성공하면 실행
													location.reload();//reload
												}
											});
										}
										else{//로그인이 되어있지 않으면 실행
											alert('로그인해주세요');
											location.href="/login";//로그인 페이지로 이동
										}
									});
								</script>
							</c:forEach>
							<!-- 댓글 들어오는 박스end -->
							<!--댓글입력박스-->
							<div class="sl__item__input">
								<input type="hidden" name="" id="pno${i.getIndex() }" value="${photo.pno}"><!-- 게시물의 번호 -->
								<input type="text" placeholder="댓글 달기..." id="comment_text${i.getIndex() }"><!-- 댓글을 쓰는 텍스트창 -->
								<button type="button"  id="comment_btn${i.getIndex() }">게시</button><!-- 댓글등록 버튼 -->
							</div>
							<!--댓글달기박스end-->
						</div>
					</div>
					<script>
						$('#comment_btn${i.getIndex() }').click(function(){//댓글 등록버튼 ajax
							var comment_user = "${login.user_id}";//로그인된 유저의 아이디
							var comment_content = $('#comment_text${i.getIndex() }').val();//텍스트에 입력된 댓글
							var pno = parseInt($('#pno${i.getIndex() }').val());//게시물의 번호
							if(comment_user!=""){//로그인 되어있으면 실행
								$.ajax({
									type:"POST",//post방식
									url:"/commnetwrite",
									data: {
										comment_user : comment_user,
										comment_content : comment_content,
										pno : pno
									},
									dataType:"text",
									success:function(result){//ajax가 성공하면 실행
										location.reload();//reload
									}
								});
							}
							else{//로그인이 되어있지 않으면 실행
								alert('로그인해주세요');
								location.href="/login";
							}
						});
						
					</script>
				</c:forEach>
			</article>
	</section>
</main>
</body>
</html>