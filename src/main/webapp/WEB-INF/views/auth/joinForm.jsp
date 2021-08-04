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
           <!--회원가입섹션-->
            <section class="login">
                <article class="login__form__container">
                  
                   <!--회원가입 폼-->
                    <div class="login__form">
                        <!--로고-->
                        <h1><img src="${pageContext.request.contextPath}/resources/images/logo.png" alt=""></h1>
                         <!--로고end-->
                         
                         <!--회원가입 인풋-->
                        <form class="login__input" action="/auth/join" method="post" id="signFrm" name="signFrm">
                            <input type="text" name="user_id" placeholder="유저아이디" id="user_id" required="required">
                            <input type="button" id="idCheck" value="중복확인">
                            <input type="password" name="user_pwd" placeholder="패스워드" id="user_pwd" required="required">
                            <input type="text" name="user_name" placeholder="이름" id="user_name" required="required">
                            <input type="email" name="user_email" placeholder="이메일" id="user_email" required="required">
                            <input type="text" name="phone" placeholder="핸드폰번호" id="user_phone" required="required">
                            <input type="button" id="signUp" value="가입" >
                        </form>
                        <!--회원가입 인풋end-->
                    </div>
                    <!--회원가입 폼end-->
                    
                    <!--계정이 있으신가요?-->
                    <div class="login__register">
                        <span>계정이 있으신가요?</span>
                        <a href="/login">로그인</a>
                    </div>
                    <!--계정이 있으신가요?end-->
                    
                </article>
            </section>
        </main>
    </div>
</body>

<script type="text/javascript">
   $(document).ready(function(e){
      var idx = false;
      $('#signUp').click(function(){//회원가입을 눌렀을때 텍스트창에 입력이 되어있는지 확인
         if($.trim($('#user_id').val()) == ''){
            alert("아이디 입력");
            $('#user_id').focus();
            return;
         } else if($.trim($('#user_pwd').val()) == ''){
            alert("패스워드 입력");
            $('#user_pwd').focus();
            return;
         } else if($.trim($('#user_name').val()) == '') {
             alert("이름 입력");
             $('#user_name').focus();
             return;
         } else if($.trim($('#user_email').val()) == '') {
            alert("이메일 입력");
            $('#user_email').focus();
            return;
         } else if($.trim($('#user_phone').val()) == '') {
             alert("핸드폰번호 입력");
             $('#user_phone').focus();
             return;
         }
         if(idx == false) {//아이디가 중복체크를 했는지 확인
            alert("아이디 중복체크를 해주세요.");
            return;
         } else {
            $('#signFrm').submit();
         }
      });
      $('#idCheck').click(function() {//아이디 중복 체크를 하는 ajax
         $.ajax({
            url : "/idCheck", //idcheck컨트롤러로 이동
            type : "GET",	//get방식
            data : {"user_id" : $("#user_id").val()},//텍스트창에 입력되어있는 아이디값을 가지고감
            success : function(data){
                if(data == 0 && $.trim($('#user_id').val()) != '') {//중복된 아이디가 없으면 실행
                  idx = true;//중복되 아이디값이 없으면 변수를 true값으로 변경
                  $('#id').attr("readonly", true);
                  alert("사용가능한 아이디입니다.")
               } else{
                  alert("중복된 아이디입니다.")
               }
            },
            error: function() {
               alert("서버에러");
            }
         });
      });
   });
</script>

</html>