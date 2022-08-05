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
									<fmt:formatNumber value="${goodsInfo.bookPrice*goodsInfo.bookDiscount}" pattern="#,### 원" /> 할인]
								</div>
								<div>
									적립 포인트 : <span class="point_span"></span>원
								</div>
							</div>			
							<div class="line">
							</div>
							<div class="button">						
								<div class="button_quantity">
									주문수량
									<input type="text" value="1" class="quantity_input">
									<span>
										<button class="plus_btn">+</button>
										<button class="minus_btn">-</button>
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
						<div class="reply_subject">
							<h2>리뷰</h2>
						</div>
						<c:if test="${member != null}">   <%-- 로그인 한 회원만 볼 수 있도록 --%>
							<div class="reply_button_wrap">
								<button>리뷰 쓰기</button>
							</div>
						</c:if>
						<div class="reply_not_div">   <%-- 댓글이 없는 경우 관련 문구 --%>
							
						</div>
						<ul class="reply_content_ul">   <%-- 댓글이 존재하는 경우 댓글 리스트 --%>
							
						</ul>
						<div class="repy_pageInfo_div">   <%-- 댓글 페이징 버튼 --%>
							<ul class="pageMaker">
								
							</ul>
						</div>
					</div>
					
					<!-- 주문 form -->
					<form action="/order/${member.memberId}" method="get" class="order_form">
						<input type="hidden" name="orders[0].bookId" value="${goodsInfo.bookId}">
						<input type="hidden" name="orders[0].bookCount" value="">
					</form>
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
				
				
				/* 포인트 삽입 */
				let salePrice = "${goodsInfo.bookPrice - (goodsInfo.bookPrice * goodsInfo.bookDiscount)}";   //할인된 상품 가격
				let point = salePrice * 0.05;   //상품 가격의 5% 를 포인트로
				point = Math.floor(point);   //포인트의 소수점 아래 내림 (1.8 -> 1)
				$(".point_span").text(point);   //포인트 출력 태그에 포인트 삽입
				
				
				/* 댓글 리스트 받아오기 */
				/* JQUERY에서는 단순히 JSON 데이터를 GET 메서드 방식으로 서버에 요청할 때 간편히 사용할 수 있는 getJOSN() 메서드를 제공
					$.getJSON(요청 URL, 서버에 전송할 데이터, 서버로부터 응답을 성공했을 때 동작할 코드) */
				const bookId = '${goodsInfo.bookId}';   //현재 상품 id
				$.getJSON("/reply/list", {bookId : bookId}, function(obj){   //obj : 서버가 반환 해준 '댓글 리스트 정보(JSON 데이터)'
					makeReplyContent(obj)   //댓글(리뷰) 동적 생성 메서드 호출
				});
				
			});
			
			
			// 주문 수량 버튼 조작
			let quantity = $(".quantity_input").val();   //수량 표시 태그
			$(".plus_btn").on("click", function(){   // +버튼 조작
				$(".quantity_input").val(++quantity);
			});
			$(".minus_btn").on("click", function(){   // -버튼 조작
				if(quantity > 1){   //0 이하로 떨어지지 않게
					$(".quantity_input").val(--quantity);	
				}
			});
			
			
			// 서버로 전송할 데이터
			const form = {
					memberId : '${member.memberId}',
					bookId : '${goodsInfo.bookId}',
					bookCount : ''   //수량('bookCount') 경우 '장바구니 버튼' 클릭 직전까지 변경할 수 있기 때문에 빈 값
			}
			
			// 장바구니 추가 버튼
			$(".btn_cart").on("click", function(e){
				form.bookCount = $(".quantity_input").val();   //버튼 클릭 시 수량 부여
				$.ajax({   //장바구니 등록 요청 ajax
					url: '/cart/add',
					type: 'POST',
					data: form,
					success: function(result){   //서버가 반환한 값에 따라 알림창 출력 메서드 호출
						cartAlert(result);
					}
				})   //장바구니 등록 요청 ajax 끝
			});
			
			//전달 받은 값에 따라 알림창 출력 메서드
			function cartAlert(result){
				if(result == '0'){
					alert("장바구니에 추가를 하지 못하였습니다.");
				} else if(result == '1'){
					alert("장바구니에 추가되었습니다.");
				} else if(result == '2'){
					alert("장바구니에 이미 추가되어져 있습니다.");
				} else if(result == '5'){
					alert("로그인이 필요합니다.");	
				}
			}
			
			
			/* 바로구매 버튼 */
			$(".btn_buy").on("click", function(){
				let bookCount = $(".quantity_input").val();   //주문 수량 태그 요소 값
				$(".order_form").find("input[name='orders[0].bookCount']").val(bookCount);   //주문 폼 개수 데이터
				$(".order_form").submit();
			});
			
			
			/* gnb_area 비동기 로그아웃 버튼 작동 */
		    $("#gnb_logout_button").click(function(){
		    	$.ajax({
		            type:"POST",
		            url:"/member/logout.do",
		            success:function(data){
		                alert("로그아웃 성공");
		                document.location.reload();   //페이지 새로 고침
		            } 
		        }); // ajax 종료
		    });
		
		
		    /* 리뷰쓰기 버튼 */
			$(".reply_button_wrap").on("click", function(e){
				e.preventDefault();			

				const memberId = '${member.memberId}';
				const bookId = '${goodsInfo.bookId}';

				/* let popUrl = "/replyEnroll/" + memberId + "?bookId=" + bookId;
				console.log(popUrl);
				let popOption = "width = 490px, height=490px, top=300px, left=300px, scrollbars=yes";
				
				// 팝업 창 생성 - url, 팝업창 이름, 팝업창 관련 설정(크기, 스크롤 방식 등)
				window.open(popUrl, "리뷰 쓰기", popOption); */
				
				//회원이 해당 상품이 이미 댓글을 달았는지 확인 후 기 작성한 댓글 존재 유무에 따라 댓글 작성 팝업창 띄우거나 안띄움
				$.ajax({
					data : {
						bookId : bookId,
						memberId : memberId
					},
					url : '/reply/check',
					type : 'POST',
					success : function(result){
						if(result === '1'){
							alert("이미 등록된 리뷰가 존재 합니다.")
						} else if(result === '0'){
							let popUrl = "/replyEnroll/" + memberId + "?bookId=" + bookId;
							console.log(popUrl);
							let popOption = "width = 490px, height=490px, top=300px, left=300px, scrollbars=yes";
							
							window.open(popUrl,"리뷰 쓰기",popOption);							
						}
					}
				});
			});
		    
		    
			/* 댓글(리뷰) 동적 생성 메서드 */
			//댓글을 동적으로 만들어 내는 작업은 화면이 렌더링 될 때뿐만 아니라 회원이 댓글을 등록, 수정, 삭제, 페이지 이동의 경우에도 똑같은 작업이 필요
			//따라서 중복하여 코드를 작성하지 않도록 댓글을 동적으로 만들어 내는 코드를 메서드로 추출 후 필요 시마다 호출하여 활용
			function makeReplyContent(obj){
				//'댓글 리스트 정보'는 ReplyPagDTO객체가 JSON으로 변환된 데이터로 JSON은 Jvascript 객체 리터럴 문법을 따르기 때문에 그 자체로 Jvascript 객체
				//따라서 객체의 프로퍼티 접근 방식으로 '댓글 리스트 정보'의 list(댓글 정보)와 pageInfo (페이지 정보)에 접근 가능
				//list 프로퍼티의 값에 아무 데이터가 없을 경우 댓글이 없는 경우이기 때문에 ". length"속성을 사용하여 데이터가 있는지 없는지를 판단
				if(obj.list.length === 0){   //댓글이 없는 경우
					$(".reply_not_div").html('<span>리뷰가 없습니다.</span>');   //동적으로 댓글이 없다는 문구가 추가
					$(".reply_content_ul").html('');   //작성 중인 댓글 리스트를 동적으로 만드는 코드는 '회원이 댓글을 추가했을 때', '수정, 삭제했을 때' 도
					$(".pageMaker").html('');   //댓글 최신화를 위해 그대로 사용할 것인데 기존의 남아 있는 태그들을 지워 주기 위함
				}
				else{   //댓글이 있는 경우
					$(".reply_not_div").html('');   //댓글 없음 문구 삭제
					
					const list = obj.list;   //댓글 리스트
					const pf = obj.pageInfo;   //페이징 데이터
					const userId = '${member.memberId}';   //회원 id
					
					/* list */
					let reply_list = '';   //댓글 목록에 추가될 태그를 작성할 변수
					
					$(list).each(function(i,obj){   //댓글 리스트를 반복문으로 하나씩 꺼내 태그를 작성
						reply_list += '<li>';
						reply_list += '<div class="comment_wrap">';
						reply_list += '<div class="reply_top">';
						/* 아이디 */
						reply_list += '<span class="id_span">'+ obj.memberId+'</span>';
						/* 날짜 */
						reply_list += '<span class="date_span">'+ obj.regDate +'</span>';
						/* 평점 */
						reply_list += '<span class="rating_span">평점 : <span class="rating_value_span">'+ obj.rating +'</span>점</span>';
						
						if(obj.memberId === userId){   //if문으로 로그인한 회원과 댓글 아이디 가 일치할 때 '수정', '삭제' 버튼이 보이게 하기
							reply_list += '<a class="update_reply_btn" href="'+ obj.replyId +'">수정</a><a class="delete_reply_btn" href="'+ obj.replyId +'">삭제</a>';
						}
						
						reply_list += '</div>';   //<div class="reply_top">
						reply_list += '<div class="reply_bottom">';
						reply_list += '<div class="reply_bottom_txt">'+ obj.content +'</div>';
						reply_list += '</div>';   //<div class="reply_bottom">
						reply_list += '</div>';   //<div class="comment_wrap">
						reply_list += '</li>';
					});
					
					$(".reply_content_ul").html(reply_list);   //작성한 댓글 목록 태그를 html로 추가
					
					/* 페이지 버튼 */
					let reply_pageMaker = '';   //추가할 페이징 태그를 저장할 변수
					
					/* prev */
					if(pf.prev){   //이전 페이지 버튼이 true인 경우
						let prev_num = pf.startPage -1;
						reply_pageMaker += '<li class="pageMaker_btn prev">';
						reply_pageMaker += '<a href="'+ prev_num +'">이전</a>';
						reply_pageMaker += '</li>';	
					}
					/* numbre btn */
					for(let i = pf.startPage; i < pf.endPage+1; i++){   //반복문으로 페이지 버튼 추가
						reply_pageMaker += '<li class="pageMaker_btn ';
						if(pf.cri.pageNum === i){
							reply_pageMaker += 'active';
						}
						reply_pageMaker += '">';
						reply_pageMaker += '<a href="'+i+'">'+i+'</a>';
						reply_pageMaker += '</li>';
					}
					/* next */
					if(pf.next){   //다전 페이지 버튼이 true인 경우
						let next_num = pf.endPage +1;
						reply_pageMaker += '<li class="pageMaker_btn next">';
						reply_pageMaker += '<a href="'+ next_num +'">다음</a>';
						reply_pageMaker += '</li>';	
					}
					
					$(".pageMaker").html(reply_pageMaker);	 //작성한 페이징 태그를 html로 추가
				}
			}
			
			
			/* 댓글 초기화 메서드 - 댓글을 등록, 수정, 삭제 혹은 페이지 이동시 해당 댓글 정보로 데이터가 초기화되어야 하는 4가지 상황에서 호출할 수 있는 메서드 */
			/* 댓글 페이지 정보 */
			const cri = {
				bookId : '${goodsInfo.bookId}',
				pageNum : 1,
				amount : 10
			}
			/* 댓글 데이터 서버 요청 및 댓글 동적 생성 메서드 */
			let replyListInit = function(){
				$.getJSON("/reply/list", cri, function(obj){   //서버에 댓글 리스트 요청 (obj : 서버가 반환 해준 '댓글 리스트 정보(JSON 데이터)')
					makeReplyContent(obj);   //최신화 된 댓글 리스트로 동적 생성
				});
			}
			/* 댓글 페이지 이동 버튼 */
