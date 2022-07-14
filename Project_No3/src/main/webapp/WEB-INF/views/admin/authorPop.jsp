<%-- 작가 선택 팝업 창 페이지 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- JSTL 라이브러리 코드 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" href="../resources/css/admin/authorPop.css">
		<script src="https://code.jquery.com/jquery-3.4.1.js" 
				integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" 
				crossorigin="anonymous"></script>
	</head>
	
	<body>
	
		<%-- 서버로부터 전달받은 "listCheck"와 "pageMaker" 데이터를 가지고 '작가 목록'과 '페이지 인터페이스'를 출력하는 코드를 추가
			"authorManage.jsp"에 작성한 코드를 복사 붙여 넣기 후 필요양식에 맞게 수정
			작가 목록 기능 구현" 과 동일한 과정의 코드 --%>
		<div class="subject_name_warp">
			<span>작가 선택</span>
		</div>
		
		<div class="content_wrap">
			<!-- 게시물 표 영역 -->
			<div class="author_table_wrap">
				<!-- 게시물 O -->
				<c:if test="${listCheck != 'empty'}">
					<div class="table_exist">
						<table class="author_table">
							<thead>
								<tr>
									<td class="th_column_1">작가 번호</td>
									<td class="th_column_2">작가 이름</td>
									<td class="th_column_3">작가 국가</td>
                    			</tr>
                    		</thead>
                    		<c:forEach items="${list}" var="list">
                    		<tr>
                    			<td><c:out value="${list.authorId}"></c:out></td>
                    			<td>
                    			<%-- 팝업창의 작가 이름을 클릭하였을 때 팝업창이 닫히면서 부모 창의 작가 <input> 태그에 데이터 입력되도록 --%>
                    			<%-- 태그 속성에 data-name 속성을 추가시켜서 <a> 태그에 '작가 이름' 데이터를 저장
                    				해당 데이터를 Javascript에서 꺼내 쓰기 위해서는 '선택자. data("name")' 코드를 통해 사용할 수 있습니다 --%>
                    				<a class="move" href='<c:out value="${list.authorId}"/>' data-name='<c:out value="${list.authorName}"/>'>
                    					<c:out value="${list.authorName}"></c:out>
                    				</a>
                    			</td>
                    			<td><c:out value="${list.nationName}"></c:out></td>
                    		</tr>
                    		</c:forEach>
                    	</table>
                   	</div>                			
				</c:if>
             	<!-- 게시물 x -->
             	<c:if test="${listCheck == 'empty'}">
					<div class="table_empty">
						등록된 작가가 없습니다.
					</div>
				</c:if>
               		
				<!-- 검색 영역 -->
				<div class="search_wrap">
					<form id="searchForm" action="/admin/authorPop" method="get">
						<div class="search_input">
							<input type="text" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"></c:out>'>
							<input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum }"></c:out>'>
							<input type="hidden" name="amount" value='${pageMaker.cri.amount}'>
							<button class='btn search_btn'>검 색</button>
						</div>
					</form>
				</div>
                    
				<!-- 페이지 이동 인터페이스 영역 -->
				<div class="pageMaker_wrap" >
					<ul class="pageMaker">
						<!-- 이전 버튼 -->
						<c:if test="${pageMaker.prev}">
							<li class="pageMaker_btn prev">
								<a href="${pageMaker.startPage - 1}">이전</a>
							</li>
						</c:if>
                    	
						<!-- 페이지 번호 -->
						<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="num">
							<li class="pageMaker_btn ${pageMaker.cri.pageNum == num ? "active":""}">
								<a href="${num}">${num}</a>
							</li>
						</c:forEach>
                    	
						<!-- 다음 버튼 -->
						<c:if test="${pageMaker.next}">
							<li class="pageMaker_btn next">
								<a href="${pageMaker.endPage + 1 }">다음</a>
							</li>
						</c:if>
					</ul>
				</div>
               		
				<%-- 페이지 이동 페이징 데이터 --%>
				<form id="moveForm" action="/admin/authorPop" method="get">
					<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
					<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
					<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
				</form>
			</div>
		</div>
		
		<script>

			let searchForm = $('#searchForm');   //검색 폼
			let moveForm = $('#moveForm');   //페이지 이동 페이징 데이터 폼
			
			/* 작감 검색 버튼 동작 */
			$("#searchForm button").on("click", function(e){
				e.preventDefault();
				
				/* 검색 키워드 유효성 검사 */
				if(!searchForm.find("input[name='keyword']").val()){
					alert("키워드를 입력하십시오");
					return false;
				}
				
				searchForm.find("input[name='pageNum']").val("1");   //검색 시 페이징 페이지를 1 페이지로 변경

				searchForm.submit();
			});
			
			
			/* 페이지 이동 버튼 */
			$(".pageMaker_btn a").on("click", function(e){
				e.preventDefault();
				
				console.log($(this).attr("href"));
				
				moveForm.find("input[name='pageNum']").val($(this).attr("href"));   //제출할 페이징 데이터의 페이지 번호를 내가 누른 번호로
				
				moveForm.submit();
			});
			
			/* 작가 선택 및 팝업창 닫기 */
			/* <a> 태그의 동작을 멈춘 뒤, 'authorId'와 'authorName' 변수를
			사용자가 클릭한 <a>태그 속성에 저장된 authorId, authorName 데이터로 초기화시킵니다
			$(opener.document)'를 통해 부모 요소 접근하여 각 <input> 태그에 'authorId', 'authorName' 변수의 값을 삽입합니다
			마지막으로 widnow.close()를 통해 팝업창을 닫습니다 */
			$(".move").on("click", function(e){
				e.preventDefault();
				
				let authorId = $(this).attr("href");   //클릭한 a태그 작가 id 초기화
				let authorName= $(this).data("name");   //클릭한 a태그 작가 이름 초기화
				
				$(opener.document).find("#authorId_input").val(authorId);   //부모요소 접근
				$(opener.document).find("#authorName_input").val(authorName);
				
				window.close();   //팝업 닫기
			});
			
		</script>
		
	</body>
</html>