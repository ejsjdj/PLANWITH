<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<!-- 이건 채팅 스타일 -->
<style>
body {
	overflow: hidden;
}

#chatBoxBtn {
    position: absolute;
    right: 5rem;
    bottom: 5rem;
    z-index: 300;
    border-radius: 50%;
    justify-content: center;
    align-items: center;
    background: #033495;
    background: #3379ff;
    
    width: 3rem;
    height: 3rem;
    display: flex;
    box-shadow: 0 14px 28px rgba(0, 0, 0, 0.2), 0 10px 10px rgba(0, 0, 0, 0.2);
}

#chatBoxBtn:hover {
	cursor: pointer;
}

#chatBoxBtn img {
	width: 1.5rem;
}

#chatArea {
	position: absolute;
	width: 15%;
	height: 500px;
	z-index: 15;
	right: 8rem;
	bottom: 5rem;
	width: 400px;
	background-color: white;
	border-radius: 0.5rem;
/* 	display: flex;  /* 이거 하면 hidden 안 됨 */
	overflow: hidden;
	box-shadow: 0 14px 28px rgba(0, 0, 0, 0.3), 0 10px 10px rgba(0, 0, 0, 0.3);
}

#chatArea .small-white {
    font-size: 0.8rem;
/*        color: #adb5bd; */
/*     color: #999999;  */
/*     color: white;  */
	color: #cccccc;
/*        color: #868e90; */
   	font-weight: 300;
   	text-decoration: none;
	text-align: center;
}

.chatTop {
	height: 50px;
}

.chatBox {
	display: flex;
	flex-flow: column;
	height: 100%;
	width: 100%;
	border-radius: 1rem;
}

.topSideChat {
	flex: 1;
	padding: 10px;
	
	background: #3379ff;
	color: white;
}

.topSideChat .topleft {
	float: left;
	padding: 10px;
}

.topSideChat .topleft #teamName {
	font-size: 1.2rem;
	font-weight: 500;
	margin-top: 5px;
}

.topSideChat .topleft img {
	width: 0.7rem;
   	opacity: 0.3;
  	margin: auto;
	filter: invert(100%) sepia(3%) saturate(5%) hue-rotate(352deg) brightness(104%) contrast(100%);
}

.topSideChat .topRight {
	float: right;
	display: flex;
	padding: 10px;
}

.topRight button {
	border-radius: 2rem;
    height: 30px;
    box-sizing: border-box;
    /* background-color: #033495; */
    color: white;
    font-size: 0.7rem;
    font-weight: 100;
    margin-left: 10px;
    margin-top: 5px;
    padding: 8px 10px;
}

#inviteCode button {
	border: 0px solid black;
	background-color: rgba(255, 255, 255, 0.1);
}

#exitTeamBtn button {
	border: 0px solid black;
    background-color: rgba(0, 0, 0, 0.2);
}

.topSideChat #participatingMembers {
	display: flex;
	font-weight: 400;
}

.middleSideChat {
	flex: 4;
	overflow-y: auto; /* 스크롤 ㄱㄴ */
	padding: 20px;
	font-size: 0.8rem;
}

.middleSideChat .userMessageContainer {
	display: flex;
	align-items: center;
	margin: 7px 0;
	margin-right: 3px;
	align-items: end;
}

.userMessageContainer .sentTime {
	font-size: 0.6rem;	
}

.middleSideChat .myMessageContainer {
    justify-content: right;
}

.middleSideChat .otherMessageContainer {

}

.userMessageContainer .userImg {
    display: flex;
    margin-right: 5px; 
}

.userMessageContainer .chatProfileImg {
	border-radius: 50%;
}

.otherMessageContainer .messageContainer {
	margin-right: 5px;
}

.myMessageContainer .messageContainer {
	margin-left: 5px;
}

.userMessageContainer .otherMessageContainer {

}

.userMessageContainer .otherName {
	font-size: 0.7rem;
}

.userMessageContainer .messageDiv {
	border-radius: 0.5rem;
    background: #3379ff;
    color: white;
    padding: 4px 8px;
    font-size: 0.7rem;
    text-align: left;
	
}

.middleSideChat .systemMessageContainer {
    padding: 3px;
    background: #eeeeee;
    margin: 8px 0;
    font-size: 0.7rem;
    text-align: center;
    border-radius: 1rem;
}

.bottomSideChat {
	height: 50px	;
	background-color: white;
}

.bottomSideChat #inputChat{
	height: 100%;
	display: flex;
    align-items: center;
    padding: 1px 10px;
    border-top: 0.1px solid #f9f8fa;
}

.bottomSideChat #textarea {
    resize: none;
    height: 20px;
    flex: 9;
    border: 1px solid #dadada;
    border-radius: 2rem;
    margin-right: 10px;
}

.bottomSideChat input {
/*     height: 20px; */
    flex: 1;
    border-radius: 2rem;
    border: 0px solid #dadada;
    height: 25px;
    box-sizing: border-box;
/*     background-color: #033495; */
	background: #788AB2;
	background: #3379ff;
    color: white;
    font-size: 0.7rem;
    font-weight: 100;	
}

.bottomSideChat #textarea:focus {
	border-color: #B1C9EF;
    outline: none;

}

.chatProfileImg {
	width: 30px;
	height: 30px;
}
</style>

<style>

.schedule {
}

.schedule div:nth-of-type(3) {
	flex: 1;
}
.schedule-item {
	border: 1px solid #e0e0e0;
	border-radius: 8px;
	padding: 15px;
	margin-bottom: 10px;
	background-color: #f9f9f9;
}

.schedule-title {
	font-weight: bold;
	font-size: 18px;
	color: #333;
	display: block;
	margin-bottom: 10px;
}

.scheduleTitle {
	font-size: 1rem;
	flex: 1;
}

.deleteScheduleBtn {
	height: 1.5rem;
}

.schedule-time {
	font-size: 14px;
	color: #666;
}

.start-time, .end-time {
	background-color: #e9ecef;
	padding: 3px 8px;
	border-radius: 4px;
}

.time-separator {
	margin: 0 5px;
}
</style>

<style>
/*    모달구현을 위한 스타일 */
#timeModal {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.7);
	z-index: 1000;
}

.hidden {
	display: none;
}

#modal>.overlay {
	position: fixed;
	background-color: rgba(0, 0, 0, 0.5);
	width: 100%;
	height: 100%;
	top: 0;
	left: 0;
	z-index: 500;
}

#modal>div#content {
	background-color: white;
	width: 80%;
	max-width: 600px;
	margin: 50px auto;
	padding: 20px;
	border-radius: 5px;
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	width: 100%;
	height: 100%;
	z-index: 1000;
	overflow-y: auto;
}

#imageArea img {
	max-width: 100%;
	height: auto;
}

#titleArea {
	font-size: 24px;
	font-weight: bold;
	margin-bottom: 10px;
}

#addressArea {
	margin-bottom: 20px;
}

#linkArea a {
	display: block;
	margin-bottom: 10px;
	color: #0066cc;
	text-decoration: none;
}

#linkArea a:hover {
	text-decoration: underline;
}

* {
	margin: 0;
}
/*    지도 구현을 위한 스타일 */
.map_wrap, .map_wrap * {
	margin: 0;
	padding: 0;
	font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
	font-size: 12px;
}