//		    $(".pageMaker_btn a").on("click", function(e){   //클릭 대상인 페이지 버튼 태그가 Javascript를 통해 동적으로 생성된 태그이기에 동작 안함
			//따라서 아래와 같이 접근할 선택자를 현재 페이지 문서 객체로 수정
			//document 객체에 접근해서 on 메서드를 호출
			//on('이벤트 종류(클릭)', 이벤트 대상인 선택자(댓글 페이지 버튼 태그), 대상 성택자에 이벤트가 발생했을 때 동작하는 함수)
			$(document).on('click', '.pageMaker_btn a', function(e){
				e.preventDefault();
				
				let page = $(this).attr("href");   //클릭한 페이지 번호
				
				cri.pageNum = page;   //위에 작성한 댓글 페이지 정보 객체의 페이지 번호를 클릭한 번호로 변경
				
				replyListInit();   //댓글 데이터 서버 요청 및 댓글 동적 생성 메서드 호출
			});
			/* 댓글 수정 버튼 - 동적으로 추가된 태그에 접근 */
			$(document).on('click', '.update_reply_btn', function(e){
				e.preventDefault();
				
				let replyId = $(this).attr("href");   //댓글 수정 버튼(a 태그)에 담긴 hrem 속성의 값(댓글id)
				
				//쿼리 스트링이 포함된 댓글 수정 요청 url
				let popUrl = "/replyUpdate?replyId=" + replyId + "&bookId=" + '${goodsInfo.bookId}' + "&memberId=" + '${member.memberId}';
				
				let popOption = "width = 490px, height=490px, top=300px, left=300px, scrollbars=yes"   //팝업 창 설정
				
				window.open(popUrl, "리뷰 수정", popOption);   // 팝업 창 생성 - url, 팝업창 이름, 팝업창 관련 설정(크기, 스크롤 방식 등)
			});
			/* 댓글 삭제 버튼 - 동적으로 추가된 태그에 접근 */
			$(document).on('click', '.delete_reply_btn', function(e){
				e.preventDefault();
				
				let replyId = $(this).attr("href");   //댓글 id
				
				//해당 댓글 삭제 비동기 요청 (상품 id는 해당 상품의 평점 평균 값 최신화에 필요)
				$.ajax({
					data : {
						replyId : replyId,
						bookId : '${goodsInfo.bookId}'
					},
					url : '/reply/delete',
					type : 'POST',
					success : function(result){
						replyListInit();   //댓글 리스트 최신화
						alert('삭제가 완료되엇습니다.');
					}
				});
			});
		    
		</script>
	</body>
</html>