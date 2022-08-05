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
		<link rel="stylesheet" href="/resources/css/cart.css">
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
					<div class="content_subject"><span>장바구니</span></div>
					<!-- 장바구니 리스트 -->
					<div class="content_middle_section"></div>
					<!-- 장바구니 가격 합계 -->
					<!-- cartInfo -->
					<div class="content_totalCount_section">
						<!-- 체크박스 전체 여부 -->
						<div class="all_check_input_div">
							<input type="checkbox" class="all_check_input input_size_20" checked="checked"><span class="all_chcek_span">전체선택</span>
						</div>
						<!-- 장바구니 리스트 정보 -->
						<table class="subject_table">
							<caption>표 제목 부분</caption>
							<tbody>
								<tr>
									<th class="td_width_1"></th>
									<th class="td_width_2"></th>
									<th class="td_width_3">상품명</th>
									<th class="td_width_4">가격</th>
									<th class="td_width_4">수량</th>
									<th class="td_width_4">합계</th>
									<th class="td_width_4">삭제</th>
								</tr>
							</tbody>
						</table>
						<table class="cart_table">
							<caption>표 내용 부분</caption>
							<tbody>
								<c:forEach items="${cartInfo}" var="ci">
									<tr>
										<td class="td_width_1 cart_info_td">   <!-- 상품 관련 정보 -->
											<input type="checkbox" class="individual_cart_checkbox input_size_20" checked="checked">
											<input type="hidden" class="individual_bookPrice_input" value="${ci.bookPrice}">
											<input type="hidden" class="individual_salePrice_input" value="${ci.salePrice}">
											<input type="hidden" class="individual_bookCount_input" value="${ci.bookCount}">
											<input type="hidden" class="individual_totalPrice_input" value="${ci.salePrice * ci.bookCount}">
											<input type="hidden" class="individual_point_input" value="${ci.point}">
											<input type="hidden" class="individual_totalPoint_input" value="${ci.totalPoint}">
											<input type="hidden" class="individual_bookId_input" value="${ci.bookId}">
										</td>
										<td class="td_width_2">   <!-- 상품당 이미지를 1개씩만 담도록 했기 때문에 이미지 리스트의 0번 데이터 저장 -->
											<div class="image_wrap" data-bookid="${ci.imageList[0].bookId}" data-path="${ci.imageList[0].uploadPath}" data-uuid="${ci.imageList[0].uuid}" data-filename="${ci.imageList[0].fileName}">
												<img>
											</div>
										</td>
										<td class="td_width_3">${ci.bookName}</td>
										<td class="td_width_4 price_td">
											정가 : <del><fmt:formatNumber value="${ci.bookPrice}" pattern="#,### 원" /></del><br>
											판매가 : <span class="red_color"><fmt:formatNumber value="${ci.salePrice}" pattern="#,### 원" /></span><br>
											마일리지 : <span class="green_color"><fmt:formatNumber value="${ci.point}" pattern="#,###" /></span>
										</td>
										<td class="td_width_4 table_text_align_center">
											<div class="table_text_align_center quantity_div">
												<input type="text" value="${ci.bookCount}" class="quantity_input">	
												<button class="quantity_btn plus_btn">+</button>
												<button class="quantity_btn minus_btn">-</button>
											</div>
											<!-- <a class="quantity_modify_btn">변경</a> -->
											<a class="quantity_modify_btn" data-cartId="${ci.cartId}">변경</a>
										</td>
										<td class="td_width_4 table_text_align_center">
											<fmt:formatNumber value="${ci.salePrice * ci.bookCount}" pattern="#,### 원" />
										</td>
										<td class="td_width_4 table_text_align_center">
											<%-- <button class="delete_btn" data-cartid="${ci.cartId}">삭제</button> --%>
											<button class="delete_btn" data-cartId="${ci.cartId}">삭제</button>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<table class="list_table">
						</table>
					</div>
					<!-- 가격 종합 -->
					<div class="content_total_section">
						<div class="total_wrap">
							<table>
								<tr>
									<td>
										<table>
											<tr>
												<td>총 상품 가격</td>
												<td>
													<span class="totalPrice_span">70000</span> 원
												</td>
											</tr>
											<tr>
												<td>배송비</td>
												<td>
													<span class="delivery_price">3000</span>원
												</td>
											</tr>									
											<tr>
												<td>총 주문 상품수</td>
												<td><span class="totalKind_span"></span>종 <span class="totalCount_span"></span>권</td>
											</tr>
										</table>
									</td>
									<td>
										<table>
											<tr>
												<td></td>
												<td></td>
											</tr>
										</table>							
									</td>
								</tr>
							</table>
							<div class="boundary_div">구분선</div>
							<table>
								<tr>
									<td>
										<table>
											<tbody>
												<tr>
													<td>
														<strong>총 결제 예상 금액</strong>
													</td>
													<td>
														<span class="finalTotalPrice_span">70000</span> 원
													</td>
												</tr>
											</tbody>
										</table>
									</td>
									<td>
										<table>
											<tbody>
												<tr>
													<td>
														<strong>총 적립 예상 마일리지</strong>
													</td>
													<td>
														<span class="totalPoint_span">70000</span> 원
													</td>
												</tr>
											</tbody>
										</table>
									</td>
								</tr>
							</table>
						</div>
						
						<!-- 수량 조정 form -->
						<form action="/cart/update" method="post" class="quantity_update_form">
							<input type="hidden" name="cartId" class="update_cartId">
							<input type="hidden" name="bookCount" class="update_bookCount">
							<input type="hidden" name="memberId" value="${member.memberId}">   <!-- 세션에 저장된 로그인 유저 id -->
						</form>
						
						<!-- 삭제 form -->
						<form action="/cart/delete" method="post" class="quantity_delete_form">
							<input type="hidden" name="cartId" class="delete_cartId">
							<input type="hidden" name="memberId" value="${member.memberId}">
						</form>
						
						<!-- 주문 form -->
						<form action="/order/${member.memberId}" method="get" class="order_form">
							
						</form>
					</div>
					<!-- 구매 버튼 영역 -->
					<div class="content_btn_section">
						<!-- <a>주문하기</a> -->
						<a class="order_btn">주문하기</a>
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
				
				/* 종합 정보 섹션 정보 */
				setTotalInfo();
				
				
				/* 이미지 삽입 */
				$(".image_wrap").each(function(i, obj){
					const bobj = $(obj);   //선택자 요소를 변수화
					
					if(bobj.data("bookid")){   //해당 요소의 data-bookid 속성에 값이 있다면 (즉, 등록된 이미지가 있다면)
						const uploadPath = bobj.data("path");   //파일 경로
						const uuid = bobj.data("uuid");   //파일 uuid
						const fileName = bobj.data("filename");   //파일명
						
						const fileCallPath = encodeURIComponent(uploadPath + "/s_" + uuid + "_" + fileName);   //썸네일 파일명 인코딩
						
						$(this).find("img").attr('src', '/display?fileName=' + fileCallPath);   //해당 요소에 등록된 섬네일 이미지 출력
					}
					else {   //등록된 이미지가 없다면
						$(this).find("img").attr('src', '/resources/img/No_Image.png');   //이미지 없음 표시
					}
				});
				
			});
			
			
			/* 총 주문 정보 세팅(배송비, 총 가격, 마일리지, 물품 수, 종류) */
			function setTotalInfo(){
				let totalPrice = 0;   // 총 가격
				let totalCount = 0;   // 총 개수
				let totalKind = 0;   // 총 종류
				let totalPoint = 0;   // 총 마일리지
				let deliveryPrice = 0;   // 배송비
				let finalTotalPrice = 0;   // 최종 가격(총 가격 + 배송비)
				
				$(".cart_info_td").each(function(index, element){   //반복문을 이용해 해당 선택자를 가진 모든 요소들을 하나씩 순회
					//element(<td> 객체)에 있는 체크박스('.individual_cart_checkbox' <input>)가 checked 상태일 때 ture이며 참이 된다는 의미
					// is() 메서드는 해당 메서드를 호출하는 객체가 is() 메서드의 인자로 지정한 선택자를 가지고 있으면 true를 반환
					if($(element).find(".individual_cart_checkbox").is(":checked") === true){	//체크여부
						// 총 가격
						totalPrice += parseInt($(element).find(".individual_totalPrice_input").val());
						// 총 갯수
						totalCount += parseInt($(element).find(".individual_bookCount_input").val());
						// 총 종류
						totalKind += 1;
						// 총 마일리지
						totalPoint += parseInt($(element).find(".individual_totalPoint_input").val());
					}
				});
				
				/* 배송비 결정 */
				if(totalPrice >= 30000){   //3만원 이상 구매 시 무료
					deliveryPrice = 0;
				} else if(totalPrice == 0){   //장바구니에 담긴 제품 없으면 0원
					deliveryPrice = 0;
				} else {   //3만원 이하 구매 시 배송비 3천원
					deliveryPrice = 3000;
				}
				
				/* 최종 가격 */
				finalTotalPrice = totalPrice + deliveryPrice;
				
				/* 값 삽입 - 통화 형식(#,###)으로 출력될 수 있도록 대상 변수들에 toLocaleString() 메서드를 호출 */
				// 총 가격
				$(".totalPrice_span").text(totalPrice.toLocaleString());
				// 총 갯수
				$(".totalCount_span").text(totalCount);
				// 총 종류
				$(".totalKind_span").text(totalKind);
				// 총 마일리지
				$(".totalPoint_span").text(totalPoint.toLocaleString());
				// 배송비
				$(".delivery_price").text(deliveryPrice);	
				// 최종 가격(총 가격 + 배송비)
				$(".finalTotalPrice_span").text(finalTotalPrice.toLocaleString());
			}
			
			
			/* 체크여부에따른 종합 정보 변화 */
			$(".individual_cart_checkbox").on("change", function(){
				/* 총 주문 정보 세팅(배송비, 총 가격, 마일리지, 물품 수, 종류) */
				setTotalInfo($(".cart_info_td"));
			});
			
			
			/* 체크박스 전체 선택 */
			$(".all_check_input").on("click", function(){
				/* 체크박스 체크/해제 */
				if($(".all_check_input").prop("checked")){
					$(".individual_cart_checkbox").prop("checked", true);   //prop 말고 attr 사용 시 개별 체크박스와 별도로 움직임
				} else{
					$(".individual_cart_checkbox").prop("checked", false);
				}
				/* prop() 메서드는 인자가 하나일 경우 호출한 객체가 인자로 부여한 속성의 값 프로퍼티로 가져오게 됩니다
				(attr() 메서드 또한 속성 값을 가져오지만 문자열의 형태로 가져오게 됩니다)
				위의 코드의 경우 체크박스 <input> 태그의 checked 속성의 값이 'checked '일 경우 true를 반환합니다
				(attr()로 호출을 하였다면 'checked'를 반환하게 됩니다)
				attr() 인자가 두 개인 경우 호출하는 객체를 대상으로 첫 번째 인자로 부여한 이름을 가진 속성의 값을 두 번째 인자 값으로 변경한다는 의미 */
				
				/* 총 주문 정보 세팅(배송비, 총 가격, 마일리지, 물품 수, 종류) */
				setTotalInfo($(".cart_info_td"));
			});
			
			
			/* 수량 증감 버튼 */
			$(".plus_btn").on("click", function(){   //증가 버튼
				let quantity = $(this).parent("div").find("input").val();
				$(this).parent("div").find("input").val(++quantity);
			});
			$(".minus_btn").on("click", function(){   //감소 버튼
				let quantity = $(this).parent("div").find("input").val();
				if(quantity > 1){
					$(this).parent("div").find("input").val(--quantity);		
				}
			});
			
			
			/* 수량 변경 버튼 */
			$(".quantity_modify_btn").on("click", function(){
				/* let cartId = $(this).data("cartid"); */   //해당 선택자 태그에 저장된 cartId 데이터 (cartid의 i를 대문자 I로 하면 에러 - data 속성은 대문자를 소문자로 바꿔서 인식함)
				let cartId = $(this).attr("data-cartId");   //위에 것으로 소문자 써도 되지만 그냥 attr로 data 속성 통째로 써서 값을 가져옴
				let bookCount = $(this).parent("td").find("input").val();   //해당 선택자의 부모 태그인 td 안에 input 태그의 값
				//가져온 값들을 서버로 보낼 form 태그 내의 hidden input 태그 값으로 적용 후 제출
				$(".update_cartId").val(cartId);
				$(".update_bookCount").val(bookCount);
				$(".quantity_update_form").submit();
			});
			
			
			/* 장바구니 삭제 버튼 */
			$(".delete_btn").on("click", function(e){
				e.preventDefault();
				/* const cartId = $(this).data("cartid"); */
				let cartId = $(this).attr("data-cartId");
				$(".delete_cartId").val(cartId);
				$(".quantity_delete_form").submit();
			});
			
			
			/* 주문 페이지 이동 */	
			$(".order_btn").on("click", function(){
				let form_contents ='';   //주문 form에 추가될 태그 작성할 변수
				let orderNumber = 0;   //주문 form에 추가될 각 태그의 name 값에 들어갈 인덱스 번호용
				
				$(".cart_info_td").each(function(index, element){   //선택된 상품들의 데이터를 하나씩 주문 form에 추가하기 위한 반복문
					if($(element).find(".individual_cart_checkbox").is(":checked") === true){	//체크여부 (체크된 상품인지)
						let bookId = $(element).find(".individual_bookId_input").val();   //상품 관련 정보 td 태그의 상품 id 값
						let bookCount = $(element).find(".individual_bookCount_input").val();   //상품 관련 정보 td 태그의 상품 개수 값
						
						//상품 id를 OrderPageDTO 객체의 List<OrderPageItemDTO> 에 넣기 위한 형태로 name 설정 후 form 태그에 추가할 변수에 적용
						let bookId_input = "<input name='orders[" + orderNumber + "].bookId' type='hidden' value='" + bookId + "'>";
						form_contents += bookId_input;
						
						//상품 개룰를 OrderPageDTO 객체의 List<OrderPageItemDTO> 에 넣기 위한 형태로 name 설정 후 form 태그에 추가할 변수에 적용
						let bookCount_input = "<input name='orders[" + orderNumber + "].bookCount' type='hidden' value='" + bookCount + "'>";
						form_contents += bookCount_input;
						
						orderNumber += 1;   //현재 인덱스에 상품 데이터를 모두 저장 후 인덱스 값 상승
					}
				});
				
				$(".order_form").html(form_contents);   //주문 form에 작성한 태그들 적용
				$(".order_form").submit();
			});
		    
		</script>
	</body>
</html>