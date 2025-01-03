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
	url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap')
	;
</style>
<style>
html {
	width: 100%;
}

body {
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

.bg {
	background-image: url("${cpath}/resources/image/고화질 구름.jpg");
	background-color: #F7F2EB;
	height: 120vh;
	width: 100%;
	background-position: center;
	background-size: cover;
	z-index: 1;
	position: relative;
	background-attachment: fixed;
}

.header {
	width: 100%;
	height: 70px;
	position: fixed;
	z-index: 9;
	/*             background-color: #7096D1  ; */
	background-color: rgba(255, 255, 255, 0);
	transition: background-color 0.5s ease;
	top: 0;
}

/* container 공통 클래스 */
.container {
	width: 1200px;
	margin: 0 auto;
	padding: 20px;
	box-sizing: border-box;
	height: 101%;
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
	transition: 0.5s ease;
}

.header-wrap-flex>.left>.titleLink>.logoImgHover {
	width: 100px;
	position: absolute;
	display: none;
	z-index: 7;
	transition: 0.5s ease;
}

.header-wrap-flex>.left:hover>.titleLink>.logoImg {
	display: none;
}

.header-wrap-flex>.left:hover>.titleLink>.logoImgHover {
	display: block;
}

.header-wrap-flex>.right {
	width: 70px;
	height: 100%;
	display: flex;
	justify-content: center;
	align-items: center;
}

.header-wrap-flex>.right>#menuBtn {
	width: 100%;
	height: 40px;
	border: 0;
	background-color: rgba(255, 255, 255, 0);
}

/* ========================================== home 스타일 ============================================= */
.home .container {
	display: flex;
	justify-content: center; /* 세로 가운데 정렬 */
	flex-direction: column; /* 위아래로 배치 */
	align-items: flex-start;
	height: 100vh; /* 화면에 맞춰서 가득 차게 */
	position: fixed;
	left: 8%;
}

.container>.title {
	font-size: 1.8rem;
	color: white;
	/*             text-align: center; /* 가운데 정렬 */
}

.container>.buttons {
	display: flex;
	justify-content: center;
	gap: 20px;
	margin-top: 20px;
}

.first-home-button {
	color: #fff;
	border-radius: 10px;
	padding: 15px;
	min-height: 30px;
	min-width: 120px;
	border: 1.5px solid rgba(255, 255, 255, 0.1);
    background: rgba(0, 0, 0, 0.2);
    cursor: pointer;
}

.first-home-button:hover {
	border: 1.5px solid rgba(255, 255, 255, 0.2);
    background: rgba(0, 0, 0, 0.3);
}

.second-home-button {
	color: #fff;
	border-radius: 10px;
	padding: 15px;
	min-height: 30px;
	min-width: 120px;
	border: 1.5px solid rgba(255, 255, 255, 0.1);
    background: rgba(0, 0, 0, 0.2);
    cursor: pointer;
}

.second-home-button:hover {
	border: 1.5px solid rgba(255, 255, 255, 0.2);
    background: rgba(0, 0, 0, 0.3);
}

.infoHomeBody {
	position: relative;
	width: 100%;
	height: 2450px;
	z-index: 2;
	top: -20px;
	background-color: #EDF1F6;
	padding-top: 0;
	border-top-left-radius: 20px;
	border-top-right-radius: 20px;
}

/* 	============================================ 사이드 바 ============================================  */
.friendOverlay.hidden, .modal.hidden, .sidebarOverlay.hidden {
	display: none;
}

.sidebarOverlay {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.4);
	z-index: 10;
}

.sidebarOverlay.active {
	background: rgba(0, 0, 0, 0.4);
	opacity: 1;
	visibility: visible;
}

.sidebar {
	width: 300px;
	height: 100vh;
	background-color: #f8f9fa;
	background-color: white;
	position: fixed;
	top: 0;
	right: -300px;
	box-shadow: -2px 0 5px rgba(0, 0, 0, 0.1);
	transition: right 0.3s ease;
	z-index: 11;
}

.sidebar.open {
	right: 0;
}

