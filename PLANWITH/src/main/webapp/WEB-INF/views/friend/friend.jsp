<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<style>
  .hidden {
      display: none;
   }
   .modal > .content {
      width: 500px;
      height: 320px;
      background-color: white;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      z-index: 2;
      position: fixed;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      border-radius: 25px;
      box-shadow: 20px 20px 20px black;
   } 
	.modal > .overlay {
      width: 100%;
      height: 100%;
      position: fixed;
      top: 0;
      left: 0;
      background-color: rgba(0, 0, 0, 0.8);
      z-index: 1;
   }
	.memberDiv {
		display: flex;
		justify-content: space-between;
	}

</style>

<h3>친구목록</h3>

<button id="logoutBtn">로그아웃</button>

<button id="infoBtn">내친구목록</button>
<button id="friendSearchBtn">친구찾기</button>

<div id="friendList"></div>

<div id="addModal" class="modal hidden">
	<div class="overlay"></div>
	<div class="content">
		<form id="searchFriendForm">
			<p>
				<input type="text" name="userid" placeholder="친구 아이디를 입력하세요" autocomplete="off">
				<input type="submit" value="검색">
			</p>
		</form>
	</div>
</div>



<script>

	
	// 모달안에다가 memberList 띄우기
	async function getMemberList(search) {
// 		if(search == undefined) {
// 			search = ''
// 		}
		
		const url = '${cpath}/friends/memberList?search=' + search 
		const result = await fetch(url).then(resp => resp.json())
		
		let memberList = document.querySelector('.memberList')
		if(memberList == null) {
	    	memberList = document.createElement('div')
	    }
		
		let tag = ''
		result.forEach(member => {
			tag += '<div class="memberDiv">'
			tag += '	<p>' + member.nickname +'(' + member.userid + ')</p>'
			tag += '	<p><button id="sendFriendRequestBtn" data-memberId="' + member.id + '">친구요청</button></p>'
			tag += '</div>'
		})
		memberList.innerHTML = tag

		memberList.classList.add('memberList')
		
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

	function getFriendSearchListHandler(event) {
		modalHandler()

		document.getElementById('searchFriendForm').querySelector('input[name="userid"]').addEventListener('keyup', function(event) {
			const search = event.target.value
			getMemberList(search)
		})

	} 
	const friendSearchBtn = document.getElementById('friendSearchBtn')
	friendSearchBtn.addEventListener('click', getFriendSearchListHandler)
</script>




<script>
	// 친구들의 상태를 불러오는 스크립트

	// 로그인하면 스톰프에 메세지 보내고 해당 멤버 친구들 연결
	const sockJS = new SockJS('${cpath}/endpoint') 
	const stomp = Stomp.over(sockJS)  
	
		// 로그인이 되어 있으면 STOMP 연결, onConnect 함수 실행
	if('${login}' != '') {
    	stomp.connect({}, onConnect) 		
	}

	function loadHandler() {
		loadFriendListHandler()		
	}
		
	// 연결이 되면 내 접속상태를 보낸다
	function onConnect() {
		stomp.subscribe('/broker/status', onCheckStatus) // /broker/friend의 메시지를 구독하고 수신가능, 수신시 onCheckStatus 함수 실행
		stomp.send('/app/connection', {} , '${login.nickname}님이 로그인했습니다')	// 내 접속 상태를 알린다
		stomp.subscribe('/broker/online', onReceiveFriendRequest)	// 친구요청을 위한 stomp 구독
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
		
	const logoutBtn = document.getElementById('logoutBtn')
	logoutBtn.addEventListener('click', onDisconnect)

	window.addEventListener('DOMContentLoaded', loadHandler)
</script>
</body>
</html>