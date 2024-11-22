<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="cpath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>함께 만드는 여행: 플랜위드</title>
<style>
/* 폰트 적용 */
@import
	url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap')
	;
/*    참고
   .noto-sans-kr-<uniquifier> {
     font-family: "Noto Sans KR", sans-serif;
     font-optical-sizing: auto;
     font-weight: <weight>;
     font-style: normal;
   }
*/
</style>
<style>
body {
	font-family: "Noto Sans KR", sans-serif;
	position: relative;
}

a {
	text-decoration: none;
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

body, html {
	margin: 0;
	padding: 0;
	width: 100vw;
	height: 100vh;
	overflow-x: hidden; /* 수정필요 */
}

header {
	width: 100%;
	height: 70px;
	background-color: white;
	border-bottom: 1px solid #f5f6f8;
	position: fixed;
	z-index: 5;
}

.header-flex {
	width: 1160px;
	margin: 0 auto;
	height: 30px;
	padding: 20px;
	display: flex;
	justify-content: space-between;
}

.header-flex>.header-left {
	display: flex;
	justify-content: center;
	align-items: center;
	padding-left: 10px;
}

#logoImg {
	/*          height: 50px; */
	width: 100px;
	height: 23.8px;
}

.buttons {
	display: flex;
	width: 500px;
	justify-content: space-between;
}

.header-right {
	display: flex;
	justify-content: center;
	align-items: center;
}

.button {
	border: 1px solid #dadada;
	margin: 5px;
	border-radius: 10px;
	width: 60px;
	height: 40px;
}

#logoImg:hover {
	cursor: pointer;
}

.button:hover {
	cursor: pointer;
	background-color: #96C6D2;
}

.disabled {
	display: none;
}

.small-grey {
   font-size: 0.75rem;
   /*        color: #adb5bd; */
   color: #999999;
   /*        color: #868e90; */
   font-weight: 400;
   text-decoration: none;
   text-align: center;
}

/*    ----------------------------------------- style 사이드바 수정한 곳 ----------------------------------------- */
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
	z-index: 20;
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
	color: #495057;				/* 회색 살짝 들어간 검은색 */
}

.sidebarmodalBox #friendList {
	background-color: #f8f9fa;	
}


.sidebarmodalBox #friendList p {
	margin: 0;
	padding:12px;
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
	  width : 0.8rem;
	  height : 0.8rem;
	  border-radius: 50%;
	  background-color: green;
}

.sidebarmodalBox #friendList .logoutStatus {
	  width : 0.8rem;
	  height : 0.8rem;
	  border-radius: 50%;
	  background-color: grey;
}

.sidebarOverlay {
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.4);
	z-index: 4;
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


/*    -------------------------------- footer ----------------------------------------- */
footer {
	bottom: -50%;
	width: 100%;
	height: 205px;
	display: flex;
	justify-content: center;
	background-color: whitesmoke;
	border-top: 1px solid rgb(219, 219, 219);
	position: absolute;
	z-index: 5;
	width: 100%;
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

/* ---------------------------------------------  modal  ---------------------------------------------- */
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
	border: 1px solid black;
	border-radius: 25px;
	z-index: 7;
	left: 25%;
	top: 15%;
}

.modalBox > p {
	display: flex;
	justify-content: center;
	align-items: center;
	margin: auto;
}

#searchFriendModal .serchFriendModal-title{
	font-size: 1.3rem;
  	margin-bottom: 2rem;
  	display: flex;
  	align-items: center;
  	margin: auto;
  	font-size: 1.1rem;
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
	margin-right: 0.8rem;
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
}

#searchFriendModal .input {
	width: 100%;
}

#searchFriendModal .input:focus {
    border-color: #B1C9EF;
    outline: none;
}

#searchFriendModal .searchFriendList {
	border: 1px dashed blue;
	width: 450px;;
	height: 230px;
	padding: 10px;
}

#searchFriendModal .searchFriendInput {
	border: 1px solid #d3d3d3;
	border-radius: 5px;
	font-size: 1rem;
	box-sizing: border-box;
	padding: 10px;
}

