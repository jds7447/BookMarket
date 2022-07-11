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
		<link rel="stylesheet" href="resources/css/main.css">
		<!--  jquery를 사용할 것이기 때문에 jquery url 코드 추가 -->
		<script src="https://code.jquery.com/jquery-3.4.1.js"
  				integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  				crossorigin="anonymous"></script>
	</head>
	
	<body>
		<div class="wrapper">
			<div class="wrap">
				<div class="top_gnb_area">
					<!-- GNB(Global Navigation Bar) : 웹디자인 용어로써 어느 페이지를 들어가든지 공통적으로 사용할 수 있는 메뉴 -->
					<!-- <h1>gnb area</h1> -->
					<ul class="list">
						<!-- 로그인 전 -->
						<c:if test = "${member == null}">
			                <li >
			                    <a href="/member/login">로그인</a>
			                </li>
			                <li>
			                    <a href="/member/join">회원가입</a>
			                </li>
		                </c:if>
		                <!-- 로그인 후 -->
		                <c:if test="${member != null }">
		                	<!-- 관리자 계정일 경우 관리자 메뉴도 추가 -->
		                	<c:if test="${member.adminCk == 1 }">
		                        <li>
		                        	<a href="/admin/main">관리자 페이지</a>
		                        </li>
		                    </c:if>
		                    <!-- 일반 계정일 경우 아래 메뉴만 -->
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
						<a href="/main"><img src="/resources/img/Logo.PNG"></a>
					</div>
					<div class="search_area">
						<h1>Search area</h1>
					</div>
					<div class="login_area">
						<!-- 로그인한 상황에서는 (로그인, 회원가입) 버튼들이 보이지 않고 로그인한 회원의 정보가 출력되도록 -->
						<!-- 로그인 하지 않은 상태 -->
						<c:if test = "${member == null }">
							<div class="login_button"><a href="/member/login">로그인</a></div>
							<span><a href="/member/join">회원가입</a></span>
						</c:if>
						
						<!-- 로그인한 상태 -->
		                <c:if test="${ member != null }">
		                	<!-- 서버로부터 받은 로그인한 회원 정보 -->
		            		<div class="login_success_area">
		                        <span>회원 : ${member.memberName}</span>
		                        <!-- 회원이 소유한 돈, 포인트가 읽기에 다소 불편하여 JSTL에서 형식 변환 기능을 제공하는 fmt 태그로 숫자 형식을 변경 -->
		                        <%-- <span>충전금액 : ${member.money}</span> --%>
		                        <%-- <span>포인트 : ${member.point}</span> --%>
		                        <span>충전금액 : <fmt:formatNumber value="${member.money }" pattern="\#,###.##"/></span>   <!-- 원화기호, 천단위 콤마(,), 소수점 둘째 자리까지 표현 -->
        						<span>포인트 : <fmt:formatNumber value="${member.point }" pattern="#,###" /></span>   <!-- 천단위 콤마(,) -->
        						<a href="/member/logout.do">로그아웃</a>   <!-- 로그아웃 기능 추가 -->
		                    </div>
		                </c:if>
					</div>
					<div class="clearfix"></div>			
				</div>
				<div class="navi_bar_area">
					<h1>navi area</h1>
				</div>
				<div class="content_area">
					<h1>content area</h1>
				</div>
				
				<!-- Footer 영역 -->
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
		                    <img src="/resources/img/Logo.PNG">
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
		    
		</script>
	</body>
</html>