.map_wrap a, .map_wrap a:hover, .map_wrap a:active {
	color: #000;
	text-decoration: none;
}

.map_wrap {
	/* 	position: absolute; */
	width: 100%;
	height: 90%;
	right: 20%;
}

#menu_wrap {
	position: absolute;
	top: 70px;
	bottom: 0;
	width: 300px;
	height: 100%;
	padding: 5px;
	overflow-y: auto;
	background: rgba(255, 255, 255, 1);
	z-index: 2;
	font-size: 12px;
	border-radius: 10px;
}

#searchPlacesInput {
	display: flex;
}

#searchPlacesInput input,
#searchPlacesInput button
 {
    width: calc(100%);
    padding: 10px;
    margin: 5px auto;
    border: 1px solid #d3d3d3;
    border-radius: 5px;
    font-size: 0.8rem;
    box-sizing: border-box;
}

#searchPlacesInput button {
	width: 7rem;
	background: #3379ff;
	color: white;
	border: 0px solid black;
	height: 95%;
}

#searchPlacesInput input:focus {
	border-color: #B1C9EF;
    outline: none;
}

.bg_white {
	background: #fff;
}

#menu_wrap hr {
	display: block;
	height: 1px;
	border: 0;
	border-top: 2px solid #5F5F5F;
	margin: 3px 0;
}

#menu_wrap .option {
	text-align: center;
}

#menu_wrap .option p {
	margin: 10px 0;
}

#menu_wrap .option button {
	margin-left: 5px;
}

/*    카테고리검색을 위한 스타일 */
#category {
	position: absolute;
    right: 0;
    border-radius: 5px;
/*     border: 1px solid #909090; */
/*     box-shadow: 0 1px 1px rgba(0, 0, 0, 0.4); */
    background: #fff;
    overflow: hidden;
    z-index: 5;
    top: 70px;
    box-shadow: 0 14px 28px rgba(0, 0, 0, 0.3), 0 10px 10px rgba(0, 0, 0, 0.3);
}

#category li {
/* 	float: left; */
    list-style: none;
    width: 50px;
    /* border-right: 1px solid #acacac; */
    padding: 10px;
    text-align: center;
    cursor: pointer;
}

#category li.on {
	background: #eee;
}

#category li:hover {
	background: #ffe6e6;
/* 	border-left: 1px solid #acacac; */
	margin-left: -1px;
}

#category li:last-child {
	margin-right: 0;
	border-right: 0;
}

#category li span {
	display: block;
	margin: 0 auto 3px;
	width: 27px;
	height: 28px;
}

#category li .category_bg {
	background:
		url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png)
		no-repeat;
}

#category li .tour {
	background-position: -10px 0;
}

#category li .munhwa {
	background-position: -10px -36px;
}

#category li .sookbak {
	background-position: -10px -72px;
}

#category li .food {
	background-position: -10px -108px;
}

#category li .cafe {
	background-position: -10px -144px;
}

#category li .park {
	background-position: -10px -180px;
}

#category li.on .category_bg {
	background-position-x: -46px;
}

.placeinfo_wrap {
	position: absolute;
	bottom: 28px;
	left: -150px;
	width: 300px;
}

.placeinfo {
	position: relative;
	width: 100%;
	border-radius: 6px;
	border: 1px solid #ccc;
	border-bottom: 2px solid #ddd;
	padding-bottom: 10px;
	background: #fff;
}

.placeinfo:nth-of-type(n) {
	border: 0;
	box-shadow: 0px 1px 2px #888;
}

.placeinfo_wrap .after {
	content: '';
	position: relative;
	margin-left: -12px;
	left: 50%;
	width: 22px;
	height: 12px;
	background:
		url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')
}

.placeinfo a, .placeinfo a:hover, .placeinfo a:active {
	color: #fff;
	text-decoration: none;
}

.placeinfo a, .placeinfo span {
	display: block;
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
}

.placeinfo span {
	margin: 5px 5px 0 5px;
	cursor: default;
	font-size: 13px;
}

.placeinfo .title {
	font-weight: bold;
	font-size: 14px;
	border-radius: 6px 6px 0 0;
	margin: -1px -1px 0 -1px;
	padding: 10px;
	color: #fff;
	background: #d95050;
	background: #d95050
		url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png)
		no-repeat right 14px center;
}

.placeinfo .tel {
	color: #0f7833;
}

.placeinfo .jibun {
	color: #999;
	font-size: 11px;
	margin-top: 0;
}

/*    지도검색기능을 위한 스타일 */
#placesList li {
	list-style: none;
}

#placesList .item {
	position: relative;
	border-bottom: 1px solid #888;
	overflow: hidden;
	cursor: pointer;
	min-height: 65px;
}

#placesList .item span {
	display: block;
	margin-top: 4px;
}

#placesList .item h5, #placesList .item .info {
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
}

#placesList .item .info {
	padding: 10px 0 10px 55px;
}

#placesList .info .gray {
	color: #8a8a8a;
}

#placesList .info .jibun {
	padding-left: 26px;
	background:
		url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png)
		no-repeat;
}

#placesList .info .tel {
	color: #009900;
}

#placesList .item .markerbg {
	float: left;
	position: absolute;
	width: 36px;
	height: 37px;
	margin: 10px 0 0 10px;
	background:
		url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png)
		no-repeat;
}

#placesList .item .marker_1 {
	background-position: 0 -10px;
}

#placesList .item .marker_2 {
	background-position: 0 -56px;
}

#placesList .item .marker_3 {
	background-position: 0 -102px
}

#placesList .item .marker_4 {
	background-position: 0 -148px;
}

#placesList .item .marker_5 {
	background-position: 0 -194px;
}

#placesList .item .marker_6 {
	background-position: 0 -240px;
}

#placesList .item .marker_7 {
	background-position: 0 -286px;
}

#placesList .item .marker_8 {
	background-position: 0 -332px;
}

#placesList .item .marker_9 {
	background-position: 0 -378px;
}

#placesList .item .marker_10 {
	background-position: 0 -423px;
}

#placesList .item .marker_11 {
	background-position: 0 -470px;
}

#placesList .item .marker_12 {
	background-position: 0 -516px;
}

#placesList .item .marker_13 {
	background-position: 0 -562px;
}

#placesList .item .marker_14 {
	background-position: 0 -608px;
}

#placesList .item .marker_15 {
	background-position: 0 -654px;
}

#pagination {
	margin: 10px auto;
	text-align: center;
}

#pagination a {
	display: inline-block;
	margin-right: 10px;
}

#pagination .on {
	font-weight: bold;
	cursor: default;
	color: #777;
}
</style>

<style>
/* 스케쥴 설정을 위한 디자인 */
.scheduling {
	width: 90%;
	height: 100%;
	display: flex;
	margin-top: 0;
}

.scheduleContainer {
    position: absolute;
    top: 70px;
    bottom: 0;
    width: 350px;
    height: 100%;
    padding: 5px;
    overflow-y: auto;
    background: rgba(255, 255, 255, 1);
    z-index: 3;
    font-size: 12px;
    border-radius: 10px;
    left: 70px;
}

