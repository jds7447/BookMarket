<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- 디자인과 출력할 데이터 큰 틀이 '작가 상세 페이지(authorDetail.jsp)'와 거의 비슷하기 때문에
	'authorDetail.jsp'와 'authorDetail.css'의 코드를 복사하여 일부를 수정하는 방식으로 'authorModify' jsp, css 파일을 작성 --%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" href="../resources/css/admin/authorModify.css">
		<script src="https://code.jquery.com/jquery-3.4.1.js"
				integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
				crossorigin="anonymous"></script>
	</head>

	<body>
	
		<%@include file="../includes/admin/header.jsp" %>
		
					<div class="admin_content_wrap">
	                    <div class="admin_content_subject"><span>작가 상세</span></div>
	                    
	                    <%-- 작가 정보 <input>태그 전체를 <form> 태그로 감싸 작가 정보 수정을 처리하는 메서드에 데이터를 전달하기 위한 용도 --%>
	                    <div class="admin_content_main">
	                    	<form id="modifyForm" action="/admin/authorModify" method="post">
	                    	<%-- 사용자가 수정 할 수 있는 데이터는 작가 이름(authorName), 작가 국가(nationId), 작가 소개(authorIntro)입니다
	                    	따라서 해당 <input>, <textarea>, <option> 태그에 "readonly"속성과 "disabled"속성을 지우고 class 속성 또한 지워줍니다
	                    	class 속성은 색상을 제거하기 위해 지웠습니다 --%>
		                   		<div class="form_section">
		                   			<div class="form_section_title">
		                   				<label>작가 번호</label>
		                   			</div>
		                   			<div class="form_section_content">
		                   				<input class="input_block" name="authorId" readonly="readonly" value="<c:out value='${authorInfo.authorId}'></c:out>">
		                   			</div>
		                   		</div>                    
		                   		<div class="form_section">
		                   			<div class="form_section_title">
		                   				<label>작가 이름</label>
		                   			</div>
		                   			<div class="form_section_content">
		                   				<input name="authorName" value="<c:out value='${authorInfo.authorName}'></c:out>" >
		                   				<%-- 작가 이름, 작가 소개 <div>태그 내부에 <span> 태그와 경고 문구를 추가
		                   				이는 수정 버튼을 눌러 서버에 수정 요청을 하기 전 빈 데이터를 전송하지 않기 위해서
		                   				유효성 체크를 할 때 빈 데이터일 경우 경구 문구를 띄우기 위한 용도
		                   				<span>태그는 일반적 상황에서 보이지 않도록 하기 위해 css 설정을 추가 --%>
		                   				<span id="warn_authorName">작가 이름을 입력 해주세요.</span>
		                   			</div>
		                   		</div>
		                   		<div class="form_section">
		                   			<div class="form_section_title">
		                   				<label>소속 국가</label>
		                   			</div>
		                   			<div class="form_section_content">
		                   				<select name="nationId" >
		                   					<option value="none" disabled="disabled">=== 선택 ===</option>
		                   					<option value="01" <c:out value=" ${authorInfo.nationId eq '01' ?'selected':''}"/>>국내</option>
		                   					<option value="02" <c:out value=" ${authorInfo.nationId eq '02' ?'selected':''}"/>>국외</option>
		                   				</select>
		                   			</div>
		                   		</div>
		                   		<div class="form_section">
		                   			<div class="form_section_title">
		                   				<label>작가소개</label>
		                   			</div>
		                   			<div class="form_section_content">
		                   				<textarea name="authorIntro" ><c:out value='${authorInfo.authorIntro}'/></textarea>
		                   				<span id="warn_authorIntro">작가 소개를 입력 해주세요.</span>
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
		                 		<div class="btn_section">
		                   			<button id="cancelBtn" class="btn">취소</button>
			                    	<button id="modifyBtn" class="btn modify_btn">수 정</button>
			                    </div> 
		                    </form>
	                    </div>                    
					</div>
	                
	                <%--  Criteria(pageNum, amount, keyword) 데이터를 저장하고 있는 기존의 <form> 태그를 그대로 남겨둠
	                	왜냐하면 '작가 수정 페이지(authorModify.jsp)'에서 다시 '작가 상세 페이지(authorDetail.jsp)' 이동을 할 수 있도록 설계를 하였는데
	                	'작가 상세 페이지'에서 만약 다시 '작가 관리 페이지(authorManage.jsp)'로 이동을 할 경우 Criteria 데이터가 필요로 하기 때문 --%>
	                <form id="moveForm" method="get">
	                	<input type="hidden" name="authorId" value='<c:out value="${authorInfo.authorId }"/>'>
	                	<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum }"/>'>
	                	<input type="hidden" name="amount" value='<c:out value="${cri.amount }"/>' >
	                	<input type="hidden" name="keyword" value='<c:out value="${cri.keyword }"/>'>
	                </form>
	                
		<%@include file="../includes/admin/footer.jsp" %>
		
		<script>
		
			let moveForm = $("#moveForm");
			let modifyForm = $("#modifyForm");
	
			/* 취소(작가 상세 페이지 이동) 버튼 */
			$("#cancelBtn").on("click", function(e){
				e.preventDefault();
						
				moveForm.attr("action", "/admin/authorDetail")
				moveForm.submit();
			});
			
			/* 수정(작가 수정) 버튼 작동 및 유효성 검사 */
			/* 작가 정보 수정 버튼의 경우는 먼저 anmeCk와 introCk 변수를 선언하여 기본적으로 false 값으로 초기화
			리고 작가 이름, 작가 소개 <input> 태그가 공란이 아닌지 if문을 통해 체크하여 공란일 경우 Ck값을 false를 대입 및
			<span> 태그 노출시키고 공란이 아닐 경우 Ck값을 true로 대입 및 <span> 태그를 숨깁니다
			마지막 최종적으로 Ck값이 모드 true일 때 작가 정보 데이터가 담긴 <form>이 서버에 전송 */
			$("#modifyBtn").on("click", function(e){
				let authorName = $(".form_section_content input[name='authorName']").val();
				let authorIntro = $(".form_section_content textarea").val();		
	
				let	nameCk = false;
				let introCk = false;		
				
				e.preventDefault();
				
				if(!authorName){
					$("#warn_authorName").css("display", "block");
				} else {
					$("#warn_authorName").css("display", "none");
					nameCk = true;
				}
				if(!authorIntro){
					$("#warn_authorIntro").css("display", "block");
				} else {
					$("#warn_authorIntro").css("display", "none");
					introCk = true;
				}
				
				if(nameCk && introCk ){
					modifyForm.submit();	
				} else {
					return false;
				}
			});
		
		</script>
	
	</body>
</html>