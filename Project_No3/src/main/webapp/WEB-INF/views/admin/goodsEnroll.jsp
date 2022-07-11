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
		<link rel="stylesheet" href="/resources/css/admin/goodsEnroll.css">
		<script src="https://code.jquery.com/jquery-3.4.1.js" 
				integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" 
				crossorigin="anonymous"></script>

		<%-- CDN 방식 위지윅 에디터를 적용
			CKEditor5
			https://ckeditor.com/ckeditor-5/download/?undefined-addons= --%>
		<script src="https://cdn.ckeditor.com/ckeditor5/34.2.0/classic/ckeditor.js"></script>
		
		<%-- Jquery에서 제공하는 datepicker를 CDN 방식으로 활용 --%>
		<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
		<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
		<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
	</head>
	
	<body>
		
		<%@include file="../includes/admin/header.jsp" %>
		
	                <div class="admin_content_wrap">
	                    <div class="admin_content_subject"><span>상품 등록</span></div>
	                    
	                    <div class="admin_content_main">
	                    	<form action="/admin/goodsEnroll" method="post" id="enrollForm">   <%-- 상품 정보 입력 폼 --%>
	                    		<div class="form_section">
	                    			<div class="form_section_title">
	                    				<label>책 제목</label>
	                    			</div>
	                    			<div class="form_section_content">
	                    				<input name="bookName">
	                    			</div>
	                    		</div>
	                    		<div class="form_section">
	                    			<div class="form_section_title">
	                    				<label>작가</label>
	                    			</div>
	                    			<div class="form_section_content">
	                    			<%-- 기존의 작가 입력(authorId) <input>태그 옆에 버튼을 추가하여
	                    			해당 버튼을 누르게 되면 DB에 등록되어 있는 작가를 선택할 수 있는 팝업창이 뜨도록 구현할 것입니다
	                    			먼저 기존의 작가 <input>태그를 아래의 코드로 수정 --%>
	                    				<!-- <input name="authorId" value="0"> -->
	                    				<input id="authorName_input" readonly="readonly">   <%-- 사용자에게 보일 작가의 이름이 출력 --%>
										<input id="authorId_input" name="authorId" type="hidden">   <%-- '상품 등록'에 필요한 authorId 데이터를 보이지 않도록 저장 --%>
										<button class="authorId_btn">작가 선택</button>
	                    			</div>
	                    		</div>            
	                    		<div class="form_section">
	                    			<div class="form_section_title">
	                    				<label>출판일</label>
	                    			</div>
	                    			<div class="form_section_content">
	                    				<%-- 달력 위젯 적용을 위해 코드 수정
	                    				'autocomplte'경우 <input> 태그를 클릭했을때 이전 데이터가 뜨는 것을 막기 위해서
							'readony'를 추가해준 이유는 datepicker을 통해 삽입된 날짜 데이터를 사용자가 잘못된 형식으로 수정하지 못하도록 하기 위함 --%>
	                    				<input name="publeYear" autocomplete="off" readonly="readonly">
	                    			</div>
	                    		</div>            
	                    		<div class="form_section">
	                    			<div class="form_section_title">
	                    				<label>출판사</label>
	                    			</div>
	                    			<div class="form_section_content">
	                    				<input name="publisher">
	                    			</div>
	                    		</div>             
	                    		<div class="form_section">
	                    			<div class="form_section_title">
	                    				<label>책 카테고리</label>
	                    			</div>
	                    			<div class="form_section_content">
	                    				<input name="cateCode">
	                    			</div>
	                    		</div>          
	                    		<div class="form_section">
	                    			<div class="form_section_title">
	                    				<label>상품 가격</label>
	                    			</div>
	                    			<div class="form_section_content">
	                    				<input name="bookPrice" value="0">
	                    			</div>
	                    		</div>               
	                    		<div class="form_section">
	                    			<div class="form_section_title">
	                    				<label>상품 재고</label>
	                    			</div>
	                    			<div class="form_section_content">
	                    				<input name="bookStock" value="0">
	                    			</div>
	                    		</div>          
	                    		<div class="form_section">
	                    			<div class="form_section_title">
	                    				<label>상품 할인율</label>
	                    			</div>
	                    			<div class="form_section_content">
	                    				<input name="bookDiscount" value="0">
	                    			</div>
	                    		</div>          		
	                    		<div class="form_section">
	                    			<div class="form_section_title">
	                    				<label>책 소개</label>
	                    			</div>
	                    			<div class="form_section_content">
	                    				<%-- CKEditor5 위지윅 에디터 적용을 위해 input에서 textarea로 변경 --%>
	                    				<textarea name="bookIntro" id="bookIntro_textarea"></textarea>
	                    			</div>
	                    		</div>        		
	                    		<div class="form_section">
	                    			<div class="form_section_title">
	                    				<label>책 목차</label>
	                    			</div>
	                    			<div class="form_section_content">
	                    				<%-- CKEditor5 위지윅 에디터 적용을 위해 input에서 textarea로 변경 --%>
	                    				<textarea name="bookContents" id="bookContents_textarea"></textarea>
	                    			</div>
	                    		</div>
	                   		</form>
	                   		
                   			<div class="btn_section">   <%-- 버튼 --%>
                   				<button id="cancelBtn" class="btn">취 소</button>
	                    		<button id="enrollBtn" class="btn enroll_btn">등 록</button>
	                    	</div> 
                    	</div>
	                </div>
	                
		<%@include file="../includes/admin/footer.jsp" %>
		
		<script>

			let enrollForm = $("#enrollForm")   //상품 정보 입력 폼
			
			/* 취소 버튼 */
			$("#cancelBtn").click(function(){
				location.href="/admin/goodsManage"   //목록(관리) 페이지로 돌아감
			});
			
			/* 상품 등록 버튼 */
			$("#enrollBtn").on("click",function(e){
				e.preventDefault();
				
				enrollForm.submit();
			});
			
			/* CKEditor5 위지윅 적용 */
			/* 책 소개 */
			ClassicEditor
				.create(document.querySelector('#bookIntro_textarea'))
				.catch(error=>{
					console.error(error);
				});
			/* 책 목차 */	
			ClassicEditor
			.create(document.querySelector('#bookContents_textarea'))
			.catch(error=>{
				console.error(error);
			});
		
			/* Jquery에서 제공하는 datepicker 달력 위젯 적용 */
			/* 아래의 config 설정을 datepicker() 괄호 안에 추가하여 원하는 날짜 형식을 지정 */
			/* 캘린더 설정 config */
			const config = {
				//기본 적용 형식은 'dd/mm/yy', DB 저장을 위해 'yy-mm-dd' 형식으로 변경
				dateFormat: 'yy-mm-dd',
				//현재 캘린더가 동작하는 방식은 <input> 태그를 클릭하여 동작 하지만	<input>태그 옆에 버튼을 추가하여 해당 버튼을 눌렀을 때 동작하도록 변경
				showOn : "button",
				buttonText:"날짜 선택",
				//현재의 달력은 영어로 되어 있는데 이를 한글로 출력되도록 변경
				prevText: '이전 달',
			    nextText: '다음 달',
			    monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			    monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			    dayNames: ['일','월','화','수','목','금','토'],
			    dayNamesShort: ['일','월','화','수','목','금','토'],
			    dayNamesMin: ['일','월','화','수','목','금','토'],
			    yearSuffix: '년',
			    //'연도'와 '월'을 <select> 태그 형식으로 선택할 수 있도록 기능을 추가
		        changeMonth: true,
		        changeYear: true
			}
			$(function() {
				  $( "input[name='publeYear']" ).datepicker(config);
			});
			
			/* 작가 선택 팝업 창 버튼 */
			/* 작가 선택 버튼 */
			$('.authorId_btn').on("click",function(e){
				e.preventDefault();
				
				let popUrl = "/admin/authorPop";   //팝업 창 url
				let popOption = "width = 650px, height=550px, top=300px, left=300px, scrollbars=yes";   //팝업 창 설정
				
				window.open(popUrl,"작가 찾기",popOption);
			});
			
		</script>
		
	</body>
</html>