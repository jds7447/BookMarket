<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	
	<body>
		<h1>게시글 등록</h1>
		
		<form action="/board/enroll" method="post">
			<!-- 게시판 등록 시 필요로 한 정보를 입력할 수 있는 <input> 태그
				<input> 태그의 name 속성 값은 BoardVO 클래스의 해당 변수 명과 일치 시켜
				게시판 등록을 수행하는 url 맵핑 메서드에 View가 전송하는 데이터를 전달받기 위해 BoardVO를 파라미터 사용
				<input>태그의 name 속성 값과 BoardVO의 멤버 변수명이 일치해야만 스프링에서 자동으로 파라미터를 수집 -->
			<div class="input_wrap">
	        	<label>Title</label>
		        <input name="title">
		    </div>
		    <div class="input_wrap">
		        <label>Content</label>
		        <textarea rows="3" name="content"></textarea>
		    </div>
		    <div class="input_wrap">
		        <label>Writer</label>
		        <input name="writer">
		    </div>
		    <button class="btn">등록</button>
		</form>
	</body>
</html>