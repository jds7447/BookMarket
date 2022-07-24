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
		<link rel="stylesheet" href="/resources/css/goodsDetail.css">
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
					<div class="line">
					</div>			
					<div class="content_top">
						<div class="ct_left_area">
							<div class="image_wrap" data-bookid="${goodsInfo.imageList[0].bookId}" data-path="${goodsInfo.imageList[0].uploadPath}" data-uuid="${goodsInfo.imageList[0].uuid}" data-filename="${goodsInfo.imageList[0].fileName}">
								<img>
							</div>				
						</div>
						<div class="ct_right_area">
							<div class="title">
								<h1>
									${goodsInfo.bookName}
								</h1>
							</div>
							<div class="line">
							</div>
							<div class="author">
								 <span>
								 	${goodsInfo.authorName} 지음
								 </span>
								 <span>|</span>
								 <span>
								 	${goodsInfo.publisher}
								 </span>
								 <span>|</span>
								 <span class="publeyear">
								 	${goodsInfo.publeYear}
								 </span>
							</div>
							<div class="line">
							</div>	
							<div class="price">
								<div class="sale_price">정가 : <fmt:formatNumber value="${goodsInfo.bookPrice}" pattern="#,### 원" /></div>
								<div class="discount_price">
									판매가 : <span class="discount_price_number"><fmt:formatNumber value="${goodsInfo.bookPrice - (goodsInfo.bookPrice*goodsInfo.bookDiscount)}" pattern="#,### 원" /></span> 
									[<fmt:formatNumber value="${goodsInfo.bookDiscount*100}" pattern="###" />% 
									<fmt:formatNumber value="${goodsInfo.bookPrice*goodsInfo.bookDiscount}" pattern="#,### 원" /> 할인]</div>							
							</div>			
							<div class="line">
							</div>	
							<div class="button">						
								<div class="button_quantity">
									주문수량
									<input type="text" value="1">
									<span>
										<button>+</button>
										<button>-</button>
									</span>
								</div>
								<div class="button_set">
									<a class="btn_cart">장바구니 담기</a>
									<a class="btn_buy">바로구매</a>
								</div>
							</div>
						</div>
					</div>
					<div class="line">
					</div>				
					<div class="content_middle">
						<div class="book_intro">
							${goodsInfo.bookIntro}
						</div>
						<div class="book_content">
							${goodsInfo.bookContents }
						</div>
					</div>
					<div class="line">
					</div>				
					<div class="content_bottom">
						리뷰
					</div>
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
			
			/* 이미지 삽입 */
			const bobj = $(".image_wrap");   //이미지 출력 태그
			
			if(bobj.data("bookid")){   //해당 상품의 이미지 데이터가 존재하는 경우 (이미지 출력 태그에 심어둔 data-bookid 속성 값이 있는 경우)
				/* 태그에 심어둔 파일 정보 데이터를 호출하여 각 변수에 저장 */
				const uploadPath = bobj.data("path");
				const uuid = bobj.data("uuid");
				const fileName = bobj.data("filename");
				
				/* 해당 데이터들을 조합하여 "/display" 매핑 메서드의 파라미터로 전달시킬 fileName 데이터를 만든 뒤 fileCallPath 변수에 저장 */
				const fileCallPath = encodeURIComponent(uploadPath + "/s_" + uuid + "_" + fileName);
				
				/* 클래스명이 .image_wrap 인 <div> 태그 내부의 <img> 태그를 호출, <img> 태그에 이미지를 호출하는 url을 가지는 src 속성 추가 */
				bobj.find("img").attr('src', '/display?fileName=' + fileCallPath);
			}
			else {   //해당 상품에 등록된 이미지가 없는 경우 "이미지 없음" 이미지 출력
				bobj.find("img").attr('src', '/resources/img/goodsNoImage.png');
			}
			
			
			/* 출판일 값 가공 */
			/* Oralce 프로젝트의 경우 출판일 항목란에 출력되는 형태는 0000-00-00 00:00:00
			yyyy-MM-dd 형태로 변경을 해주기 위해 fmt:formatDate 태그를 사용하면 된다고 생각할 수 있지만 사용 시 아래와 같은 에러
			fmt:formatDate 태그는 Date타입의 데이터를 가공을 할 수 있는 태그이기 때문
			BookVO.java 클래스의 출판일(publeYear) 변수 데이터 타입은 String으로 정의
			String으로 정의 되어야 캘릭더 위젯으로 선택한 날짜 데이터가 BookVO 객체의 변수로 변환되어 담길 수 있기 때문
			BookVO 객체에 넣을 땐 0000-00-00 형태였지만 DB의 book_goods 테이블의 publeYear 열의 데이터 타입은 Date로 정의되어 있음
			DB단계와 Java단계의 데이터 타입을 같게 해주어야 하지만, 현재의 두 개의 데이터 타입은 달라도 정보를 주고받거나, 삽입할 때는 크게 문제는 되지 않음
			출판일의 값 형태를 yyyy-MM-dd 형태로 변경해주어야 하는데, 현재의 값이 String인 점을 착안하여 substirng(), indexOf() 메서드를 활용 */
			const year = "${goodsInfo.publeYear}";   //출판일 값
			
			let tempYear = year.substr(0,10);   //출판일 값을 10글자로 자르기 (0부터 9까지)
			
			let yearArray = tempYear.split("-")   //자른 값을 "-" 을 기준으로 나눠서 배열에 저장
			let publeYear = yearArray[0] + "년 " + yearArray[1] + "월 " + yearArray[2] + "일";   //나눈 값을 원하는 형식으로 합체
			
			$(".publeyear").html(publeYear);   //완성한 날짜 형식을 출판일 출력 태그에 html로 적용
			
		});
		    
		</script>
	</body>
</html>