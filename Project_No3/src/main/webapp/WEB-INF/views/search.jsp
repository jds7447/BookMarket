<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- JSTL을 사용하기 위해 태그라이브러리 코드 추가 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Welcome BookMall</title>
		<link rel="stylesheet" href="/resources/css/search.css">
		<!--  jquery를 사용할 것이기 때문에 jquery url 코드 추가 -->
		<script src="https://code.jquery.com/jquery-3.4.1.js"
  				integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  				crossorigin="anonymous"></script>
	</head>
	
	<body>
		
		<%@include file="./includes/common/headerCommon.jsp" %>
		
				<div class="content_area">
					<!-- <h1>content area</h1> -->
					<%-- 게시물(검색결과) o --%>
					<c:if test="${listcheck != 'empty'}">
						<c:if test="${ pageMaker.cri.type ne 'C' }">
							<div class="search_filter">   <%-- 카테고리 필터 --%>
								<div class="filter_button_wrap">
									<button class="filter_button filter_active" id="filter_button_a">국내</button>
									<button class="filter_button" id="filter_button_b">외국</button>
								</div>
								<div class="filter_content filter_a">   <%-- 국내 상품 카테고리 정보 --%>
									<c:forEach items="${filter_info}" var="filter">
										<c:if test="${filter.cateGroup eq '1'}">
											<a href="${filter.cateCode}">${filter.cateName}(${filter.cateCount})</a>
										</c:if>
									</c:forEach>
								</div>
								<div class="filter_content filter_b">   <%-- 국외 상품 카테고리 정보 --%>
									<c:forEach items="${filter_info}" var="filter">
										<c:if test="${filter.cateGroup eq '2'}">
											<a href="${filter.cateCode}">${filter.cateName}(${filter.cateCount})</a>
										</c:if>
									</c:forEach>		
								</div>
								<form id="filter_form" action="/search" method="get" >   <%-- 필터링 데이터 --%>
									<input type="hidden" name="keyword">
									<input type="hidden" name="cateCode">
									<input type="hidden" name="type">
								</form>
							</div>
						</c:if>
						<div class="list_search_result">   <%-- 상품 목록 --%>
							<table class="type_list">
								<colgroup>
									<col width="110">
									<col width="*">
									<col width="120">
									<col width="120">
									<col width="120">
								</colgroup>
								<tbody id="searchList>">
									<c:forEach items="${list}" var="list">
										<tr>
											<td class="image">   <!-- 이미지 데이터를 태그에 data 속성으로 넣고 스크립트로 출력 -->
												<div class="image_wrap" data-bookid="${list.imageList[0].bookId}" data-path="${list.imageList[0].uploadPath}" data-uuid="${list.imageList[0].uuid}" data-filename="${list.imageList[0].fileName}">
													<img>
												</div>
											</td>
											<td class="detail">
												<div class="category">
													[${list.cateName}]
												</div>
												<div class="title">
													<a href="/goodsDetail/${list.bookId}">   <%-- 책 이름 클릭 시 상품 상세 페이지로 --%>
														${list.bookName}
													</a>
												</div>
												<div class="author">
													<%-- BookVO의 publeYear는 String 타입의 데이터라서 이 데이터를 먼저 Date 타입으로 변경을 해준 뒤 <fmt:formDate> 태그를 사용해 날짜 형식 변경
														<fmt:parseDate>는 문자열로 표현한 날짜 혹은 시간 데이터를 Date타입(엄밀히 말하면 java.util.Date)으로 파싱 해주는 태그 --%>
													<fmt:parseDate var="publeYear" value="${list.publeYear}" pattern="yyyy-MM-dd" />
													${list.authorName} 지음 | ${list.publisher} | <%-- ${list.publeYear} --%><fmt:formatDate value="${publeYear}" pattern="yyyy-MM-dd"/>
												</div>
											</td>
											<td class="info">
												<div class="rating">
													평점 : ${list.ratingAvg}
												</div>
											</td>
											<td class="price">
												<div class="org_price">
													<del>
														<%-- ${list.bookPrice} --%>
														<fmt:formatNumber value="${list.bookPrice}" pattern="#,### 원" />
													</del>
												</div>
												<div class="sell_price">
													<strong>
														<%-- <c:out value="${list.bookPrice * (1-list.bookDiscount)}"/> --%>
														<fmt:formatNumber value="${list.bookPrice * (1-list.bookDiscount)}" pattern="#,### 원" />
													</strong>
												</div>
											</td>
											<td class="option"></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						
						<%-- 페이지 이동 인터페이스 --%>
						<div class="pageMaker_wrap">
							<ul class="pageMaker">
								<%-- 이전 버튼 --%>
								<c:if test="${pageMaker.prev }">
			               			<li class="pageMaker_btn prev">
			               				<a href="${pageMaker.startPage - 1}">이전</a>
			               			</li>
								</c:if>
			               		<%-- 페이지 번호 --%>
			               		<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="num">
			               			<li class="pageMaker_btn ${pageMaker.cri.pageNum == num ? 'active':''}">
			               				<a href="${num}">${num}</a>
			               			</li>	
			               		</c:forEach>
			                   	<%-- 다음 버튼 --%>
			                   	<c:if test="${pageMaker.next}">
			                   		<li class="pageMaker_btn next">
			                   			<a href="${pageMaker.endPage + 1}">다음</a>
			                   		</li>
			                   	</c:if>
							</ul>
						</div>
						
						<%-- 페이지 이동 데이터 (페이징 데이터) --%>
						<form id="moveForm" action="/search" method="get" >
							<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
							<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
							<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
							<input type="hidden" name="type" value="${pageMaker.cri.type}">
							<input type="hidden" name="cateCode" value="<c:out value="${pageMaker.cri.cateCode}"/>">
						</form>
					</c:if>
					
					<%-- 게시물(검색결과) x --%>
					<c:if test="${listcheck == 'empty'}">
						<div class="table_empty">
							검색결과가 없습니다.
						</div>
					</c:if>
				</div>
				
			<%@include file="./includes/common/footer.jsp" %>
		
		<script>
		
			$(document).ready(function(){
				// 검색 타입 selected (사용자가 검색 전에 선택했던 검색 타입으로 검색 타입 태그 옵션 설정)
				const selectedType = '<c:out value="${pageMaker.cri.type}"/>';
				if(selectedType != "" && selectedType != "C"){   //검색 타입이 카테고리가 아닌 경우
					let type = selectedType.split("")[0];
					$("select[name='type']").val(type).attr("selected", "selected");	
				}
				else if(selectedType == "C"){   //검색 타입이 카테고리인 경우
					$("select[name='type']").val("T").attr("selected", "selected");
				}
				
				/* $(선택자).each(function(i,obj));
				선택자로 지명된 태그가 여러 개일 경우 $(선택자)를 통해 해당 태그 객체를 호출하게 되면, 해당 선택자를 가지는 모든 태그가 담긴 객체를 반환
				이 객체에 each(function) 메서드를 호출하게 되면 동일한 선택자를 가진 모든 태그 객체를 순회하여 each메서드의 구현부에 작성된 코드를 실행 */
				/* $(선택자).data("속성명")
				태그에 데이터를 심기 위해서 선택자로 선택되는 태그 내에 "data-속성명 ='속성값'" 속성을 작성
				작성해둔 속성 값을 얻기 위해서 .data() 메서드의 파라미터로 속성명을 부여하면 속성 값을 얻을 수 있다 */
				
				/* 이미지 삽입 */
				$(".image_wrap").each(function(i, obj){   /*  i는 순회하면서 실행될 때의 idnex이고 obj는 그 순서의 객체 */
					const bobj = $(obj);   /* 작업의 대상이 되는 <div> 태그 객체 */
					
					if(bobj.data("bookid")) {   //해당 상품의 이미지 데이터가 존재하는 경우 (이미지 출력 태그에 심어둔 data-bookid 속성 값이 있는 경우)
						/* 태그에 심어둔 파일 정보 데이터를 호출하여 각 변수에 저장 */
						const uploadPath = bobj.data("path");
						const uuid = bobj.data("uuid");
						const fileName = bobj.data("filename");
						
						/* 해당 데이터들을 조합하여 "/display" 매핑 메서드의 파라미터로 전달시킬 fileName 데이터를 만든 뒤 fileCallPath 변수에 저장 */
						const fileCallPath = encodeURIComponent(uploadPath + "/s_" + uuid + "_" + fileName);
						
						/* 클래스명이 .image_wrap 인 <div> 태그 내부의 <img> 태그를 호출, <img> 태그에 이미지를 호출하는 url을 가지는 src 속성 추가 */
						$(this).find("img").attr('src', '/display?fileName=' + fileCallPath);
					}
					else {   //해당 상품에 등록된 이미지가 없는 경우 "이미지 없음" 이미지 출력
						$(this).find("img").attr('src', '/resources/img/No_Image.png');
					}
				});
				
				
				/* 필터링 선택 시 기존 선택(국내, 국외) 설정 */
				let filterCode = '<c:out value="${pageMaker.cri.cateCode}"/>';   //검색 객체에 담겨 있는 카테고리 코드
				if(filterCode != "" && filterCode != null){   //카테고리 코드가 비어있지 않다면
					let nowCode = filterCode.split("")[0];   //검색 객체에 담겨 있는 카테고리 코드 맨 앞자리
					if(nowCode == 1){   //이전에 선택한 필터링 카테고리가 국내 카테고리일 경우
						console.log("이전에 선택한 필터링 카테고리가 국내 카테고리");
						$(".filter_b").css("display", "none");
						$(".filter_a").css("display", "block");		
						buttonA.attr("class", "filter_button filter_active");
						buttonB.attr("class", "filter_button");
					}
					if(nowCode == 2){   //이전에 선택한 필터링 카테고리가 국외 카테고리일 경우
						console.log("이전에 선택한 필터링 카테고리가 국외 카테고리");
						$(".filter_a").css("display", "none");
						$(".filter_b").css("display", "block");
						buttonB.attr("class", "filter_button filter_active");
						buttonA.attr("class", "filter_button");
					}
				}
				
			});
 
			
		    /* gnb_area 비동기 로그아웃 버튼 작동 */
		    $("#gnb_logout_button").click(function(){
		    	$.ajax({
		            type:"POST",
		            url:"/member/logout.do",
		            success:function(data){
		                /* alert("로그아웃 성공"); */
		                document.location.reload();     
		            } 
		        }); // ajax 종료
		    });
		    
		    
		    /* 페이지 이동 버튼 */
		    const moveForm = $('#moveForm');
		    
			$(".pageMaker_btn a").on("click", function(e){
				e.preventDefault();
				
				moveForm.find("input[name='pageNum']").val($(this).attr("href"));
				
				moveForm.submit();
			});
			
			
			/* 검색 필터 */
			let buttonA = $("#filter_button_a");   //국내 버튼
			let buttonB = $("#filter_button_b");   //국외 버튼
			
			buttonA.on("click", function(){   //국내 버튼이 눌리면 국내 버튼이 눌린 효과, 국외 버튼은 눌린 효과 제거
				$(".filter_b").css("display", "none");
				$(".filter_a").css("display", "block");		
				buttonA.attr("class", "filter_button filter_active");
				buttonB.attr("class", "filter_button");
			});
			
			buttonB.on("click", function(){   //국외 버튼이 눌리면 국외 버튼이 눌린 효과, 국내 버튼은 눌린 효과 제거
				$(".filter_a").css("display", "none");
				$(".filter_b").css("display", "block");
				buttonB.attr("class", "filter_button filter_active");
				buttonA.attr("class", "filter_button");		
			});
			
			$(".filter_content a").on("click", function(e){   //필터링 정보 a태그 클릭 시 필더링 된 검색 페이지로 이동
				e.preventDefault();
			
				let type = '<c:out value="${pageMaker.cri.type}"/>';
				if(type === 'A' || type === 'T'){   //타입이 책이름 혹은 작가 단독으로만 있을 경우 기존 검색 타입에 카테고리 타입 추가
					type = type + 'C';	
				}
				
				let keyword = '<c:out value="${pageMaker.cri.keyword}"/>';   //검색 키워드 데이터
				let cateCode= $(this).attr("href");   //해당 버튼의 href 값 (filter.cateCode = 카테고리 코드)
				
				$("#filter_form input[name='keyword']").val(keyword);   //필터링 폼에 들어갈 필터링 데이터 (검색어)
				$("#filter_form input[name='cateCode']").val(cateCode);   //필터링 폼에 들어갈 필터링 데이터 (카테고리 코드)
				$("#filter_form input[name='type']").val(type);   //필터링 폼에 들어갈 필터링 데이터 (검색 타입)
				$("#filter_form").submit();   //필터링 검색 수행
			});
			
			
			/* 검색버튼 동작 */
			$(".search_btn").on("click", function(){
				let searchKeyword = $(".search_input input[name='keyword']").val();
				
				if(searchKeyword == "" || searchKeyword == null){
					alert("검색어를 입력하세요");
					return false;
				}
				
				$(this).submit();
			});
		    
		</script>
	</body>
</html>