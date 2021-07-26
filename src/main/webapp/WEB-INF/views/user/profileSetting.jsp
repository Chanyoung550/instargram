<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	
    <%@ include file="../layout/header.jsp"%>

    <!--프로필셋팅 메인-->
    <main class="main">
        <!--프로필셋팅 섹션-->
        <section class="setting-container">
            <!--프로필셋팅 아티클-->
            <article class="setting__content">

                <!--프로필셋팅 아이디영역-->
                <div class="content-item__01">
                    <div class="item__img"><img src="/upload/${principal.user.profileImageUrl}" alt=""  onerror="this.src='/images/common.jpg'"/></div>
                    <div class="item__username">
                        <h2>${principal.user.username}</h2>
                    </div>
                </div>
                <!--프로필셋팅 아이디영역end-->
                
                <!--프로필 수정-->
                <form id="profile_setting" onsubmit="update(${principal.user.id})">
                    <div class="content-item__02">
                        <div class="item__title">이름</div>
                        <div class="item__input">
                            <input type="text" name="name" id="name" placeholder="이름" value="${principal.user.name}"/>
                        </div>
                    </div>
                    <div class="content-item__03">
                        <div class="item__title">유저 네임</div>
                        <div class="item__input">
                            <input type="text" name="username" placeholder="유저네임"  value="${principal.user.username}" readonly="readonly"/>
                        </div>
                    </div>
                    
                    <div class="content-item__04">
                    <div class="item__title">패스워드</div>
                        <div class="item__input">
                            <input type="password" name="password" placeholder="패스워드"  />
                        </div>
                    </div>
                    
                    <div class="content-item__05">
                        <div class="item__title">웹사이트</div>
                        <div class="item__input">
                            <input type="text" name="website" id="website" placeholder="웹사이트" value="${principal.user.website}" />
                        </div>
                    </div>
                    <div class="content-item__06">
                        <div class="item__title">소개</div>
                        <div class="item__input">
                            <textarea name="bio" id="bio" rows="3" id="bio" placeholder="소개">${principal.user.bio}</textarea>
                        </div>
                    </div>
                    <div class="content-item__07">
                        <div class="item__title"></div>
                        <div class="item__input">
                            <span><b>개인정보</b></span>
                            <span>비즈니스나 반려동물 등에 사용된 계정인 경우에도 회원님의 개인 정보를 입력하세요. 공개 프로필에는 포함되지 않습니다.</span>
                        </div>
                    </div>
                    <div class="content-item__08">
                        <div class="item__title">이메일</div>
                        <div class="item__input">
                           <input type="text" name="email" placeholder="이메일"  value="${principal.user.email}" readonly="readonly"/>
                        </div>
                    </div>
                    <div class="content-item__09">
                        <div class="item__title">전회번호</div>
                        <div class="item__input">
                            <input type="text" name="phone" id="phone" placeholder="전화번호" value="${principal.user.phone}" />
                        </div>
                    </div>
                    <div class="content-item__10">
                        <div class="item__title">성별</div>
                        <div class="item__input">
                            <input type="text" name="gender" id="gender" placeholder="성별" value="${principal.user.gender}"/>
                        </div>
                    </div>
                            
                    <input type="hidden" id="id" value="${id}" />
                      <input type="hidden" id="id2" value="${principal.user.id}" />
                    
                    <!--제출버튼-->
                    <div class="content-item__11">
                        <div class="item__title"></div>
                        <div class="item__input">
                            <button id="btn_update">제출</button>
                        </div>
                    </div>
                    <!--제출버튼end-->
                    
                </form>
                <!--프로필수정 form end-->
            </article>
        </section>
    </main>
    
     <script src="/js/profile.js"></script>
    
    <!-- <script>
    	$("#btn_update").on("click", (e)=>{
    		e.preventDefault();
    		let data = {
    				name: $("#name").val(),
    				username: $("#username").val(),
    				website: $("#website").val(),
    				bio: $("#bio").val(),
    				email: $("#email").val(),
    				phone: $("#phone").val(),
    				gender: $("#gender").val(),
    		}
    		
    		let id = $("#id").val();
    		let id2 = $("#id2").val();
    		console.log(1,id);
    		console.log(2,data);
    		
    		 if(!data.name || !data.username){ 
    		/* if(data.name == "" || data.username == ""){ */
    			alert("이름 그리고 사용자이름을 적어주세요")
    		} else {
    			$.ajax({
        			
        			type:"PUT",
        			url: "/user/"+id,
        			data: JSON.stringify(data),
        			contentType: "application/json; charset=utf-8",
        			dataType: "json"
        			
        		}).done((res) =>{
        			console.log(res);
        			if(res.statuscode === 1){
        				alert("수정에 성공하였습니다.")
        				location.reload();
        			} else{
        				alert("수정에 실패하였습니다.")
        			}
        		});
    		}
    	});
    
    </script> -->
    
    
    <%@ include file="../layout/footer.jsp" %>