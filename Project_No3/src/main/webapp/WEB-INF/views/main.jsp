<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- JSTL을 사용하기 위해 태그라이브러리 코드 추가 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Welcome BookMarket</title>
		
		<!--  jquery를 사용할 것이기 때문에 jquery url 코드 추가 -->
		<script src="https://code.jquery.com/jquery-3.4.1.js"
  				integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  				crossorigin="anonymous"></script>
		<!-- 직접 설정한 css 코드 불러오기 -->
		<link rel="stylesheet" href="/resources/css/main.css">
		
  		<%-- slick 라이브러리 cdn 코드 (css, js) --%>
  		<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
		<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
		<%-- slick에서 기본적으로 제공하는 슬라이드 꾸미기 css  --%>
		<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css"/>
		
		<style type="text/css">
			/* 슬라이드의 숨겨진 좌, 우 이동 버튼이 보이도록 위치를 이동하고
				그림 태그 영역까지 버튼을 당겨서 버튼 태그와 그림 태그가 겹치지만 z-index 속성을 주어서 버튼 태그가 제일 앞에 위치하도록 */
			.slick-prev{
				left: 100px;
			    z-index: 1;
			    color: black;
			    background: gray;
			}
			.slick-next{
				right: 100px;
			    z-index: 1;
			    color: black;
			    background: gray;
			}
		</style>
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
		                        <a href="/cart/${member.memberId}">장바구니</a>
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
	                				<input type="text" name="keyword">
	                    			<button class='btn search_btn'>검 색</button>                				
	                			</div>
	                		</form>
	                	</div>
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
					<!-- <h1>navi area</h1> -->
					<div class="dropdown">
						<button class="dropbtn">국내
					      <i class="fa fa-caret-down"></i>
					    </button>
					    <div class="dropdown-content">
					    	<c:forEach items="${cate1}" var="cate">
					    		<a href="search?type=C&cateCode=${cate.cateCode}">${cate.cateName}</a>
					    	</c:forEach>
					    </div>
					</div>
					<div class="dropdown">
						<button class="dropbtn">국외
					      <i class="fa fa-caret-down"></i>
					    </button>
					    <div class="dropdown-content">
					    	<c:forEach items="${cate2}" var="cate">
					    		<a href="search?type=C&cateCode=${cate.cateCode}">${cate.cateName}</a>
					    	</c:forEach>
					    </div>
					</div>
				</div>
				<div class="content_area">
					<!-- <h1>content area</h1> -->
					<div class="slide_div_wrap">
						<div class="slide_div">   <%-- 슬라이드 배너 적용 --%>
							<div>
								<a>
									<img src="../resources/img/SB_1.png">
								</a>
							</div>
							<div>
								<a>
									<img src="../resources/img/SB_2.png">
								</a>
							</div>
							<div>
								<a>
									<img src="../resources/img/SB_3.png">
								</a>
							</div>				
						</div>	
					</div>
					
					<div class="ls_wrap">
						<div class="ls_div_subject">
							평점순 상품
						</div>
						<div class="ls_div">
							<c:forEach items="${ls}" var="ls">
								<a href="/goodsDetail/${ls.bookId}">
									<div class="ls_div_content_wrap">
										<div class="ls_div_content">
											<div class="image_wrap" data-bookid="${ls.imageList[0].bookId}" data-path="${ls.imageList[0].uploadPath}" data-uuid="${ls.imageList[0].uuid}" data-filename="${ls.imageList[0].fileName}">
												<img>
											</div>				
											<div class="ls_category">
												${ls.cateName}
											</div>
											<div class="ls_rating">
												${ls.ratingAvg}
											</div>
											<div class="ls_bookName">
												${ls.bookName}
											</div>							
										</div>
									</div>
								</a>					
							</c:forEach>					
						</div>
					</div>
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
				
				/* 광고 배너 - 해당 태그에 슬라이드 배너 적용 */
				$(".slide_div").slick(   //괄호() 안에 슬라이드 옵션 추가
					{
						dots: true,   //슬라이드의 현재 위치와 바로 이동할 수 있는 점
						autoplay : true,   //슬라이드 자동 넘김
						autoplaySpeed: 5000   //슬라이드 넘김 간격 5초(5000ms)
					}
				);
				
				
				/* 이미지 삽입 */
				$(".image_wrap").each(function(i, obj){   //해당 클래스를 가진 태그들 반복
					const bobj = $(obj);   //태그 객체
					
					if(bobj.data("bookid")){   //상품에 id 데이터가 있으면 (이미지 있으면) 이미지 데이터로 해당 이미지 가져와 태그에 삽입
						const uploadPath = bobj.data("path");
						const uuid = bobj.data("uuid");
						const fileName = bobj.data("filename");
						
						const fileCallPath = encodeURIComponent(uploadPath + "/s_" + uuid + "_" + fileName);   //썸네일 이미지 파일명
						
						$(this).find("img").attr('src', '/display?fileName=' + fileCallPath);   //파일명을 쿼리스트링으로 이미지 데이터 요청
						
					} else {   //이미지 없으면
						$(this).find("img").attr('src', '/resources/img/No_Image.png');   //이미지 없음 이미지 출력
					}
					
				});
				
				/* 평점순 상품에 슬라이드 적용 */
				$(".ls_div").slick({
					slidesToShow: 4,   //몇 개의 슬라이드를 한화면에 보일 것인지
					slidesToScroll: 4,   //다음 슬라이드 이동 시 몇 개씩 이동할 것인지
					prevArrow : "<button type='button' class='ls_div_content_prev'>이전</button>",   // 이전 버튼 화살표 모양 설정
					nextArrow : "<button type='button' class='ls_div_content_next'>다음</button>"   // 다음 버튼 화살표 모양 설정
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
		    
		    
		    
		</script>
	</body>
</html>