<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Photogram</title>
    <!-- Style -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/profile.css">
    <!-- Fontawesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@100;200;300;400;500;600;700&display=swap" 
    	  rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>

<body>

    <header class="header">
        <div class="container">
            <a href="/image/feed" class="logo"><img src="${pageContext.request.contextPath}/resources/images/logo.png" alt=""></a><!-- 로고 -->
            <nav class="navi">
                <ul class="navi-list">
                    <li class="navi-item"><a href="/image/feed"><i class="fas fa-home"></i></a></li><!-- 메인페이지로 이동하는 버튼 -->
                    <li class="navi-item"><a href="/image/explore"><i class="far fa-compass"></i></a></li><!-- 인기게시물 페이지로 이동하는 버튼 -->
                    <li class="navi-item"><a id="profile_page" href="#"><i class="far fa-user"></i></a></li><!-- 자신의 프로필 페이지로 이동하는 버튼 -->
                    <li class="navi-item"><a class="modi" data-toggle="modal" href="#myModal4"><i class="fas fa-cog"></i></a></li><!-- 로그인 /로그아웃 모달창을 띄우는 버튼 -->
                </ul>
            </nav>
        </div>
    </header>
	<script>//프로필로 이동할때 로그인 되어있는 상태여야만 본인의 프로필로 갈수 있음
		$('#profile_page').click(function(){
			var checklogin = "${login.user_id}";
			console.log(checklogin);
			if(checklogin !== ""){
				location.href="/user/profile?user_id="+checklogin;
			}
			else{
				alert('로그인을 해주세요')
				location.href="/login";
			}
		});
	</script>
    <section class="profile">
        <div class="container">
            <div class="profile-left">
                <div class="profile-img-wrap story-border" onclick="popup('.modal-image')">
                	<a data-toggle="modal" href="#myModal"><!-- 유저의 프로필을 클릭하면 프로필 변경할 수 있는 모달창을 띄움 -->
                    	<img src="${user.user_photothumb }"><!-- 유저의 프로필 사진을 출력 -->
	                    <svg viewbox="0 0 110 110"><!-- 사진의 모양 -->
	                        <circle cx="55" cy="55" r="53" />
	                    </svg>
                    </a>
                </div>
            </div>
            
            <div class="profile-right">
                <div class="name-group">
                    <h2>${userid }</h2><!-- 프로필 페이지의 주인의 아이디를 출력 -->
                    <c:set var="logid" value="${login.user_id }"/><!-- 로그인된 유저의 아이디를 세팅 -->
                    <c:set var="pageid" value="${userid }"/><!-- 프로필 페이지의 주인의 아이디를 세팅 -->
                    <c:if test="${logid==pageid}"><!-- 로그인된 유저의 아이디와 프로필 페이지의 주인의 아이디가 같으면 실행 -->
	                    <button class="cta blue" onclick="location.href='/image/upload'">upload</button><!-- 업로드 하는 페이지로 이동하는 버튼 -->
                    </c:if>
                    <c:if test="${logid!=pageid }"><!-- 로그인된 유저의 아이디와 프로필 페이지의 주인의 아이디가 다르면 실행 -->
                    	<c:choose>
                            <c:when test="${result == '0'}"> <!-- '0'이면 follow 안되어 있으면 실행-->
                               <input type="button" id="follow_btn" class="btn btn-outline-secondary" value="follow"><!-- 팔로우 버튼 -->
                            </c:when>
                            <c:otherwise><!-- '0'이 아니면 이미 follow되어있으면 실행 -->
                               <input type="button" id="follow_btn" class="btn btn-outline-secondary" value="follower"><!-- 팔로우 취소 버튼 -->
                            </c:otherwise>
                         </c:choose>   
                    </c:if>
                </div>
                <div class="follow">
                    <ul>
                        <li><p>게시물<span>${content}</span></p> </li><!-- 올린 게시물의 개수 -->
                        <li><a data-toggle="modal" href="#myModal2">팔로워<span>${follower}</span></a></li><!-- 자신을 팔로우한 유저를 카운트, 자신을 팔로우한 유저의 리스트를 가지고 모달창으로 이동 -->
                    	<li><a data-toggle="modal" href="#myModal3">팔로우<span>${follow}</span></a></li><!-- 자신이 팔로우한 유저를 카운트, 자신이 팔로우한 유저의 리스트를 가지고 모달창으로 이동 -->
                    </ul>
                </div>
                
            </div>
        </div>
    </section>
	<script>//팔로우가 되어있으면 팔로우취소로 안되어있으면 팔로우로 되게하는 ajax
		$("#follow_btn").click(function(){
			var follow_id = "${login.user_id}";//로그인 한 유저의 아이디
			var follower_id = "${userid }";//페이지의 주인의 아이디
			console.log(follow_id);
			console.log(follower_id);
			if(follower_id!=""){//로그인이 되어있으면 실행
				if($('#follow_btn').val()=="follow"){//팔로우가 안되어있으면 실행(팔로우)
					$.ajax({
						type:"POST",//post방식
			            url:"/followUpdate",
			            data: {
			            	follow_user : follow_id,
			            	follower_user : follower_id
			            },
			            dataType: "text",
			            success:function(result){//ajax가 성공하면 실행.
			            	location.reload();
			            	alert('팔로우 성공')
			            }
			        });
				}
				else if($('#follow_btn').val()=="follower"){//팔로우가 되어있으면 실행(팔로우 취소)
					$.ajax({
						type:"POST",//post방식
			            url:"/followDelete",
			            data: {
			            	follow_user : follow_id,
			            	follower_user : follower_id
			            },
			            dataType: "text",
			            success:function(result){//ajax가 성공하면 실행.
			            	location.reload();
			            	alert('팔로우 취소');
			            }
			        });
				}
			}
			else{
				alert('로그인을 해주세요')
				location.href="/login";
			}
		});
	</script>
    <div class="gallery">
        <div class="container">
            <div class="controller">      
            </div>
        </div>
    </div>
	<!-- 등록한 사진을 출력하는 foreach문 -->
    <section id="tab-content">
        <div class="container">
            <div id="tab-1-content" class="tab-content-item show">
                <div class="tab-1-content-inner">
                	<c:forEach var="photo" items="${photolist }"><!-- 등록된 사진리스트 -->
	                    <div class="img-box">
	                        <a href=""><img src="${photo.photothumb }"></a><!-- 등록된 사진의 썸네일 -->
	                        <div class="comment">
	                            <a href="#a" class=""><i class="fas fa-heart"></i><span>${photo.photo_like}</span></a><!-- 사진에 마우스를 올리면 그 게시물의 좋아요수를 출력 -->
	                        </div>
	                    </div>
                	</c:forEach>
                </div>
            </div>
        </div>
    </section>
      <footer>
        <div class="container">
            <ul>
	            <li><a href="#a">소개</a></li>
				<li><a href="#a">블로그</a></li>
				<li><a href="#a">채용 정보</a></li>
				<li><a href="#a">도움말</a></li>
				<li><a href="#a">API</a></li>
				<li><a href="#a">개인정보처리방침</a></li>
				<li><a href="#a">약관</a></li>
				<li><a href="#a">인기 계정</a></li>
				<li><a href="#a">해시태그</a></li>
				<li><a href="#a">위치</a></li>
            </ul>
            <div class="copy">
                <p>짤 2021 codechangram from There Programing</p>
            </div>
        </div>
    </footer>
    <!-- profile upload Modal --><!-- 프로필을 변경하는 모달창 -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title" >프로필 변경</h4>
          <button type="button" class="close" data-dismiss="modal">×</button>
        </div>
        <div class="modal-body">
          <form class="upload-form" enctype="multipart/form-data" action="/profileupload"method = "post" id="upload_frm"> <!-- 선택한 프로필을 등록하는 form태그 -->
                <input type="hidden" name="user_id" value="${login.user_id }"><!-- 히든값에 로그인된 유저의 아이디를 담음 -->
				<label for="gdsImg">이미지</label>
				<input type="file" id="gdsImg" name="file" /><!-- 등록할 프로필 사진을 선택하는 버튼 -->
				<div class="select_img"><img src="" /></div><!-- 선택한 이미지를 출력 -->
                <!--사진설명 + 업로드버튼-->
                <!--사진설명end-->
           </form>
        </div>
        <div class="modal-footer">
        	<input type="button" class="cta blue" id="up_btn" value="등록">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
      <!-- follower Modal -->
  <div class="modal fade" id="myModal2" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content--><!-- 자신을 팔로우한 리스트를 출력하는 모달창 -->
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title" >팔로워 리스트</h4>
          <button type="button" class="close" data-dismiss="modal">×</button>
        </div>
        <div class="modal-body">
        	<c:forEach var="follower" items="${followerlist}">
        		<a href="/user/profile?user_id=${follower.follow_user}&follow_user=${login.user_id}"><strong>${follower.follow_user}</strong></a><!-- 자신을 팔로우한 유저 리스트 출력및 선택한 유저의 프로필로 가는 a태그 -->
        		<hr/>
        	</c:forEach>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
      <!-- follow list Modal -->
  <div class="modal fade" id="myModal3" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content--><!-- 자신이 팔로우한 리스트를 출력하는 모달창 -->
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title" >팔로우 리스트</h4>
          <button type="button" class="close" data-dismiss="modal">×</button>
        </div>
        <div class="modal-body">
        	<c:forEach var="follow" items="${followlist}">
        		<a href="/user/profile?user_id=${follow.follower_user}&follow_user=${login.user_id}"><strong>${follow.follower_user}</strong></a><!-- 자신이 팔로우한 유저 리스트 출력및 선택한 유저의 프로필로 가는 a태그 -->
        		<hr/>
        	</c:forEach>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
        <!-- Menu Modal --><!-- 로그아웃 로그인 모달창 -->
  <div class="modal fade" id="myModal4" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title" >메뉴</h4>
          <button type="button" class="close" data-dismiss="modal">×</button>
        </div>
        <div class="modal-body">
         <c:if test="${login.user_id == null }"><!-- 로그인 되어있지 않으면 실행 -->
        	<a href="/login">로그인</a><!-- 로그인 페이지로 이동 -->
        </c:if>
        <c:if test="${login.user_id != null }"><!-- 로그인 되어있으면 실행 -->
        	<a href="/logout">로그아웃</a><!-- 로그아웃 -->
        </c:if>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
<script> /* 선택한 사진을 화면에 띄어줌 */
	$("#gdsImg").change(function(){
		if(this.files && this.files[0]) {
			var reader = new FileReader;
			reader.onload = function(data) {
				$(".select_img img").attr("src", data.target.result).width(300).height(300);        
			}
			reader.readAsDataURL(this.files[0]);
		}
	});
	$('#up_btn').click(function(){
		var louserid = "${login.user_id}";
		var pageuserid = "${userid}";
		if(louserid !=""){
			if(louserid==pageuserid){
				$('#upload_frm').submit();
			}
			else{
				alert('로그인된 유저만 바꿀수 있습니다.')
			}
		}
		else{
			alert('로그인을 해주세요')
		}
	})
</script>
</body>
 
</html>