.schedule {
	display: flex; /* Flexbox 사용 */
	justify-content: space-between; /* 아이템 사이의 공간을 균등하게 분배 */
	border: 1px solid #ccc; /* 테두리 추가 */
	border-radius: 8px; /* 모서리 둥글게 */
	padding: 20px; /* 내부 여백 */
	background-color: #f9f9f9; /* 배경색 */
	align-items: center;
}

.schedule-item {
	flex: 1; /* 각 아이템이 동일한 비율로 공간을 차지하도록 설정 */
	text-align: center; /* 텍스트 중앙 정렬 */
}

.schedule-item p {
	margin: 5px 0; /* 단락 간격 설정 */
}

/* img { */
/* 	width: 60px; */
/* 	height: 60px; */
/* } */
</style>

<!-- 디자인 기능 구현을 위한 스타일 -->
<!-- 버튼을 누를때 움직이는 기능 구현 및 관련 스타일 -->
<style>
#viewHandler {
	width: 70px;
	display: flex;
	flex-direction: column; /* 세로로정렬 */
	margin-right: 0px;
	z-index: 5;
	border-right: 5px solid white;
}

#viewHandler .viewHandlerBox {
	top: 70px;
	position: relative;
	width: 70px;
}

#viewHandler .viewHandlerBox img {
	width: 1.5rem;
}

#viewHandler .viewHandlerBox .viewFunctionSelect:hover {
	cursor: pointer; 
}

.viewFunctionSelect {
	width: 100%;
	height: 100px;
	text-align: center;
	display: flex;
	align-items: center; /* 수직정렬인데 적용이 되는지모르겠음 */
	justify-content: center; /* 수평 */
/* 	border: 2px solid black; /* 테두리모양이다 */ 
/* 	background-color: #f0f0f0;  */
}

.viewFunctionSelect:hover { /* 마우스를 올렸을때 어떻게 나타나게 할까? */
	
}
</style>

<!-- 맵에서 표시할 모달 -->
<div id="modal" class="hidden">
	<div id="overlay" class="overlay"></div>
	<div id="content">
		<div id="imageArea"></div>
		<div id="titleArea"></div>
		<div id="addressArea"></div>
		<div id="linkArea"></div>
	</div>
</div>

<div id="timeModal" class="hidden">
	<!--     <input id="modalDate" type="date"> -->
	<input id="modalStartTime" type="time"> <input
		id="modalEndTime" type="time">
	<button id="modalSubmit">제출</button>
	<button id="modalClose">닫기</button>
</div>

<!--  <div class="wrap"> -->
<!-- 일정HTML -->
<div class="scheduling">
	<div id="chatBoxBtn">
		<img src="${cpath }/resources/image/whiteChatBoxBtn.png">
	</div>
	<div id="range"></div>
	<div id="viewHandler">
		<div class="viewHandlerBox">
			<div class="viewFunctionSelect" id="mapHomeBtn">
				<img id="mapSearchIcon" src="${cpath }/resources/image/mapSearch.png">
			</div>
			<div class="viewFunctionSelect" id="planBtn">
				<img id="planIcon" src="${cpath }/resources/image/planIcon.png">
			</div>
			<div class="viewFunctionSelect" id="wishListBtn">
				<img id="wishListIcon" src="${cpath }/resources/image/wishListIcon.png">
			</div>
		</div>
	</div>
	<div class="scheduleContainer hidden"></div>

	<!-- 지도HTML -->
	<div class="map_wrap" style="right: 0">
		<!-- 지도를 불러온다 -->
		<div id="map"
			style="width: 100%; height: 100%; position: absolute; overflow: hidden;"></div>

		<!-- 지도 카테고리 -->
		<ul id="category">
			<li id="AT4" data-order="0"><span class="category_bg tour"></span>관광명소</li>
			<li id="CT1" data-order="1"><span class="category_bg munhwa"></span>문화시설</li>
			<li id="AD5" data-order="2"><span class="category_bg sookbak"></span>숙박시설</li>
			<li id="FD6" data-order="3"><span class="category_bg food"></span>음식점</li>
			<li id="CE7" data-order="4"><span class="category_bg cafe"></span>카페</li>
			<li id="PK6" data-order="5"><span class="category_bg park"></span>주차장</li>
		</ul>
		<div id="menu_wrap" class="bg_white hidden">
			<div class="option">
				<div>
					<form id="searchPlacesInput" onsubmit="searchPlaces(); return false;">
						<input type="text" value="센텀드림월드" id="keyword" size="15">
						<button type="submit">검색하기</button>
					</form>
				</div>
			</div>
			<hr>
			<ul id="placesList"></ul>
			<!-- listEl -->
			<div id="pagination"></div>
		</div>
		<!-- 지도 검색목록 -->
	</div>
	<!-- 지도HTML 끝 -->
	<!-- 채팅방 -->
			<c:if test="${not empty team && not empty login}">
				<!-- 주소창으로 접근가능해서 걸어둠 -->
				<div>
					<form id="updateTeamNameForm">
						<input type="text" name="name" placeholder="변경할 팀 이름"
							value="${team.name}" required>
						<button type="submit">팀 이름 수정</button>
					</form>
				</div>
				<div>
					<span>코드 : ${team.inviteCode }</span>
				</div>
			</c:if>
	<div id="chatArea">
		<div class="chatBox">
			<c:choose>
				<c:when test="${not empty team && not empty login}">
					<div class="topSideChat">
						<div class="topleft">
							<div id="teamName">${team.name }</div>
							<div id="howManyInChatRoom">
								<img src="${cpath }/resources/image/사람 수 아이콘.png" >
				            	<span class="small-white">
				            		${memberList.size() }
				            	</span>
							</div>
							<div id="participatingMembers" class="small-white">
								<c:forEach var="member" items="${memberList }"
									varStatus="status">
									${member.nickname }
									<c:if test="${!status.last }">, </c:if>
									<!-- member 가 마지막사람이 아니면 , 를 넣어준다 -->
								</c:forEach>
							</div>
						</div>

						<div class="topRight">
							<div id="inviteCode">
								<button>inviteCode
<!-- 									<img -->
<!-- 										src="https://cdn-icons-png.flaticon.com/512/2228/2228706.png" -->
<!-- 										width="30px"> -->
								</button>
							</div>
							<div id="exitTeamBtn">
								<button>leave