.sidebarHeader {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 20px;
	color: black;
	border-bottom: 1px solid #ffffff;
	height: 30px;
}

.sidebarHeader .sidebarHeaderImg {
	width: 100px;
}

.closeSidebarBtn {
	background: none;
	border: none;
	font-size: 18px;
	color: black;
	cursor: pointer;
}

.sidebarmodalBox {
	padding: 20px;
}

.sidebarmodalBox .sidebarListName {
	font-size: 0.7rem;
	background-color: #f1f3f5;
	background-color: #f8f9fa;
	background-color: #f3f3f3;
	padding: 0.3rem 0.7rem;
	color: #495057; /* 회색 살짝 들어간 검은색 */
}

.sidebarmodalBox #friendList {
	background-color: #f8f9fa;
}

.sidebarmodalBox #friendList p {
	margin: 0;
	padding: 12px;
}

#friendRequestList {
	background-color: #f8f9fa;
}

.sidebarmodalBox .sidebarBtn {
	width: 15rem;
	padding: 10px;
	margin: 5px auto;
	border: 1px solid #d3d3d3;
	border-radius: 2rem;
	font-size: 0.8rem;
	box-sizing: border-box;
	justify-content: center;
	display: flex;
	background-color: #033495;
	color: white;
	border: none;
	cursor: pointer;
	transition: background-color 0.3s;
}

.sidebarmodalBox .sidebarBtn:hover {
	background-color: pink;
}

.sidebarmodalBox .sidebarFriendDiv {
	margin-bottom: 1rem;
}

.sidebarmodalBox ul {
	list-style: none;
	padding: 0;
	margin: 0;
}

.sidebarmodalBox ul li {
	padding: 1rem 0.7rem;
}

.sidebarmodalBox ul li a {
	text-decoration: none;
	color: #333;
	font-size: 0.9rem;
	transition: color 0.3s ease;
}

.sidebarmodalBox ul li a:hover {
	color: #96C6D2;
}

.sidebarmodalBox #friendList .friendStatus {
	display: flex;
}

.sidebarmodalBox #friendList .loginStatus {
	width: 0.8rem;
	height: 0.8rem;
	border-radius: 50%;
	background-color: green;
}

.sidebarmodalBox #friendList .logoutStatus {
	width: 0.8rem;
	height: 0.8rem;
	border-radius: 50%;
	background-color: grey;
}

.myPage {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 0 0;
}

.myPage>.myInfo {
	margin-right: 30px;
}

.myPage>.myInfo>p:nth-child(1) {
	margin-bottom: 0;
}

.myPage>.myInfo>p:nth-child(2) {
	margin-top: 0;
}

.myPage>.myInfo>p>span {
	font-size: 20px;
	font-weight: 500;
}

.myPage>.myInfo>p>a {
	color: darkgrey;
	text-decoration: none;
	font-size: 13px;
}

.myPage .profileImg {
	width: 70px;
	height: 70px;
	border-radius: 50%;
	margin-left: 10px;
}

.sidebarBtn {
	border: 0;
	background-color: rgba(255, 255, 255, 0);
	font-size: 16px;
	transition: color 0.3s ease;
	cursor: pointer;
	padding: 0;
	color: #333;
}

.sidebarBtn:hover {
	color: #96C6D2;
}

#addmodal {
	width: 100%;
	height: 100%;
}

#addmodal>.overlay {
	background-color: rgba(255, 255, 255, 0);
	width: 100%;
	height: 100%;
	z-index: 6;
}

.modalBox {
	width: 470px;
	height: 430px;
	padding: 15px;
	display: flex;
	flex-flow: column;
	position: fixed;
	background-color: white;
	border-radius: 25px;
	z-index: 20;
	left: 35%;
	top: 30%;
}

.modalBox>p {
	display: flex;
	justify-content: center;
	align-items: center;
	margin: auto;
}

#searchFriendModal .serchFriendModal-title {
	font-size: 1.3rem;
	margin-bottom: 2rem;
	display: flex;
	align-items: center;
	margin: auto;
	font-size: 1.1rem;
}

