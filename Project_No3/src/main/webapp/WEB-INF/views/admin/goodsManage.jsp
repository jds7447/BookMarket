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
		<link rel="stylesheet" href="/resources/css/admin/goodsManage.css">
		<script src="https://code.jquery.com/jquery-3.4.1.js" 
				integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" 
				crossorigin="anonymous"></script>
	</head>
	
	<body>
	
		<%@include file="../includes/admin/header.jsp" %>
		
	                <div class="admin_content_wrap">
	                    <div class="admin_content_subject"><span>상품 관리</span></div>
	                </div>
	                
		<%@include file="../includes/admin/footer.jsp" %>
		
		<script>
			$(document).ready(function(){
				let eResult = '<c:out value="${enroll_result}"/>';   //서버에서 전달한 상품 등록 결과 데이터
				
				checkResult(eResult);
				
				function checkResult(result){
					if(result === ''){   //결과 데이터가 비어있으면 함수 종료
						return;
					}
					alert("상품 '" + eResult + "' 을 등록하였습니다.");   //결과 데이터(책 이름)를 이용한 알림 메시지 띄움
				}
			});
		</script>
		
	</body>
</html>