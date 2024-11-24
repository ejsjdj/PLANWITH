<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>




<style>
	.preview {
		position: relative;
		box-sizing: border-box;
		bottom: 0;
		width: 100px;
		height: 100px;
		background-position: center center;
		background-repeat: no-repeat;
		background-size: auto 100%;
		margin-top: 20px;
		overflow: hidden;
		border: 1px solid #dadada;
		border-radius: 10px;
   	}
   	.updateMainBody {
		width: 100%;
		height: auto;
		display: flex;
		padding-top: 70px;
   	}
   	.updateMainBody > .updateInnerBox {
   		width: 600px;
   		height: auto;
   		padding: 50px;
   		margin: 80px auto;
   		background-color: #ffffff;
    	border-radius: 10px;
    	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
   	}
   	.updateMainBody > .updateInnerBox > h3 {
   		display: flex;
   		justify-content: center;
   		font-size: 22px;
   	}
   	.updateMainBody > .updateInnerBox > #updateBoardForm > .normalTagP {
   		display: flex;
   		flex-flow: column;
   		margin: 25px 0;
   	}
   	.updateMainBody > .updateInnerBox > #updateBoardForm > .normalTagP > span {
   		margin-left: 10px;
   		font-size: 14px;
   		color: #7a7a7a;
   	}
   	#title {
   		width: 580px;
   		height: 30px;
   		padding: 5px 10px;
   		font-size: 16px;
   		border: 1px solid #dadada;
   		border-radius: 10px;
   	}
   	#updateContent {
   		width: 580px;
   		height: 150px;
   		padding: 5px 10px;
   		border: 1px solid #dadada;
   		border-radius: 10px;
   		font-size: 16px;
    	font-family: auto;
   	}
   	#tag {
   		width: 580px;
   		height: 30px;
   		padding: 5px 10px;
   		font-size: 16px;
   		border: 1px solid #dadada;
   		border-radius: 10px;
   	}
   	#updateSubmit {
   		background: linear-gradient(70deg, #172d9d, #561689);
   		color: white;
   		width: 600px;
   		height: 50px;
   		border-radius: 10px;
   		font-size: 18px;
   		border: 0;
   		transition: background 0.4s ease;
   	}
   	#updateSubmit:hover {
		filter: brightness(1.2);
	}
	.removeInputBtn {
		width: 35px;
		height: 35px;
		border: 0;
		background-color: #ff6a84;
		color: white;
		border-radius: 8px;
		font-size: 18px;
	}
	.removeInputBtn:hover {
		background-color: red;
	}
	#addFileBtn {
		border: 0;
		background-color: #afe2af;
		height: 30px;
		padding: 5px;
		font-size: 16px;
		border-radius: 8px;
		color: white;
	}
	#addFileBtn:hover {
		background-color: #64c864;
	}
	#deleteFilesBtn {
		border: 0;
		background-color: #afe2af;
		height: 30px;
		padding: 5px;
		font-size: 16px;
		border-radius: 8px;
		color: white;
	}
	#deleteFilesBtn:hover {
		background-color: #64c864;
	}
	#rollbackBtn {
		border: 0;
		background-color: #ff6a84;
		height: 30px;
		padding: 5px;
		font-size: 16px;
		border-radius: 8px;
		color: white;
		margin-top: 5px;
	}
	#rollbackBtn:hover {
		background-color: red;
	}
	.inputFile {
	    display: flex;
	    flex-flow: column; 
	}
	.inputFile.hidden {
    	display: none !important; /* !important로 우선순위를 높임 */
	}
</style>

