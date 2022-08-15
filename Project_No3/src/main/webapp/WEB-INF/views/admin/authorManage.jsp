<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- JSTL 라이브러리 코드를 추가 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" href="/resources/css/admin/authorManage.css">
		<script src="https://code.jquery.com/jquery-3.4.1.js" 
				integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" 
				crossorigin="anonymous"></script>
	</head>
	
	<body>
	
		<%@include file="../includes/admin/header.jsp" %>
		
					<div class="admin_content_wrap">
	                    <div class="admin_content_subject"><span>작가 관리</span></div>
	                    
	                    <div class="author_table_wrap">
	                    	<%-- 검색 키워드에 맞는 작가가 있는 경우 --%>
	                    	<c:if test="${listCheck != 'empty' }">
	                    		<table class="author_table">
		                    		<thead>
		                    			<tr>
		                    				<td class="th_column_1">작가 번호</td>
		                    				<td class="th_column_2">작가 이름</td>
		                    				<td class="th_column_3">작가 국가</td>
		                    				<td class="th_column_4">등록 날짜</td>
		                    				<td class="th_column_5">수정 날짜</td>
		                    			</tr>
		                    		</thead>
		                    		<c:forEach items="${list}" var="list">
			                    		<tr>
			                    			<td><c:out value="${list.authorId}"></c:out></td>
			                    			<td>
			                    				<a class="move" href='<c:out value="${list.authorId}"/>'>
			                    					<c:out value="${list.authorName}"></c:out>
			                    				</a>
			                    			</td>
			                    			<td><c:out value="${list.nationName}"></c:out></td>
			                    			<td><fmt:formatDate value="${list.regDate}" pattern="yyyy-MM-dd"/></td>
			                    			<td><fmt:formatDate value="${list.updateDate}" pattern="yyyy-MM-dd"/></td>
			                    		</tr>
		                    		</c:forEach>
		                    	</table>
	                    	</c:if>
	                    	<%-- 검색 키워드에 맞는 작가가 없는 경우 --%>
	                    	<c:if test="${listCheck == 'empty'}">
	                			<div class="table_empty">
	                				등록된 작가가 없습니다.
	                			</div>
	                		</c:if>
	                    </div>
	                    
	                    <!-- 검색 영역 -->
	                    <div class="search_wrap">
	                    	<form id="searchForm" action="/admin/authorManage" method="get">
           					<%-- 검색 키워드 정보와 pageNum과 amount에 대한 데이터도 같이 넘겨야 하기 때문에 type 값이 hidden인 <input> 태그 추가
                			해당 <input> 태그는 페이지가 로딩될 때 기본적으로 서버에서 전달받은 pageNum과 amount, keyword값이 저장되도록 설정 --%>
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
	                    		<%-- '${pageMaker.cri.pageNum == num?"active":"" ' 을 작성한 이유는 현재 페이지일 경우
                   				class 속성 값이 "pageMaker_btn active"되는데 해당 버튼에 현재 페이지임을 알 수 있도록 css 설정을 해주기 위함 --%>
		                    	<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="num">
		                    		<li class="pageMaker_btn ${ pageMaker.cri.pageNum == num ? "active" : "" }">
		                    			<a href="${num}">${num}</a>
		                    			<%-- <a> 태그의 href 속성 값으로 url 경로를 작성하지 않았습니다
		                    			href속성 값에 url 경로를 삽입할 경우 "/admin/authorManage? pageNum=${num}&amount=10"와 같이
		                    			쿼리스트링을 통해서 필요 데이터 값을 직접 작성해주면 됩니다
		                    			하지만 좀 더 다양한 상황에서 유연하게 명령을 처리할 수 있도록 <form> 태그 내부 <input>태그에
		                    			필요 데이터를 저장하고 Javascript 코드를 통해서 버튼의 동작과 <form>태그 안의 데이터를
		                    			서버에 전송할 수 있도록 하고자 함 --%>
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
					
					<!-- 페이지 이동 후 서버로부터 전달받은 "pageMaker" 데이터에 있는 pageNum, amount, keyword 값이 기본적으로 저장되도록 -->
                    <form id="moveForm" action="/admin/authorManage" method="get">
						<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
						<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
						<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
					</form>
	                </div>
	                
		<%@include file="../includes/admin/footer.jsp" %>
	    
	    <%-- 작성한 코드 그대로 사용하더라도 정상적으로 작동을 하지만 ${enroll_result} 는 사용자가 작성한 값을 그대로 전송되기 때문에
			XSS 공격과 같이 스크립트 코드를 주입시키는 웹사이트 공격에 취할 수 있다
			예를 들면 ${enroll_result}는 작가 등록 때 작성한 작가 이름인데,
			사용자가 <script> alert('공격');</script>을 작가 이름에 작성을 한다면
			'작가 관리(authorManage)' 페이지에 alsert() 문이 실행될 수 있다
			이를 방지하기 위해서 작가이름 작성을 할 때 유효성 검사를 통해 스크립트 코드를 작성하지 못하도록 할 수도 있다
			더불어 스크립트 코드가 입력되더라도 출력되는 값(${})에도 스크립트 코드가 실행이 되지 않도록 할 수 있는 방법이 JSTL의 <c:out>을 사용하는 것이다
			<c:out>는 변수의 내용을 출력할 때 사용되는 태그인데 해당 태그에 HTML 문자를 탈락(escpae)시키는 기능이 있기 때문 --%>
	    <script>
	    
			$(document).ready(function(){
				/* 작가 등록 수행 후 '작가 관리'페이지에 이동함과 동시에 등록 성공을 알리는 데이터("enroll_result")를 활용해 성공 경고창 띄우는 코드 */
				/* let result = "${enroll_result}";   //서버로부터 전달 받은 데이터 */
			    let result = '<c:out value="${enroll_result}"/>';
			    
			    checkResult(result);   //등록 성공 여부 확인 함수 호출
			    
			    function checkResult(result){   //등록 성공 여부 확인 함수
			        if(result === ''){   //전달받은 데이터가 비어있으면 취소
			            return;
			        }
			        alert("작가'${enroll_result}' 을 등록하였습니다.");   //등록 완료된 작가 이름을 알림창에 띄움
			    }
			    
			    /* 작가 수정 수행 후 '작가 관리' 페이지에 이동함과 동시에 수정 성공 여부를 알리는 데이터("modify_result")를 활용해 경고창 띄우는 코드 */
			    let mresult = '<c:out value="${modify_result}"/>';
				
				checkmResult(mresult);   //수정 성공 여부 확인 함수 호출
				
				function checkmResult(mresult){
					if(mresult === '1'){
						alert("작가 정보 수정을 완료하였습니다.");
					} else if(mresult === '0') {
						alert("작가 정부 수정을 하지 못하였습니다.")	
					}
				}
			});
			
			/* 작가 정보 삭제 결과 경고창 */
			let delete_result = '${delete_result}';
			
			if(delete_result == 1){
				alert("삭제 완료");
			} else if(delete_result == 2){
				alert("해당 작가 데이터를 사용하고 있는 데이터가 있어서 삭제 할 수 없습니다.")
			}
	    	
	    	
	    	/* 기능 요약
	    	'숫자 버튼'을 누르게 되면 <a> 태그의 동작을 멈추고, <a> 태그에 저장된 href속성 값을 <form> 태그의 내부에 있는 pageNum <input> 태그 값으로
	    	저장을 시킨 뒤 <fomr> 태그 속성에 설정되어 있는 url 경로와 method 방식으로 form을 서버로 전송*/
	    	/* let moveForm 변수를 선언한 이유는 <form> 태그 호출을 용이하게 하기 위함 */
			let moveForm = $('#moveForm');   //페이징 데이터 (cri)
			 
			/* 페이지 이동 버튼 */
			$(".pageMaker_btn a").on("click", function(e){
			    e.preventDefault();   //클릭한 페이지 번호 a태그 기능 억제
			    
			    moveForm.find("input[name='pageNum']").val($(this).attr("href"));   //페이징 데이터에 클릭한 페이지 번호 적용
			    
			    moveForm.submit();   //클릭한 페이지 번호에 대한 페이징 데이터 제출
			});
			
			/* 아래의 스크립트 코드가 없어도 검색 기능 동작이 가능
			하지만 키워드 입력 없이 사용자가 검색 버튼을 누르지 못하도록 유효성 체크 기능과 pageNum의 값을 1로 대입해주는 처리를 하기 위해서 아래의 Js 코드를 작성
			pageNum을 1로 변경해주는 이유는 만약 7페이지에 있는 상태에서 검색을 하는 경우 검색어로 필터링된 7페이지로 이동이 됩니다
			하지만 만약 필터링된 검색 결과가 7페이지가 존재하지 않을 경우 문제가 될 수 있습니다
			따라서 검색을 한경우 1페이지로 이동할 수 있도록 값을 변경해줍니다 */
			let searchForm = $('#searchForm');   //검색창
			
			/* 작거 검색 버튼 동작 */
			$("#searchForm button").on("click", function(e){
				e.preventDefault();
				
				/* 검색 키워드 유효성 검사 */
				if(!searchForm.find("input[name='keyword']").val()){
					alert("키워드를 입력하십시오");
					return false;
				}
				
				searchForm.find("input[name='pageNum']").val("1");
				searchForm.submit();
				
			});
			
			/* 작가 상세 페이지 이동 */
			$(".move").on("click", function(e){
				e.preventDefault();
				
				moveForm.append("<input type='hidden' name='authorId' value='"+ $(this).attr("href") + "'>");
				moveForm.attr("action", "/admin/authorDetail");
				moveForm.submit();
			});
			
		</script>
	</body>
</html>