<!-- 									<img -->
<!-- 										src="https://e7.pngegg.com/pngimages/311/926/png-clipart-button-computer-icons-exit-angle-rectangle-thumbnail.png" -->
<!-- 										width="30px"> -->
								</button>
							</div>
						</div>
					</div>

					<div class="middleSideChat">
						<c:forEach var="message" items="${messageList }">
							<div>
								<p>
									<c:choose>
									    <c:when test="${message.isUser == 1}">
									        <c:choose>
									            <c:when test="${message.memberId == login.id}">
									                <!-- 내 메시지 -->
									                <div class="userMessageContainer myMessageContainer">
											        	<div class="sentTime">${message.formattedTime}</div> 
									                    <div class="messageContainer">
									                        <div class="messageDiv">${message.content}</div>
									                    </div>
									                </div>
									            </c:when>
									            <c:otherwise>
									                <!-- 상대방 메시지 -->
									                <div class="userMessageContainer otherMessageContainer">
									                    <div class="userImg">
									                        <img class="chatProfileImg" 
									                            src="${cpath}/upload/${message.storedFileName != null ? message.storedFileName : 'default.png'}">
									                    </div>
									                    <div class="messageContainer">
									                        <div class="otherName">${message.nickname}</div>
									                        <div class="messageDiv">${message.content}</div>
									                    </div>
									                    <div class="sentTime">${message.formattedTime}</div> 
									                </div>
									            </c:otherwise>
									        </c:choose>
									    </c:when>
									    <c:otherwise>
									        <!-- 시스템 메시지 -->
									        <div class="systemMessageContainer">
									            <div class="systemMessage">${message.content}</div>
									        </div>
									    </c:otherwise>
									</c:choose>
								</p>
							</div>
						</c:forEach>
					</div>

					<div class="bottomSideChat">
						<form id="inputChat">
							<textarea id="textarea" name="msg"></textarea>
							<input type="submit" value="send">
						</form>
					</div>
				</c:when>
				<c:otherwise>
					<p>채팅기능을 사용하기 위해서는 로그인이 필요해요!😂</p>
					<a href="${cpath }/member/login"><button>로그인하러가기</button></a>
				</c:otherwise>
			</c:choose>
		</div>
		<!-- chatBox -->
	</div>
	<!-- chatArea -->
</div>
<!-- <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=발급받은 APP KEY를 사용하세요&libraries=services"></script> -->

<!-- 디자인 기능 구현을 위한 스크립트(버튼을 누르면 해당 창이 생겼다 사라졌다 하는 기능) -->
<script>
	const searchMenuBtn = document.getElementById('mapHomeBtn')
	const wishListBtn = document.getElementById('wishListBtn')	
	const chatBoxBtn = document.getElementById('chatBoxBtn')
	
	function updateMenuWrapPosition() {
	    const scheduleContainer = document.querySelector('.scheduleContainer');
	    const menu_wrap = document.getElementById('menu_wrap');
	    if (scheduleContainer.classList.contains('hidden')) {
	        menu_wrap.style.left = '70px';
	    } else {
	        menu_wrap.style.left = '420px';
	    }
	}

	searchMenuBtn.onclick = function() {
	    console.log('지도검색 클릭');
	    const menu_wrap = document.getElementById('menu_wrap');
	    menu_wrap.classList.toggle('hidden');
	    updateMenuWrapPosition();
	}
	
	
	chatBoxBtn.onclick = function () {
		const chatArea = document.getElementById('chatArea')
		chatArea.classList.toggle('hidden')
	}
	
</script>

<script>
	const teamId = '${team.id}'