<div class="updateMainBody">
	<div class="updateInnerBox">
		<h3>게시글 수정</h3>
		
		<form id="updateBoardForm" method="POST" enctype="multipart/form-data">
		
		    <p class="normalTagP">
		    	<span>제목</span>
		    	<input type="text" id="title" name="title" value="${board.title}">
		    </p>
		    
		    <!-- 사진리스트, 삭제버튼 누르면 ajax로 전부삭제, 추가누르면 disable 풀리고 추가만 가능 -->
		   	<p class="normalTagP">
		   		<input type="button" id="deleteFilesBtn" value="사진지우고 다시 올리기">
		   	</p> 


			<div class="fileArea inputFile hidden"></div>
			
			<p class="inputFile hidden">
				<input id="addFileBtn" type="button" value="+">
				<input  type="button" id="rollbackBtn" value="사진수정취소">
			</p>
			
			
			<p class="normalTagP">
				<span>내용</span>
		    	<textarea id="updateContent" name="content">${board.content}</textarea>
		    </p>
		    
		    <p class="normalTagP">
		    	<span>태그</span>
		    	<input type="text" id="tag" name="tag" value="${board.tag}">
		    </p>	
		    <p><input type="hidden" name="flag" value="false"></p> 
		    <p class="normalTagP"><input id="updateSubmit" type="submit" value="수정하기"></p>
		</form>
	</div>
</div>




<script>
	
	const updateBoardForm = document.getElementById('updateBoardForm')
	
	function changeHandler(event) {
	    // event.target 은 파일을 첨부하는 input 요소이다
	    // preview는 미리보기 그림을 보여줄 div 요소이다
	    
		const preview = event.target.previousElementSibling
	    
	    if(event.target.files) {
	        preview.style.height = '100px'
	        preview.style.border = '2px solid black'
	        const reader = new FileReader()
	        reader.onload = (e) => {
	            preview.style.backgroundImage = 'url(' + e.target.result + ')'
	        }
	        reader.readAsDataURL(event.target.files[0])
	    }
	    else {
	        preview.style.backgroundImage = ''
	    }
	}
	
	// 파일 삭제 함수
	function removeHandler(event) {
		const fileArea = document.querySelector('div.fileArea')
		const parent = event.target.parentNode
		fileArea.removeChild(parent)
		document.querySelectorAll('input[type="file"]').forEach((element, index) => element.name = 'files[' + index + ']')
	}
	
	// 사진 추가 버튼을 누르면 실행되는 함수
	function addFileHandler() {
		const fileArea = document.querySelector('div.fileArea')
		
		const preview = document.createElement('div')
		preview.className = 'preview'
		
		const input = document.createElement('input')
		input.type = 'file'
		const index = document.querySelectorAll('input[type="file"]').length
		input.onchange = changeHandler
		
		const removeInputBtn = document.createElement('input')
		removeInputBtn.classList.add('removeInputBtn')
		removeInputBtn.type = 'button'
		removeInputBtn.value = 'X'
		removeInputBtn.addEventListener('click', removeHandler)
		
		const p = document.createElement('p')
		p.style.display = 'flex'
		p.style.alignItems = 'center'
		p.style.justifyContent = 'space-around'
		p.appendChild(preview)
		p.appendChild(input)
		p.appendChild(removeInputBtn)
		fileArea.appendChild(p)
	
		document.querySelectorAll('input[type="file"]').forEach((element, index) => {
			element.name = 'files[' + index + ']'			
		})
	}
	
	let flag = false
	function toggleInputFile(event) {
		flag = !flag
	
		const updateBoardForm = document.getElementById('updateBoardForm')
		updateBoardForm.querySelector('input[name="flag"]').value = flag
		
		console.log(flag)
		document.querySelector('input[name="flag"]')
		
		const inputFile = updateBoardForm.querySelectorAll('form .inputFile')
		inputFile.forEach(ob => ob.classList.toggle('hidden'))
		document.getElementById('deleteFilesBtn').classList.toggle('hidden')
	}
	
	// 사진파일 지우고 다시 올리기 버튼 누르면 실행
	const deleteFilesBtn = document.getElementById('deleteFilesBtn')
	deleteFilesBtn.addEventListener('click', function(event) {
		const fileArea = document.querySelector('div.fileArea')
		fileArea.innerHTML = ''
		
		toggleInputFile(event)
		
		const addFileBtn = document.getElementById('addFileBtn')
		const input = document.querySelector('input[name="files"]')
		addFileBtn.addEventListener('click', addFileHandler)
		
		addFileHandler()
	})
	
	// 취소 버튼 누르면 실행
	const rollbackBtn = document.getElementById('rollbackBtn')
	rollbackBtn.addEventListener('click', function() {
		toggleInputFile(event)
	})		
</script>

<%@ include file="../footer.jsp"%>