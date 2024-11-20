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
	border: 1px solid lime;
   }
</style>


<h3>게시글 수정</h3>

<form id="updateBoardForm" method="POST" enctype="multipart/form-data">

    <p><input type="text" id="title" name="title" value="${board.title}"></p>
    <!-- 사진리스트, 삭제버튼 누르면 ajax로 전부삭제, 추가누르면 disable 풀리고 추가만 가능 -->
   	<p><input  type="button" id="deleteFilesBtn" value="사진지우고 다시 올리기"></p> 
<!--    	<p></p>  -->
	<div class="fileArea inputFile hidden"></div>
	<p class="inputFile hidden">
		<input id="addFileBtn" type="button" value="사진추가">
		<input  type="button" id="rollbackBtn" value="사진수정취소">
	</p>
    <textarea name="content">${board.content}</textarea>
    <p><input type="text" id="tag" name="tag" value="${board.tag}"></p>
    <p><input type="hidden" name="flag" value="false"></p> 
    <p><input type="submit" value="수정하기"></p>
</form>


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

</body>
</html>
