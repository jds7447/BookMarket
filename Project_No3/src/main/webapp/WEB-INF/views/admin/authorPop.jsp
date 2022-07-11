<%-- 작가 선택 팝업 창 페이지 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- JSTL 라이브러리 코드 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" href="../resources/css/admin/authorPop.css">
		<meta charset="UTF-8">
		<title>Insert title here</title>
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
                    			<td><c:out value="${list.authorId}"></c:out> </td>
                    			<td><c:out value="${list.authorName}"></c:out></td>
                    			<td><c:out value="${list.nationName}"></c:out> </td>
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
               		
				<%-- 페이징 데이터 --%>
				<form id="moveForm" action="/admin/authorPop" method="get">
					<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
					<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
					<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
				</form>
			</div>
		</div>
		
	</body>
</html>