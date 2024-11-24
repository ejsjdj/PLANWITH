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
		border: 1px solid #dadada;
		border-radius: 10px;
   	}
   	.insertMainBody {
		width: 100%;
		height: auto;
		display: flex;
		padding-top: 70px;
   	}
   	.insertMainBody > .insertInnerBox {
   		width: 600px;
   		height: auto;
   		padding: 50px;
   		margin: 80px auto;
   		background-color: #ffffff;
    	border-radius: 10px;
    	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
   	}
   	.insertMainBody > .insertInnerBox > h3 {
   		display: flex;
   		justify-content: center;
   		font-size: 22px;
   	}
   	.insertMainBody > .insertInnerBox > #writeForm > p {
   		display: flex;
   		flex-flow: column;
   		margin: 25px 0;
   	}
   	.insertMainBody > .insertInnerBox > #writeForm > p > span {
   		margin-left: 10px;
   		font-size: 14px;
   		color: #7a7a7a;
   	}
   	#insertTitle {
   		width: 580px;
   		height: 30px;
   		padding: 5px 10px;
   		font-size: 16px;
   		border: 1px solid #dadada;
   		border-radius: 10px;
   	}
   	#insertContent {
   		width: 580px;
   		height: 150px;
   		padding: 5px 10px;
   		border: 1px solid #dadada;
   		border-radius: 10px;
   		font-size: 16px;
    	font-family: auto;
   	}
   	#insertTag {
   		width: 580px;
   		height: 30px;
   		padding: 5px 10px;
   		font-size: 16px;
   		border: 1px solid #dadada;
   		border-radius: 10px;
   	}
   	#insertSubmit {
   		background: linear-gradient(70deg, #172d9d, #561689);
   		color: white;
   		width: 600px;
   		height: 50px;
   		border-radius: 10px;
   		font-size: 18px;
   		border: 0;
   		transition: background 0.4s ease;
   	}
   	#insertSubmit:hover {
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
</style>

<div class="insertMainBody">
	<div class="insertInnerBox">
		<h3>게시물 작성</h3>
		
		<form id="writeForm" method="POST" enctype="multipart/form-data">
			<p>
				<span>제목</span>
				<input id="insertTitle" type="text" name="title" autofocus required>
			</p>
			
			<div class="fileArea"></div>
			<p><input id="addFileBtn" type="button" value="+"></p>
			
			<p>	
				<span>내용</span>
				<textarea id="insertContent" name="content"></textarea>
			</p>
			
			<p>
				<span>태그</span>
				<input id="insertTag" type="text" name="tag" >
			</p>
			
			<p><input id="insertSubmit" type="submit" value="완료">
		</form>
	</div>
</div>



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

<%@ include file="../footer.jsp"%>