// 	const sockJS = new SockJS(cpath + '/endpoint')	// teamView 에 들어오면 웹소켓 연결 ? 로그인했을 때 연결하면 안되나 ...?? 강사님 여쭙기
// 	const stomp = Stomp.over(sockJS)
	stomp.debug = null

   // 마커를 클릭했을 때 해당 장소의 상세정보를 보여줄 커스텀오버레이입니다
   var placeOverlay = new kakao.maps.CustomOverlay({zIndex:1}), 
       contentNode = document.createElement('div'), // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다 
       markers = [], // 마커를 담을 배열입니다
       currCategory = ''; // 현재 선택된 카테고리를 가지고 있을 변수입니다
       
    // 지도 설정 
   var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
       mapOption = {
           center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
           level: 3 // 지도의 확대 레벨
       };
   
   // 지도를 생성    
   var map = new kakao.maps.Map(mapContainer, mapOption); 
   
   // 장소 검색 객체를 생성
   var ps = new kakao.maps.services.Places();
   var psCategory = new kakao.maps.services.Places(map);
   
   // 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우
   var infowindow = new kakao.maps.InfoWindow({zIndex:1});
   
   // 키워드로 장소를 검색합니다
   searchPlaces();
   
   // 키워드 검색을 요청하는 함수
   function searchPlaces() {
   
       var keyword = document.getElementById('keyword').value;
       if (!keyword.replace(/^\s+|\s+$/g, '')) {
           alert('키워드를 입력해주세요!');
           return false;
       }
   
       // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다 (내장함수) -> 콜백함수 실행
       ps.keywordSearch(keyword, placesSearchCB); 
   }
   
   	// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
	function placesSearchCB(data, status, pagination) {
       	if (status === kakao.maps.services.Status.OK) {		// 정상적으로 검색이 완료됐으면
           	 
           	displayPlaces(data);			// 검색 목록과 마커를 표출합니다
           	displayPagination(pagination);	// 페이지 번호를 표출합니다
   
       	} else if (status === kakao.maps.services.Status.ZERO_RESULT) {
       		
           alert('검색 결과가 존재하지 않습니다.');
           return;
   
       } else if (status === kakao.maps.services.Status.ERROR) {
   
           alert('검색 결과 중 오류가 발생했습니다.');
           return;
   
       }
   }
   
   // 검색 결과 목록과 마커를 표출하는 함수입니다
   function displayPlaces(places) {
		var listEl = document.getElementById('placesList')
		var menuEl = document.getElementById('menu_wrap')
		var fragment = document.createDocumentFragment()
		var bounds = new kakao.maps.LatLngBounds()
		var listStr = ''
		
		removeAllChildNods(listEl);			// 검색 결과 목록에 추가된 항목들을 제거합니다	
		removeMarker();						// 지도에 표시되고 있는 마커를 제거합니다

		for ( var i=0; i<places.length; i++ ) {
			 // 마커를 생성하고 지도에 표시합니다
			 var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),	// 좌표 저장
			     marker = addMarker(placePosition, i),		// 마커 생성
			     itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다
			     
			 // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
			 // LatLngBounds 객체에 좌표를 추가합니다
			 bounds.extend(placePosition);
	 
			 // 마커와 검색결과 항목에 mouseover 했을때
			 // 해당 장소에 인포윈도우에 장소명을 표시합니다
			 // mouseout 했을 때는 인포윈도우를 닫습니다
		
			 (function(marker, title) {
			     kakao.maps.event.addListener(marker, 'mouseover', function() {
			         displayInfowindow(marker, title)
			     })
			
			     kakao.maps.event.addListener(marker, 'mouseout', function() {
			         infowindow.close();
			     })
			         
	                       
			// 네이버 지역검색 구현
			itemEl.onclick = async function (event) {
				const blogSearchUrl = "${cpath}/maps/blogSearch?title=" + title
				const imageSearchUrl = "${cpath}/maps/imageSearch?title=" + title
				
				// List<NaverBlogDTO>
				const blogSearchResult = await fetch(blogSearchUrl).then(resp => resp.json())
				
				// List<NaverImageDTO>
				const imageSearchResult = await fetch(imageSearchUrl).then(resp => resp.json())
				// 값을 모달에 하나씩 집어 넣는 명령어
				// 타이틀에 내용추가
				const titleArea = document.getElementById('titleArea')
				titleArea.innerHTML = '<h2>' + title + '<h2>'
				titleArea.innerHTML += '<button id="addScheduleBtn">' + '계획추가' + '</button>'
				titleArea.innerHTML += '<button id="addWishList">' + '<img id="wishListIcon" src="/PLANWITH/resources/image/wishListIcon.png">' + '</button>'				
				
				function addSchedule() {	
					stomp.send('/app/addSchedule/' + teamId, {}, JSON.stringify({
						title: title,
						st: new Date().getTime(),
						et: new Date().getTime(),
						address: addressInfo,
						content: title
					}))
			 	  
					modalHandler()
			   	}
				
				async function addWishList () {
					const url = '${cpath}/maps/addWishList'
					const data = {
							title: title,
							st: new Date().getTime(),
							et: new Date().getTime(),
							address: addressInfo,
							content: title
					}
					const result = await fetch(url, {
						method: 'POST',
						headers: {
							'Content-Type': 'application/json',
						},
						body: JSON.stringify(data)
					}).then(resp => resp.json())
					console.log('addWishList 함수 실행')
					drawWishList(result)
					modalHandler()
				}
				
				document.getElementById('addWishList').onclick = addWishList
				document.getElementById('addScheduleBtn').onclick = addSchedule
                 
                  let imgIndex = 0
                  const imageArea = document.getElementById('imageArea')
                  imageArea.innerHTML = ''

                  function appendImage() {
                      if (imgIndex == imageSearchResult.length) return

                      const img = document.createElement('img')
                      img.src = imageSearchResult[imgIndex].link
                      img.style.width = '33.3%'
                      img.style.objectFit = 'cover'
                      img.style.height = '200px' // 높이를 고정값으로 설정하거나 필요에 따라 조정

                      img.onerror = function() {
                          imgIndex++
                          appendImage()
                      }
						
                      img.onload = function() {	
                          imageArea.appendChild(img)
                          imgIndex++
                          if (imageArea.children.length < 3) {
                              appendImage()
                          }
                      }
                  }

                  // 3개의 이미지를 로드하기 위한 함수
                  appendImage()
                  
                  const addressArea = document.getElementById('addressArea')
                  addressArea.innerHTML = ''
                  const addressInfo = event.target.parentNode.children[1].innerText
                  addressArea.innerHTML += addressInfo
                  const linkArea = document.getElementById('linkArea')
                  linkArea.innerHTML = ''
                  for (let i = 0; i < 4; i ++) {
                     const dto = blogSearchResult[i]
                     linkArea.innerHTML += dto.title + "'<br>'" + dto.description + '<br><a href="' + dto.link + '" target="_blank">자세히 보기</a><br>'
                  }
//                blogSearchResult.forEach(dto => linkArea.innerHTML += dto.title + "'<br>'" + dto.description + '<br><a href="' + dto.link + '" target="_blank">자세히 보기</a><br>')
                  modalHandler()
               }
               
               itemEl.onmouseover =  function () {
                   displayInfowindow(marker, title);
               }
   
               itemEl.onmouseout =  function () {
                   infowindow.close();
               }
           })(marker, places[i].place_name);
   
           fragment.appendChild(itemEl);
       }
   
       // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
       listEl.appendChild(fragment);
       menuEl.scrollTop = 0;
   
       // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
       map.setBounds(bounds);
   }
   
   // 검색결과 항목을 Element로 반환하는 함수
   function getListItem(index, places) {
       var el = document.createElement('li'),
       itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                   '<div class="info">' +
                   '   <h5>' + places.place_name + '</h5>';
   
       if (places.road_address_name) {
           itemStr += '    <span>' + places.road_address_name + '</span>' +
                       '   <span class="jibun gray">' +  places.address_name  + '</span>';
       } else {
           itemStr += '    <span>' +  places.address_name  + '</span>'; 
       }
                    
         itemStr += '  <span class="tel">' + places.phone  + '</span>' +
                   '</div>';
                   
       el.innerHTML = itemStr;
       el.className = 'item';
   
       return el;
   }
   
   // 마커를 생성하고 지도 위에 마커를 표시하는 함수
   function addMarker(position, idx, title) {
       var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
           imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
           imgOptions =  {
               spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
               spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
               offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
           },
           markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
               marker = new kakao.maps.Marker({
               position: position, // 마커의 위치
               image: markerImage 
           })
   
       marker.setMap(map) // 지도 위에 마커를 표출합니다
       markers.push(marker)  // 배열에 생성된 마커를 추가합니다
   
       return marker
   }
   
   // 지도 위에 표시되고 있는 마커를 모두 제거하는 함수
   function removeMarker() {
       for ( var i = 0; i < markers.length; i++ ) {
           markers[i].setMap(null);
       }   
       markers = [];
   }
   
   // 검색결과 목록 하단에 페이지번호를 표시는 함수
   function displayPagination(pagination) {
       var paginationEl = document.getElementById('pagination'),
           fragment = document.createDocumentFragment(),
           i; 
   
       // 기존에 추가된 페이지번호를 삭제합니다
       while (paginationEl.hasChildNodes()) {
           paginationEl.removeChild (paginationEl.lastChild);
       }
   
       for (i=1; i<=pagination.last; i++) {
           var el = document.createElement('a');
           el.href = "#";
           el.innerHTML = i;

           if (i===pagination.current) {
               el.className = 'on';
           } else {
               el.onclick = (function(i) {
                   return function() {
                       pagination.gotoPage(i);
                   }
               })(i);
           }
   
           fragment.appendChild(el);
       }
       paginationEl.appendChild(fragment);
   }
   
   // 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수, 인포윈도우에 장소명(title)을 표시합니다
   function displayInfowindow(marker, title) {
       var content = '<div class="infoWindow">'
       	   + '<p>' + title + '</p>'
       	   + '</div>';
      // 타이틀이 해당 항목의 이름을 담고 있음
       infowindow.setContent(content);
       infowindow.open(map, marker);
   }

    // 검색결과 목록의 자식 Element를 제거하는 함수
   function removeAllChildNods(el) {   
       while (el.hasChildNodes()) {
           el.removeChild (el.lastChild);
       }
   }

   function modalHandler() {
      document.getElementById('modal').classList.toggle('hidden')
   }
    
   function timeModalHandler() {
	   document.getElementById('timeModal').classList.toggle('hidden')
   }
   // 오버레이를 클릭했을 시 모달 끄기
   document.getElementById('overlay').addEventListener('click', modalHandler)
   
   
   
   // ----------------------- 여기서부터 카테고리 선택 스크립트 -----------------------
   
   // 각 카테고리에 클릭 이벤트를 등록합니다
   addCategoryClickEvent();
    
   // 각 카테고리에 클릭 이벤트를 등록합니다
   function addCategoryClickEvent() {
       var category = document.getElementById('category'),
           children = category.children
   
       for (var i=0; i<children.length; i++) {
           children[i].onclick = onClickCategory
       }
   }
   
   // 카테고리를 클릭했을 때 호출되는 함수
   function onClickCategory() {
       var id = this.id,
           className = this.className

       placeOverlay.setMap(null);

       if (className === 'on') {		// 이미 클릭되어 있다면 ..
           currCategory = ''
           changeCategoryClass()
           removeMarker()
       } else {
           currCategory = id
           changeCategoryClass(this)
           searchCategory()
       }
   }
   
   // 클릭된 카테고리에만 클릭된 스타일을 적용하는 함수
   function changeCategoryClass(el) {
       var category = document.getElementById('category'),
           children = category.children,
           i

       for ( i=0; i<children.length; i++ ) {
           children[i].className = ''
       }

       if (el) {
           el.className = 'on'
       } 
   } 
   
   // 카테고리 검색을 요청하는 함수입니다
   function searchCategory() {
       if (!currCategory) {
           return;
       }
       
       // 커스텀 오버레이를 숨깁니다 
       placeOverlay.setMap(null);
       removeMarker();		 // 지도에 표시되고 있는 마커를 제거합니다
       
       psCategory.categorySearch(currCategory, placesSearchCB, {useMapBounds:true}); 
   }
