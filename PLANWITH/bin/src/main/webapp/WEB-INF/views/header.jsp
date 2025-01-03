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
	
}

.header-flex {
	height: 50px;
	background-color: #96C6D2;
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
}

.button {
	border: 2px solid #96C6D2;
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

/*    ----------------------------------------- style 사이드바 수정한 곳 ----------------------------------------- */
.sidebar {
	width: 300px;
	height: 100vh;
	background-color: #f8f9fa;
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
	padding: 15px;
	background-color: #96C6D2;
	color: white;
	border-bottom: 1px solid #e0e0e0;
}

.closeSidebarBtn {
	background: none;
	border: none;
	font-size: 18px;
	color: white;
	cursor: pointer;
}

.sidebarContent {
	padding: 20px;
}

.sidebarContent ul {
	list-style: none;
	padding: 0;
	margin: 0;
}

.sidebarContent ul li {
	margin: 15px 0;
}

.sidebarContent ul li a {
	text-decoration: none;
	color: #333;
	font-size: 16px;
	transition: color 0.3s ease;
}

.sidebarContent ul li a:hover {
	color: #96C6D2;
}

.modal-overlay {
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.4);
	z-index: 10;
}

.myPage {
	display: flex;
	justify-content: space-between;
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

.profileImg {
	width: 70px;
	height: 70px;
	border-radius: 50%;
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

#friendsBtn {
	border: 0;
	background-color: rgba(255, 255, 255, 0);
	font-size: 16px;
	transition: color 0.3s ease;
	cursor: pointer;
	padding: 0;
	color: #333;
}

#friendsBtn:hover {
	color: #96C6D2;
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
				<img id="logoImg" src="${cpath }/resources/image/plan with흰.png">
			</div>
			<div class="buttons">
				<button id="scheduleBtn" class="button disabled">일정</button>
				<button id="mapBtn" class="button disabled">지도</button>
				<button id="chatBtn" class="button disabled">채팅</button>
			</div>
			<div class="header-right">
				<button id="boardBtn" class="button">게시판</button>
				<button id="menuBtn" class="button">메뉴</button>
			</div>
		</div>
	</header>

	<!-- ------------------------------------ jps div 추가 아래부터 modal-overlay 까지 복붙 ------------------------------------------ -->

	<div id="sidebar" class="sidebar">
		<div class="sidebarHeader">
			<h3>메뉴</h3>
			<button id="closeSidebar" class="closeSidebarBtn">X</button>
		</div>
		<div class="sidebarContent">
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
				<div class="friendList"></div>
				<p>
					<button id="friendSearchBtn">친구찾기</button>
				</p>
				<div class="addFriendRequest"></div>
			</c:if>
			<c:if test="${empty login }">
				<ul>
					<li><a href="${cpath }/team/main">여행지 검색</a></li>
					<li><a href="${cpath }/member/login">로그인 후 이용하기</a></li>
				</ul>
			</c:if>
		</div>
	</div>

	<div class="modal-overlay"></div>

	<footer>
		<c:if test="${footerVisible != false}">
			<div class="footinfo">
				<div class="top">
					<div class="left">
						<span>고객 센터</span>
					</div>
					<div class="right">
						<a href="${cpath}/member/login">MEMBER</a>
					</div>
				</div>
				<div class="middle">
					<span> (주)기범컴퍼니 플랜위드는 통신판매중개로서 통신판매의 당사자가 아니며<br> 상품
						거래정보 및 거래등에 대한 책임을 지지않습니다.
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
		</c:if>
	</footer>

	<!-- 친구찾기 모달 -->
	<div id="addModal" class="modal hidden">
		<div class="overlay"></div>
		<div class="content">
			<form id="searchFriendForm">
				<p>
					<input type="text" name="userid" placeholder="친구 아이디를 입력하세요"
						autocomplete="off"> <input type="submit" value="검색">
				</p>
			</form>
		</div>
	</div>


<!-- 스크립트 -------------------------------------->

	<script>
	
		const cpath = '${cpath}'
		// 회원/비회원 체크
		const login = '${login != null ? login : 'null'}'
	
	</script>




	<script>
      function disableHandler() {
         document.getElementById('scheduleBtn').classList.remove('disabled')
         document.getElementById('mapBtn').classList.remove('disabled')
         document.getElementById('chatBtn').classList.remove('disabled')
      }

      document.getElementById('logoImg').addEventListener('click',
            function() {

               location.href = cpath + '/team/main'

            })

      document.getElementById('boardBtn').addEventListener('click',
            function() {
               location.href = cpath + '/board/boardList'
            })

      //------------------------------------------ 아래 스크립트 부분 붙여넣기 하면 됨 ------------------------------------------------
      // 사이드 바 스크립트 내용
      // 사이드 바 스크립트
      const menuBtn = document.getElementById('menuBtn')
      const sidebar = document.getElementById('sidebar')
      const closeSidebarBtn = document.getElementById('closeSidebar')
      const modalOverlay = document.querySelector('.modal-overlay')
      const friendsBtn = document.getElementById('friendsBtn')
      
      // 메뉴 버튼 클릭 시 사이드바 열기
      menuBtn.addEventListener('click', function (event) {
          sidebar.classList.add('open')
          modalOverlay.style.display = 'block'
          event.stopPropagation() // 이벤트 전파 중단
      })
      
      // 닫기 버튼 클릭 시 사이드바 닫기
      closeSidebarBtn.addEventListener('click', function (event) {
          sidebar.classList.remove('open')
          modalOverlay.style.display = 'none'
          event.stopPropagation() // 이벤트 전파 중단
      });
      
      // 문서의 다른 부분 클릭 시 사이드바 닫기
      document.addEventListener('click', function () {
          sidebar.classList.remove('open')
          modalOverlay.style.display = 'none'
      })
      
      // 사이드바 내부 클릭 시 이벤트 전파 방지
      sidebar.addEventListener('click', function (event) {
          event.stopPropagation() // 이벤트 전파 중단
      });
      
      // ----------------------------------------------- 친구목록 ------------------------------------------------
      
      // 친구 목록 불러오기
      async function loadFriendListHandler() {

              const url = '${cpath}/friends' // 서버 API URL
              let result = await fetch(url)
              if(!result) result = result.then(resp => resp.json())
              console.log(result)
              const friendList = document.getElementById('friendList')
              if (!friendList) {
                  console.log('friendList 가 없습니다')
                  return
              }

              // 친구 목록 렌더링
			  let tag = ''
			  result.forEach(member => {
				tag += '<p><span>' + member.nickname + '(' + member.userid + ') </span>'
				tag += '<span class="' + (member.status == 1 ? 'green' : 'grey') + '"></span></p>'
			  })

              // 결과가 없을 경우
              if (result.length === 0) {
                  tag = '<p>친구 목록이 비어 있습니다.</p>'
              }

              friendList.innerHTML = tag    
      }

      
      // loadFreindHandler 는 사이드바가 열리면 실행 되게끔 ... 수정
      const infoBtn = document.getElementById('infoBtn')
      if (infoBtn) {
          infoBtn.addEventListener('click', loadFriendListHandler)
      }

      
      // 친구 찾기 모달 열기 및 검색 처리
      function toggleModal() {
          document.getElementById('addModal').classList.toggle('hidden')
      }

	  async function getMemberList(search = '') {
        
              const url = '${cpath}/friends/memberList?search=' + search
              const result = await fetch(url).then(resp => resp.json())
              console.log('검색된 회원 목록:', result)

              let memberList = document.querySelector('.memberList')
              if (!memberList) {
                  memberList = document.createElement('div')
                  memberList.classList.add('memberList')
              }

              // 회원 목록 렌더링
              let tag = ''
              result.forEach(member => {
            	tag += '<p>' + member.nickname +'(' + member.userid + ')</p>'
      			tag += '<p>'
            	tag += '	<button id="sendFriendRequestBtn" data-memberId="' + member.id + '">친구요청</button>'
            	tag += '</p>'
              })

			memberList.innerHTML = tag

              // 모달에 추가
			document.querySelector('#addModal > .content').appendChild(memberList)
    
            // 아직 친구요청 구현 X .. memberId 가 안넘어옴
			const sendFriendRequestBtn = document.getElementById('sendFriendRequestBtn')
			sendFriendRequestBtn.addEventListener('click', function(event) {
				const memberId = event.target.dataset.memberId
				console.log(memberId)
				const message = {
						sender: '${login.id}',
						receiver: memberId
				}
				stomp.send('/app/friendRequest', {}, JSON.stringify(message))				
		})         
      }
     
	function getFriendSearchListHandler() {
          toggleModal()

          // 모달 내부 검색 폼 처리
	 	  const searchFriendForm = document.getElementById('searchFriendForm')
		  const searchInput = searchFriendForm.querySelector('input[name="userid"]')
		  searchInput.addEventListener('keyup', (event) => {
	             const search = event.target.value
	             getMemberList(search)
          })
	}
   
	
	  const friendSearchBtn = document.getElementById('friendSearchBtn')
	  console.log(friendSearchBtn)
	  
	  if('${login}' != '') {
		  friendSearchBtn.addEventListener('click', getFriendSearchListHandler)		  
	  }
 	</script>

	<script>      
      // WebSocket 연결

      
      const sockJS = new SockJS('${cpath}/endpoint')
      const stomp = Stomp.over(sockJS)
      
      if ('${login}' != '') {
          stomp.connect({}, onConnect)
      }

      function onConnect() {
		console.log('WebSocket 연결 성공')
		stomp.subscribe('/broker/status', onCheckStatus) // /broker/friend의 메시지를 구독하고 수신가능, 수신시 onCheckStatus 함수 실행
		stomp.send('/app/connection', {} , '${login.nickname}님이 로그인했습니다')	// 내 접속 상태를 알린다
// 		stomp.subscribe('/broker/online', onReceiveFriendRequest)	// 친구요청을 위한 stomp 구독
      }

	// 웹소켓으로 메시지를 받으면 친구목록을 새로고침한다
	function onCheckStatus(message) {
		loadFriendListHandler()			
	}
	
	// 웹소켓 연결이 끊기면 함수가 실행된다 (끊기는 시점은 .. 로그아웃 했을때)
	function onDisconnect() {
		stomp.send('/app/connection', {} , '${login.nickname}님이 로그아웃했습니다')
		location.href = '${cpath }/member/logout'
	}
		
// 	const logoutBtn = document.getElementById('logoutBtn')
// 	logoutBtn.addEventListener('click', onDisconnect)
	
	window.addEventListener('DOMContentLoaded', loadFriendListHandler)
      
   </script>