<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="/resources/css/includes/common/header.css">

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
		                        <a href="/member/logout.do">로그아웃</a>   <%-- 로그아웃 후 메인 페이지로 이동 --%>
		                    </li>
		                    <!-- <li>
		                        마이룸
		                    </li> -->
		                    <li>
		                        <a href="/cart/${member.memberId}">장바구니</a>
		                    </li>
		                </c:if>
		                <!-- 공통 -->
		                <!-- <li>
		                    고객센터
		                </li> -->            
		            </ul> 
				</div>
				<div class="top_area">
					<div class="logo_area">
						<a href="/main"><img src="/resources/img/Logo2.png"></a>
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
							<!-- <span><a href="/member/join">회원가입</a></span> -->
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
        						<!-- <a href="/member/logout.do">로그아웃</a> -->   <%-- 로그아웃 기능 추가 --%>
		                    </div>
		                </c:if>
					</div>
					<div class="clearfix"></div>			
				</div>