</script>



<script>
	function formatTime(time) {
	    const date = new Date(time);
	    return date.toLocaleTimeString('ko-KR', {
// 	    	year: '4-digit',
// 	    	month: '2-digit',
// 	    	day: '2-digit'
	        hour: '2-digit',
	        minute: '2-digit',
	        hour12: false
	    })
	}
	
	let currentScheduleId
	
	function timeHandler(event) {
		// 아이디를 가지고 오기
	    const scheduleElement = event.target.closest('.schedule')
	    const idElement = scheduleElement.querySelector('.scheduleId')
	    currentScheduleId = idElement.textContent
	    
	    // 현재 시간 값을 가져와서 모달의 input에 설정
	    const startTime = scheduleElement.querySelector('.start-time').textContent
	    const endTime = scheduleElement.querySelector('.end-time').textContent
	    
	    document.getElementById('modalStartTime').value = startTime
	    document.getElementById('modalEndTime').value = endTime
	    
	    timeModalHandler();
	}
	
	function submitTime() {
	    let startTime = document.getElementById('modalStartTime').value;
	    let endTime = document.getElementById('modalEndTime').value;

	    console.log('id : ' + currentScheduleId);
	    console.log('startTime : ' + startTime);
	    console.log('endTime : ' + endTime);
	    
	    // 현재 날짜 정보를 가져옵니다.
	    const currentDate = new Date();
	    const year = currentDate.getFullYear();
	    const month = currentDate.getMonth();
	    const day = currentDate.getDate();

	    // 시작 시간과 종료 시간을 Date 객체로 변환합니다.
	    startTime = new Date(year, month, day, ...startTime.split(":").map(Number));
	    endTime = new Date(year, month, day, ...endTime.split(":").map(Number));

	    // STOMP를 통해 서버로 데이터 전송
	    stomp.send('/app/updateScheduleTime/' + teamId, {}, JSON.stringify({
	        id: currentScheduleId,
	        startTime: startTime.getTime(),
	        endTime: endTime.getTime()
	    }));
	    
	    timeModalHandler();
	}
	
	document.getElementById('modalSubmit').addEventListener('click', submitTime)
	document.getElementById('modalClose').addEventListener('click', timeModalHandler)
	
	function drawWishList(msg) {
       	const scheduleContainer = document.querySelector('.scheduleContainer')
       	scheduleContainer.innerHTML = ''
		msg.forEach((dto, index) => {
		    const scheduleBox = document.createElement('div')
		    scheduleBox.className = 'schedule'
			
		    const idDiv = document.createElement('div')
		    idDiv.className = 'scheduleId'
		    idDiv.textContent = dto.id
		    idDiv.style.display = 'none'
		    scheduleBox.appendChild(idDiv)
		    
		    const titleDiv = document.createElement('div')
		    titleDiv.className = 'scheduleTitle'
		    titleDiv.textContent = dto.name
		    scheduleBox.appendChild(titleDiv)
		    
		    titleDiv.onclick = async function() {
				const blogSearchUrl = "${cpath}/maps/blogSearch?title=" + dto.name
				const imageSearchUrl = "${cpath}/maps/imageSearch?title=" + dto.name
				
				// List<NaverBlogDTO>
				const blogSearchResult = await fetch(blogSearchUrl).then(resp => resp.json())				
				// List<NaverImageDTO>
				const imageSearchResult = await fetch(imageSearchUrl).then(resp => resp.json())
				
				let imgIndex = 0
                  const imageArea = document.getElementById('imageArea')
                  imageArea.innerHTML = ''

                  function appendImage() {
                      if (imgIndex == imageSearchResult.length) return

                      const img = document.createElement('img')
                      img.src = imageSearchResult[imgIndex].link
                      img.style.width = '33.3%'
                      img.style.objectFit = 'cover'
                      img.style.height = '200px' // 높이를 고정값으로 설정하거나 필요에 따라 조정

                      img.onerror = function() {
                          imgIndex++
                          appendImage()
                      }
						
                      img.onload = function() {	
                          imageArea.appendChild(img)
                          imgIndex++
                          if (imageArea.children.length < 6) {
                              appendImage()
                          }
                      }
                  }

                  // 3개의 이미지를 로드하기 위한 함수
                  appendImage()
                  
                  const linkArea = document.getElementById('linkArea')
                  linkArea.innerHTML = ''
                  for (let i = 0; i < 4; i ++) {
                     const dto = blogSearchResult[i]
                     linkArea.innerHTML += dto.title + "'<br>'" + dto.description + '<br><a href="' + dto.link + '" target="_blank">자세히 보기</a><br>'
                  }
                  
                  modalHandler()
		    }
		
		    const deleteBtn = document.createElement('button')
		    deleteBtn.textContent = '삭제'
		    deleteBtn.className = 'deleteScheduleBtn'
		    deleteBtn.onclick = deleteWishList
		    
		    scheduleBox.appendChild(deleteBtn)
		    scheduleContainer.appendChild(scheduleBox)
		    
		})
		
	}
	
	function drawSchedule(msg) {
		console.log(msg)
       	const scheduleContainer = document.querySelector('.scheduleContainer')
       	scheduleContainer.innerHTML = ''
		msg.forEach((dto, index) => {
		    const startDate = new Date(dto.startTime)
		    const endDate = new Date(dto.endTime)
		    const scheduleBox = document.createElement('div')
		    scheduleBox.className = 'schedule'
			
		    const idDiv = document.createElement('div')
		    idDiv.className = 'scheduleId'
		    idDiv.textContent = dto.id
		    idDiv.style.display = 'none'
		    scheduleBox.appendChild(idDiv)
		    
		    const titleDiv = document.createElement('div')
		    titleDiv.className = 'scheduleTitle'
		    titleDiv.textContent = dto.content
		    scheduleBox.appendChild(titleDiv)
		    
		    titleDiv.onclick = async function() {
				const blogSearchUrl = "${cpath}/maps/blogSearch?title=" + dto.content
				const imageSearchUrl = "${cpath}/maps/imageSearch?title=" + dto.content
				
				// List<NaverBlogDTO>
				const blogSearchResult = await fetch(blogSearchUrl).then(resp => resp.json())				
				// List<NaverImageDTO>
				const imageSearchResult = await fetch(imageSearchUrl).then(resp => resp.json())

				const info = await fetch("${cpath}/maps/searchPlaceByScheduleId/" + dto.id).then(resp => resp.json())
				
				console.log(info)
				
				let imgIndex = 0
                  const imageArea = document.getElementById('imageArea')
                  imageArea.innerHTML = ''

                  function appendImage() {
                      if (imgIndex == imageSearchResult.length) return

                      const img = document.createElement('img')
                      img.src = imageSearchResult[imgIndex].link
                      img.style.width = '33.3%'
                      img.style.objectFit = 'cover'
                      img.style.height = '200px' // 높이를 고정값으로 설정하거나 필요에 따라 조정

                      img.onerror = function() {
                          imgIndex++
                          appendImage()
                      }
						
                      img.onload = function() {	
                          imageArea.appendChild(img)
                          imgIndex++
                          if (imageArea.children.length < 6) {
                              appendImage()
                          }
                      }
                  }

                  // 3개의 이미지를 로드하기 위한 함수
                  appendImage()
                  
                  const linkArea = document.getElementById('linkArea')
                  linkArea.innerHTML = ''
                  for (let i = 0; i < 4; i ++) {
                     const dto = blogSearchResult[i]
                     linkArea.innerHTML += dto.title + "'<br>'" + dto.description + '<br><a href="' + dto.link + '" target="_blank">자세히 보기</a><br>'
                  }
                  
                  modalHandler()
		    }
		    
		    // 시간 정보를 담을 div 생성
		    const timeDiv = document.createElement('div')
		    
		    // 시작 시간 span 생성
		    const startTimeSpan = document.createElement('span')
		    startTimeSpan.className = 'start-time'
		    startTimeSpan.textContent = formatTime(startDate)
		    
			startTimeSpan.onclick = timeHandler
		    
		    // 종료 시간 span 생성
		    const endTimeSpan = document.createElement('span')
		    endTimeSpan.className = 'end-time'
		    endTimeSpan.textContent = formatTime(endDate)
		    
		    endTimeSpan.onclick = timeHandler
		    
		    // 시간 정보 조립
		    timeDiv.appendChild(startTimeSpan)
		    timeDiv.appendChild(document.createTextNode(' - '))
		    timeDiv.appendChild(endTimeSpan)
		    
		    scheduleBox.appendChild(timeDiv)
		
		    const deleteBtn = document.createElement('button')
		    deleteBtn.textContent = '삭제'
		    deleteBtn.className = 'deleteScheduleBtn'
		    deleteBtn.onclick = deleteSchedule
		    
		    scheduleBox.appendChild(deleteBtn)
		    scheduleContainer.appendChild(scheduleBox)
		    
		})
	}
	
	function onScheduleUpdate(message) {
		const msg = JSON.parse(message.body)
		drawSchedule(msg)
	}
	
	// 삭제버튼 누르면 삭제되도록.
	function deleteSchedule(event) {
		stomp.send('/app/deleteSchedule/' + teamId, {}, JSON.stringify({
			id: event.target.previousElementSibling.previousElementSibling.previousElementSibling.textContent
		}))
	}
	
	async function deleteWishList(event) {
		const id = event.target.previousElementSibling.previousElementSibling.textContent
		console.log(id)
		const url = '${cpath}/maps/deleteWishList?id=' + id 
		const result = await fetch(url, {
			method: 'POST',
			headers: {
				headers: {
					'Content-Type': 'application/json',
				}
			}
		}).then(resp => resp.json())
		console.log('deleteWishList 함수 실행')
		drawWishList(result);
	}
