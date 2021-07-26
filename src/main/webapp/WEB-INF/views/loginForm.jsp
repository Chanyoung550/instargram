<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Photogram</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/insta.svg">
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"
        integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous" />
        
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    
</head>

<body>
    <div class="container">
        <main class="loginMain">
        <!--로그인섹션-->
            <section class="login">
               <!--로그인박스-->
                <article class="login__form__container">
                   <!--로그인 폼-->
                   <div class="login__form">
                        <h1><img src="${pageContext.request.contextPath}/resources/images/daseulgram.png" alt=""></h1>
                        
                        <!--로그인 인풋-->
                        <form class="login__input" action="/login" method="post" id="loginFrm" name="loginFrm">
                            <input type="text" name="login_id" placeholder="유저아이디" id="login_id" required="required">
                            <input type="password" name="login_pw" placeholder="비밀번호" id="login_pw" required="required">
                            <input type="button" id="loginBtn" value="로그인" >
                        </form>
                        <!--로그인 인풋end-->
                        
                        <!-- 또는 -->
                        <div class="login__horizon">
                            <div class="br"></div>
                            <div class="or">또는</div>
                            <div class="br"></div>
                        </div>
                        <!-- 또는end -->
                        
                        <!-- Oauth 소셜로그인 -->
                        <div class="login__facebook">
                        <a href="/oauth2/authorization/facebook">
                            <button>
                                <i class="fab fa-facebook-square"></i>
                             
                                <span>Facebook으로 로그인</span>
                                
                            </button>
                         </a>
                        </div>
                        <!-- Oauth 소셜로그인end -->
                    </div>
                    
                    <!--계정이 없으신가요?-->
                    <div class="login__register">
                        <span>계정이 없으신가요?</span>
                        <a href="/join">가입하기</a>
                    </div>
                    <!--계정이 없으신가요?end-->
                    
                </article>
            </section>
        </main>
        
    </div>
</body>

<script>
	$(function() {
		
		let chk1 = false;
		let chk2 = false;
		$('#login_id').on('keyup', function(){
		    if($('#login_id').val() === "") {
		        chk1 = false;
		    } else {
		        chk1 = true;
		    }
		});
		$('#login_pw').on('keyup', function(){
		    if($('#login_pw').val() === "") {
		        chk2 = false;
		    } else {
		        chk2 = true;
		    }
		});
	
		$('#loginBtn').click(function(e) {
			
			console.log("check 통과 - true");
			
			if(chk1 && chk2) {
				
				console.log("if 진입");
				
				const userID = $('#login_id').val();
				const userPassword = $('#login_pw').val();
				
				//콘솔에 값 출력
				console.log("userID: " + userID);
				console.log("userPassword: " + userPassword);
				
				//json객체에 담기
				const userInfo = {
					userID: userID,
					userPassword: userPassword
				};
				
				$.ajax({
					type: "POST",
					url: "/loginCheck",
					headers: {
						"Content-Type": "application/json",
		                "X-HTTP-Method-Override": "POST"
					},
					data: JSON.stringify(userInfo),
					dataType: "text",
					success: function(result) {
						//console.log("data: " + data);
						//console.log("result:" + result);
						
						const resultSet = $.trim(result);
						console.log("resultSet:" + resultSet);
						
						if(resultSet === "idFail") {
							$('#login_id').focus();
							$('#alert_msg').html('<p>ID 확인이 필요합니다.</p>');
							
						} else if(resultSet === "pwFail") {
							$('#login_pw').focus();
							$('#alert_msg').html('<p>PW 확인이 필요합니다.</p>');
							
						} else if(resultSet === "loginSuccess") {
							$('#loginFrm').submit();
						}
					}
					
				});
				
			} else {
				alert('입력 정보를 다시 확인하세요');
			}
		});
	});
</script>

</html>