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
                        <h1><img src="${pageContext.request.contextPath}/resources/images/logo.png" alt=""></h1>
                        
                        <!--로그인 인풋-->
                        <form class="login__input" action="/login" method="post" id="loginFrm" name="loginFrm">
                            <input type="text" name="login_id" placeholder="유저아이디" id="login_id" required="required">
                            <input type="password" name="login_pw" placeholder="비밀번호" id="login_pw" required="required">
                            <input type="button" id="loginBtn" value="로그인" >
                        </form>
                        <!--로그인 인풋end-->
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
		$('#login_id').on('keyup', function() {
			if ($('#login_id').val() === "") {
				chk1 = false;
			} else {
				chk1 = true;
			}
		});
		$('#login_pw').on('keyup', function() {
			if ($('#login_pw').val() === "") {
				chk2 = false;
			} else {
				chk2 = true;
			}
		});

		$('#loginBtn').click(function(e) {//#loginBtn 클릭시 실행.

			console.log("check 통과 - true");

			if (chk1 && chk2) {//아이디, 비밀번호가 입력되어 있으면 실행.

				console.log("if 진입");

				const user_id = $('#login_id').val();//아이디 텍스트창에 value값을 변수에 저장.
				const user_pwd = $('#login_pw').val();//비밀번호 텍스트창에 value값을 변수에 저장.

				const userInfo = {//json객체에 담기.
					user_id : user_id,//변수에 저장된 유저아이디.
					user_pwd : user_pwd//변수에 저장된 패스워드.
				};

				$.ajax({
					type : "POST",//post방식으로 전달.
					url : "/loginCheck",
					headers : {
						"Content-Type" : "application/json",
						"X-HTTP-Method-Override" : "POST"
					},
					data : JSON.stringify(userInfo),//json.stringfy타입으로 userInfo에 저장된 값을 전달.
					dataType : "text",//반환되는 타입은 text
					success : function(result) {//ajax가 성공하면 실행.
						console.log(result);
						const resultSet = $.trim(result);//전달된 result값의 띄어쓰기 없애기
						console.log("resultSet:" + resultSet);

						if (resultSet === "idFail") {//result값이 idFail이면 실행
							$('#login_id').focus();
							alert('아이디/패스워드가 틀렸습니다.')//alert실행.

						} else if (resultSet === "loginSuccess") {//result값이 loginSuccess면 실행.
							$('#loginFrm').submit();//form 태그 실행.
						}
					}

				});

			} else {//아이디, 비밀번호가 입력되어있지 않으면 실행.
				alert('입력 정보를 다시 확인하세요');
			}
		});
	});
</script>
	

</html>