#searchFriendModal .searchSubmit {
	border: 1px solid #d3d3d3;
	border-radius: 5px;
	font-size: 0.9rem;
	box-sizing: border-box;
	color: white;
	border: none;
	cursor: pointer;
	transition: background-color 0.3s;
	width: 5rem;
	height: 40px;
}

#searchFriendModal .searchSubmit:hover {
}

.hidden {
	display: none;
}
</style>


<!-- sweetalert -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />

<!-- summernote -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="${cpath }/resources/script/summernote-lite.js"></script>
<script src="${cpath }/resources/script/summernote-ko-KR.js"></script>
<link type="text/css" rel="stylesheet"
	href="${cpath }/resources/style/summernote-lite.css">

<!-- sockjs, stomp -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.js"></script>

<!-- 다음 주소 API -->
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<!-- 카카오맵 API -->
<script
	src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=9e3658bf7037a3bf6fa2967e59b96526&libraries=services,clusterer"></script>

<!-- dateRangePicker -->
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
</head>
<body>

	<header>
		<div class="header-flex">
			<div class="header-left">
				<img id="logoImg" src="${cpath }/resources/image/plan with.png">
			</div>
			<div class="header-right">
				<button id="boardBtn" class="button">게시판</button>
				<button id="menuBtn" class="button">메뉴</button>
			</div>
		</div>
	</header>

	<!-- ------------------------------------ jps div 추가 아래부터 sidebarOverlay 까지 복붙 ------------------------------------------ -->

	<div id="sidebar" class="sidebar">
		<div class="sidebarHeader">
			<img class="sidebarHeaderImg" src="${cpath }/resources/image/plan with.png">
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
	<div class="sidebarOverlay"></div>

