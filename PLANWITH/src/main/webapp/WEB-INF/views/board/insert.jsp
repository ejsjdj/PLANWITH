<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<style>
	#tmp {
		display: none;
	}
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

<h3>게시물 작성</h3>

<form id="writeForm" method="POST" enctype="multipart/form-data">
	<p><input type="text" name="title" placeholder="제목" autofocus required></p>
	
	<div class="fileArea"></div>
	<p><input id="addFileBtn" type="button" value="사진추가"></p>
	
	<textarea name="content"></textarea>
	<p><input type="text" name="tag" placeholder="태그 입력"></p>
	<p><input type="submit" value="완료">
</form>

<script>

	function changeHandler(event) {
	    // event.target 은 파일을 첨부하는 input 요소이다
	    // preview는 미리보기 그림을 보여줄 div 요소이다
	    
// 	    const preview = document.getElementById('preview')
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

	const addFileBtn = document.getElementById('addFileBtn')
	const input = document.querySelector('input[name="files"]')
	
	addFileBtn.addEventListener('click', addFileHandler)
	
	addFileHandler()
</script>


</body>
</html>