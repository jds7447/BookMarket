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
		<link rel="stylesheet" href="/resources/css/admin/goodsModify.css">
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
                    	<form action="/admin/goodsModify" method="post" id="modifyForm">
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>책 제목</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="bookName" value="${goodsInfo.bookName}">
                    				<span class="ck_warn bookName_warn">책 이름을 입력해주세요.</span>
                    			</div>
                    		</div>
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>작가</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input id="authorName_input" readonly="readonly" value="${goodsInfo.authorName}">
                    				<input id="authorId_input" name="authorId" type="hidden" value="${goodsInfo.authorId}">
                    				<button class="authorId_btn">작가 선택</button>
                    				<span class="ck_warn authorId_warn">작가를 선택해주세요</span>
                    			</div>
                    		</div>            
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>출판일</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="publeYear" autocomplete="off" readonly="readonly">
                    				<span class="ck_warn publeYear_warn">출판일을 선택해주세요.</span>
                    			</div>
                    		</div>            
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>출판사</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="publisher" value="${goodsInfo.publisher}">
                    				<span class="ck_warn publisher_warn">출판사를 입력해주세요.</span>
                    			</div>
                    		</div>             
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>책 카테고리</label>
                    			</div>
                    			<div class="form_section_content">
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
                    				<span class="ck_warn cateCode_warn">카테고리를 선택해주세요.</span>                  				                    				
                    			</div>
                    		</div>          
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>상품 가격</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="bookPrice" value="${goodsInfo.bookPrice}">
                    				<span class="ck_warn bookPrice_warn">상품 가격을 입력해주세요.</span>
                    			</div>
                    		</div>               
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>상품 재고</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="bookStock" value="${goodsInfo.bookStock}">
                    				<span class="ck_warn bookStock_warn">상품 재고를 입력해주세요.</span>
                    			</div>
                    		</div>          
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>상품 할인율</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input id="discount_interface" maxlength="2" value="0">
                    				<input name="bookDiscount" type="hidden" value="${goodsInfo.bookDiscount}">
                    				<span class="step_val">할인 가격 : <span class="span_discount"></span></span>
                    				<span class="ck_warn bookDiscount_warn">1~99 숫자를 입력해주세요.</span>
                    			</div>
                    		</div>          		
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>책 소개</label>
                    			</div>
                    			<div class="form_section_content bit">
                    				<textarea name="bookIntro" id="bookIntro_textarea">${goodsInfo.bookIntro}</textarea>
                    				<span class="ck_warn bookIntro_warn">책 소개를 입력해주세요.</span>
                    			</div>
                    		</div>        		
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>책 목차</label>
                    			</div>
                    			<div class="form_section_content bct">
                    				<textarea name="bookContents" id="bookContents_textarea">${goodsInfo.bookContents}</textarea>
                    				<span class="ck_warn bookContents_warn">책 목차를 입력해주세요.</span>
                    			</div>
                    		</div>
                    		<%-- 상품 이미지 항목 추가 --%>
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>상품 이미지</label>
                    			</div>
                    			<div class="form_section_content">
									<input type="file" id ="fileItem" name='uploadFile' style="height: 30px;">
									<div id="uploadResult">
																		
									</div>									
                    			</div>
                    		</div>
                    		<input type="hidden" name='bookId' value="${goodsInfo.bookId}">   <%-- 수정을 하는 쿼리에서 bookId 필요 --%>
                   		</form>
                   		
						<div class="btn_section">
							<button id="cancelBtn" class="btn">취 소</button>
                    		<button id="modifyBtn" class="btn modify_btn">수 정</button>
                    		<button id="deleteBtn" class="btn delete_btn">삭 제</button>
                    	</div> 
                    </div>
                    
					<%-- 수정 페이지에서 조회 페이지 이동할 때, 조회 페이지에서 목록 페이지로 이동을 할 때 필요로 한 데이터 --%>
                	<form id="moveForm" action="/admin/goodsManage" method="get" >
 						<input type="hidden" name="pageNum" value="${cri.pageNum}">
						<input type="hidden" name="amount" value="${cri.amount}">
						<input type="hidden" name="keyword" value="${cri.keyword}">
						<input type="hidden" name='bookId' value="${goodsInfo.bookId}">
                	</form>                     
                </div>
 
		<%@include file="../includes/admin/footer.jsp" %>
		
		<script>
	
			$(document).ready(function(){
				/* 캘린더 위젯 적용 */
				/* 설정 */
				const config = {
					dateFormat: 'yy-mm-dd',
					showOn : "button",
					buttonText:"날짜 선택",
				    prevText: '이전 달',
				    nextText: '다음 달',
				    monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
				    monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
				    dayNames: ['일','월','화','수','목','금','토'],
				    dayNamesShort: ['일','월','화','수','목','금','토'],
				    dayNamesMin: ['일','월','화','수','목','금','토'],
				    yearSuffix: '년',
			        changeMonth: true,
			        changeYear: true
				}			
				/* 캘린더 */
				/* 수정 페이지이기 때문에 DB에 저장된 데이터가 출력이 되어야 합니다
				문제는 <input> 태그에 value속성을 추가해도 datepicker가 적용되었기 때문에 출력이 되지 않습니다
				datepicker를 적용시키는 코드에 DB에 저장된 데이터가 출력이 되도록 하는 코드를 따로 추가해주어야 합니다
				datepicker 적용하는 기존 코드 중 익명 함수의 코드를 아래의 코드로 변경 */
				/* $(function() {	
				  $( "input[name='publeYear']" ).datepicker(config);
				}); */
				$(function() {
					let publeYear = '${goodsInfo.publeYear}';   //DB에서 가져온 데이터
					let puble_length = publeYear.indexOf(" ");   //DB에서 가져온 날짜 0000-00-00 00:00:00 에서 가운데 공백의 인덱스 번호
					publeYear = publeYear.substring(0, puble_length);   //날짜의 처음부터 가운데 공백 이전까지만 자르기
					$( "input[name='publeYear']" ).datepicker(config);   //캘린더 위젯 설정 적용
					$( "input[name='publeYear']" ).datepicker('setDate', publeYear);   //input 요소에 DB의 날짜 값 적용
				});
				
				/* 카테고리 */
				/* 책 카테고리는 '상품 조회' 페이지에서 처럼 DB에 저장된 카테고리가 출력이 되면서,
				'상품 등록'페이지 와 같이 대분류 선택, 혹은 중분류 선택에 따라서 하위분류가 초기화 및 변경되도
				'상품 조회', '상품 등록' 페이지에서의 사용한 상품 카테고리 관련 코드를 활용하여 작성 */
				let cateList = JSON.parse('${cateList}');

				let cate1Array = new Array();
				let cate2Array = new Array();
				let cate3Array = new Array();
				let cate1Obj = new Object();
				let cate2Obj = new Object();
				let cate3Obj = new Object();
				
				let cateSelect1 = $(".cate1");		
				let cateSelect2 = $(".cate2");
				let cateSelect3 = $(".cate3");
				
				/* 카테고리 배열 초기화 메서드 */
				function makeCateArray(obj,array,cateList, tier){
					for(let i = 0; i < cateList.length; i++){
						if(cateList[i].tier === tier){
							obj = new Object();
							
							obj.cateName = cateList[i].cateName;
							obj.cateCode = cateList[i].cateCode;
							obj.cateParent = cateList[i].cateParent;
							
							array.push(obj);				
							
						}
					}
				}
				
				/* 배열 초기화 */
				makeCateArray(cate1Obj,cate1Array,cateList,1);
				makeCateArray(cate2Obj,cate2Array,cateList,2);
				makeCateArray(cate3Obj,cate3Array,cateList,3);
				
				/* 중,소분류 변수화 */
				let targetCate2 = '';
				let targetCate3 = '${goodsInfo.cateCode}';
				
				/* 소분류 */
				for(let i = 0; i < cate3Array.length; i++){
					if(targetCate3 === cate3Array[i].cateCode){
						targetCate3 = cate3Array[i];
					}
				}
				for(let i = 0; i < cate3Array.length; i++){
					if(targetCate3.cateParent === cate3Array[i].cateParent){
						cateSelect3.append("<option value='"+cate3Array[i].cateCode+"'>" + cate3Array[i].cateName + "</option>");
					}
				}
				$(".cate3 option").each(function(i,obj){
					if(targetCate3.cateCode === obj.value){
						$(obj).attr("selected", "selected");
					}
				});
				
				/* 중분류 */
				for(let i = 0; i < cate2Array.length; i++){
					if(targetCate3.cateParent === cate2Array[i].cateCode){
						targetCate2 = cate2Array[i];	
					}
				}
				for(let i = 0; i < cate2Array.length; i++){
					if(targetCate2.cateParent === cate2Array[i].cateParent){
						cateSelect2.append("<option value='"+cate2Array[i].cateCode+"'>" + cate2Array[i].cateName + "</option>");
					}
				}
				$(".cate2 option").each(function(i,obj){
					if(targetCate2.cateCode === obj.value){
						$(obj).attr("selected", "selected");
					}
				});
				
				/* 대분류 */
				for(let i = 0; i < cate1Array.length; i++){
					cateSelect1.append("<option value='"+cate1Array[i].cateCode+"'>" + cate1Array[i].cateName + "</option>");
				}
				$(".cate1 option").each(function(i,obj){
					if(targetCate2.cateParent === obj.value){
						$(obj).attr("selected", "selected");
					}
				});
				
				/* 책 소개, 책 목차는 단순히 ckeditor를 적용시켜주기만
				ckeditor를 적용시키는 코드를 document ready 메서드 구현부에 추가
				두 번째 <script> 태그 내부에 추가해도 상관은 없습니다
				단지 렌더링 될 때 적용되어야 할 코드들과 함께 두기 위해 document read 메서드 구현부에 작성 */
				/* 위지윅 적용 */
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
				
				/* 페이지에 들어가 보면 0으로 되어 있지만 실질적으로 서버에 전송되어야 할 할인율 데이터는 type이 hidden인 <input> 태그에 저장되어 있습니다
				해당 <input> 태그에는 할인율이 소수로 저장되어 있는데 이를 자연수로 변경하여 사용자에게 노출되는 <input> 태그 값으로 삽입할 것입니다
				더불어 원가와 할인율을 통해 할인 가격이 얼마인지도 사용자가 볼 수 있도록 해줄 것 */
				/* 할인율 인터페이스 출력 */
				let bookPriceInput = $("input[name='bookPrice']");
				let discountInput = $("input[name='bookDiscount']");
				
				let bookPrice = bookPriceInput.val();
				let rawDiscountRate = discountInput.val();
				let discountRate = rawDiscountRate * 100;
				
				
				let discountPrice = bookPrice * (1-rawDiscountRate);
				$(".span_discount").html(discountPrice);
				$("#discount_interface").val(discountRate);
				
				
				/* 기존 상품 이미지 출력 */
				let bookId = '<c:out value="${goodsInfo.bookId}"/>';   //상품id (이미지 데이터 호출용)
				let uploadResult = $("#uploadResult");   //이미지 출력할 태그
				
				$.getJSON("/getAttachList", {bookId : bookId}, function(arr){   //GET 방식으로 요청
					console.log(arr);
					
					if(arr.length === 0){   //등록된 상품 이미지가 없을 경우
						let str = "";
						str += "<div id='result_card'>";
						str += "<img src='/resources/img/No_Image.png'>";
						str += "</div>";
						
						uploadResult.html(str);
						return;
					}
					
					let str = "";   //uploadResult 태그 내부에 삽입될 태그 코드(String 데이터)
					let obj = arr[0];   //서버로부터 전달받은 이미지 정보 객체
					
					/* str 변수에 uploadResult 태그에 삽입될 코드를 값으로 부여 */
					let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);   //이미지 파일 경로
					str += "<div id='result_card'";
					str += "data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "'";
					str += ">";
					str += "<img src='/display?fileName=" + fileCallPath +"'>";
					str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>x</div>";
					str += "<input type='hidden' name='imageList[0].fileName' value='"+ obj.fileName +"'>";
					str += "<input type='hidden' name='imageList[0].uuid' value='"+ obj.uuid +"'>";
					str += "<input type='hidden' name='imageList[0].uploadPath' value='"+ obj.uploadPath +"'>";				
					str += "</div>";
					
					uploadResult.html(str);   //html 삽입
				})
			});
	
		</script>
		
		<%-- 사용자 선택에 따라 분류들이 변경되도록 새로 작성할 코드는 렌더링 될 때 실행될 코드와 구분하기 위해서 새로운 <script>를 추가하여 작업 --%>
		<script>
		
			/* 작가 선택 팝업 창 버튼 */
			/* 작가 선택 버튼 */
			$('.authorId_btn').on("click",function(e){
				e.preventDefault();
				
				let popUrl = "/admin/authorPop";   //팝업 창 url
				let popOption = "width = 650px, height=550px, top=300px, left=300px, scrollbars=yes";   //팝업 창 설정
				
				window.open(popUrl,"작가 찾기",popOption);
			});
		
			/* 사용자 선택에 따라 카테고리 분류가 변경 되록해주는 기능을 하는 Javascript 코드
			해당 코드는 '상품 등록' 페이지의 코드를 그대로 사용
			단, 위에서 이미 대분류를 출력시키는 코드는 존재하기 때문에 대분류 <option> 태그를 출력시키는 코드는 추가하지 않음 */
			/* 카테고리 */
			let cateList = JSON.parse('${cateList}');
	
			let cate1Array = new Array();
			let cate2Array = new Array();
			let cate3Array = new Array();
			let cate1Obj = new Object();
			let cate2Obj = new Object();
			let cate3Obj = new Object();
			
			let cateSelect1 = $(".cate1");		
			let cateSelect2 = $(".cate2");
			let cateSelect3 = $(".cate3");
			
			/* 카테고리 배열 초기화 메서드 */
			function makeCateArray(obj,array,cateList, tier){
				for(let i = 0; i < cateList.length; i++){
					if(cateList[i].tier === tier){
						obj = new Object();
						
						obj.cateName = cateList[i].cateName;
						obj.cateCode = cateList[i].cateCode;
						obj.cateParent = cateList[i].cateParent;
						
						array.push(obj);
					}
				}
			}	
			
			/* 배열 초기화 */
			makeCateArray(cate1Obj,cate1Array,cateList,1);
			makeCateArray(cate2Obj,cate2Array,cateList,2);
			makeCateArray(cate3Obj,cate3Array,cateList,3);
	
			
			/* 중분류 <option> 태그 */
			$(cateSelect1).on("change",function(){
				let selectVal1 = $(this).find("option:selected").val();	
				
				cateSelect2.children().remove();
				cateSelect3.children().remove();
				
				cateSelect2.append("<option value='none'>선택</option>");
				cateSelect3.append("<option value='none'>선택</option>");
				
				for(let i = 0; i < cate2Array.length; i++){
					if(selectVal1 === cate2Array[i].cateParent){
						cateSelect2.append("<option value='"+cate2Array[i].cateCode+"'>" + cate2Array[i].cateName + "</option>");	
					}
				}
			});
			
			/* 소분류 <option>태그 */
			$(cateSelect2).on("change",function(){
				let selectVal2 = $(this).find("option:selected").val();
				
				cateSelect3.children().remove();
				
				cateSelect3.append("<option value='none'>선택</option>");		
				
				for(let i = 0; i < cate3Array.length; i++){
					if(selectVal2 === cate3Array[i].cateParent){
						cateSelect3.append("<option value='"+cate3Array[i].cateCode+"'>" + cate3Array[i].cateName + "</option>");	
					}
				}
			});
			
			
			/* 이번에는 사용자가 할인율을 변경했을 때 입력된 할인율을 소수로 변경하여 서버로 전송될 할인율을 저장하는 <input> 태그의 값으로 삽입되도록
			그리고 할인 가격이 얼마인지 출력되는 <span> 태그의 값도 입력된 값에 따라 변경되도록
			더불어서 상품 가격에 새로운 값을 입력하여도 할인가격 <span> 태그의 값이 변경되도록
			이러한 기능을 하는 코드를 이미 '상품 등록 페이지'에 작성하였기 때문에 해당 코드를 그대로 복사 */
			/* 할인율 Input 설정 */
			$("#discount_interface").on("propertychange change keyup paste input", function(){
				let userInput = $("#discount_interface");
				let discountInput = $("input[name='bookDiscount']");
				
				let discountRate = userInput.val();   // 사용자가 입력한 할인값
				let sendDiscountRate = discountRate / 100;   // 서버에 전송할 할인값
				let goodsPrice = $("input[name='bookPrice']").val();   // 원가
				let discountPrice = goodsPrice * (1 - sendDiscountRate);   // 할인가격
				
				if(!isNaN(discountRate)){
					$(".span_discount").html(discountPrice);		
					discountInput.val(sendDiscountRate);				
				}
			});	
			
			$("input[name='bookPrice']").on("change", function(){
				let userInput = $("#discount_interface");
				let discountInput = $("input[name='bookDiscount']");
				
				let discountRate = userInput.val();					// 사용자가 입력한 할인값
				let sendDiscountRate = discountRate / 100;			// 서버에 전송할 할인값
				let goodsPrice = $("input[name='bookPrice']").val();			// 원가
				let discountPrice = goodsPrice * (1 - sendDiscountRate);		// 할인가격
				
				if(!isNaN(discountRate)){
					$(".span_discount").html(discountPrice);	
				}
			});
			
			/* 취소 버튼 */
			$("#cancelBtn").on("click", function(e){
				e.preventDefault();
				$("#moveForm").submit();
			});
			/* 수정 버튼 */
			$("#modifyBtn").on("click", function(e){
				e.preventDefault();

				/* 서버로 수정 요청을 하기 전 작성하지 않은 빈 항목이 없는지 유효성 검사, 이미 '상품 등록' 구현 때 작성한 코드가 있기 때문에 이를 활용 */
				/* 체크 변수 */
				let bookNameCk = false;
				let authorIdCk = false;
				let publeYearCk = false;
				let publisherCk = false;
				let cateCodeCk = false;
				let priceCk = false;
				let stockCk = false;
				let discountCk = false;
				let introCk = false;
				let contentsCk = false;	
				
				/* 체크 대상 변수 */
				let bookName = $("input[name='bookName']").val();
				let authorId = $("input[name='authorId']").val();
				let publeYear = $("input[name='publeYear']").val();
				let publisher = $("input[name='publisher']").val();
				let cateCode = $("select[name='cateCode']").val();
				let bookPrice = $("input[name='bookPrice']").val();
				let bookStock = $("input[name='bookStock']").val();
				let bookDiscount = $("#discount_interface").val();
				let bookIntro = $(".bit p").html();
				let bookContents = $(".bct p").html();	
				
				/* 공란 체크 */
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
				
				if(!isNaN(bookDiscount)){
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
					//alert('통과');
					$("#modifyForm").submit();
				} else {
					return false;
				}
			});
			
			/* 상품 삭제 버튼 */
			$("#deleteBtn").on("click", function(e){
				e.preventDefault();
				let moveForm = $("#moveForm");
				moveForm.find("input").remove();
				moveForm.append('<input type="hidden" name="bookId" value="${goodsInfo.bookId}">');
				moveForm.attr("action", "/admin/goodsDelete");
				moveForm.attr("method", "post");
				moveForm.submit();
			});

			
			/* 이미지 삭제 버튼 동작 */
			$("#uploadResult").on("click", ".imgDeleteBtn", function(e){
				deleteFile();
			});
			/* 이미지 삭제 메서드 */
			function deleteFile(){
				$("#result_card").remove();   //출력된 이미지 태그만 삭제
			}
			
			
			/* type이 file인 <input> 태그에 접근하기 위해서 해당 <input> 태그가 change 이벤트가 일어났을 때 동작하는 메서드 추가 */
			/* 이미지 업로드 */
			$("input[type='file']").on("change", function(e){
				/* 이미 업로드 된 이미지 존재시 삭제 */
				if($("#result_card").length > 0){   //미리보기 이미지 태그의 존재 유무 확인 (이미지 태그를 선택자로)
					deleteFile();
				}
				
				/* FileList 객체에 접근 */
				let fileInput = $('input[name="uploadFile"]');
				let fileList = fileInput[0].files;
				/* FileList의 요소로 있는 File 객체에 접근 */
				let fileObj = fileList[0];
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
				if(!uploadResultArr || uploadResultArr.length == 0){
					return
				}
				
				let uploadResult = $("#uploadResult");   //이미지 출력 태그
				let obj = uploadResultArr[0];   //서버에서 뷰로 반환할 때 List타입의 데이터를 전송했기 때문 (이미지 1개만 쓰기 때문에 0번 인덱스만)
				let str = "";   //이미지 출력 태그에 추가할 태그 문자열
				
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
				str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>x</div>";   //삭제 버튼에 썸네일 파일 경로 담기
				/* DB에 이미지 정보를 담기 위한 input 태그 추가 */
				str += "<input type='hidden' name='imageList[0].fileName' value='"+ obj.fileName +"'>";
				str += "<input type='hidden' name='imageList[0].uuid' value='"+ obj.uuid +"'>";
				str += "<input type='hidden' name='imageList[0].uploadPath' value='"+ obj.uploadPath +"'>";
				str += "</div>";
				
				uploadResult.append(str);   //태그 코드가 담긴 문자열 값(str)을 uploadResult 태그에 append() 혹은 html() 메서드로 추가
			}
		
		</script>
		
	</body>
</html>