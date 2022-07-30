<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="https://code.jquery.com/jquery-3.4.1.js"
	  			integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	  			crossorigin="anonymous"></script>
	  	<link rel="stylesheet" href="/resources/css/replyEnroll.css">
	</head>
	
	<body>
		<div class="wrapper_div">
			<div class="subject_div">
				리뷰 등록
			</div>
			<div class="input_wrap">			
				<div class="bookName_div">
					<h2>${bookInfo.bookName}</h2>
				</div>
				<div class="rating_div">
					<h4>평점</h4>
					<select name="rating">
						<option value="0.5">0.5</option>
						<option value="1.0">1.0</option>
						<option value="1.5">1.5</option>
						<option value="2.0">2.0</option>
						<option value="2.5">2.5</option>
						<option value="3.0">3.0</option>
						<option value="3.5">3.5</option>
						<option value="4.0">4.0</option>
					</select>
				</div>
				<div class="content_div">
					<h4>리뷰</h4>
					<textarea name="content"></textarea>
				</div>
			</div>
			<div class="btn_wrap">
				<a class="cancel_btn">취소</a><a class="enroll_btn">등록</a>
			</div>
		</div>
		
		<script>
		
			/* 취소 버튼 */
			$(".cancel_btn").on("click", function(e){
				window.close();   //팝업 창 종료
			});
			
			/* 등록 버튼 */
			$(".enroll_btn").on("click", function(e){
				const bookId = '${bookInfo.bookId}';   //상품id
				const memberId = '${memberId}';   //회원id
				const rating = $("select").val();   //평점
				const content = $("textarea").val();   //댓글 내용

				const data = {
						bookId : bookId,
						memberId : memberId,
						rating : rating,
						content : content
				}
				
				/* 비동기로 서버에 댓글 및 평점 등록 후 성공 시 팝업 창 종료 */
				$.ajax({
					data : data,
					type : 'POST',
					url : '/reply/enroll',
					success : function(result){
						window.close();
					}
				});
			});
		
		</script>
	</body>
</html>