</script>

<!-- 채팅 script -->
<script>
	// 채팅 메시지가 들어가는 곳
	const middleSideChat = document.querySelector('.middleSideChat')
	
	function onConnect() {
	    // 채팅 메시지 구독
		stomp.subscribe('/broker/team/' + teamId, onReceiveMessage)

	    // 팀 이름 변경됐는지 알 수 있도록 구독
		stomp.subscribe('/broker/team/teamName/' + teamId, onTeamNameUpdate)

	    // 팀에 멤버가 들어가고 나가면 멤버리스트 들고오기 구독
		stomp.subscribe('/broker/team/members/' + teamId, onMemberListUpdate)
		
		// 스케쥴 업데이트 구독
		stomp.subscribe('/broker/map/' + teamId, onScheduleUpdate)
		
		// 팀꺼들고오기 자동실행 (없앰)
// 		stomp.send('/app/enterSchedule/' + teamId, {}, JSON.stringify({}))
		
// 	    // 멤버가 팀에 처음으로 합류했는지 검사 후 입장 메시지 전송 구독
		stomp.send('/app/join/' + teamId, {}, JSON.stringify({
			id: ${login.id},	// memberId인데 memberDTO에서 id라서 id로 해놓음
			nickname: '${login.nickname}'	
		}))
		
	}
	
	// 팀 이름 변경 시 호출
	function onTeamNameUpdate(message) {
	    const newTeamName = message.body  // 새로 작성된 teamName
	    document.getElementById('teamName').textContent = newTeamName;  // 팀 이름 실시간으로 채팅 위에 반영
	    const inputTeamName = document.querySelector('#updateTeamNameForm input[name="name"]')
	    inputTeamName.value = newTeamName;  // 폼에 새 팀 이름 반영
	    inputTeamName.focus()  				// 폼에 포커스 추가
	}

	// 참여 멤버 목록 업데이트 시 호출
	function onMemberListUpdate(message) {
	    const memberList = JSON.parse(message.body)
	
	    // 참여한 멤버 닉넴들
	    const memberNickNames = memberList.map(member => member.nickname).join(", ")
	    
	    // 참여한 멤버들 수 
	    const memberCount = memberList.length
	
	    document.getElementById('participatingMembers').textContent = memberNickNames
	    document.getElementById('howManyInChatRoom').textContent = memberCount + '명'
    }

	// 메시지 전송
	function sendMessage() {
	    const messageContent = document.getElementById('textarea').value
	    if (messageContent) {   // 입력 내용 있으면 보내요
	        stomp.send('/app/message/' + teamId, {}, JSON.stringify({
	            teamId: teamId,
	            memberId: ${login.id},
	            content: messageContent,
	            isUser: 1,
	            nickname : '${login.nickname}'
	        }))
	        document.getElementById('textarea').value = ''
	    }
	}
	
	// 채팅 폼 제출하면 sendMessage(메시지 전송) 연결
	   
	function inputMessage(event) {
	    event.preventDefault()
	    sendMessage()
	}
	const inputChat = document.getElementById('inputChat')
	inputChat.addEventListener('keydown', function(event) {
	 console.log('Enter 입력 함수 실행')
	   if (event.key === 'Enter') inputMessage(event) 
	})
	inputChat.addEventListener('click', inputMessage)
	
	function exitTeam() {
	    // 탈퇴 요청을 서버로 보냄
	    stomp.send('/app/exitTeam/' + teamId, {}, JSON.stringify({
	        memberId: ${login.id}
	    }))

	    // 탈퇴 성공 여부 응답 받고
	    stomp.subscribe('/broker/team/' + teamId + '/exitSuccess', function (message) {
	        if (message.body === 'success') {  // "success" 문자열을 받으면 페이지 이동
	            window.location.href = cpath + '/team/teamList'
	        }
	    })

	}

	// 채팅 메시지 받을 때 마다 호출
// 	   function onReceiveMessage(message) {
// 		    const msg = JSON.parse(message.body)
// 		    const messageDIV = document.createElement('div')
// 		    const paragraph = document.createElement('p')
		   
// 		    if (msg.isUser === 1) {
// 		        // 사용자 메시지
// 		        const img = document.createElement('img')
// 		        img.className = 'chatProfileImg'
// 		        img.src = cpath + '/upload/' + (msg.storedFileName ? msg.storedFileName : 'default.png')
		        
