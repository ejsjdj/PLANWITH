<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<style>
	#tmp {
		display: none;
	}
</style>

<h3>게시물 작성</h3>

<form id="writeForm" method="POST" enctype="multipart/form-data">
	<p><input type="text" name="title" placeholder="제목" autofocus required></p>
	
	<div class="fileArea">
		
		<p>
			<input type="file" name="files[0]" accept="image/*">
			<input type="button" class="removeInputBtn" value="X">
		</p>
	</div>
	<input id="addFileBtn" type="button" value="사진추가">
	
	<div id="photoList"></div>
	
	<textarea name="content"></textarea>
	<p><input type="text" name="tag" placeholder="태그 입력"></p>
	<p><input type="submit" value="완료">
</form>

<script>

	function changeHandler(event) {
	    // event.target 은 파일을 첨부하는 input 요소이다
	    // preview는 미리보기 그림을 보여줄 div 요소이다
	    const preview = document.getElementById('preview')
	    if(event.target.files && event.target.files[0]) {
	        preview.style.height = '300px'
	        preview.style.border = '2px solid black'
	        const reader = new FileReader()
	        reader.onload = (e) => {
	            preview.style.backgroundImage = `url('${e.target.result}')`
	        }
	        reader.readAsDataURL(event.target.files[0])
	    }
	    else {
	        preview.style.backgroundImage = ''
	    }
	}

	function removeHandler(event) {
		const fileArea = document.querySelector('div.fileArea')
		const parent = event.target.parentNode
		fileArea.removeChild(parent)
		document.querySelectorAll('input[type="file"]').forEach((element, index) => element.name = 'files[' + index + ']')
	}
	
	function addFileHandler() {
		const fileArea = document.querySelector('div.fileArea')
		
		const input = document.createElement('input')
		input.type = 'file'
		const index = document.querySelectorAll('input[type="file"]').length
		
		const removeInputBtn = document.createElement('input')
		removeInputBtn.classList.add('removeInputBtn')
		removeInputBtn.type = 'button'
		removeInputBtn.value = 'X'
		removeInputBtn.onclick = removeHandler
		
		const p = document.createElement('p')
		p.appendChild(input)
		p.appendChild(removeInputBtn)
		fileArea.appendChild(p)
		
		document.querySelectorAll('input[type="file"]').forEach((element, index) => element.name = 'files[' + index +']')
	} 

	const addFileBtn = document.getElementById('addFileBtn')
	addFileBtn.addEventListener('click', addFileHandler)
	
	document.querySelector('input.removeInputBtn').onclick = removeHandler

</script>


</body>
</html>