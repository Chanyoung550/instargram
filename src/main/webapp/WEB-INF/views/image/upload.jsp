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
                        <img src="/images/logo.jpg" alt="">
                    </a>
                    <p>사진 업로드</p>
                </div>
                <!--사진업로드 로고 end-->
                
                <!--사진업로드 Form-->
                <form class="upload-form" method="post" enctype="multipart/form-data" action="/image"> <!-- 타입이 하나가 아니다. 2가지 이상 타입 -->
                    <input type="file" name="file" accept="image/*1" id="input_img">
                    
                    <div class="upload-img">
                        <img src="/images/profile.jpeg" alt="" id="img-preview" >
                    </div>
                    
       
                    <!--사진설명 + 업로드버튼-->
                    <div class="upload-form-detail">
                        <input type="text" placeholder="사진설명" name="caption">
                        <input type="text" placeholder="#태그" name="tags">
                        <button class="cta blue">업로드</button>
                    </div>
                    <!--사진설명end-->
                    
                </form>
                <!--사진업로드 Form-->
            </section>
            <!--사진업로드 박스 end-->
        </main>
        
        <script>
        	$("#input_img").on("change" ,(e) =>{
        		let files = e.target.files;
        		let filesArr = Array.prototype.slice.call(files);
        		filesArr.forEach((f)=>{
        			/* 이미지로 시작하는게 아니라면 */
        			if(!f.type.match("image.*")){
        				alert("이미지를 등록해야 합니다.");
        				return;
        			}
        			
        			let reader = new FileReader();
        			reader.onload = (e) =>{
        				console.log("e.target:"+e.target);
        				$("#img-preview").attr("src",e.target.result);
        			}
        			reader.readAsDataURL(f); // 이 코드 실행시 reader.onload 실행됨.
        		});
        		
        	})
        
        
        </script>

    <%@ include file="../layout/footer.jsp" %>