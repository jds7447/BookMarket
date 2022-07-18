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
		<link rel="stylesheet" href="/resources/css/admin/goodsDetail.css">
		<script src="https://code.jquery.com/jquery-3.4.1.js" 
				integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" 
				crossorigin="anonymous"></script>
		<!-- ckeditor를 사용하기 위한 cdn 코드 -->
		<script src="https://cdn.ckeditor.com/ckeditor5/34.2.0/classic/ckeditor.js"></script>
		<!-- 상품 이미지 태그 스타일 -->
		<style type="text/css">
			#result_card img{
				max-width: 100%;
			    height: auto;
			    display: block;
			    padding: 5px;
			    margin-top: 10px;
			    margin: auto;	
			}
		</style>
	</head>
	
	<body>
		<%@include file="../includes/admin/header.jsp" %>
		
					<div class="admin_content_wrap">
                    	<div class="admin_content_subject"><span>상품 상세</span></div>

						<div class="admin_content_main">
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>책 제목</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="bookName" value="<c:out value="${goodsInfo.bookName}"/>" disabled>
                    			</div>
                    		</div>
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>등록 날짜</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input value="<fmt:formatDate value='${goodsInfo.regDate}' pattern='yyyy-MM-dd'/>" disabled>
                    			</div>
                    		</div>
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>최근 수정 날짜</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input value="<fmt:formatDate value='${goodsInfo.updateDate}' pattern='yyyy-MM-dd'/>" disabled>
                    			</div>
                    		</div>                    		                    		
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>작가</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input id="authorName_input" readonly="readonly" value="${goodsInfo.authorName }" disabled>
                    				                    				
                    			</div>
                    		</div>            
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>출판일</label>
                    			</div>
                    			<div class="form_section_content">
                    				<%-- <input name="publeYear" autocomplete="off" readonly="readonly" value="<fmt:formatDate value='${goodsInfo.publeYear}' pattern='yyyy-MM-dd' />" disabled> --%>                    				
                    				<input name="publeYear" autocomplete="off" readonly="readonly" value="<c:out value="${goodsInfo.publeYear}"/>" disabled>
                    			</div>
                    		</div>            
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>출판사</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="publisher" value="<c:out value="${goodsInfo.publisher}"/>" disabled>
                    			</div>
                    		</div>             
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>책 카테고리</label>
                    			</div>
                    			<div class="form_section_content">
                    				<div class="cate_wrap">
                    					<span>대분류</span>
                    					<select class="cate1" disabled>
                    						<option  value="none">선택</option>
                    					</select>
                    				</div>
                    				<div class="cate_wrap">
                    					<span>중분류</span>
                    					<select class="cate2" disabled>
                    						<option  value="none">선택</option>
                    					</select>
                    				</div>
                    				<div class="cate_wrap">
                    					<span>소분류</span>
                    					<select class="cate3" name="cateCode" disabled>
                    						<option value="none">선택</option>
                    					</select>
                    				</div>                  				                    				
                    			</div>
                    		</div>          
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>상품 가격</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="bookPrice" value="<c:out value="${goodsInfo.bookPrice}"/>" disabled>
                    			</div>
                    		</div>               
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>상품 재고</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="bookStock" value="<c:out value="${goodsInfo.bookStock}"/>" disabled>
                    			</div>
                    		</div>          
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>상품 할인율</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input id="discount_interface" maxlength="2" disabled>
                    			</div>
                    		</div>          		
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>책 소개</label>
                    			</div>
                    			<div class="form_section_content bit">
                    				<textarea name="bookIntro" id="bookIntro_textarea" disabled>${goodsInfo.bookIntro}</textarea>
                    			</div>
                    		</div>        		
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>책 목차</label>
                    			</div>
                    			<div class="form_section_content bct">
                    				<textarea name="bookContents" id="bookContents_textarea" disabled>${goodsInfo.bookContents}</textarea>
                    			</div>
                    		</div>
                    		
                    		<!-- 상품 이미지 추가 -->
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>상품 이미지</label>
                    			</div>
                    			<div class="form_section_content">
									<div id="uploadReslut">
																		
									</div>
                    			</div>
                    		</div>
                   		
                   			<div class="btn_section">
                   				<button id="cancelBtn" class="btn">상품 목록</button>
	                    		<button id="modifyBtn" class="btn enroll_btn">수정</button>
	                    	</div> 
                    	</div>
                	
                	<form id="moveForm" action="/admin/goodsManage" method="get" >
 						<input type="hidden" name="pageNum" value="${cri.pageNum}">
						<input type="hidden" name="amount" value="${cri.amount}">
						<input type="hidden" name="keyword" value="${cri.keyword}">
                	</form>
                </div>
                
		<%@include file="../includes/admin/footer.jsp" %>
		
		<script>
		
			$(document).ready(function(){
				/* 할인율 값 삽입 */
			/* 현재의 할인율 값은 소수로 출력되는데 사용자가 보기 편하도록 자연수(1~99)로 출력되도록 서버로부터 받아온 할인율 값을 가공하여 할인율 항목에 출력 */
				let bookDiscount = '<c:out value="${goodsInfo.bookDiscount}"/>' * 100;
				$("#discount_interface").attr("value", bookDiscount);
				
				/* 출판일 값 가공 */
				/* Oralce 프로젝트의 경우 출판일 항목란에 출력되는 형태는 0000-00-00 00:00:00
				yyyy-MM-dd 형태로 변경을 해주기 위해 fmt:formatDate 태그를 사용하면 된다고 생각할 수 있지만 사용 시 아래와 같은 에러
				fmt:formatDate 태그는 Date타입의 데이터를 가공을 할 수 있는 태그이기 때문
				BookVO.java 클래스의 출판일(publeYear) 변수 데이터 타입은 String으로 정의
				String으로 정의 되어야 캘릭더 위젯으로 선택한 날짜 데이터가 BookVO 객체의 변수로 변환되어 담길 수 있기 때문
				BookVO 객체에 넣을 땐 0000-00-00 형태였지만 DB의 book_goods 테이블의 publeYear 열의 데이터 타입은 Date로 정의되어 있음
				DB단계와 Java단계의 데이터 타입을 같게 해주어야 하지만, 현재의 두 개의 데이터 타입은 달라도 정보를 주고받거나, 삽입할 때는 크게 문제는 되지 않음
				출판일의 값 형태를 yyyy-MM-dd 형태로 변경해주어야 하는데, 현재의 값이 String인 점을 착안하여 substirng(), indexOf() 메서드를 활용 */
				let publeYear = '${goodsInfo.publeYear}';
				let length = publeYear.indexOf(" ");
				publeYear = publeYear.substring(0, length);
				$("input[name='publeYear']").attr("value", publeYear);
				
				/*  '책소개', '책 목차' <textarea> 태그에 ckeditor를 적용 */
				/* 책 소개 */
				ClassicEditor
					.create(document.querySelector('#bookIntro_textarea'))
					.then(editor => {
						//ckeditor가 적용된 상태에서 <textarea>에 disabled 속성을 추가해주더라도 수정 가능하기 때문에
						const toolbarElement = editor.ui.view.toolbar.element;   //에디터 툴바
						toolbarElement.style.display = 'none';   //사용자가 수정하지 못하도록 에디터 툴바 숨김
						editor.enableReadOnlyMode('#bookIntro_textarea');   //DB에서 가져온 텍스트를 수정하지 못 하도록
					})
					.catch(error=>{
						console.error(error);
					});
				/* 책 목차 */	
				ClassicEditor
				.create(document.querySelector('#bookContents_textarea'))
				.then(editor => {
					//ckeditor가 적용된 상태에서 <textarea>에 disabled 속성을 추가해주더라도 수정 가능하기 때문에
					const toolbarElement = editor.ui.view.toolbar.element;   //에디터 툴바
					toolbarElement.style.display = 'none';   //사용자가 수정하지 못하도록 에디터 툴바 숨김
					editor.enableReadOnlyMode('#bookContents_textarea');   //DB에서 가져온 텍스트를 수정하지 못 하도록
				})
				.catch(error=>{
					console.error(error);
				});
				
				/* "상품 등록"에 사용하였던 서버로부터 전달받은 '카테고리 리스트' 객체를 JSON으로 변환하고 소분류, 중분류, 대분류로 분류하여
					데이터를 cate1Array, cate2Array, cate3Array 변수에 저장하는 코드 */
				/* 카테고리 */
				let cateList = JSON.parse('${cateList}');   //서버로 부터 전달받은 JSON 데이터 카테고리 리스트를 javascript 객체로 변환
				
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
				
				/* 중분류, 소분류 카테고리에서 선택된(selected) 항목에 대한 데이터를 저장할 변수 선언 및 소분류 변수는 DB에 저장된 사용자가 선택한 카테고리 코드로 초기화 */
				let targetCate2 = '';
				let targetCate3 = '${goodsInfo.cateCode}';
				
				/* 소분류 찾기 */
				/* targetCate3 변수는 현재 오로지 코드만 저장되어 있으므로 cateParent, cateName 값도 포함된 객체로 저장되도록 아래의 코드를 추가 */
				for(let i = 0; i < cate3Array.length; i++){
					if(targetCate3 === cate3Array[i].cateCode){
						targetCate3 = cate3Array[i];
					}
				}
				/* cate3Array에 담긴 소분류 데이터를 모두 비교하여 targetCate3의 cateParent와 동일한 값을 가지는 데이터들 소분류 <select> 항목에 추가하는 코드 */
				for(let i = 0; i < cate3Array.length; i++){
					if(targetCate3.cateParent === cate3Array[i].cateParent){
						cateSelect3.append("<option value='"+cate3Array[i].cateCode+"'>" + cate3Array[i].cateName + "</option>");
					}
				}
				/* 소분류를 DB에 저장된 값에 해당하는 카테고리 <option> 태그에 selected 속성이 추가되도록 */
				$(".cate3 option").each(function(i,obj){
					if(targetCate3.cateCode === obj.value){
						$(obj).attr("selected", "selected");
					}
				});
				
				/* 중분류를 출력시키는 것은 소분류와 동일한 작업
				소분류와 마찬가지로 targetCate2 변수에 선택되어야 할 항목 객체로 초기화
				cate2Array 요소의 cateCode 중 targetCate3의 cateParent 값과 동일한 cate2Array 요소를 찾는 작업
				쉽게 말해 선택되어져야할 중분류를 찾는 작업 */
				for(let i = 0; i < cate2Array.length; i++){
					if(targetCate3.cateParent === cate2Array[i].cateCode){
						targetCate2 = cate2Array[i];	
					}
				}
				/* 중분류의 <select> 태그에 <option> 데이터들을 추가해준 후 선택되어야 할 <option> 태그에 selected 속성을 부여 */
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
				
				/* 대분류 찾기 */
				/* 마지막 분류이기 때문에 따로 변수를 선언하여 진행하지 않았습니다
				왜냐하면 대분류에 있는 모든 항목들을 <option> 태그로 추가해주면 되고,
				선택(selected)되어야 할 값은 targetCate2.cateParent 을 사용하면 되기 때문 */
				/* 먼저 대분류의 <option> 태그들을 추가해주는 Javascript 코드 */
				for(let i = 0; i < cate1Array.length; i++){
					cateSelect1.append("<option value='"+cate1Array[i].cateCode+"'>" + cate1Array[i].cateName + "</option>");
				}
				/* targetCate2.cateParent 값을 활용하여 대분류 중 선택되어야 할 <option>태그에 'selected' 속성을 추가 */
				$(".cate1 option").each(function(i,obj){
					if(targetCate2.cateParent === obj.value){
						$(obj).attr("selected", "selected");
					}
				});
				
				/* 이미지 정보 호출 */
				/* 페이지에 접속하자마자 실행되도록 하기 위해서 기존 작성되어 있는 $(document).ready(functino() 메서드 구현부에서 코드를 추가 */
				let bookId = '<c:out value="${goodsInfo.bookId}"/>';   //상품id (이미지 데이터 호출용)
				let uploadReslut = $("#uploadReslut");   //이미지 출력할 태그
				
				/* getJSON - GET 방식으로 요청 및 응답을 하는 서버로부터 JSON으로 인코딩 된 데이터를 전달받기 위해 사용하는 메서드 */
				/* 첫 번째 인자는 서버에 요청할 GET방식 url, 두 번째 인자는 요청할 때 전달할 데이터, 세 번째 인자는 서버의 반환 데이터 획득 시 실행할 콜백함수
					getJSON(url[,data][,success]); */
				$.getJSON("/getAttachList", {bookId : bookId}, function(arr){
					/* 해당 상품에 이미지 없는 경우 - 이미지 없음 이미지를 추가 */
					if(arr.length === 0){			
						let str = "";
						str += "<div id='result_card'>";
						str += "<img src='/resources/img/No_Image.png'>";
						str += "</div>";
						
						uploadReslut.html(str);
					}
					
					let str = "";   //uploadResult 태그 내부에 삽입될 태그 코드(String 데이터)
					let obj = arr[0];   //서버로부터 전달받은 이미지 정보 객체
					
					/* str 변수에 uploadResult 태그에 삽입될 코드를 값으로 부여 */
					let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
					str += "<div id='result_card'";
					str += "data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "'";
					str += ">";
					str += "<img src='/display?fileName=" + fileCallPath +"'>";
					str += "</div>";
					
					/*  html() 메서드를 사용해 str변수에 저장된 값들을 uploadReuslt 태그 내부에 추가 */
					uploadReslut.html(str);
				});
			});
			
			/* 목록 이동 버튼 */
			$("#cancelBtn").on("click", function(e){
				e.preventDefault();
				$("#moveForm").submit();	
			});	
			
			/* 수정 페이지 이동 */
			$("#modifyBtn").on("click", function(e){
				e.preventDefault();
				let addInput = '<input type="hidden" name="bookId" value="${goodsInfo.bookId}">';
				$("#moveForm").append(addInput);
				$("#moveForm").attr("action", "/admin/goodsModify");
				$("#moveForm").submit();
			});
		
		</script>
	</body>
</html>