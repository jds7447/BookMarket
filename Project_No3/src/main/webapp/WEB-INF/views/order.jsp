<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- JSTL을 사용하기 위해 태그라이브러리 코드 추가 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" href="/resources/css/order.css">
		<!--  jquery를 사용할 것이기 때문에 jquery url 코드 추가 -->
		<script src="https://code.jquery.com/jquery-3.4.1.js"
  				integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  				crossorigin="anonymous"></script>
  		<!-- 다음 주소록 API -->
		<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
		                        <a href="/member/logout.do">로그아웃</a>   <!-- 특정 화면 이동 없이 현 페이지가 새로고침 되는 비동기 방식 구현 -->
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
					<div class="content_subject"><span>장바구니</span></div>
					<div class="content_main">
						<!-- 회원 정보 -->
						<div class="member_info_div">
							<table class="table_text_align_center memberInfo_table">
								<tbody>
									<tr>
										<th style="width: 25%;">주문자</th>
										<td style="width: *">${memberInfo.memberName} | ${memberInfo.memberMail}</td>
									</tr>
								</tbody>
							</table>
						</div>
						<!-- 배송지 정보 -->
						<div class="addressInfo_div">
							<div class="addressInfo_button_div">
								<button class="address_btn address_btn_1" onclick="showAdress('1')" style="background-color: #3c3838;">주문자 정보 주소록</button>
								<button class="address_btn address_btn_2" onclick="showAdress('2')">직접 입력</button>
							</div>
							<div class="addressInfo_input_div_wrap">
								<div class="addressInfo_input_div addressInfo_input_div_1" style="display: block">   <!-- address_btn_1 과 연동 - DB에 저장된 회원 주소 -->
									<table>
										<colgroup>
											<col width="25%">
											<col width="*">
										</colgroup>
										<tbody>
											<tr>
												<th>이름</th>
												<td>
													${memberInfo.memberName}
												</td>
											</tr>
											<tr>
												<th>주소</th>
												<td>
													${memberInfo.memberAddr1} ${memberInfo.memberAddr2}<br>${memberInfo.memberAddr3}
													<%-- '사용자 정보 주소록' 선택했을 때 가져올 데이터 --%>
													<input class="selectAddress" value="T" type="hidden">   <%-- 기존 주소 방식 --%>
													<input class="addressee_input" value="${memberInfo.memberName}" type="hidden">
													<input class="address1_input" type="hidden" value="${memberInfo.memberAddr1}">
													<input class="address2_input" type="hidden" value="${memberInfo.memberAddr2}">
													<input class="address3_input" type="hidden" value="${memberInfo.memberAddr3}">
												</td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="addressInfo_input_div addressInfo_input_div_2">   <!-- address_btn_1 과 연동 - 주소록 AIP를 이용한 직접 입력 -->
									<table>
										<colgroup>
											<col width="25%">
											<col width="*">
										</colgroup>
										<tbody>
											<tr>
												<th>이름</th>
												<td>
													<input class="addressee_input">
												</td>
											</tr>
											<tr>
												<th>주소</th>
												<td>
													<input class="selectAddress" value="F" type="hidden">   <%-- 주소 직접 입력 방식 --%>
													<input class="address1_input" readonly="readonly"> <a class="address_search_btn" onclick="execution_daum_address()">주소 찾기</a><br>
													<input class="address2_input" readonly="readonly"><br>
													<input class="address3_input" readonly="readonly">
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
						<!-- 상품 정보 -->
						<div class="orderGoods_div">
							<!-- 상품 종류 -->
							<div class="goods_kind_div">
								주문상품 <span class="goods_kind_div_kind"></span>종 <span class="goods_kind_div_count"></span>개
							</div>
							<!-- 상품 테이블 -->
							<table class="goods_subject_table">
								<colgroup>
									<col width="15%">
									<col width="45%">
									<col width="40%">
								</colgroup>
								<tbody>
									<tr>
										<th>이미지</th>
										<th>상품 정보</th>
										<th>판매가</th>
									</tr>
								</tbody>
							</table>
							<table class="goods_table">
								<colgroup>
									<col width="15%">
									<col width="45%">
									<col width="40%">
								</colgroup>					
								<tbody>
									<c:forEach items="${orderList}" var="ol">
										<tr>
											<td>
												<div class="image_wrap" data-bookid="${ol.imageList[0].bookId}" data-path="${ol.imageList[0].uploadPath}" data-uuid="${ol.imageList[0].uuid}" data-filename="${ol.imageList[0].fileName}">
													<img>
												</div>
											</td>
											<td>${ol.bookName}</td>
											<td class="goods_table_price_td">
												<fmt:formatNumber value="${ol.salePrice}" pattern="#,### 원" /> | 수량 ${ol.bookCount}개
												<br><fmt:formatNumber value="${ol.totalPrice}" pattern="#,### 원" />
												<br>[<fmt:formatNumber value="${ol.totalPoint}" pattern="#,### 원" />P]
												<input type="hidden" class="individual_bookPrice_input" value="${ol.bookPrice}">
												<input type="hidden" class="individual_salePrice_input" value="${ol.salePrice}">
												<input type="hidden" class="individual_bookCount_input" value="${ol.bookCount}">
												<input type="hidden" class="individual_totalPrice_input" value="${ol.salePrice * ol.bookCount}">
												<input type="hidden" class="individual_point_input" value="${ol.point}">
												<input type="hidden" class="individual_totalPoint_input" value="${ol.totalPoint}">
												<input type="hidden" class="individual_bookId_input" value="${ol.bookId}">
											</td>
										</tr>							
									</c:forEach>
					
								</tbody>
							</table>
						</div>
						<!-- 포인트 정보 -->
						<div class="point_div">
							<div class="point_div_subject">포인트 사용</div>
							<table class="point_table">
								<colgroup>
									<col width="25%">
									<col width="*">
								</colgroup>
								<tbody>
									<tr>
										<th>포인트 사용</th>
										<td>
											${memberInfo.point} | <input class="order_point_input" value="0">원 
											<a class="order_point_input_btn order_point_input_btn_N" data-state="N">모두사용</a>
											<a class="order_point_input_btn order_point_input_btn_Y" data-state="Y" style="display: none;">사용취소</a>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<!-- 주문 종합 정보 -->
						<div class="total_info_div">
							<!-- 가격 종합 정보 -->
							<div class="total_info_price_div">
								<ul>
									<li>
										<span class="price_span_label">상품 금액</span>
										<span class="totalPrice_span">100000</span>원
									</li>
									<li>
										<span class="price_span_label">배송비</span>
										<span class="delivery_price_span">100000</span>원
									</li>
																							<li>
										<span class="price_span_label">할인금액</span>
										<span class="usePoint_span">100000</span>원
									</li>
									<li class="price_total_li">
										<strong class="price_span_label total_price_label">최종 결제 금액</strong>
										<strong class="strong_red">
											<span class="total_price_red finalTotalPrice_span">
												1500000
											</span>원
										</strong>
									</li>
									<li class="point_li">
										<span class="price_span_label">적립예정 포인트</span>
										<span class="totalPoint_span">7960원</span>
									</li>
								</ul>
							</div>
							<!-- 버튼 영역 -->
							<div class="total_info_btn_div">
								<a class="order_btn">결제하기</a>
							</div>
						</div>
					</div>
				</div>
				
				<!-- 주문 요청 form -->
				<form class="order_form" action="/order" method="post">
					<!-- 주문자 회원번호 -->
					<input name="memberId" value="${memberInfo.memberId}" type="hidden">
					<!-- 주소록 & 받는이-->
					<input name="addressee" type="hidden">
					<input name="memberAddr1" type="hidden">
					<input name="memberAddr2" type="hidden">
					<input name="memberAddr3" type="hidden">
					<!-- 사용 포인트 -->
					<input name="usePoint" type="hidden">
					<!-- 상품 정보 -->
				</form>
				
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
				
				/* 총 주문 정보 (배송비, 총 가격, 마일리지, 물품 수, 종류) 최신화 */
				setTotalInfo();
				
				
				/* 이미지 삽입 */
				$(".image_wrap").each(function(i, obj){
					const bobj = $(obj);
					
					if(bobj.data("bookid")){   //상품 이미지 있으면
						const uploadPath = bobj.data("path");
						const uuid = bobj.data("uuid");
						const fileName = bobj.data("filename");
						
						const fileCallPath = encodeURIComponent(uploadPath + "/s_" + uuid + "_" + fileName);   //썸네일 이미지
						
						$(this).find("img").attr('src', '/display?fileName=' + fileCallPath);
					}
					else {   //상품 이미지 없으면
						$(this).find("img").attr('src', '/resources/img/No_Image.png');
					}
				});
				
			});
		
		
			/* 주소입력란 버튼 동작(숨김, 등장) */
			function showAdress(className){
				/* 컨텐츠 동작 */
				// 모두 숨기기
				$(".addressInfo_input_div").css('display', 'none');
				// 컨텐츠 보이기
				$(".addressInfo_input_div_" + className).css('display', 'block');
				
				/* 버튼 색상 변경 */
				// 모든 색상 동일
				$(".address_btn").css('backgroundColor', '#555');
				// 지정 색상 변경
				$(".address_btn_"+className).css('backgroundColor', '#3c3838');
				
				/* selectAddress Type - T/F ==> 회원이 선택한 값(주소 방식)을 T로 만드는 작업 */
				/* 모든 selectAddress F만들기 */
					$(".addressInfo_input_div").each(function(i, obj){
						$(obj).find(".selectAddress").val("F");
					});
				/* 선택한 selectAdress T만들기 */
					$(".addressInfo_input_div_" + className).find(".selectAddress").val("T");
			}
			
			
			/* 다음 주소록 API 연동 ( https://postcode.map.daum.net/guide ) */
			function execution_daum_address(){
				/* 주소를 검색하는 팝업창을 띄우는 코드를 추가 (다음 주소 API 홈페이지에 있다) */
				new daum.Postcode({
			        oncomplete: function(data) {   //data는 사용자가 선택한 주소 정보를 담고 있는 객체
			        	// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분
			        	
			            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
		                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		                var addr = '';   // 주소 변수
		                var extraAddr = '';   // 참고항목 변수
		 
		                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
		                if (data.userSelectedType === 'R') {   // 사용자가 도로명 주소를 선택했을 경우
		                    addr = data.roadAddress;
		                } else {   // 사용자가 지번 주소를 선택했을 경우(J)
		                    addr = data.jibunAddress;
		                }
		 
		                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
		                if(data.userSelectedType === 'R'){
		                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
		                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
		                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
		                        extraAddr += data.bname;
		                    }
		                    // 건물명이 있고, 공동주택일 경우 추가한다.
		                    if(data.buildingName !== '' && data.apartment === 'Y'){
		                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                    }
		                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
		                    if(extraAddr !== ''){
		                        extraAddr = ' (' + extraAddr + ')';
		                    }
		                    // 조합된 참고항목을 해당 필드에 넣는다.
		                    //document.getElementById("sample6_extraAddress").value = extraAddr;   // 기존 예제 코드
		                    
		                    /* 기존 예제 코드의 경우는 사용자가 도로명주소를 선택하였을 때 추가적으로 입력되어야 할 정보를 참고 항목 필드 입력되도록 되어 있다
		                    하지만 지금은 참고항목 필드를 따로 만들어 놓지 않아서 주소가 입력되는 필드에 추가 항목 필드에 입력될 정보가 함께 입력되도록 만들 것 */
		                 	// 주소변수 문자열과 참고항목 문자열 합치기
		                    addr += extraAddr;   // 신규 병경 코드
		                
		                } else {
		                    //document.getElementById("sample6_extraAddress").value = '';   // 기존 예제 코드
		                    
		                    //기존의 코드는 추가 항목 필드에 아무것도 입력되지 않게 하기 위한 코드이므로 현재는 추가항목 필드가 따로 없기 때문에 제거
		                	addr += ' ';   // 신규 병경 코드
		                }
		 
		                // 우편번호와 주소 정보를 해당 필드에 넣는다.
		                //document.getElementById('sample6_postcode').value = data.zonecode;   // 기존 예제 코드
		                //document.getElementById("sample6_address").value = addr;   // 기존 예제 코드
		                
		                //제이쿼리를 사용 중이기 때문에 제이쿼리에 맞는 코드로 수정
		                $(".address1_input").val(data.zonecode);   // 신규 병경 코드
			            //$("[name=memberAddr1]").val(data.zonecode);   // 신규 병경 코드 대체가능
			            $(".address2_input").val(addr);   // 신규 병경 코드
			            //$("[name=memberAddr2]").val(addr);   // 신규 병경 코드 대체가능
			            
		                // 커서를 상세주소 필드로 이동한다.
		                //document.getElementById("sample6_detailAddress").focus();   // 기존 예제 코드
		                
						// 상세주소 입력란 읽기전용 속성 비활성으로 변경 및 커서를 상세주소 필드로 이동한다
						//$(".address_input_3").attr("readonly", "false");   // 신규 병경 코드
						/* HTML 버전이 변경 되며 readonly 속성은 readonly="readonly" 만 되기 때문에 false 동작을 안함, 따라서 아예 속성 자체를 없앰 */
						$(".address3_input").removeAttr("readonly");
						$(".address3_input").focus();   // 신규 병경 코드
			        }   //팝업에서 검색결과 항목을 클릭했을때 실행할 코드 종료
			    }).open();   //주소를 검색하는 팝업창을 띄우는 코드 종료
			}   //다음 주소록 API 연동 종료
			
			
			/* 포인트 입력 */
			//0 이상 & 최대 포인트 수 이하
			$(".order_point_input").on("propertychange change keyup paste input", function(){   //포인트 사용 입력란에 변화가 감지될 때 실행
				const maxPoint = parseInt('${memberInfo.point}');   //DB에서 가져온 회원의 포인트(String)을 정수(int)로 바꿔서 변수 저장 (사용 가능 포인트)
				console.log("hihi");
				let totalPrice = $(".finalTotalPrice_span").val();
				console.log(totalPrice);
				console.log("hihi");
				
				let inputValue = parseInt($(this).val());   //사용자가 포인트 사용 입력란에 작성한 값 저장
				
				/* 0보다 작은 값을 입력할 경우에는 0이 입력되도록, '사용 가능 포인트'보다 많은 값을 입력할 경우 '사용 가능 포인트' 최댓값이 입력되도록 */
				if(inputValue < 0){
					$(this).val(0);
				} else if(inputValue > maxPoint){
					if(maxPoint > totalPrice){
						$(this).val(totalPrice);
					}
					else{
						$(this).val(maxPoint);	
					}
				}
				
				/* 포인트 사용에 따른 주문 정보 최신화 */
				setTotalInfo();
			});
			
			/* 포인트 모두사용 및 사용취소 버튼 
			 * Y: 모두사용 상태 / N : 사용취소 상태 */
			$(".order_point_input_btn").on("click", function(){
				const maxPoint = parseInt('${memberInfo.point}');   //DB에서 가져온 회원의 포인트(String)을 정수(int)로 바꿔서 변수 저장 (사용 가능 포인트)
				
				let state = $(this).data("state");   //눌린 버튼 태그에 심어진 data 값 가져오기 (Y: 사용취소 누름 / N : 모두사용 누름)
				
				if(state == 'N'){
					/* console.log("n동작"); */
					/* 모두사용 */
					//값 변경
					$(".order_point_input").val(maxPoint);
					//글 변경
					$(".order_point_input_btn_Y").css("display", "inline-block");
					$(".order_point_input_btn_N").css("display", "none");
				} else if(state == 'Y'){
					/* console.log("y동작"); */
					/* 취소 */
					//값 변경
					$(".order_point_input").val(0);
					//글 변경
					$(".order_point_input_btn_Y").css("display", "none");
					$(".order_point_input_btn_N").css("display", "inline-block");		
				}
				
				/* 포인트 사용에 따른 주문 정보 최신화 */
				setTotalInfo();
			});
			
			
			/* 총 주문 정보 세팅(배송비, 총 가격, 마일리지, 물품 수, 종류) 함수 */
			function setTotalInfo(){
				/* 변수 초기화 */
				let totalPrice = 0;   // 총 가격
				let totalCount = 0;   // 총 갯수
				let totalKind = 0;   // 총 종류
				let totalPoint = 0;   // 총 마일리지 (획득 포인트)
				let deliveryPrice = 0;   // 배송비
				let usePoint = 0;   // 사용 포인트(할인가격)
				let finalTotalPrice = 0;   // 최종 가격(총 가격 + 배송비)
				
				/* 반복문으로 각 상품의 '총 가격', '총 개수', '총 종류', '총 (받을) 마일리지' 값 계산 및 적용 */
				$(".goods_table_price_td").each(function(index, element){
					// 총 가격
					totalPrice += parseInt($(element).find(".individual_totalPrice_input").val());
					// 총 갯수
					totalCount += parseInt($(element).find(".individual_bookCount_input").val());
					// 총 종류
					totalKind += 1;
					// 총 마일리지
					totalPoint += parseInt($(element).find(".individual_totalPoint_input").val());
				});
				
				/* 배송비 결정 */
				if(totalPrice >= 30000){
					deliveryPrice = 0;
				} else if(totalPrice == 0){
					deliveryPrice = 0;
				} else {
					deliveryPrice = 3000;	
				}
				
				/* 최종 가격 계산 */
				finalTotalPrice = totalPrice + deliveryPrice;
				
				/* 사용된 포인트 */
				usePoint = $(".order_point_input").val();
				
				/* 사용된 포인트를 제외한 최종 가격 */
				finalTotalPrice = totalPrice - usePoint;
				
				/* 포인트 사용에 따른 총 마일리지(획득 포인트) 변화 - 실제로 결제하는 가격에만 포인트 적용 (포인트 사용으로 감소된 가격은 포인트 적립 제외) */
				if(usePoint !== 0) {
					totalPoint = parseInt(finalTotalPrice * 0.05);
				}
				
				/* 값 삽입 */
				$(".totalPrice_span").text(totalPrice.toLocaleString());   // 총 가격
				$(".goods_kind_div_count").text(totalCount);   // 총 갯수
				$(".goods_kind_div_kind").text(totalKind);   // 총 종류
				$(".totalPoint_span").text(totalPoint.toLocaleString());   // 총 마일리지
				$(".delivery_price_span").text(deliveryPrice.toLocaleString());	  // 배송비
				$(".finalTotalPrice_span").text(finalTotalPrice.toLocaleString());   // 최종 가격(총 가격 + 배송비)
				$(".usePoint_span").text(usePoint.toLocaleString());   // 할인가(사용 포인트)
			}   /* 총 주문 정보 세팅(배송비, 총 가격, 마일리지, 물품 수, 종류) 함수 종료 */
			
			
			/* 주문 요청 - 결제하기 버튼 클릭 시 */
			$(".order_btn").on("click", function(){
				/* 입력된 주소 정보 & 받는이 값을 가져와 서버로 보낼 form 의 hidden input 태그에 셋팅 */
				$(".addressInfo_input_div").each(function(i, obj){
					if($(obj).find(".selectAddress").val() === 'T'){
						$("input[name='addressee']").val($(obj).find(".addressee_input").val());
						$("input[name='memberAddr1']").val($(obj).find(".address1_input").val());
						$("input[name='memberAddr2']").val($(obj).find(".address2_input").val());
						$("input[name='memberAddr3']").val($(obj).find(".address3_input").val());
					}
				});
				
				/* 사용 포인트 값을 가져와 서버로 보낼 form 의 hidden input 태그에 셋팅 */
				$("input[name='usePoint']").val($(".order_point_input").val());
				
				/* 상품정보 값을 가져와 필요한 hidden input 태그를 만들어 서버로 보낼 form에 추가 */
				let form_contents = ''; 
				$(".goods_table_price_td").each(function(index, element){
					let bookId = $(element).find(".individual_bookId_input").val();
					let bookCount = $(element).find(".individual_bookCount_input").val();
					let bookId_input = "<input name='orders[" + index + "].bookId' type='hidden' value='" + bookId + "'>";
					form_contents += bookId_input;
					let bookCount_input = "<input name='orders[" + index + "].bookCount' type='hidden' value='" + bookCount + "'>";
					form_contents += bookCount_input;
				});	
				$(".order_form").append(form_contents);
				
				/* 서버 전송 */
				$(".order_form").submit();
			});
		    
		</script>
	</body>
</html>