<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- JSTL을 사용하기 위해 태그라이브러리 코드 추가 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri = "http://java.sun.com/jsp/jstl/functions" %>

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
		<link rel="stylesheet" type="text/css" href="/resources/css/main.css">
		
  		<%-- slick 라이브러리 cdn 코드 (css, js) --%>
  		<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
		<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
		<%-- slick에서 기본적으로 제공하는 슬라이드 꾸미기 css  --%>
		<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css"/>
		
		<style type="text/css">
			/* 광고 배너 슬라이드의 숨겨진 좌, 우 이동 버튼이 보기 쉽도록 색, 위치를 조정
				(그림 태그 영역까지 버튼을 당겨서 버튼 태그와 그림 태그가 겹치지만 z-index 속성을 주어서 버튼 태그가 제일 앞에 위치하도록 설정) - 안 겹치게 수정
				css 적용 우선 순위로 인해 main.css 파일(19번줄)에 넣으면 추가한 slick 라이브러리 css 파일(25번줄) 때문에 적용되지 않아 여기에 추가 */
			.slick-prev{
				left: 100px;
			    /* z-index: 1; */
			    /* color: black; */
			    /* background: gray; */
			}
			.slick-next{
				right: 100px;
			    /* z-index: 1; */
			    /* color: black; */
			    /* background: gray; */
			}
			.slick-prev:before, .slick-next:before{
			    color: black;
			}
		</style>
	</head>
	
	<body>
		
		<%@include file="./includes/common/headerCommon.jsp" %>
		
				<div class="navi_bar_area">
					<!-- <h1>navi area</h1> -->
					<div class="dropdown">
						<button class="dropbtn">국내
					      <i class="fa fa-caret-down"></i>
					    </button>
					    <div class="dropdown-content">
					    	<c:forEach items="${cate1}" var="cate">
					    		<c:if test="${ fn:substring(cate.cateCode, 3, 6) eq '000' }">
					    			<c:if test="${ cate.cateCode ne '101000' }"><br></c:if>
					    		</c:if>
					    		<c:choose> 
									<c:when test="${ fn:substring(cate.cateCode, 3, 6) eq '000' }">
										<a style="background-color: lightgray; font-weight: bold; font-size: 17px;">${cate.cateName}</a>
									</c:when>
									<c:otherwise>
					    				<a href="search?type=C&cateCode=${cate.cateCode}">${cate.cateName}</a>
									</c:otherwise> 
								</c:choose>
					    	</c:forEach>
					    </div>
					</div>
					<div class="dropdown">
						<button class="dropbtn">국외
					      <i class="fa fa-caret-down"></i>
					    </button>
					    <div class="dropdown-content">
					    	<c:forEach items="${cate2}" var="cate">
					    		<c:if test="${ fn:substring(cate.cateCode, 3, 6) eq '000' }">
					    			<c:if test="${ cate.cateCode ne '201000' }"><br></c:if>
					    		</c:if>
					    		<c:choose> 
									<c:when test="${ fn:substring(cate.cateCode, 3, 6) eq '000' }">
										<a style="background-color: lightgray; font-weight: bold; font-size: 17px;">${cate.cateName}</a>
									</c:when>
									<c:otherwise>
					    				<a href="search?type=C&cateCode=${cate.cateCode}">${cate.cateName}</a>
									</c:otherwise> 
								</c:choose>
					    	</c:forEach>
					    </div>
					</div>
				</div>
				<div class="content_area">
					<!-- <h1>content area</h1> -->
					<div class="slide_div_wrap">
						<div class="slide_div">   <%-- 광고 슬라이드 배너 적용 --%>
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
						<div class="ls_div">   <%-- 평점순 상품에 슬라이드 적용 --%>
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
				
			<%@include file="./includes/common/footer.jsp" %>
		
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
		                /* alert("로그아웃 성공"); */
		                document.location.reload();     
		            } 
		        }); // ajax 종료
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