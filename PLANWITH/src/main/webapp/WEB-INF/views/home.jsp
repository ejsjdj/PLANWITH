<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>함께 만드는 여행: 플랜위드</title>
<style>
	/* 폰트 적용 */
	@import
	   url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap');
</style>
<style>
	html {
	   width: 100%;
	}
	body {
	   height: 3000px;
	   margin: 0;
	   font-size: 0.8rem;
	   font-family: "Noto Sans KR", sans-serif;
	   width: 100%;
	}
	
	/* 스크롤바 스타일링 */
	::-webkit-scrollbar {
	   width: 12px;
	   height: 12px;
	}
	
	::-webkit-scrollbar-thumb {
	   background-color: #9999;
	   border-radius: 10px;
	   border: 3px solid #f1f1f1;
	}
	
	::-webkit-scrollbar-track {
	   background-color: #f1f1f1;
	   border-radius: 10px;
	}
	
	::-webkit-scrollbar-thumb:hover {
	   background-color: #999;
	}
	
	.grid { /* 선 가이드 (나중에 지우기) */
	   
	}
	
	.bg {
	   background-image: url("${cpath}/resources/image/고화질 구름.jpg");
	   background-color: #F7F2EB;
	   height: 100vh;
	   width: 100%;
	   background-position: center;
	   background-size: cover;
	   z-index: 4;
	   position: relative;
	   background-attachment: fixed;
	}
	
	.header {
	   width: 100%;
	   height: 70px;
	   position: fixed;
	   z-index: 5;
	   /*             background-color: #7096D1  ; */
	   background-color: rgba(255, 255, 255, 0);
	   transition: background-color 0.5s ease;
	   top: 0;
	}
	/*       .header .container {   /* header의 container 따로 높이 지정 */
	/*           height: 70px;  */
	/*           padding: 0; */
	/*           box-sizing: border-box; */
	/*        } */
	
	/* container 공통 클래스 */
	.container {
	   width: 1200px;
	   margin: 0 auto;
	   padding: 20px;
	   box-sizing: border-box;
	   height: 100%;
	}
	
	/* header 내부 container */
	.header-wrap {
	   display: block;
	   height: 100%;
	   padding: 0;
	   margin-left: auto;
	   margin-right: auto;
	   position: relative;
	   box-sizing: border-box;
	   width: 100%;
	}
	
	.header-wrap-flex {
	   justify-content: space-between;
	   display: flex;
	   box-sizing: border-box;
	   height: 100%;
	}
	
	.header-wrap-flex>.left {
	   justify-content: center;
	   align-items: center;
	   display: flex;
	   box-sizing: border-box;
	   width: 150px;
	   position: relative;
	   z-index: 6;
	}
	
	.header-wrap-flex>.left>.titleLink {
	   width: 100%;
	   height: 100%;
	   position: relative;
	   display: flex;
	   justify-content: center;
	   align-items: center;
	}
	
	.header-wrap-flex>.left>.titleLink>.logoImg {
	   width: 100px;
	   position: absolute;
	   z-index: 7;
	}
	
	.header-wrap-flex>.left>.titleLink>.logoImgHover {
	   width: 100px;
	   position: absolute;
	   display: none;
	   z-index: 7;
	}
	
	.header-wrap-flex>.left>.titleLink:hover>logoImg {
	   display: none;
	}
	
	.header-wrap-flex>.left>.titleLink:hover>logoImgHover {
	   display: block;
	}
	
	/* home 스타일 */
	.home .container {
	   display: flex;
	   justify-content: center; /* 세로 가운데 정렬 */
	   flex-direction: column; /* 위아래로 배치 */
	   align-items: flex-start;
	   height: 100vh; /* 화면에 맞춰서 가득 차게 */
	}
	
	.container>.title {
	   font-size: 1.8rem;
	   color: white;
	   /*             text-align: center; /* 가운데 정렬 */
	   s
	}
	
	.smaller { /* 좀 더 작은 글씨로 만들고 싶으면 추가 */
	   /*          font-size: 1.5rem; */
	   
	}
	
	.container>.buttons {
	   display: flex;
	   justify-content: center;
	   gap: 20px;
	   margin-top: 20px;
	}
	
	.first-home-button {
	   background-color: rgba(0, 0, 0, 0);
	   color: #fff;
	   border-radius: 10px;
	   padding: 15px;
	   min-height: 30px;
	   min-width: 120px;
	   cursor: pointer;
	   border: 0.05rem solid white;
	}
	
	.second-home-button {
	   background-color: rgb(255, 255, 255, 0.2);
	   color: #fff;
	   border-radius: 10px;
	   padding: 15px;
	   min-height: 30px;
	   min-width: 120px;
	   cursor: pointer;
	   border: 0.05rem solid white;
	}
	
	.full-container {
	   width: 100%;
	   height: 3000px;
	   z-index: 6;
	   background-color: #EDF1F6;
	   padding-top: 0;
	}
	
	.header>.container>header-wrap>.header-wrap-flex>.right {
	   width: 50px;
	   height: 100%;
	   display: flex;
	   justify-content: center;
	   align-items: center;
	}
	
	.header>.container>header-wrap>.header-wrap-flex>.right>#menuBtn {
	   width: 100%;
	   height: 100%;
	   border: 0;
	   background-color: 0;
	}
	
	footer {
	   top: -70px;
	   width: 100%;
	   height: 205px;
	   display: flex;
	   justify-content: center;
	   background-color: whitesmoke;
	   border-top: 1px solid rgb(219, 219, 219);
	   position: relative;
	   z-index: 5;
	}
	
	footer>.footinfo {
	   width: 80%;
	   height: 90%;
	   padding-top: 20px;
	}
	
	footer>.footinfo>.top {
	   width: 100%;
	   height: 35px;
	   display: flex;
	   justify-content: space-between;
	   margin-top: 20px;
	}
	
	footer>.footinfo>.top>.left {
	   color: rgb(113, 113, 113);
	}
	
	footer>.footinfo>.top>.right>a>button {
	   border: 1px solid rgb(168, 168, 168);
	   border-radius: 5px;
	   width: 80px;
	   height: 30px;
	}
	
	footer>.footinfo>.middle {
	   width: 100%;
	   height: 50px;
	}
	
	footer>.footinfo>.middle>span {
	   color: rgb(169, 169, 169);
	   font-size: 12px;
	}
	
	footer>.footinfo>.bottom {
	   width: 100%;
	   display: flex;
	   justify-content: space-between;
	   margin-top: 20px;
	}
	
	footer>.footinfo>.bottom>.right>img {
	   width: 50px;
	   border-radius: 50px;
	}
