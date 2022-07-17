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
		<!-- 업로드 이미지 출력 태그 스타일 -->
		<style type="text/css">
			#result_card img{
				max-width: 100%;
			    height: auto;
			    display: block;
			    padding: 5px;
			    margin-top: 10px;
			    margin: auto;	
			}
			#result_card {
				position: relative;
			}
			.imgDeleteBtn{
			    position: absolute;
			    top: 0;
			    right: 5%;
			    background-color: #ef7d7d;
			    color: wheat;
			    font-weight: 900;
			    width: 30px;
			    height: 30px;
			    border-radius: 50%;
			    line-height: 26px;
			    text-align: center;
			    border: none;
			    display: block;
			    cursor: pointer;	
			}
		</style>
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
	                    				<span class="ck_warn bookName_warn">책 이름을 입력해주세요.</span>   <%-- 공란 유효성 검사 --%>
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
										<span class="ck_warn authorId_warn">작가를 선택해주세요</span>   <%-- 공란 유효성 검사 --%>
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
	                    				<span class="ck_warn publeYear_warn">출판일을 선택해주세요.</span>   <%-- 공란 유효성 검사 --%>
	                    			</div>
	                    		</div>            
	                    		<div class="form_section">
	                    			<div class="form_section_title">
	                    				<label>출판사</label>
	                    			</div>
	                    			<div class="form_section_content">
	                    				<input name="publisher">
	                    				<span class="ck_warn publisher_warn">출판사를 입력해주세요.</span>   <%-- 공란 유효성 검사 --%>
	                    			</div>
	                    		</div>             
	                    		<div class="form_section">
	                    			<div class="form_section_title">
	                    				<label>책 카테고리</label>
	                    			</div>
	                    			<div class="form_section_content">
	                    				<%-- 상품 카테고리를 출력시킬 기본적인 틀로서 <select>,<option>태그를 추가 --%>
	                    				<%-- 사용자가 '대분류'를 선택하게 되면 그에맞는 '중분류' <option>이 세팅이 되고,
	                    					'중분류'를 선택하면 그에 맞는 '소분류'의 <option> 태그가 세팅하게 됩니다
	                    					그리고 최종적으로 '소분류'를 선택하는 것은 상품 등록에 필요로 한 "cateCode"데이터를 선택하는 것이기 때문에
	                    					'소분류'의 <select> 태그에 name속성을 부여 --%>
	                    				<!-- <input name="cateCode"> -->
	                    				<div class="cate_wrap">
											<span>대분류</span>
											<select class="cate1">
												<option selected value="none">선택</option>
											</select>
										</div>
										<div class="cate_wrap">
											<span>중분류</span>
											<select class="cate2">
												<option selected value="none">선택</option>
											</select>
										</div>
										<div class="cate_wrap">
											<span>소분류</span>
											<select class="cate3" name="cateCode">
												<option selected value="none">선택</option>
											</select>
										</div>
										<span class="ck_warn cateCode_warn">카테고리를 선택해주세요.</span>   <%-- 공란 유효성 검사 --%>
	                    			</div>
	                    		</div>          
	                    		<div class="form_section">
	                    			<div class="form_section_title">
	                    				<label>상품 가격</label>
	                    			</div>
	                    			<div class="form_section_content">
	                    				<input name="bookPrice" value="0">
	                    				<span class="ck_warn bookPrice_warn">상품 가격을 입력해주세요.</span>   <%-- 공란 유효성 검사 --%>
	                    			</div>
	                    		</div>               
	                    		<div class="form_section">
	                    			<div class="form_section_title">
	                    				<label>상품 재고</label>
	                    			</div>
	                    			<div class="form_section_content">
	                    				<input name="bookStock" value="0">
	                    				<span class="ck_warn bookStock_warn">상품 재고를 입력해주세요.</span>   <%-- 공란 유효성 검사 --%>
	                    			</div>
	                    		</div>          
	                    		<div class="form_section">
	                    			<div class="form_section_title">
	                    				<label>상품 할인율</label>
	                    			</div>
	                    			<div class="form_section_content">
	                    				<%-- 현재의 할인율 입력란을 소수를 입력을 해야 에러가 나지 않습니다
	                    				하지만 일반의 사용자는 정수를 입력하는 것이 편할 수 있습니다
	                    				따라서 사용자가 입력은 정수를 입력하고 서버에 전송할 때는 해당 값을 소수로 변경되도록
	                    				더불어서 사용자가 제품 가격과 할인율을 입력하였을 때 할인된 가격이 얼마인지 볼 수 있도록 구현 --%>
	                    				<!-- <input name="bookDiscount" value="0"> -->
	                    				<input id="discount_interface" maxlength="2" value="0">   <!-- 1~99 값만 작성하도록 maxlength -->
										<input name="bookDiscount" type="hidden" value="0">   <!-- 서버에 전송될 할인율 (입력한 정수를 소수점) -->
										<span class="step_val">할인 가격 : <span class="span_discount"></span></span>
	                    				<!-- <span class="ck_warn bookDiscount_warn">상품 할인율을 입력해주세요.</span> -->   <%-- 공란 유효성 검사 --%>
	                    				<span class="ck_warn bookDiscount_warn">1~99 숫자를 입력해주세요.</span>
	                    			</div>
	                    		</div>
	                    		<div class="form_section">
	                    			<div class="form_section_title">
	                    				<label>책 소개</label>
	                    			</div>
	                    			<div class="form_section_content bit">
	                    				<%-- CKEditor5 위지윅 에디터 적용을 위해 input에서 textarea로 변경 --%>
	                    				<textarea name="bookIntro" id="bookIntro_textarea"></textarea>
	                    				<span class="ck_warn bookIntro_warn">책 소개를 입력해주세요.</span>   <%-- 공란 유효성 검사 --%>
	                    			</div>
	                    		</div>        		
	                    		<div class="form_section">
	                    			<div class="form_section_title">
	                    				<label>책 목차</label>
	                    			</div>
	                    			<div class="form_section_content bct">
	                    				<%-- CKEditor5 위지윅 에디터 적용을 위해 input에서 textarea로 변경 --%>
	                    				<textarea name="bookContents" id="bookContents_textarea"></textarea>
	                    				<span class="ck_warn bookContents_warn">책 목차를 입력해주세요.</span>   <%-- 공란 유효성 검사 --%>
	                    			</div>
	                    		</div>
	                    		<div class="form_section">
	                    			<div class="form_section_title">
	                    				<label>상품 이미지</label>
	                    			</div>
                    				<div class="form_section_content">
                    					<input type="file" id ="fileItem" name='uploadFile' style="height: 30px;">
                    					<!-- 위에 추가 해준 <input> 태그는 파일 1개만 추가할 수 있는 형식, 파일 여러 개 선택 시 'multiple' 속성 추가 -->
                    					<!-- 파일 여러개 -->
										<!-- <input type="file" multiple> -->
										
										<div id="uploadResult">   <!-- 업로드 한 이미지를 출력 -->
											<!-- <div id="result_card">
												<div class="imgDeleteBtn">x</div>   이미지 삭제 기능을 수행 버튼
												<img src="/display?fileName=기존거백업/P1234.png">   테스트이미지
											</div> -->
											
										</div>
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
				
				/* 유효성 검사를 위한 체크 변수 */
				let bookNameCk = false;   //책이름
				let authorIdCk = false;   //작가
				let publeYearCk = false;   //출판일
				let publisherCk = false;   //출판사
				let cateCodeCk = false;   //카테고리 분류
				let priceCk = false;   //가격
				let stockCk = false;   //재고
				let discountCk = false;   //할인율
				let introCk = false;   //책소개
				let contentsCk = false;   //책목차
				
				/* 체크 대상 변수 - 상품 등록 정보 input 태그 */
				let bookName = $("input[name='bookName']").val();   //책이름
				let authorId = $("input[name='authorId']").val();   //작가
				let publeYear = $("input[name='publeYear']").val();   //출판일
				let publisher = $("input[name='publisher']").val();   //출판사
				let cateCode = $("select[name='cateCode']").val();   //카테고리 분류
				let bookPrice = $("input[name='bookPrice']").val();   //가격
				let bookStock = $("input[name='bookStock']").val();   //재고
				//let bookDiscount = $("input[name='bookDiscount']").val();   //할인율 (보이지 않는 <input> 태그를 가리키)
				let bookDiscount = $("#discount_interface").val();   //할인율 (사용자가 입력하는 <input>태그를 가리키)
				let bookIntro = $(".bit p").html();   //CKEditor5 위지윅 적용한 책 소개 textarea
				let bookContents = $(".bct p").html();   //CKEditor5 위지윅 적용한 책 목차 textarea
				
				/* 각 항목 공란 체크 */
				if(bookName){
					$(".bookName_warn").css('display','none');
					bookNameCk = true;
				} else {
					$(".bookName_warn").css('display','block');
					bookNameCk = false;
				}
				
				if(authorId){
					$(".authorId_warn").css('display','none');
					authorIdCk = true;
				} else {
					$(".authorId_warn").css('display','block');
					authorIdCk = false;
				}
				
				if(publeYear){
					$(".publeYear_warn").css('display','none');
					publeYearCk = true;
				} else {
					$(".publeYear_warn").css('display','block');
					publeYearCk = false;
				}	
				
				if(publisher){
					$(".publisher_warn").css('display','none');
					publisherCk = true;
				} else {
					$(".publisher_warn").css('display','block');
					publisherCk = false;
				}
				
				if(cateCode != 'none'){
					$(".cateCode_warn").css('display','none');
					cateCodeCk = true;
				} else {
					$(".cateCode_warn").css('display','block');
					cateCodeCk = false;
				}	
				
				if(bookPrice != 0){
					$(".bookPrice_warn").css('display','none');
					priceCk = true;
				} else {
					$(".bookPrice_warn").css('display','block');
					priceCk = false;
				}	
				
				if(bookStock != 0){
					$(".bookStock_warn").css('display','none');
					stockCk = true;
				} else {
					$(".bookStock_warn").css('display','block');
					stockCk = false;
				}		
				
				//if(bookDiscount < 1 && bookDiscount != ''){
				if(!isNaN(bookDiscount)){   //isNaN(is Not a Number) :  메서드의 파라미터에 있는 값이 문자인 경우 true를 반환
					$(".bookDiscount_warn").css('display','none');
					discountCk = true;
				} else {
					$(".bookDiscount_warn").css('display','block');
					discountCk = false;
				}	
				
				if(bookIntro != '<br data-cke-filler="true">'){
					$(".bookIntro_warn").css('display','none');
					introCk = true;
				} else {
					$(".bookIntro_warn").css('display','block');
					introCk = false;
				}	
				
				if(bookContents != '<br data-cke-filler="true">'){
					$(".bookContents_warn").css('display','none');
					contentsCk = true;
				} else {
					$(".bookContents_warn").css('display','block');
					contentsCk = false;
				}
				
				/* 최종 확인 */
				if(bookNameCk && authorIdCk && publeYearCk && publisherCk && cateCodeCk && priceCk && stockCk && discountCk && introCk && contentsCk ){
					enrollForm.submit();
				} else {
					return false;
				}
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
			
			
			/* 상품 카테고리 리스트 */
			/* 서버로 부터 전달받은 JSON 데이터를 Javascript가 바로 사용할 수 없어서 JSON 데이터를 Javascript트로 객체로 변환해주어야 합니다
				Javascript 에서는 JSON 문자열 데이터를 Javascript 객체로 변환해주는 메서드를 제공 >> JSON.parse() */
			let cateList = JSON.parse('${cateList}');   //서버로 부터 전달받은 JSON 데이터 카테고리 리스트를 javascript 객체로 변환
				
			/* 현재의 'cateList' 객체에는 '대분류', '중분류', '소분류' 모두 섞여 있는 상태
				이 객체를 각 등급(tier)에 맞게 분류하여 배열에 저장시킬 것
				각 배열에는 'cateName', 'cateCode', 'cateParent' 변수와 그 값을 가지고 있는 객체가 저장될 것
			작가 관리 페이지에서 작가 목록 리스트 데이터를 반환받기 위해 mapper, Service 메서드에서 반환 타입으로 사용했던 "List<AuthorVO>"와 형태가 동일 */
			let cate1Array = new Array();   //1등급 튜플 모음 (tier 값이 1인 튜플의 데이터를 가지고 있는 객체들을 저장)
			let cate2Array = new Array();   //2등급 튜플 모음 (tier 값이 2인 튜플의 데이터를 가지고 있는 객체들을 저장)
			let cate3Array = new Array();   //3등급 튜플 모음 (tier 값이 3인 튜플의 데이터를 가지고 있는 객체들을 저장)
			let cate1Obj = new Object();   //1등급 튜플 (tier 값이 1인 튜플 1개의 'cateName', 'cateCode', 'cateParent' 변수와 그 값을 저장)
			let cate2Obj = new Object();   //2등급 튜플 (tier 값이 2인 튜플 1개의 'cateName', 'cateCode', 'cateParent' 변수와 그 값을 저장)
			let cate3Obj = new Object();   //3등급 튜플 (tier 값이 3인 튜플 1개의 'cateName', 'cateCode', 'cateParent' 변수와 그 값을 저장)
			
			let cateSelect1 = $(".cate1");   //대분류 (1 tier)
			let cateSelect2 = $(".cate2");   //중분류 (2 tier)
			let cateSelect3 = $(".cate3");   //소분류 (3 tier)
			
			/* 카테고리 배열 초기화 메서드 */
			//객체, 배열, 카테고리 리스트, 티어값 을 받아 카테고리 리스트에서 각 위치에 맞는 값을 초기화 하는 함수
			function makeCateArray(obj, array, cateList, tier) {
				for(let i = 0; i < cateList.length; i++) {   //카테고리 리스트의 내부 객체 수 만큼 반복
					if(cateList[i].tier === tier) {   //각 튜플의 티어 값이 전달 받은 티어 값과 동일하면
						obj = new Object();   //객체 생성
						
						obj.cateName = cateList[i].cateName;   //생성한 객체에 각 값 추가
						obj.cateCode = cateList[i].cateCode;
						obj.cateParent = cateList[i].cateParent;
						
						array.push(obj);   //각 값을 넣은 객체를 배열에 저장
					}
				}
			}
			
			/* 배열 초기화 */
			makeCateArray(cate1Obj, cate1Array, cateList, 1);
			makeCateArray(cate2Obj, cate2Array, cateList, 2);
			makeCateArray(cate3Obj, cate3Array, cateList, 3);
			
			/* 'for'문과 Jquery의 'append'를 이용해 상품 카테고리 '대분류' <select> 태그 내부에 <option> 태그를 추가 */
			for(let i = 0; i < cate1Array.length; i++){
				cateSelect1.append("<option value='"+cate1Array[i].cateCode+"'>" + cate1Array[i].cateName + "</option>");
			}   //value 값엔 cateCode(000000) 가 들어가고 보여지는 HTML에는 cateName(국내, 국외)가 들어감
			
			/* 중분류 <option> 태그 - 대분류의 옵션이 선택되었을 때 출력이 되어야 함 */
			$(cateSelect1).on("change", function() {
				let selectVal1 = $(this).find("option:selected").val();   //대분류에서 선택한 카테고리의 값(value) 가져오기
				
				cateSelect2.children().remove();   //중분류 옵션 태그 모두 지우기 
													//(사용자가 대분류 선택 후 다시 다른 대분류를 선택했을 때 기존의 <option> 태그들을 없애기 위함)
				cateSelect2.append("<option value='none'>선택</option>");   //중분류 기본(초기) 옵션 태그 추가
				
				/* 대분류, 중분류, 소분류 순으로 선택을 한 뒤 다시 대분류를 선택을 하게 되면
					중분류는 정상적으로 기존의 코드가 없어지고 기본 <option> 태그가 출력이되는데 소분류는 기존의 <option> 태그가 그대로 있습니다
				 이는 중분류 선택이 변경되었을 때만 소분류가 초기화되도록 작성하였기 때문
				 이를 해결하기 위해선 대분류가 변경되었을 때도 소분류가 초기화 되도록 코드를 추가 */
				cateSelect3.children().remove();
				cateSelect3.append("<option value='none'>선택</option>");
				
				for(let i = 0; i < cate2Array.length; i++){   //대분류 선택 값과 일치하는 'cateParent'값을 가진 중분류 <option> 태그를 출력
					if(selectVal1 === cate2Array[i].cateParent){
						cateSelect2.append("<option value='"+cate2Array[i].cateCode+"'>" + cate2Array[i].cateName + "</option>");	
					}   //부모 cateCode 값(cateParent)이 대분류에서 선택한 것의 cateCode 값과 일치하는 tier 2의 객체를 찾아 중분류 옵션에 추가
				}
			});
			
			/* 소분류 <option>태그 - 중분류와 비슷한 형태, 중분류 옵션이 선택되었을 때 출력이 되어야 함 */
			$(cateSelect2).on("change",function(){
				let selectVal2 = $(this).find("option:selected").val();   //중분류에서 선택한 카테고리의 값(value) 가져오기
				
				cateSelect3.children().remove();   //소분류 옵션 태그 모두 지우기 
				cateSelect3.append("<option value='none'>선택</option>");   //소분류 기본(초기) 옵션 태그 추가
				
				for(let i = 0; i < cate3Array.length; i++){   //중분류 선택 값과 일치하는 'cateParent'값을 가진 소분류 <option> 태그를 출력
					if(selectVal2 === cate3Array[i].cateParent){
						cateSelect3.append("<option value='"+cate3Array[i].cateCode+"'>" + cate3Array[i].cateName + "</option>");	
					}
				}
			});
			
			/* 할인율 Input 설정 */
			//사용자가 입력 할 수 있는 input에 값이 입력되었을 때 바로 숨겨진 할인율 <input> 태그에 소수의 값이 입력되도록
			//propertychange change keyup paste input : input box에 사용자가 값을 입력하면 실시간으로 감지
			$("#discount_interface").on("propertychange change keyup paste input", function(){
				let userInput = $("#discount_interface");   //사용자가 할인율 정수 1~99 를 입력하는 input 요소
				let discountInput = $("input[name='bookDiscount']");   //사용자가 입력한 정수를 소수점으로 바꿔 서버에 전송할 히든 인풋 요소
				
				let discountRate = userInput.val();   // 사용자가 입력할 할인값
				let sendDiscountRate = discountRate / 100;   // 서버에 전송할 할인값
				
				/* 할인율 입력란에 입력할 때 할인 가격이 출력되어야 하기 때문에 앞에서 추가한 메서드에 위의식을 활용하여 할인 가격이 출력되도록 */
				let goodsPrice = $("input[name='bookPrice']").val();   // 원가 (상품 가격)
				let discountPrice = goodsPrice * (1 - sendDiscountRate);   // 할인된 상품 가격 (상품 가격 - 할인가)
				
				/* 할인 가격에 NaN이 출력되어 할인 가격을 출력하는 코드에도 isNaN을 사용하는 조건문을 가진 if 문으로 감싸 */
				if(!isNaN(discountRate)){
					$(".span_discount").html(discountPrice);   //할인된 상품 가격을 span 요소에 표시
					discountInput.val(sendDiscountRate);   //서버에 전송할 할인값을 히든 인풋 요소에 넣기
				}
			});
			/* '상품 가격', '상품 할인율' 순으로 입력을 했다가 다시 '상품 가격'을 수정하는 경우에도 '할인 가격'을 바로 볼 수 있도록 */
			$("input[name='bookPrice']").on("change", function(){
				let userInput = $("#discount_interface");   //사용자가 할인율 정수 1~99 를 입력하는 input 요소
				let discountInput = $("input[name='bookDiscount']");   //사용자가 입력한 정수를 소수점으로 바꿔 서버에 전송할 히든 인풋 요소
				
				let discountRate = userInput.val();					// 사용자가 입력한 할인값
				let sendDiscountRate = discountRate / 100;			// 서버에 전송할 할인값
				let goodsPrice = $("input[name='bookPrice']").val();			// 원가
				let discountPrice = goodsPrice * (1 - sendDiscountRate);		// 할인가격
				
				/* 할인 가격에 NaN이 출력되어 할인 가격을 출력하는 코드에도 isNaN을 사용하는 조건문을 가진 if 문으로 감싸 */
				if(!isNaN(discountRate)){
					$(".span_discount").html(discountPrice);
				}
			});
			
			/* type이 file인 <input> 태그에 접근하기 위해서 해당 <input> 태그가 change 이벤트가 일어났을 때 동작하는 메서드 추가 */
			/* 이미지 업로드 */
			$("input[type='file']").on("change", function(e){
				/* 이미 업로드 된 이미지 존재시 삭제 */
				if($(".imgDeleteBtn").length > 0){   //미리보기 이미지 태그의 존재 유무 확인 (이미지 삭제 버튼을 선택자로)
					deleteFile();
				}
				
				/* FileList 객체에 접근 */
				//"type이 file인 <input> 요소(element)"[0].files   /* Jquery */
				//"type이 file인 <input> 요소(element)".files   /* Javascript */
				let fileInput = $('input[name="uploadFile"]');
				let fileList = fileInput[0].files;
				//console.log("fileList : " + fileList);
				/* FileList의 요소로 있는 File 객체에 접근 */
				let fileObj = fileList[0];
				//console.log("fileObj : " + fileObj);
				/* File 객체에 담긴 데이터가 정말 <input> 태그를 통해 선택한 파일의 데이터가 맞는지를 확인
				File 인터페이스가 가진 속성(MDN File API 참고)을 사용하여 파일 이름, 파일 사이즈, 파일 타입 */
				//console.log("fileName : " + fileObj.name);
				//console.log("fileSize : " + fileObj.size);
				//console.log("fileType(MimeType) : " + fileObj.type);
				
				/* FormData 객체를 인스턴스화 하여 변수에 저장 */
				let formData = new FormData();
				
				if(!fileCheck(fileObj.name, fileObj.size)){   //not(!) 연산자로 fileCheck 메서드가 false 반환하면 true로 되어 이벤트 탈출
					return false;
				}
				
				/* 사용자가 선택한 파일을 FormData에 "uploadFile"이란 이름(key)으로 추가 */
				formData.append("uploadFile", fileObj);   //위의 if문 조건이 false가 되어 그냥 넘어가야 이벤트 통과
				
				/* 지금 현재 우리는 사용자가 한 개의 파일만 선택할 수 있도록 제한을 했기 때문에 한개의 파일만 FormData객체에 저장되도록 작성을 하였습니다
				만약 <input> 태그에 multiple 속성을 부여하여서 사용자가 여러 개의 파일을 선택할 수 있다면 아래와 같이 코드를 작성하면 됩니다 */
				/* for(let i = 0; i < fileList.length; i++){
					formData.append("uploadFile", fileList[i]);
				} */
				
				/* 준비된 데이터를 AJAX를 사용하여 서버로 전송하는 코드 - 업로드한 이미지 파일 전송 */
				$.ajax({
					url : '/admin/uploadAjaxAction',
			    	processData : false,
			    	contentType : false,
			    	data : formData,
			    	type : 'POST',
			    	dataType : 'json',
			    	success : function(result){   //서버로부터 성공적으로 반환 값(상태코드 200)을 전달 받았을 때 작동하는 콜백 함수
			    		console.log(result);
			    		showUploadImage(result);   //이미지 업로드를 요청 후 성공적으로 업로드 한 이미지에 대한 데이터(path, filename, uuid)들을 전달받았을 때 전달받은 이미지 데이터를 활용하여 이미지가 출력되도록 하는 함수 호출
			    	},
			    	error : function(result){   //서버로부터 잘못된 반환 값(상태코드 400)을 전달 받았을 때 작동하는 콜백 함수
			    		alert("이미지 파일이 아닙니다.");
			    	}
				});
				//주의할 점은 processData, 와 contenttype 속성의 값을 'false'로 해주어야만 첨부파일이 서버로 전송
				//url : 서버로 요청을 보낼 url
				//processData : 서버로 전송할 데이터를 queryStirng 형태로 변환할지 여부
				//contentType : 서버로 전송되는 데이터의 content-type
				//data : 서버로 전송할 데이터
				//type : 서보 요청 타입(GET, POST)
				//dataType : 서버로부터 반환받을 데이터 타입
			});
			
			/*  뷰(View) 단계에서 사용자가 선택 한 파일이 개발자가 허용하는 파일이 아닐 시에 경고창과 함께 <input> change 이벤트 메서드에서 벗어나도록 */
			/* 사용자가 파일을 이미지 파일만을 올렸으면 좋겠고, 그중에서도 jpg, png 파일만 허용, 파일의 크기는 1048576byte(1MB)의 크기만 허용*/
			let regex = new RegExp("(.*?)\.(jpg|png)$");
			let maxSize = 1048576;   //1MB
			/* 변수로 저장된 2가지 조건을 만족하지 못하는 파일이면 경고문구와 함께 false를 반환하도록 하였고 두 가지 모두 만족 시에 true를 반환 */
			function fileCheck(fileName, fileSize){
				if(fileSize >= maxSize){
					alert("파일 사이즈 초과");
					return false;
				}
				if(!regex.test(fileName)){
					alert("해당 종류의 파일은 업로드할 수 없습니다.");
					return false;
				}
				return true;
			}
			
			/* 이미지 출력 함수 - 업로드 요청 후 서버에서 반환받은 데이터를 활용 */
			function showUploadImage(uploadResultArr){
				/* 전달받은 데이터 검증 */
				if(!uploadResultArr || uploadResultArr.length == 0){return}
				
				let uploadResult = $("#uploadResult");   //이미지 출력 태그
				
				let obj = uploadResultArr[0];   //서버에서 뷰로 반환할 때 List타입의 데이터를 전송했기 때문 (이미지 1개만 쓰기 때문에 0번 인덱스만)
				
				let str = "";   //이미지 출력 태그에 추가할 태그 문자열
				
				//let fileCallPath = obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName;   //이미지 출력을 요청하는 url 매핑 메서드("/display")에 전달해줄 파일의 경로와 이름을 포함하는 값
				
				//경로 에러로 아래와 같이 수정
				//let fileCallPath = obj.uploadPath.replace(/\\/g, '/') + "/s_" + obj.uuid + "_" + obj.fileName;
				/* replace(/\\/g, '/') 의미는 대상 String 문자열 중 모든 '\'을 '/'로 변경
				Javascript는 Java의 reaplceAll과 같은 메서드가 없기 때문에 replace 메서드의 인자 값으로 정규표현식을 사용하여 치환 대상 모든 문자를 지정 */
				
				//브라우저에 따른 인코딩 문제 예방으로 아래 같이 수정
				let fileCallPath = encodeURIComponent(obj.uploadPath.replace(/\\/g, '/') + "/s_" + obj.uuid + "_" + obj.fileName);
				/* UTF-8로 인코딩을 자동으로 해주지 않는 웹브라우저가 있기 때문에 지금의 코드가 동작하지 않을 수도 있습니다
				encodeURIComponent() 메서드는 A-Z a-z 0-9 - _ . ! ~ * ' ( )을 제외한 모든 문자를 UTF-8로 인코딩하여 이스케이프 문자로 변환
				더불어서 encodeURIComponent() 메서드는 '/'와 '\'문자 또한 인코딩을 하기 때문에 replace() 메서드를 사용 안 해도 해당 URI로 동작
				// replace 적용 => 동작 o
				let fileCallPath = encodeURIComponent(obj.uploadPath.replace(/\\/g, '/') + "/s_" + obj.uuid + "_" + obj.fileName);
				// replace 적용 x => 동작 o
				let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
				*/
				
				/* 추가되어야 할 태그 코드인 문자열 */
				str += "<div id='result_card'>";
				str += "<img src='/display?fileName=" + fileCallPath +"'>";   //썸네일 이미지 출력
				/* str += "<div class='imgDeleteBtn'>x</div>"; */
				str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>x</div>";   //삭제 버튼에 썸네일 파일 경로 담기
				str += "</div>";
				
				uploadResult.append(str);   //태그 코드가 담긴 문자열 값(str)을 uploadResult 태그에 append() 혹은 html() 메서드로 추가
			}
			
			/* 이미지 파일 삭제 함수 */
			function deleteFile(){
				let targetFile = $(".imgDeleteBtn").data("file");   //삭제 <div> 태그에 심어둔 썸네일 파일 경로 데이터
				let targetDiv = $("#result_card");   //이미지 파일 업로드 시 출력되는 미리 보기 이미지를 감싸고 있는 result_card <div> 태그
				
				/* 파일의 삭제를 요청하는 ajax 코드 */
				$.ajax({
					url: '/admin/deleteFile',
					data : {fileName : targetFile},
					dataType : 'text',
					type : 'POST',
					success : function(result){
						console.log(result);
						/* 파일 삭제를 성공한 경우 미리 보기 이미지를 삭제해 주고 파일 <input> 태그를 초기화 */
						targetDiv.remove();
						$("input[type='file']").val("");
					},
					error : function(result){
						console.log(result);
						/* 파일 실패의 경우 경고창을 띄우기 위해 경고창을 띄우는 코드를 작성 */
						alert("파일을 삭제하지 못하였습니다.");
					}
				});
//				url : 이전 포스팅에서 작성한 파일 삭제를 수행하는 url을 작성
//				data : 객체 초기자를 활용하여 fileName 속성명에 targetFile(이미지 파일 경로) 속성 값을 부여, 서버의 메서드 파라미터에 String fileName을 선언하였기 때문에 스프링에서 해당 데이터를 매핑
//				type : 서버 요청 방식입니다. 'POST'를 지정
//				dataType : 전송하는 targetFile은 문자 데이터이기 때문에 'text'를 지정
//				success : 성공할 경우 실행되는 속성
//				error : 요청이 실패 혹은 에러일 경우 실행되는 속성
			}
			
			/* 'x' 버튼을 클릭한 경우 '파일 삭제'가 동작 */
			/* 'x'가 출력되어 있는 <div> 태그는 웹 페이지가 완전히 렌더링 된 이후 Javascript 코드를 통해 새롭게 출력된(동적으로 출력된) 태그이기 때문에
				$(".imgDeletBtn").click(function(){} 는 동작하지 않는다
				아래 코드는 기존 렌더링 될 때 추가되어 있는 '#uploadReulst" <div> 태그를 식별자로 하여
				그 내부에 있는 'imgDeleteBtn' <div> 태그를 클릭(click) 하였을 때 콜백 함수가 호출 된다는 의미 */
			$("#uploadResult").on("click", ".imgDeleteBtn", function(e){
				deleteFile();   //파일 삭제 함수 호출
			});
			
		</script>
		
	</body>
</html>