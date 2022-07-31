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
	  	<link rel="stylesheet" href="/resources/css/replyUpdate.css">
	</head>
	
	<body>
		<div class="wrapper_div">
			<div class="subject_div">
				리뷰 수정
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
					<textarea name="content">${replyInfo.content}</textarea>   <%-- 기존에 작성했던 댓글 내용 --%>
				</div>
			</div>
			<div class="btn_wrap">
				<a class="cancel_btn">취소</a><a class="update_btn">수정</a>
			</div>
		</div>
		
		<script>
		
			$(document).ready(function(){
				
				/* 기존에 작성했던 평점 값 적용 */
				let rating = '${replyInfo.rating}';   //기존에 작성한 평점 값
				
				$("option").each(function(i,obj){   //<option> 태그가 여러 개 있기 때문에 option 객체에 접근을 하면 배열 형태의 프로퍼티
					if(rating === $(obj).val()){   //옵션 값들을 순회하며 DB에 저장됐던(기존에 작성한) 평점 값과 같은 값으로 옵션 선택 설정
						$(obj).attr("selected", "selected");
					}
				});
				
			});
		
			/* 취소 버튼 */
			$(".cancel_btn").on("click", function(e){
				window.close();   //팝업 창 종료
			});
			
			/* 수정 버튼 */
			$(".update_btn").on("click", function(e){
				const replyId = '${replyInfo.replyId}';   //댓글 id
				const bookId = '${replyInfo.bookId}';   //상품 id
				const memberId = '${memberId}';   //회원 id
				const rating = $("select").val();   //평점 값 (회원이 수정한)
				const content = $("textarea").val();   //댓글 내용 (회원이 수정한)
				
				const data = {   //서버에 보낼 데이터
						replyId : replyId,
						bookId : bookId,
						memberId : memberId,
						rating : rating,
						content : content
				}
				
				//비동기 방식 요청
				$.ajax({
					data : data,
					type : 'POST',
					url : '/reply/update',
					success : function(result){
						/* 댓글 초기화 - 댓글 작성 완료 후 댓글 작성 팝업 창이 종료되기 전에 부모 창에 '댓글 정보 최신화 동적 생성' 메서드를 호출 */
						$(opener.location).attr("href", "javascript:replyListInit();");
						
						window.close();
					}			
				});
			});
		
		</script>
	</body>
</html>