</style>
</head>

<body>

   <div class="grid first bg">
      <div class="header">
         <div class="container">
            <div class="header-wrap">
               <div class="header-wrap-flex">
                  <div class="left">
                     <a class="titleLink" href="${cpath }">
                        <img class="logoImg"
                           src="${cpath}/resources/image/plan with흰.png">
                        <img class="logoImgHover"
                           src="${cpath}/resources/image/plan with.png">
                     </a>
                  </div>
                  <div class="right">
                     <button id="menuBtn" class="button">
                        <span></span>
                        <span></span>
                        <span></span>
                     </button>
                  </div>
               </div>
            </div>
         </div>
      </div>

      <div class="home">
         <div class="container">
            <div class="title">
               <h1>
                  함께 만드는 여행<br>플랜위드
               </h1>
            </div>
            <div class="buttons">
               <button id="startBtn" class="first-home-button">여행지 검색</button>
               <c:if test="${login == null }">
               <button id="loginBtn" class="second-home-button">로그인</button>
               </c:if>
            </div>
         </div>
      </div>
   </div>

   <!-- 이후 스크롤 내리는 부분 -->
   <div class="grid full-container">
      <div class="container">
         <c:if test="${empty login}">
            <p>
               <a href="${cpath}/member/join">회원가입</a>
            </p>
            <p>
               <a href="${cpath}/member/login">로그인</a>
            </p>
            <p>
            	<a href="${cpath }/member/findUserid">아이디 재발급받기</a>
            </p>
            <p>
				<a href="${cpath}/member/findPassword">비밀번호 재발급받기</a>
            </p>
         </c:if>

         <!-- 로그인 상태일 때만 로그아웃 버튼 보이기 -->
         <c:if test="${not empty login}">
            <p>
               <a href="${cpath}/member/logout">로그아웃</a>
            </p>
         </c:if>

         <p>
            <a href="${cpath}/map/schedule">계획만들기</a>
         </p>
         <p>
            <a href="${cpath}/board/boardList">게시판 임시 구현</a>
         </p>

         <form action="${cpath}/team/main">
            <button type="submit">(비회원 전용)여행 시작하기</button>
         </form>

         <p>
            <a href="${cpath}/team/viewTeams">로그인 하고 열리는 일정 페이지</a>
         </p>
         <p>
            <a href="${cpath}/friend/friend">친구 목록</a>
         </p>
      </div>
   </div>
   
   <footer>
      <div class="footinfo">
         <div class="top">
                <div class="left">
                    <span>고객 센터</span>
                </div>
                <div class="right">
                    <a href="${cpath}/member/login">로그인</a>
                </div>
            </div>
            <div class="middle">
                <span>
                    (주)기범컴퍼니 플랜위드는 통신판매중개로서 통신판매의 당사자가 아니며<br>
                    상품 거래정보 및 거래등에 대한 책임을 지지않습니다.
                </span>
            </div>
            <div class="bottom">
                <div class="left">
                    <span>서비스 이용약관 | 개인정보 처리방침 | 고객 센터</span>
                </div>
                <div class="right">
                    <img src="${cpath }/resources/image/으헝.jpg">
                </div>
            </div>
      </div>
   </footer>
   

   <script> 
    const cpath = '${cpath}'
</script>

   <script>
    document.getElementById('startBtn').addEventListener('click', function() {
        location.href = cpath + '/team/main'
    })

    document.getElementById('loginBtn').addEventListener('click', function() {
        location.href = cpath + '/member/login'
    })
    
    // 헤더 및 배경 변경에 필요한 요소 가져오기
    const header = document.querySelector('.header')
    const changePoint = document.querySelector('.full-container').offsetTop

    // 스크롤 이벤트 등록
    window.addEventListener('scroll', () => {
        if (window.scrollY >= changePoint) {
            header.style.backgroundColor = '#96C6D2' // 스크롤 지점 이후 색상 변경
            
        } else {
            header.style.backgroundColor = 'rgba(255,255,255,0)' // 초기 색상 (투명)
        }
    })
</script>

</body>
</html>