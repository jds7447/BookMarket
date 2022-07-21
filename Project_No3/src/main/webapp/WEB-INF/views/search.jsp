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
		<div class="wrapper">
			<div class="wrap">
				<div class="top_gnb_area">
					<%-- GNB(Global Navigation Bar) : 웹디자인 용어로써 어느 페이지를 들어가든지 공통적으로 사용할 수 있는 메뉴 --%>
					<!-- <h1>gnb area</h1> -->
					<ul class="list">
						<%-- 로그인 전 --%>
						<c:if test = "${member == null}">
			                <li >
			                    <a href="/member/login">로그인</a>
			                </li>
			                <li>
			                    <a href="/member/join">회원가입</a>
			                </li>
		                </c:if>
		                <%-- 로그인 후 --%>
		                <c:if test="${member != null }">
		                	<%-- 관리자 계정일 경우 관리자 메뉴도 추가 --%>
		                	<c:if test="${member.adminCk == 1 }">
		                        <li>
		                        	<a href="/admin/main">관리자 페이지</a>
		                        </li>
		                    </c:if>
		                    <%-- 일반 계정일 경우 아래 메뉴만 --%>
		                    <li>
		                        <a id="gnb_logout_button">로그아웃</a>   <!-- 특정 화면 이동 없이 현 페이지가 새로고침 되는 비동기 방식 구현 -->
		                    </li>
		                    <li>
		                        마이룸
		                    </li>
		                    <li>
		                        장바구니
		                    </li>
		                </c:if>
		                <!-- 공통 -->
		                <li>
		                    고객센터
		                </li>            
		            </ul> 
				</div>
				<div class="top_area">
					<div class="logo_area">
						<a href="/main"><img src="/resources/img/Logo.png"></a>
					</div>
					<div class="search_area">
						<!-- <h1>Search area</h1> -->
						<div class="search_wrap">
	                		<form id="searchForm" action="/search" method="get">
	                			<div class="search_input">
	                				<select name="type">
	                					<option value="T">책 제목</option>
	                					<option value="A">작가</option>
                					</select>
	                				<input type="text" name="keyword" value="<c:out value="${pageMaker.cri.keyword}"/>">
	                    			<button class='btn search_btn'>검 색</button>
	                			</div>
	                		</form>
	                	</div>
					</div>
					<div class="login_area">
						<%-- 로그인한 상황에서는 (로그인, 회원가입) 버튼들이 보이지 않고 로그인한 회원의 정보가 출력되도록 --%>
						<%-- 로그인 하지 않은 상태 --%>
						<c:if test = "${member == null }">
							<div class="login_button"><a href="/member/login">로그인</a></div>
							<span><a href="/member/join">회원가입</a></span>
						</c:if>
						
						<%-- 로그인한 상태 --%>
		                <c:if test="${ member != null }">
		                	<%-- 서버로부터 받은 로그인한 회원 정보 --%>
		            		<div class="login_success_area">
		                        <span>회원 : ${member.memberName}</span>
		                        <%-- 회원이 소유한 돈, 포인트가 읽기에 다소 불편하여 JSTL에서 형식 변환 기능을 제공하는 fmt 태그로 숫자 형식을 변경 --%>
		                        <%-- <span>충전금액 : ${member.money}</span> --%>
		                        <%-- <span>포인트 : ${member.point}</span> --%>
		                        <span>충전금액 : <fmt:formatNumber value="${member.money }" pattern="\#,###.##"/></span>   <%-- 원화기호, 천단위 콤마(,), 소수점 둘째 자리까지 표현 --%>
        						<span>포인트 : <fmt:formatNumber value="${member.point }" pattern="#,###" /></span>   <%-- 천단위 콤마(,) --%>
        						<a href="/member/logout.do">로그아웃</a>   <%-- 로그아웃 기능 추가 --%>
		                    </div>
		                </c:if>
					</div>
					<div class="clearfix"></div>			
				</div>
				<!-- <div class="navi_bar_area">
					<h1>navi area</h1>
				</div> -->
				<div class="content_area">
					<!-- <h1>content area</h1> -->
					<%-- 게시물(검색결과) o --%>
					<c:if test="${listcheck != 'empty'}">
						<div class="list_search_result">
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
													${list.bookName}
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
													평점(추후 추가)
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
						</form>
					</c:if>
					
					<%-- 게시물(검색결과) x --%>
					<c:if test="${listcheck == 'empty'}">
						<div class="table_empty">
							검색결과가 없습니다.
						</div>
					</c:if>
				</div>
				
				<%-- Footer 영역 --%>
		        <div class="footer_nav">
		            <div class="footer_nav_container">
		                <ul>
		                    <li>회사소개</li>
		                    <span class="line">|</span>
		                    <li>이용약관</li>
		                    <span class="line">|</span>
		                    <li>고객센터</li>
		                    <span class="line">|</span>
		                    <li>광고문의</li>
		                    <span class="line">|</span>
		                    <li>채용정보</li>
		                    <span class="line">|</span>
		                </ul>
		            </div>
		        </div> <!-- class="footer_nav" -->
		        
		        <div class="footer">
		            <div class="footer_container">
		                <div class="footer_left">
		                    <img src="/resources/img/Logo.png">
		                </div>
		                <div class="footer_right">
		                    (주) BookMarket    대표이사 : OOO
		                    <br>
		                    사업자등록번호 : ooo-oo-ooooo
		                    <br>
		                    대표전화 : oooo-oooo(발신자 부담전화)
		                    <br>
		                    <br>
		                    COPYRIGHT(C) <strong>blog.naver.com/jds7447</strong>    ALL RIGHTS RESERVED.
		                </div>
		                <div class="clearfix"></div>
		            </div>
		        </div> <!-- class="footer" -->
			</div>
		</div>
		
		<script>
		
			$(document).ready(function(){
				// 검색 타입 selected (사용자가 검색 전에 선택했던 검색 타입으로 검색 타입 태그 옵션 설정)
				const selectedType = '<c:out value="${pageMaker.cri.type}"/>';
				if(selectedType != ""){
					$("select[name='type']").val(selectedType).attr("selected", "selected");	
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
			});
 
			
		    /* gnb_area 비동기 로그아웃 버튼 작동 */
		    $("#gnb_logout_button").click(function(){
		    	$.ajax({
		            type:"POST",
		            url:"/member/logout.do",
		            success:function(data){
		                alert("로그아웃 성공");
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
		    
		</script>
	</body>
</html>