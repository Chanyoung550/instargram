<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Photogram</title>
    <!-- Style -->
    <link rel="stylesheet" href="css/profile.css">
    <!-- Fontawesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@100;200;300;400;500;600;700&display=swap"
        rel="stylesheet">
</head>

<body>

    <header class="header">
        <div class="container">
            <a href="home.html" class="logo"><img src="images/logo.jpg" alt=""></a>
            <nav class="navi">
                <ul class="navi-list">
                    <li class="navi-item"><a href="home.html"><i class="fas fa-home"></i></a></li>
                    <li class="navi-item"><a href="explor.html"><i class="far fa-compass"></i></a></li>
                    <li class="navi-item"><a href="profile.html"><i class="far fa-user"></i></a></li>
                </ul>
            </nav>
        </div>
    </header>

    <section class="profile">
        <div class="container">
            <div class="profile-left">
                <div class="profile-img-wrap story-border" onclick="popup('.modal-image')">
                    <img src="images/profile.jpeg" alt="">
                    <svg viewbox="0 0 110 110">
                        <circle cx="55" cy="55" r="53" />
                    </svg>
                </div>
            </div>
            <div class="profile-right">
                <div class="name-group">
                    <h2>There Programing</h2>
                    <button class="cta blue" onclick="location.href='imageUpload.html'">사진등록</button>
                    <button class="cta">구독하기</button>
                    <button class="modi" onclick="popup('.modal-info')"><i class="fas fa-cog"></i></button>
                </div>
                <div class="follow">
                    <ul>
                        <li><a href="">게시물<span>6</span></a> </li>
                        <li><a href="" id="subscribeBtn">구독정보<span>106</span></a> </li>
                    </ul>
                </div>
                <div class="state">
                    <h4>겟인데어</h4>
                </div>
            </div>
        </div>
    </section>

    <div class="gallery">
        <div class="container">
            <div class="controller">      
            </div>
        </div>
    </div>

    <section id="tab-content">
        <div class="container">
            <div id="tab-1-content" class="tab-content-item show">
                <div class="tab-1-content-inner">
                    <div class="img-box">
                        <a href=""><img src="images/profile.jpeg" alt=""></a>
                        <div class="comment">
                            <a href="#a" class=""><i class="fas fa-heart"></i><span>36</span></a>
                        </div>
                    </div>
                    <div class="img-box">
                        <a href=""><img src="images/profile.jpeg" alt=""></a>
                        <div class="comment">
                            <a href="#a" class=""><i class="fas fa-heart"></i><span>36</span></a>
                        </div>
                    </div>
                    <div class="img-box">
                        <a href=""><img src="images/profile.jpeg" alt=""></a>
                        <div class="comment">
                            <a href="#a" class=""><i class="fas fa-heart"></i><span>36</span></a>
                        </div>
                    </div>
                    <div class="img-box">
                        <a href=""><img src="images/profile.jpeg" alt=""></a>
                        <div class="comment">
                            <a href="#a" class=""><i class="fas fa-heart"></i><span>36</span></a>
                        </div>
                    </div>
                    <div class="img-box">
                        <a href=""><img src="images/profile.jpeg" alt=""></a>
                        <div class="comment">
                            <a href="#a" class=""><i class="fas fa-heart"></i><span>36</span></a>
                        </div>
                    </div>
                    <div class="img-box">
                        <a href=""><img src="images/profile.jpeg" alt=""></a>
                        <div class="comment">
                            <a href="#a" class=""><i class="fas fa-heart"></i><span>36</span></a>
                        </div>
                    </div>
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
                <p>© 2020 Photogram from There Programing</p>
            </div>
        </div>
    </footer>

    <div class="modal-info">
        <div class="modal">
            <button onclick="location.href='profileSetting.html'">회원정보 변경</button>
            <button>로그아웃</button>
            <button onclick="closePopup('.modal-info')">취소</button>
        </div>
    </div>

    <div class="modal-image">
        <div class="modal">
            <p>프로필 사진 바꾸기</p>
            <button>사진 업로드</button>
            <button onclick="closePopup('.modal-image')">취소</button>
        </div>
    </div>

    <div class="modal-follow">
        <div class="follower">
            <div class="follower-header">
                <span>구독정보</span>
                <button onclick="closeFollow()"><i class="fas fa-times"></i></button>
            </div>
            <div class="follower-list">
                <div class="follower__item">
                    <div class="follower__img"><img src="images/profile.jpeg" alt=""></div>
                    <div class="follower__text">
                        <h2>아이디</h2>
                    </div>
                    <div class="follower__btn"><button onclick="clickFollow(this)">구독취소</button></div>
                </div>
                <div class="follower__item">
                    <div class="follower__img"><img src="images/profile.jpeg" alt=""></div>
                    <div class="follower__text">
                        <h2>아이디</h2>
                    </div>
                    <div class="follower__btn"><button onclick="clickFollow(this)">구독취소</button></div>
                </div>
                <div class="follower__item">
                    <div class="follower__img"><img src="images/profile.jpeg" alt=""></div>
                    <div class="follower__text">
                        <h2>아이디</h2>
                    </div>
                    <div class="follower__btn"><button onclick="clickFollow(this)">구독취소</button></div>
                </div>
                <div class="follower__item">
                    <div class="follower__img"><img src="images/profile.jpeg" alt=""></div>
                    <div class="follower__text">
                        <h2>아이디</h2>
                    </div>
                    <div class="follower__btn"><button onclick="clickFollow(this)">구독취소</button></div>
                </div>
                <div class="follower__item">
                    <div class="follower__img"><img src="images/profile.jpeg" alt=""></div>
                    <div class="follower__text">
                        <h2>아이디</h2>
                    </div>
                    <div class="follower__btn"><button onclick="clickFollow(this)">구독취소</button></div>
                </div>
                <div class="follower__item">
                    <div class="follower__img"><img src="images/profile.jpeg" alt=""></div>
                    <div class="follower__text">
                        <h2>아이디</h2>
                    </div>
                    <div class="follower__btn"><button onclick="clickFollow(this)">구독취소</button></div>
                </div>
                <div class="follower__item">
                    <div class="follower__img"><img src="images/profile.jpeg" alt=""></div>
                    <div class="follower__text">
                        <h2>아이디</h2>
                    </div>
                    <div class="follower__btn"><button onclick="clickFollow(this)">구독취소</button></div>
                </div>
                <div class="follower__item">
                    <div class="follower__img"><img src="images/profile.jpeg" alt=""></div>
                    <div class="follower__text">
                        <h2>아이디</h2>
                    </div>
                    <div class="follower__btn"><button onclick="clickFollow(this)">구독취소</button></div>
                </div>

            </div>
        </div>
    </div>

    <script src="js/profile.js"></script>
</body>

</html>