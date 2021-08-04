<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	
	<%@ include file="../layout/header.jsp" %>

    <!--사진 업로드페이지 중앙배치-->
        <main class="uploadContainer">
           <!--사진업로드 박스-->
            <section class="upload">
               
               <!--사진업로드 로고-->
                <div class="upload-top">
                    <a href="home.html" class="">
                        <img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="">
                    </a>
                    <p>사진 업로드</p>
                </div>
                <!--사진업로드 로고 end-->
                <!--사진업로드 Form-->
                <form class="upload-form" enctype="multipart/form-data" action="/uploadImage"method = "post" id="upload_frm"> <!-- 파일을 업로드하는 form태그 -->
                    <input type="hidden" name="photo_id" value="${login.user_id }"><!-- 로그인된 유저의 아이디 -->
                    <input type="hidden" name="user_photoUrl" value="${login.user_photoUrl }"><!-- 로그인된 유저의 프로필사진-->
                    <input type="hidden" name="user_photothumb" value="${login.user_photothumb }"><!-- 로그인된 유저의 프로필사진의 썸네일 -->
					<label for="gdsImg">이미지</label>
					<input type="file" id="gdsImg" name="file" /><!-- 업로드할 파일을 선택하는 버튼 -->
					<div class="select_img"><img src="" /></div>
                    <!--사진설명 + 업로드버튼-->
                    <div class="upload-form-detail">
						<textarea cols="55" rows="8" name="photo_content"></textarea><!-- 게시물의 내용을 입력하는 텍스트 -->
						<!-- <button class="cta blue">업로드</button> -->
					</div>
                    <!--사진설명end-->
                    <input type="button" class="cta blue" id="up_btn" value="등록">
                </form>
                <!--사진업로드 Form-->
            </section>
            <!--사진업로드 박스 end-->
        </main>
<script>//선택한 사진을 화면에 띄어주는 스크립트 문
	$("#gdsImg").change(function(){
		if(this.files && this.files[0]) {
			var reader = new FileReader;
			reader.onload = function(data) {
				$(".select_img img").attr("src", data.target.result).width(300).height(300);        
			}
			reader.readAsDataURL(this.files[0]);
		}
	});
	$('#up_btn').click(function(){//업로드 버튼을 누르면 실행되는 스크립트문
		var login = "${login.user_id}";//로그인된 유저의 아이디
		if(login ==""){//로그인이 되어있지 않으면 실행
			alert('로그인을 해주세요')
		}
		else{//로그인이 되어있으면 실행
			$('#upload_frm').submit();
		}
	});
</script>

<%@ include file="../layout/footer.jsp" %>