#searchFriendModal #searchFriendForm {
	margin: 5px 15px;
}

#searchFriendModal .group p {
	display: flex;
	justify-content: space-between;
	margin-top: 0;
}

#searchFriendModal .group span {
	display: inline-flex;
	justify-content: space-between;
}

#searchFriendModal .group span:nth-of-type(1) {
	display: block;
	width: 100%;
}

#searchFriendModal .group label {
	width: 100%; /* 이미 적용된 스타일 */
	display: block; /* 줄 전체를 차지하도록 */
	text-align: left; /* 텍스트 왼쪽 정렬 */
}

#searchFriendModal .inpute, .submit {
	width: calc(100%);
	padding: 10px;
	margin: 5px auto;
	border: 1px solid #d3d3d3;
	border-radius: 5px;
	font-size: 1rem;
	box-sizing: border-box;
}

#searchFriendModal .submit {
	/*    background-color: #628ECB; */
	background-color: #033495;
	/*    background-color: #4267a9; */
	color: white;
	border: none;
	cursor: pointer;
	transition: background-color 0.3s;
	margin-top: 0;
	font-size: 0.9rem;
	border-radius: 1rem;
}

#searchFriendModal .input {
	width: 90%;
	justify-content: center;
	display: flex;
	margin: 5px 0;
}

#searchFriendModal .input:focus {
	border-color: #B1C9EF;
	outline: none;
}

#searchFriendModal .searchFriendList {
	width: 90%;
	height: 200px;
	padding: 10px;
	box-sizing: border-box;
	background-color: #f8f9fa;
	margin: 5px 15px;
}

#searchFriendModal .searchFriendInput {
	border: 1px solid #d3d3d3;
	border-radius: 5px;
	font-size: 1rem;
	box-sizing: border-box;
	padding: 10px;
}

.friendOverlay {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.4);
	z-index: 12;
}

/* ====================================== 메뉴 햄버거 ======================================= */
.menu {
	position: absolute;
	top: 0;
	right: 0;
	height: 100%;
	max-width: 0;
	transition: 0.5s ease;
	z-index: 12;
	background-color: #eee;
}

.burger-icon {
	cursor: pointer;
	display: flex;
	flex-flow: column;
	position: absolute;
	z-index: 13;
	user-select: none;
	width: 25px;
	height: 25px;
	margin: 0;
	justify-content: center;
	align-items: center;
}

.burger-icon .burger-sticks1, .burger-sticks2, .burger-sticks3 {
	background: white;
	display: block;
	height: 3px;
	position: relative;
	transition: background .2s ease-out;
	width: 22px;
	border-radius: 10px;
}

.burger-sticks1 {
	top: -5px;
}

.burger-sticks3 {
	top: 5px;
}

.burger-check {
	display: none;
}

.burger-icon:hover>.burger-sticks1, .burger-icon:hover>.burger-sticks2,
	.burger-icon:hover>.burger-sticks3 {
	background: black;
}

.footer-container {
	position: relative;
	z-index: 2;
	bottom: 20px;
}

/* ============================================ 본문 ========================================== */

.infoHomeBody {
    background-color: #f8f9fa;
    padding: 80px 0;
}

.infoThePL {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
}

.features {
    text-align: center;
}

.features h2 {
    font-size: 2.5rem;
    margin-bottom: 50px;
    color: #333;
}

.feature-grid {
    display: flex;
    flex-direction: column;
    gap: 120px;
}

.feature-item {
    background-color: white;
    padding: 40px;
    border-radius: 10px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease;
    height: 600px;
}

.feature-item:hover {
    transform: translateY(-5px);
}


.feature-item h3 {
    font-size: 1.8rem;
    margin-bottom: 15px;
    color: #333;
}

.feature-item p {
    font-size: 1.1rem;
    color: #666;
    line-height: 1.6;
}