<!-- 	<footer> -->
<%-- 		<c:if test="${footerVisible != false}"> --%>
<!-- 			<div class="footinfo"> -->
<!-- 				<div class="top"> -->
<!-- 					<div class="left"> -->
<!-- 						<span>고객 센터</span> -->
<!-- 					</div> -->
<!-- 					<div class="right"> -->
<%-- 						<a href="${cpath}/member/login">MEMBER</a> --%>
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 				<div class="middle"> -->
<!-- 					<span> (주)기범컴퍼니 플랜위드는 통신판매중개로서 통신판매의 당사자가 아니며<br> 상품 -->
<!-- 						거래정보 및 거래등에 대한 책임을 지지않습니다. -->
<!-- 					</span> -->
<!-- 				</div> -->
<!-- 				<div class="bottom"> -->
<!-- 					<div class="left"> -->
<!-- 						<span>서비스 이용약관 | 개인정보 처리방침 | 고객 센터</span> -->
<!-- 					</div> -->
<!-- 					<div class="right"> -->
<%-- 						<img src="${cpath }/resources/image/으헝.jpg"> --%>
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
<%-- 		</c:if> --%>
<!-- 	</footer> -->

	<!-- 친구찾기 모달 -->
	<div id="searchFriendModal" class="modal hidden">
		<div class="overlay"></div>
		<div class="modalBox">
			<p>
				<span class="serchFriendModal-title">친구찾기</span>
			</p>
			<form id="searchFriendForm">
				<div class="group">
					
					<p>
						<span>
							<input id="searchFriendModalSearch" class="searchFriendInput input" 
							   	   type="text" name="search" autocomplete="off" required> 
						</span>
						<span>
							<input class="searchSubmit submit" type="submit" value="검색">
						</span>
					</p>
					<label for="searchFriendModalSearch" class="small-grey">친구 아이디를 입력하세요</label>
				</div>
			</form>
			<div class="searchFriendList"></div>
			<p>
				<button id="closeModalBtn" class="closeModalBtn">닫기</button>
			</p>
		</div>
	</div>


	<script>
		const cpath = '${cpath}'
		const login = '${login != null ? login : ''}'	// 회원/비회원 체크 
		 
	    // 회원의 친구 목록 불러오는 함수
	    async function loadFriendListHandler() {
			const url = cpath + '/friends' 
            const result = await fetch(url).then(resp => resp.json())
//          	console.log(result)
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
		
		document.getElementById('logoImg').addEventListener('click', function() {
				location.href = cpath
		})
		document.getElementById('boardBtn').addEventListener('click', function() {
				location.href = cpath + '/board/boardList'
		})	
		
		async function acceptHandler(id) {
			const url = cpath + '/friends/accept?id=' + id
			const reult = await fetch(url).then(resp => resp.json())
			console.log(result)
			if(result.success) {
				stomp.send('/app/connection', {} , '친구수락')
			}
					
		}
		
		async function rejectHandler() {
			const url = cpath + '/friends/reject?id=' + id
			const reult = await fetch(url).then(resp => resp.json())
			console.log(result)
			if(result.success) {
				stomp.send('/app/connection', {} , '친구거절')
			}
			
		}
		
		// 친구요청목록을 불러오는 함수
		async function friendRequestList() {
			const url = cpath + '/friends/friendRequestList'
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
			
			document.querySelector('.accept').addEventListener('click', function(event) {
					const id = event.target.parentNode.dataset.id		
					acceptHandler(id)
			})
			
			document.querySelector('.reject').addEventListener('click', function(event) {
					const id = event.target.parentNode.dataset.id		
					rejectHandler(id)
			})
		}

// ----- 사이드 바 스크립트 -----
		const menuBtn = document.getElementById('menuBtn')
		const sidebar = document.getElementById('sidebar')
		const closeSidebarBtn = document.getElementById('closeSidebarBtn')
		const sidebarModalOverlay = document.querySelector('.sidebarOverlay')
		const friendsBtn = document.getElementById('friendsBtn')
	      
		// 메뉴 버튼 클릭 시 사이드바 열기
		menuBtn.addEventListener('click', function (event) {
				if('${login}' != '') {
					loadFriendListHandler() 
					friendRequestList()
				}
				sidebar.classList.add('open')
				sidebarModalOverlay.style.display = 'block'
				event.stopPropagation() // 이벤트 전파 중단
		})
	      
		// 닫기 버튼 클릭 시 사이드바 닫기
		closeSidebarBtn.addEventListener('click', function (event) {
    			sidebar.classList.remove('open')
    			sidebarModalOverlay.style.display = 'none'
    			event.stopPropagation() // 이벤트 전파 중단
		})
	      
		// 문서의 다른 부분 클릭 시 사이드바 닫기
		document.addEventListener('click', function () {
				sidebar.classList.remove('open')
				sidebarModalOverlay.style.display = 'none'
		})
	      
		// 사이드바 내부 클릭 시 이벤트 전파 방지
		sidebar.addEventListener('click', function (event) {
				event.stopPropagation() // 이벤트 전파 중단
		})
	      
// ----- 친구검색 스크립트 -----

		// 친구 찾기 모달 
		function toggleModal() {
			document.getElementById('searchFriendModal').classList.toggle('hidden')
      	}
	      
      	const closeModalBtn = document.getElementById('closeModalBtn')
      	// 닫기 버튼 클릭 시 친구검색 모달이 닫힌다
		closeModalBtn.addEventListener('click', toggleModal)

     	// 친구 검색 시 회원을 조회하는 함수
		async function getMemberList(search = '') {    
      		
			const url = cpath + '/friends/memberList?search=' + search
			const result = await fetch(url).then(resp => resp.json())
// 			console.log('검색된 회원 목록:', result)
		
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
					tag = '<p class="small-grey">해당하는 회원이 없습니다.</p>'
				}				
			}
			searchFriendList.innerHTML = tag
			
			// 친구요청을 보내는 이벤트 연결
			const sendFriendRequestBtn = document.getElementById('sendFriendRequestBtn')
			if (sendFriendRequestBtn != null) {
				sendFriendRequestBtn.addEventListener('click', function(event) {
						const memberId = event.currentTarget.dataset.memberid
						console.log(memberId)
						const message = {
								sender: '${login.id}',
								receiver: memberId
						}
						stomp.send('/app/friendRequest', {}, JSON.stringify(message))				
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
	 	</script>

		<script>      
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
			stomp.subscribe('/broker/friendRequest', onReceiveFriendRequest)	// 친구요청을 위한 stomp 구독
	      }
	
		// 웹소켓으로 메시지를 받으면 친구목록을 새로고침한다
		function onLoginConnect(message) {
			loadFriendListHandler()		
			friendRequestList()
		}
		
		// 친구요청을 받았을 때 
		function onReceiveFriendRequest(message) {
			console.log(message)
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
	
	