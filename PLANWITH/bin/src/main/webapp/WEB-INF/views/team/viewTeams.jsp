<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<style>
   .viewTeamsBody {
      width: 100%;
      height: 100%;
   }
   .viewTeamsBody > .teamBoxes {
      width: auto;
      height: 100%;
      margin: 25px;
      display: flex;
      flex-flow: wrap;
      position: relative;
   }
   .viewTeamsBody > .teamBoxes > .teamBox {
      width: 230px;
      height: 230px;
      padding: 25px;
      border: 1px solid black;
      display: grid;
      justify-content: center;
      align-content: center;
      border-radius: 5px;
      margin: 25px;
   }
   .viewTeamsBody > .teamBoxes > .createBox {
      width: 230px;
      height: 230px;
      padding: 25px;
      border: 1px solid black;
      display: grid;
      justify-content: center;
      align-content: center;
      border-radius: 5px;
      margin: 25px;
   }
   .viewTeamsBody > .createAndJoinTeamModal {
      border: 1px solid black;
      width: 500px;
      height: 250px;
      position: absolute;
   }
   
   .modalOverlay {
       display: none;
       position: fixed;
       top: 0;
       left: 0;
       width: 100%;
       height: 100%;
       background: rgba(0, 0, 0, 0.4);
       z-index: 10;
   }
   /* 모달 스타일 */
   .createAndJoinTeamModal {
       display: none; /* 기본적으로 숨김 */
       position: fixed;
       top: 50%;
       left: 50%;
       transform: translate(-50%, -50%);
       width: 500px;
       padding: 20px;
       background: white;
       border-radius: 10px;
       box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
       z-index: 11;
       display: flex;
       flex-direction: column;
       gap: 20px;
   }
   .createAndJoinTeamModal > span {
      display: flex;
       justify-content: center;
       font-size: 20px;
       font-weight: bold;
   }
   .inTheBox {
      width: 100%;
      height: 80%;
      display: flex;
   }
    .createAndJoinTeamModal > .inTheBox > .left,
    .createAndJoinTeamModal > .inTheBox > .right {
        flex: 1; 
        text-align: center;
        padding: 5px;
    }

    .createAndJoinTeamModal > .inTheBox > .left {
        border-right: 1px solid #ddd;
    }
    .createAndJoinTeamModal {
        display: flex;
        justify-content: space-between;
        gap: 20px;
    }
    .createAndJoinTeamModal > .inTheBox > .left,
    .createAndJoinTeamModal > .inTheBox > .right {
        width: calc(50% - 10px); 
        height: 100%;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
    }
    
    .createAndJoinTeamModal > .inTheBox > .left {
       
    }
    
    .createAndJoinTeamModal > .inTheBox > .right {
       
    }
    
    .createAndJoinTeamModal > .close {
        width: 100%;
        text-align: center;
    }

    .modal-close-button {
        display: inline-block;
        margin-top: 10px;
        padding: 10px 20px;
        background-color: #f44336; 
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        text-align: center;
    }
    .modal-close-button:hover {
        background-color: #d32f2f; 
    }
</style>

<div class="modalOverlay"></div>
<div class="viewTeamsBody">
   <div class="teamBoxes">
       <c:forEach var="team" items="${teamList }">
         <div class="teamBox">
            <a href="${cpath }/team/view/${team.id}">${team.name }</a>
         </div>
      </c:forEach>
      <div class="createBox">
         <span>지금 바로 일정을 추가해보세요.</span>
         <button id="createButton">일정 추가하기</button>
      </div>
   </div>
   
   
   <div class="createAndJoinTeamModal">
      <span>일정 추가하기</span>
      <div class="inTheBox">
         <div class="left">
              <form action="${cpath}/team/create">
                  <button type="submit">새로 만들게요</button>
              </form>
          </div>
          <div class="right">
              <form action="${cpath}/team/joinTeam" method="POST">
                  <input type="text" name="inviteCode" placeholder="초대 코드 입력" required>
                  <button type="submit">입장하기</button>
              </form>
          </div>
      </div>
      <!-- 닫기 버튼 추가 -->
      <div class="close">
          <button class="modal-close-button">닫기</button>
      </div>
   </div>
</div>

<div class="sideBar"> 
   <div class="profile"></div>
   <div class="friendList"></div>
   <div class="requestToAddFriend"></div>
</div>


<script>
    document.addEventListener("DOMContentLoaded", function () {
        const modal = document.querySelector(".createAndJoinTeamModal")
        const modalOverlay = document.querySelector(".modalOverlay")
        const createButton = document.querySelector("#createButton")
        const closeButton = document.querySelector(".modal-close-button")

        // 페이지 로드 시 모달과 오버레이 숨기기
        modal.style.display = "none"
        modalOverlay.style.display = "none"

        // "일정 추가하기" 버튼 클릭 시 모달과 오버레이 표시
        createButton.addEventListener("click", function () {
            modal.style.display = "flex"
            modalOverlay.style.display = "block"
        })

        // 닫기 버튼 클릭 시 모달과 오버레이 숨기기
        closeButton.addEventListener("click", function () {
            modal.style.display = "none"
            modalOverlay.style.display = "none"
        })

        // 오버레이 클릭 시 모달과 오버레이 숨기기
        modalOverlay.addEventListener("click", function (event) {
            if (event.target === modalOverlay) {
                modal.style.display = "none"
                modalOverlay.style.display = "none"
            }
        })
    })
</script>


</body>
</html>