// 		        paragraph.appendChild(img)
// 		        paragraph.innerHTML += msg.nickname + ': ' + msg.content
		        
// 		    } else {
// 		        // 시스템 또는 다른 사용자의 메시지
// 		        paragraph.textContent = msg.nickname + ' ' + msg.content
// 		    }
		    
// 		    messageDIV.appendChild(paragraph);
// 		    middleSideChat.appendChild(messageDIV);
		    
// 		    // 스크롤을 최신 메시지로 이동
// 		    middleSideChat.scrollTop = middleSideChat.scrollHeight;
// 		}
			
function onReceiveMessage(message) {
    const msg = JSON.parse(message.body)
    const messageDIV = document.createElement('div')

    console.log('msg.sentTime', msg.sentTime)
    console.log('msg.formattedTime', msg.formattedTime)

    if (msg.isUser === 1) {
        const userMessageContainer = document.createElement('div')
        userMessageContainer.className = msg.memberId === ${login.id} ? 'userMessageContainer myMessageContainer' : 'userMessageContainer otherMessageContainer'

        if (msg.memberId === ${login.id}) {
            // 내 메시지일 경우 시간 먼저 추가
            const sentTimeDiv = document.createElement('div')
            sentTimeDiv.className = 'sentTime'
            sentTimeDiv.textContent = msg.formattedTime
            userMessageContainer.prepend(sentTimeDiv) // 내 메시지일 때만 prepend로 시간 추가
        } else {
            // 다른 사용자의 메시지일 경우
            const userImgDiv = document.createElement('div')
            userImgDiv.className = 'userImg'

            const userImg = document.createElement('img')
            userImg.className = 'chatProfileImg'
            userImg.src = cpath + '/upload/' + (msg.storedFileName ? msg.storedFileName : 'default.png')
            userImgDiv.appendChild(userImg)

            userMessageContainer.appendChild(userImgDiv)
        }

        // 메시지 내용 및 시간 처리
        const messageContainer = document.createElement('div')
        messageContainer.className = 'messageContainer'

        if (msg.memberId !== ${login.id}) {
            // 다른 사용자의 메시지에 이름 추가
            const otherNameDiv = document.createElement('div')
            otherNameDiv.className = 'otherName'
            otherNameDiv.textContent = msg.nickname
            messageContainer.appendChild(otherNameDiv)
        }

        const messageDiv = document.createElement('div')
        messageDiv.className = 'messageDiv'
        messageDiv.textContent = msg.content

        const sentTimeDiv = document.createElement('div')
        sentTimeDiv.className = 'sentTime'
        sentTimeDiv.textContent = msg.formattedTime

        messageContainer.appendChild(messageDiv)

        userMessageContainer.appendChild(messageContainer)
        if (msg.memberId !== ${login.id}) {
	        userMessageContainer.appendChild(sentTimeDiv)
        }
        
        messageDIV.appendChild(userMessageContainer)
    } else if (msg.isUser === 0) {
        const systemMessageDiv = document.createElement('div')
        systemMessageDiv.className = 'systemMessageContainer'

        const systemMessage = document.createElement('div')
        systemMessage.className = 'systemMessage'
        systemMessage.textContent = msg.content

        systemMessageDiv.appendChild(systemMessage)
        messageDIV.appendChild(systemMessageDiv)
    }

    middleSideChat.appendChild(messageDIV)

    // 최신 메시지로 스크롤
    middleSideChat.scrollTop = middleSideChat.scrollHeight
}

	// 팀 이름 수정 제출 시 websocket 연결
	function updateTeamName(event) {
	    event.preventDefault()
	    
	    const inputTeamName = document.querySelector('#updateTeamNameForm input[name="name"]')	
	    const newTeamName = inputTeamName.value	// newTeamName = 작성한(input) teamName
	    
	    // 서버에 팀 이름 보내기, 서버가 처리결과 바당와서 팀 이름 처리하여 반영하기
	    stomp.send('/app/updateTeamName/' + teamId, {}, newTeamName)
	    
	    inputTeamName.value = ''	// 작성란 비움
	}
	
	// 팀이름수정 폼 제출 시 
	document.getElementById('updateTeamNameForm').onsubmit = updateTeamName		// 팀 이름 폼 제출 시 처리
	document.getElementById('exitTeamBtn').onclick = exitTeam				
	stomp.connect({}, onConnect)
	window.addEventListener('DOMContentLoaded', function() {
		document.querySelectorAll('button.deleteScheduleBtn').forEach(e => e.onclick = deleteSchedule)
		teamViewLoadHandler()
	})
</script>

<!-- 스타일 스크립트 -->
<script>
	
// 	지도 검색 아이콘 클릭 시 이미지 교체
	document.getElementById('mapHomeBtn').addEventListener('click', function() {
		let img = this.querySelector('img')
	  	if (img.src.includes('mapSearch.png')) {
		  	img.src = '${cpath}/resources/image/mapSearchHover.png'
	  	} else {
		  	img.src = '${cpath}/resources/image/mapSearch.png'
	  	}
	})
	
	async function teamViewLoadHandler() {
		const url = '${cpath}/maps/teamViewLoad/' + ${teamId}
		const data = await fetch(url).then(resp => resp.json())
		drawSchedule(data)
	}
	
	function showPlan () {
		let img = this.querySelector('img')
		const scheduleContainer = document.querySelector('.scheduleContainer')
	  	if (img.src.includes('planIcon.png')) {
		  	img.src = '${cpath}/resources/image/planIconHover.png'
	  		if (scheduleContainer.classList.contains('hidden')) {
			    scheduleContainer.classList.toggle('hidden')
			}
	  	} else {
		  	img.src = '${cpath}/resources/image/planIcon.png'
		  	scheduleContainer.classList.toggle('hidden')
	  	}
		
		updateMenuWrapPosition()
	    teamViewLoadHandler()
	}
	
	async function showWishList () {
		let img = this.querySelector('img')
		const scheduleContainer = document.querySelector('.scheduleContainer')
	  	if (img.src.includes('wishListIcon.png')) {
		  	img.src = '${cpath}/resources/image/wishListIconHover.png'
	  		if (scheduleContainer.classList.contains('hidden')) {
			    scheduleContainer.classList.toggle('hidden')
			}
	  	} else {
		  	img.src = '${cpath}/resources/image/wishListIcon.png'
		  	scheduleContainer.classList.toggle('hidden')
	  	}
		console.log('showWishList')
	    updateMenuWrapPosition()
	    const url = '${cpath}/maps/getWishList'
	    const answer = await fetch(url).then(resp => resp.json())
	    console.log('answer : ', answer)
		drawWishList(answer)
	}
	
	// 계획 아이콘 클릭 시 이미지 교체
	document.getElementById('planBtn').addEventListener('click', showPlan)
	
	// 위시리스트 아이콘 클릭 시 이미지 교체
	document.getElementById('wishListBtn').addEventListener('click', showWishList)
	
	window.onload = function() {
	    const middleSideChat = document.querySelector('.middleSideChat')
	    middleSideChat.scrollTop = middleSideChat.scrollHeight
	}
</script>

</body>
</html>