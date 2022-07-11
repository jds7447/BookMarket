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
		<link rel="stylesheet" href="/resources/css/admin/authorDetail.css">
		<script src="https://code.jquery.com/jquery-3.4.1.js"
				integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
				crossorigin="anonymous"></script>
	</head>

	<body>
	
		<%@include file="../includes/admin/header.jsp" %>
		
					<div class="admin_content_wrap">
                    	<div class="admin_content_subject"><span>작가 상세</span></div>
                    	
                   		<%--  <input> 태그에 수정을 하지 못하도록 'readonly'속성을 추가 --%>
						<div class="admin_content_main">
	                   		<div class="form_section">
	                   			<div class="form_section_title">
	                   				<label>작가 번호</label>
	                   			</div>
	                   			<div class="form_section_content">
	                   				<input class="input_block" name="authorId" readonly="readonly" value="<c:out value='${authorInfo.authorId }'></c:out>">
	                   			</div>
	                   		</div>
	                   		<div class="form_section">
	                   			<div class="form_section_title">
	                   				<label>작가 이름</label>
	                   			</div>
	                   			<div class="form_section_content">
	                   				<input class="input_block" name="authorName" readonly="readonly" value="<c:out value='${authorInfo.authorName }'></c:out>" >
	                   			</div>
	                   		</div>
	                   		<div class="form_section">
	                   			<div class="form_section_title">
	                   				<label>소속 국가</label>
	                   			</div>
	                   			<%-- <option>태그의 경우 선택을 하지 못하도록 하기위해서 'disabled' 속성을 추가 --%>
	                   			<div class="form_section_content">
	                   				<select class="input_block" name="nationId" >
	                   					<option value="none" selected disabled="disabled">=== 선택 ===</option>
	                   					<option value="01" disabled="disabled" <c:out value=" ${authorInfo.nationId eq '01' ?'selected':''}"/>>국내</option>
	                   					<option value="02" disabled="disabled" <c:out value=" ${authorInfo.nationId eq '02' ?'selected':''}"/>>국외</option>
	                   				</select>
	                   			</div>
	                   		</div>
	                   		<div class="form_section">
	                   			<div class="form_section_title">
	                   				<label>작가소개</label>
	                   			</div>
	                   			<div class="form_section_content">
	                   				<textarea class="input_block" name="authorIntro" readonly="readonly"><c:out value='${authorInfo.authorIntro }'/></textarea>
	                   			</div>
	                   		</div>
	                   		<div class="form_section">
	                   			<div class="form_section_title">
	                   				<label>등록 날짜</label>
	                   			</div>
	                   			<div class="form_section_content">
	                   				<input class="input_block" type="text" readonly="readonly" value="<fmt:formatDate value="${authorInfo.regDate}" pattern="yyyy-MM-dd"/>">
	                   			</div>
	                   		</div>
							<div class="form_section">
	                   			<div class="form_section_title">
	                   				<label>수정 날짜</label>
	                   			</div>
	                   			<div class="form_section_content">
	                   				<input class="input_block" type="text" readonly="readonly" value="<fmt:formatDate value="${authorInfo.updateDate}" pattern="yyyy-MM-dd"/>">
	                   			</div>
                   			</div>
                   			<%-- '작가 관리 페이지(authorManage.jsp)', '작가 수정 페이지(authorModify.jsp)'로 이동할 수 있도록 버튼 --%>
                   			<div class="btn_section">
                   				<button id="cancelBtn" class="btn">작가 목록</button>
	                    		<button id="modifyBtn" class="btn modify_btn">수 정</button>
	                    	</div> 
						</div>                    
					</div>
                	
                	<%-- Criteria 정보를 저장하는 <form> 태그 --%>
					<form id="moveForm" method="get">
						<input type="hidden" name="authorId" value='<c:out value="${authorInfo.authorId }"/>'>
						<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum }"/>'>
						<input type="hidden" name="amount" value='<c:out value="${cri.amount }"/>' >
						<input type="hidden" name="keyword" value='<c:out value="${cri.keyword }"/>'>
					</form>
                
		<%@include file="../includes/admin/footer.jsp" %>
				
		<script>
		
			let moveForm = $("#moveForm");   //전달 해야하는 데이터 모음
	
			/* 작가 관리 페이지 이동 버튼 */
			$("#cancelBtn").on("click", function(e){
				e.preventDefault();
				
				$("input[name=authorId]").remove();
				moveForm.attr("action", "/admin/authorManage")
				moveForm.submit();
			});
			
			/* 작가 수정 페이지 이동 버튼 */
			$("#modifyBtn").on("click", function(e){
				e.preventDefault();
				
				moveForm.attr("action", "/admin/authorModify");
				moveForm.submit();
			});
		
		</script>
	</body>
</html>