.sharing {
	display: flex;
    justify-content: space-between;
    align-content: center;
    padding: 0 45px;
}
.sharingInfo {
	display: flex;
	flex-flow: column;
}
.realTime {
	display: flex;
    justify-content: space-between;
    align-content: center;
    padding: 0 90px;
}
.realTimeInfo {
	display: flex;
	flex-flow: column;
}
.blackBigger {
	display: flex;
    width: 400px;
    height: 100px;
    justify-content: center;
    padding-top: 128px;
    font-size: 29px;
    font-weight: bold;
}
.greySmall {
	display: flex;
	justify-content: center;
	width: 400px;
    height: 200px;
    font-size: 30px;
}
.greySmall > span {
	width: 300px;
	font-size: 20px;
	color: grey;
}
</style>

<!-- sockjs, stomp -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.js"></script>


</head>

<body>

	<div class="header">
		<div class="container">
			<div class="header-wrap">
				<div class="header-wrap-flex">
					<div class="left">
						<a class="titleLink" href="${cpath }"> <img class="logoImg"
							src="${cpath}/resources/image/plan with흰.png"> <img
							class="logoImgHover" src="${cpath}/resources/image/plan with.png">
						</a>
					</div>
					<div class="right">
						<input class="burger-check" type="checkbox" id="burger-check" />
						<label class="burger-icon" for="burger-check"> <span
							class="burger-sticks1"></span> <span class="burger-sticks2"></span>
							<span class="burger-sticks3"></span>
						</label>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="bg">

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

	<!-- 사이드바 -->
	<div id="sidebarOverlay" class="sidebarOverlay hidden"></div>
	<div id="friendOverlay" class="friendOverlay hidden"></div>


	<div id="sidebar" class="sidebar">
		<div class="sidebarHeader">
			<img class="sidebarHeaderImg"
				src="${cpath }/resources/image/plan with.png">
			<button id="closeSidebarBtn" class="closeSidebarBtn">X</button>
		</div>
		<div class="sidebarmodalBox">
			<c:if test="${not empty login }">
				<div class="myPage">
					<img class="profileImg"
						src="${cpath}/upload/${login.memberPhoto != null ? login.memberPhoto : 'default.png'}">
					<div class="myInfo">
						<p>
							<span>${login.nickname }님</span>
						</p>
						<p>
							<a href="${cpath }/member/info">회원정보 변경/관리</a>
						</p>
					</div>
				</div>
				<div class="sidebarFriendDiv">
					<p>
						<button id="friendSearchBtn" class="sidebarBtn">친구찾기</button>
					</p>
					<div class="sidebarListName">친구 목록</div>
					<div id="friendList"></div>
					<div class="sidebarListName">친구 요청</div>
					<div id="friendRequestList"></div>
				</div>
				<ul>
					<li><a href="${cpath}/team/teamList">나의 일정</a></li>
					<li><a href="${cpath}/board/boardList">게시판 보기</a></li>
					<li><a id="logoutBtn" href="${cpath }/member/logout">로그아웃</a></li>
				</ul>

			</c:if>
			<c:if test="${empty login }">
				<p class="small-grey">로그인이 되어있지 않습니다</p>
				<a class="sidebarBtn" href="${cpath }/member/login">로그인 후 이용하기</a>
				<ul>
					<li><a href="${cpath }/team/main">여행지 검색</a></li>
				</ul>
			</c:if>
		</div>
	</div>


	<!-- 친구찾기 모달 -->
	<div id="searchFriendModal" class="modal hidden">
		<div class="modalBox">
			<p>
				<span class="serchFriendModal-title">친구찾기</span>
			</p>
			<form id="searchFriendForm">
				<div class="group">
					<label for="searchFriendModalSearch" class="small-grey">친구
						아이디를 입력하세요</label>
					<p>
						<span> <input id="searchFriendModalSearch"
							class="searchFriendInput input" type="text" name="search"
							autocomplete="off" required>
						</span>
					</p>
				</div>
			</form>
			<div class="searchFriendList"></div>
			<p>
				<button id="closeModalBtn" class="closeModalBtn submit">닫기</button>
			</p>
		</div>
	</div>




	<!-- 이후 스크롤 내리는 부분 -->
	<div class="infoHomeBody">
		<div class="infoThePL">
	        <section class="features">
	            <h2>플랜위드의 특별한 기능</h2>
	            <div class="feature-grid">
	                <div class="feature-item">
	                    <h3>맞춤형 여행 계획</h3>
	                    <p>당신의 취향에 맞는 완벽한 여행 일정을 만들어보세요.</p>
	                    <img src="${cpath}/resources/image/지도 및 계획.png" 
	                    	 alt="기능 1" 
	                    	 style="width: 960px; border: 1px solid #f5f6f7; border-radius: 20px;">
	                </div>
	                <div class="feature-item">
	                    <h3>다양한 정보 공유</h3>
	                    <p>다양한 정보를 공유하고 소통하세요.</p>
	                    <div class="sharing">
	                    	<div class="sharingInfo">
		                    	<span class="blackBigger">
		                    		자유롭게 여행지의 정보와 후기등 <br>
		                    		다양한 소통을 해보세요!
		                    	</span>
		                    	<div class="greySmall">
			                    	<span>
				                    	게시판을 이용해서 다양한 여행 정보와
				                    	꿀팁, 후기등을 알아볼 수 있어요!
				                    	동시에 다양한 사람들과 소통까지!
			                    	</span>
			                    </div>
	                    	</div>
		                    <img src="${cpath}/resources/image/게시판.png" 
		                    	 alt="기능 2" 
		                    	 style="width: 530px; border: 1px solid #f5f6f7; border-radius: 20px;">
	                    </div>
	                </div>
	                <div class="feature-item">
	                    <h3>실시간 계획 및 대화</h3>
	                    <div class="realTime">
	                    	<div class="realTimeInfo">
			                    <span class="blackBigger">
			                    	실시간으로 친구, 가족과 정보를 공유하며 계획을 만들어보세요.
			                    </span>
			                    <div class="greySmall">
			                    	<span>
				                    	우리 플랜위드는 실시간으로 지도와 계획표, 
				                    	그리고 채팅창을 한눈에 이용할 수 있어요!
				                    	보다 원활한 계획을 완성해보세요!
			                    	</span>
			                    </div>
	                    	</div>
		                    <img src="${cpath}/resources/image/대화.png" 
		                    	 alt="기능 3" 
		                    	 style="width: 400px; border: 1px solid #f5f6f7; border-radius: 20px;">
	                    </div>
	                </div>
	            </div>
	        </section>
	    </div>
	</div>

	<script> 
    const cpath = '${cpath}'
    const login = '${login != null ? login : ''}'
    
   	// 사이드 바의 친구목록 (header.jsp 에서 가져옴)
       
	// 회원의 친구 목록 불러오는 함수
	async function loadFriendListHandler() {
   		const url = cpath + '/friends' 
        const result = await fetch(url).then(resp => resp.json())
		// console.log(result)
   		// 친구 목록 
		const friendList = document.getElementById('friendList')

   		let tag = ''
   		result.forEach(member => {
   			tag += '<p class="friendStatus"><span>' + member.nickname + '(' + member.userid + ') </span>'
   			tag += '<span class="' + (member.status == 1 ? 'loginStatus' : 'logoutStatus')+ '"></span></p>'
   		})
			// 결과가 없을 경우
            if (result.length === 0) {
   			tag = '<p class="small-grey">친구 목록이 비어 있습니다.</p>'
   		}
   		friendList.innerHTML = tag    
	}	
   	
   	async function acceptHandler(id) {
   		const url = cpath + '/friends/accept?id=' + id
   		const result = await fetch(url).then(resp => resp.json())
   			// console.log(result)
   		if(result.success) {
   			stomp.send('/app/connection', {} , '친구수락')
   		}
   				
   	}
   		
   	async function rejectHandler(id) {
   		const url = cpath + '/friends/reject?id=' + id
   		const result = await fetch(url).then(resp => resp.json())
   			// console.log(result)
   		if(result.success) {
   			stomp.send('/app/connection', {} , '친구거절')
   		}
   		
   	}
   	
   	// 친구요청목록을 불러오는 함수
   	async function friendRequestList() {
   		const url = cpath + '/friends/friendRequestList?id=${login.id}'
   		const result = await fetch(url).then(resp => resp.json())
   		console.log(result)
   		
   		const friendRequestList = document.getElementById('friendRequestList')
   		
   		let tag = ''
   		result.forEach(ob => {
   			tag += '<p data-id="' + ob.id + '" class="requestFriend-p"><span>' + ob.nickname + '(' + ob.userid + ') </span>'
   			tag += '<button class="accept">수락</button><button class="reject">거절</button></p>'		
   		})
   		 // 결과가 없을 경우
              if (result.length === 0) {
                  tag = '<p class="small-grey">친구 요청이 없습니다.</p>'
              }
   		friendRequestList.innerHTML = tag
   		
   		const acceptBtn = document.querySelector('.accept')
   		const rejectBtn = document.querySelector('.reject')
   		
   		if (acceptBtn != null) {
   			acceptBtn.addEventListener('click', function(event) {
   					const id = event.target.parentNode.dataset.id		
   					acceptHandler(id)
   			})				
   		}
   		if (rejectBtn != null) {
   			document.querySelector('.reject').addEventListener('click', function(event) {
   					const id = event.target.parentNode.dataset.id		
   					rejectHandler(id)
   			})				
   		}
   		
   	}
    
    document.getElementById('startBtn').addEventListener('click', function() {
        location.href = cpath + '/team/main'
    })
	
    const homeLoginBtn = document.getElementById('loginBtn')
    if (homeLoginBtn != null) {
    	homeLoginBtn.addEventListener('click', function() {
	        location.href = cpath + '/member/login'
	    })	
    }
    
    // 헤더 및 배경 변경에 필요한 요소 가져오기
    const header = document.querySelector('.header')
    const changePoint = document.querySelector('.infoHomeBody').offsetTop

    // 스크롤 이벤트 등록
    window.addEventListener('scroll', () => {
        if (window.scrollY >= changePoint) {
            header.style.backgroundColor = '#dadada' // 스크롤 지점 이후 색상 변경
        } else {
            header.style.backgroundColor = 'rgba(255,255,255,0)' // 초기 색상 (투명)
        }
    })
    
    
    // 사이드 바 (header.jsp 에서 가져옴)
    
    const menuBtn = document.getElementById('burger-check')
	const sidebar = document.getElementById('sidebar')
	const closeSidebarBtn = document.getElementById('closeSidebarBtn')
	const sidebarOverlay = document.querySelector('.sidebarOverlay')
	const friendsBtn = document.getElementById('friendsBtn')
   	const friendOverlay = document.querySelector('.friendOverlay')
	
	// 메뉴 버튼 클릭 시 사이드바 열기
	menuBtn.addEventListener('click', function (event) {
			if('${login}' != '') {
				loadFriendListHandler() 
				friendRequestList()
			}
			sidebar.classList.add('open')
			sidebarOverlay.style.display = 'block'
			event.stopPropagation() // 이벤트 전파 중단
	})
      
	// 닫기 버튼 클릭 시 사이드바 닫기
	closeSidebarBtn.addEventListener('click', function (event) {
   			sidebar.classList.remove('open')
   			sidebarOverlay.style.display = 'none'
   			event.stopPropagation() // 이벤트 전파 중단
	})
    
    // 오버레이 클릭시 사이드바 끔
    sidebarOverlay.addEventListener('click', function () {
    	sidebar.classList.remove('open')
		sidebarOverlay.style.display = 'none'
	})
    
	// 사이드바 내부 클릭 시 이벤트 전파 방지
	sidebar.addEventListener('click', function (event) {
			event.stopPropagation() // 이벤트 전파 중단
	})
	
	
		
	// 친구 찾기 모달 
	
	function toggleModal() {
		document.getElementById('searchFriendModal').classList.toggle('hidden')
		document.getElementById('friendOverlay').classList.toggle('hidden')
     	}
     	
	friendOverlay.addEventListener('click', function () {
		document.getElementById('searchFriendModal').classList.toggle('hidden')
		document.getElementById('friendOverlay').classList.toggle('hidden')
	})
      
     	const closeModalBtn = document.getElementById('closeModalBtn')
     	// 닫기 버튼 클릭 시 친구검색 모달이 닫힌다
	closeModalBtn.addEventListener('click', toggleModal)

    	// 친구 검색 시 회원을 조회하는 함수
	async function getMemberList(search = '') {    
     		
		const url = cpath + '/friends/memberList?id=${login.id}&search=' + search
		const result = await fetch(url).then(resp => resp.json())
			// console.log('검색된 회원 목록:', result)
	
		// 검색한 회원들의 목록을 띄운다
		const searchFriendList = document.querySelector('.searchFriendList')

        let tag = ''
		if(search == '') tag = '<p class="small-grey">검색할 회원의 닉네임을 입력하세요.</p>'
		else {
	        result.forEach(member => {
	      		tag += '<p>' + member.nickname +'(' + member.userid + ')'
	      		tag += '<button id="sendFriendRequestBtn" data-memberid="' + member.id + '">친구요청</button></p>'
	        })
	        if (result.length === 0) {
				tag = '<p class="small-grey">이미 친구거나, 해당하는 회원이 없습니다.</p>'
			}				
		}
		searchFriendList.innerHTML = tag
		
		// 친구요청을 보내는 이벤트 연결
		const sendFriendRequestBtn = document.getElementById('sendFriendRequestBtn')
		if (sendFriendRequestBtn != null) {
			sendFriendRequestBtn.addEventListener('click', function(event) {
					const memberId = event.currentTarget.dataset.memberid
					console.log('memberId : ' + memberId + 'login.id : ${login.id}')
					const message = {
							sender: '${login.id}',
							receiver: memberId
					}
					stomp.send('/app/friendRequest', {}, JSON.stringify(message))
					toggleModal()
			})         			
		}
		
	}
      	
	// 친구찾기 버튼 누르면 실행되는 함수
	function FriendSearchHandler() {
		toggleModal()		
		// 모달 내부 검색 폼 처리
		const searchFriendForm = document.getElementById('searchFriendForm')
		const searchFriendInput = searchFriendForm.querySelector('input[name="search"]')
		searchFriendInput.addEventListener('keyup', function(event) {
				const search = event.target.value
				getMemberList(search)
		})
	}
	  				
	const friendSearchBtn = document.getElementById('friendSearchBtn')	  
	if('${login}' != '') {
		friendSearchBtn.addEventListener('click', FriendSearchHandler)		  
	}
	
	// WebSocket 연결	     
	const sockJS = new SockJS(cpath + '/endpoint')
	const stomp = Stomp.over(sockJS)
	   
	if ('${login}' != '') {
		stomp.connect({}, onConnect)
	}
	
	function onConnect() {
		console.log('WebSocket 연결 성공')
		stomp.subscribe('/broker/login', onLoginConnect)
		stomp.send('/app/connection', {} , '${login.nickname}님이 로그인했습니다')	// 내 접속 상태를 알린다
		stomp.subscribe('/broker/allMember', onReceiveAlert)	// 친구요청을 위한 stomp 구독
	}
	
	// 웹소켓으로 메시지를 받으면 친구목록을 새로고침한다
	function onLoginConnect(message) {
		loadFriendListHandler()		
		friendRequestList()
	}
	
	// 친구요청을 받았을 때 
	function onReceiveAlert(message) {
			// console.log("친구요청 받았을 때 아이디가 넘어온다 : " + message)
		if(message = '${login.id}') {
			friendRequestList()
		} 			
	}
	
	const logoutBtn = document.getElementById('logoutBtn')
	if(logoutBtn != null) {
		logoutBtn.onclick = function(event) {
			event.preventDefault()
			stomp.send('/app/connection', {} , '${login.nickname}님이 로그아웃했습니다')
			location.href = this.href
		}
	}
    
    
</script>

	<%@ include file="footer.jsp"%>