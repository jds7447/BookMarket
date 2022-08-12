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
		<!-- 회원가입 페이지 css 파일 연결 -->
		<link rel="stylesheet" href="/resources/css/member/join.css">
		<!-- jquery 사용을 위해 CDN 방식으로 js 파일 연결 -->
		<script src="https://code.jquery.com/jquery-3.4.1.js"
			  	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
			  	crossorigin="anonymous"></script>
	</head>
	
	<body>
		<div class="wrapper">
			<!-- form태그에 기존에 있던 action속성은 지우고, id속성과 method속성을 추가 -->
			<form id="join_form" method="post">
				<!-- VO객체로 자동 변환을 위해 input 태그 속성 name의 값을 해당 input 태그에 입력할 값과 매칭되는 MemberVO 에서 정의한 변수 이름을 삽입 -->
				<div class="wrap">
					<div class="subjecet">
						<span>회원가입</span>
					</div>
					<div class="id_wrap">
						<div class="id_name">아이디</div>
						<div class="id_input_box">
							<input class="id_input" name="memberId">
						</div>
						<span class="final_id_ck">아이디를 입력해주세요.</span>   <!-- 유효성 검사를 위한 문구 추가 (공란) -->
						<!-- 아이디 중복 검사 문구 추가 -->
						<span class="id_input_re_1">사용 가능한 아이디입니다.</span>
						<span class="id_input_re_2">아이디가 이미 존재합니다.</span>
					</div>
					<div class="pw_wrap">
						<div class="pw_name">비밀번호</div>
						<div class="pw_input_box">
							<input type="password" class="pw_input" name="memberPw">
						</div>
						<span class="final_pw_ck">비밀번호를 입력해주세요.</span>   <!-- 유효성 검사를 위한 문구 추가 (공란) -->
					</div>
					<div class="pwck_wrap">
						<div class="pwck_name">비밀번호 확인</div>
						<div class="pwck_input_box">
							<input type="password" class="pwck_input">
						</div>
						<span class="final_pwck_ck">비밀번호 확인을 입력해주세요.</span>   <!-- 유효성 검사를 위한 문구 추가 (공란) -->
						<!-- 비밀번호, 비밀번호 확인 일치 검사 문구 추가 -->
						<span class="pwck_input_re_1">비밀번호가 일치합니다.</span>
                		<span class="pwck_input_re_2">비밀번호가 일치하지 않습니다.</span>
					</div>
					<div class="user_wrap">
						<div class="user_name">이름</div>
						<div class="user_input_box">
							<input class="user_input" name="memberName">
						</div>
						<span class="final_name_ck">이름을 입력해주세요.</span>   <!-- 유효성 검사를 위한 문구 추가 (공란) -->
					</div>
					<div class="mail_wrap">
						<div class="mail_name">이메일</div> 
						<div class="mail_input_box">
							<input class="mail_input" name="memberMail">
						</div>
						<span class="final_mail_ck">이메일을 입력해주세요.</span>   <!-- 유효성 검사를 위한 문구 추가 (공란) -->
						<span class="mail_input_box_warn"></span>   <!-- 이메일 형식이 올바르지 않을때 뜨는 문구 추가 -->
						<div class="mail_check_wrap">
							<div class="mail_check_input_box" id="mail_check_input_box_false">   <!-- 이메일 인증 추가하며 id 추가 -->
								<input class="mail_check_input" disabled="disabled">   <!-- 이메일 인증 추가하며 disabled(비활성) 추가 -->
							</div>
							<div class="mail_check_button">
								<span>인증번호 전송</span>
							</div>
							<div class="clearfix"></div>
							<span id="mail_check_input_box_warn"></span>   <!-- 인증번호의 일치 여부를 알려주는 경고글 역할 span 태그 추가 -->
						</div>
					</div>
					<div class="address_wrap">
						<div class="address_name">주소</div>   <!-- 주소 API로 찾은 주소가 들어갈 수 있게 모든 항목 읽기전용 속성 추가 -->
						<div class="address_input_1_wrap">
							<div class="address_input_1_box">
								<input class="address_input_1" name="memberAddr1" readonly="readonly">
							</div>							<!-- disabled (비활성)를 설정할 경우 데이터 자체가 전송이 되지 않음 -->
							<div class="address_button" onclick="execution_daum_address()">   <!-- 주소찾기 버튼(div태그)을 클릭할 시 추가한 메서드가 실행이 되도록 onclick속성을 추가 -->
								<span>주소 찾기</span>
							</div>
							<div class="clearfix"></div>
						</div>
						<div class ="address_input_2_wrap">
							<div class="address_input_2_box">
								<input class="address_input_2" name="memberAddr2" readonly="readonly">
							</div>
						</div>
						<div class ="address_input_3_wrap">
							<div class="address_input_3_box">
								<input class="address_input_3" name="memberAddr3" readonly="readonly">
							</div>
						</div>
						<span class="final_addr_ck">주소를 입력해주세요.</span>   <!-- 유효성 검사를 위한 문구 추가 (공란) -->
					</div>
					<div class="join_button_wrap">
						<input type="button" class="join_button" value="가입하기">
					</div>
				</div>
			</form>
		</div>
		
		<!-- '통합 로딩 방식'의 다음 주소록 API 사용을 위해 CDN 방식으로 js 코드 불러오기 -->
		<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		
		<script>
		
		var code = "";   //이메일 전송 후 서버에서 생성되어 전달 받은 인증번호 저장을 위한 코드
		
		/* 유효성 검사 통과유무 변수 */
		var idCheck = false;   // 아이디 공란 여부
		var idckCheck = false;   // 아이디 중복 검사
		var pwCheck = false;   // 비번 공란 여부
		var pwckCheck = false;   // 비번 확인 공란 여부
		var pwckcorCheck = false;   // 비번 확인 일치 확인 (위에 입력한 비번과 일치 여부)
		var nameCheck = false;   // 이름 공란 여부
		var mailCheck = false;   // 이메일 공란 여부
		var mailnumCheck = false;   // 이메일 인증번호 확인 (입력한 이메일로 보내진 인증번호와 입력한 인증번호 일치 여부)
		var addressCheck = false;   // 주소 공란 여부

		$(document).ready(function(){   //페이지 생성 시 실행
			
			/* '가입하기 버튼' 클릭하였을때 form태그에 속성 action(url 경로)이 추가되고, form태그가 서버에 제출이 된다는 의미 */
			//회원가입 버튼(회원가입 기능 작동)
			$(".join_button").click(function(){
				/* 유효성 검사를 위해 기존의 회원가입 버튼 클릭 시 기능 비활성화 */
				//$("#join_form").attr("action", "/member/join");
				//$("#join_form").submit();
				
				/* 각 항목에 입력된 값을 편하게 사용하기 위해 입력값 변수 선언 */
		        var id = $('.id_input').val();   // id 입력란
		        var pw = $('.pw_input').val();   // 비밀번호 입력란
		        var pwck = $('.pwck_input').val();   // 비밀번호 확인 입력란
		        var name = $('.user_input').val();   // 이름 입력란
		        var mail = $('.mail_input').val();   // 이메일 입력란
		        var addr = $('.address_input_3').val();   // 주소 입력란
				
				/* 아이디 유효성검사 */
		        if(id == ""){   //아이디 입력란 공란
		            $('.final_id_ck').css('display','block');   // 아이디 입력해주세요 문구 블록 형식으로 보이게
		            idCheck = false;   //아이디 공란 여부 유효성 X
		        }else{   //아이디 입력
		            $('.final_id_ck').css('display', 'none');   // 아이디 입력해주세요 문구 다시 안 보이게
		            idCheck = true;   //아이디 공란 여부 유효성 O
		        }
		        
		        /* 비밀번호 유효성 검사 */
		        if(pw == ""){
		            $('.final_pw_ck').css('display','block');
		            pwCheck = false;
		        }else{
		            $('.final_pw_ck').css('display', 'none');
		            pwCheck = true;
		        }
		        
		        /* 비밀번호 확인 유효성 검사 */
		        if(pwck == ""){
		            $('.final_pwck_ck').css('display','block');
		            pwckCheck = false;
		        }else{
		            $('.final_pwck_ck').css('display', 'none');
		            pwckCheck = true;
		        }
		        
		        /* 이름 유효성 검사 */
		        if(name == ""){
		            $('.final_name_ck').css('display','block');
		            nameCheck = false;
		        }else{
		            $('.final_name_ck').css('display', 'none');
		            nameCheck = true;
		        }
		        
		        /* 이메일 유효성 검사 */
		        if(mail == ""){
		            $('.final_mail_ck').css('display','block');
		            mailCheck = false;
		        }else{
		            $('.final_mail_ck').css('display', 'none');
		            mailCheck = true;
		        }
		        
		        /* 주소 유효성 검사 */
		        if(addr == ""){
		            $('.final_addr_ck').css('display','block');
		            addressCheck = false;
		        }else{
		            $('.final_addr_ck').css('display', 'none');
		            addressCheck = true;
		        }
		        
		        /* 최종 유효성 검사 (위에 선언한 유효성 검사 통과유무 변수 모두가 true인지 판별하여 하나라도 false이면 회원 가입 불가) */
		        if(idCheck && idckCheck && pwCheck && pwckCheck && pwckcorCheck && nameCheck 
		        																	&& mailCheck && mailnumCheck && addressCheck){
		        	/* 기존의 회원가입 버튼 클릭 시 기능(작성한 데이터로 회원 가입)이 작성한 데이터의 최종 유효성 검사를 통과해야만 수행됨 */
					$("#join_form").attr("action", "/member/join");
					$("#join_form").submit();
		        }
		        
		        /* 위의 최종 유효성 검사를 통과하지 못했을 때, 감싸고 있는 메서드(join_button click)가 정상 종료되지 못할 경우를 대비 */
		        return false;
			});
		});
		
		
		//아이디 중복검사 (input 태그(class="id_input")에 변화가 있을 때마다 실행)
		$('.id_input').on("propertychange change keyup paste input", function(){
			var memberId = $('.id_input').val();   // .id_input에 입력되는 값
			var data = {memberId : memberId}   // '컨트롤에 넘길 데이터 이름' : '데이터(.id_input에 입력되는 값)'
			
			$.ajax({   //특정 부문의 데이터만 동적으로 표현하기 위해 페이지 비동기식으로 서버와 데이터를 주고 받는 기술
				type : "post",   //전송 방식
				url : "/member/memberIdChk",   //전송 받을 url
				data : data,   //전송 할 데이터
				success : function(result){   //데이터 전송에 성공 후 서버(컨트롤러)에서 반환 값이 성공적으로 넘어오는 경우
					// console.log("성공 여부" + result);
					if(result != 'fail'){   //중복 아이디 없을 경우
						$('.id_input_re_1').css("display","inline-block");   //사용 가능한 아이디 문구 보이게
						$('.id_input_re_2').css("display", "none");   //중복 아이디 문구 안 보이게
						idckCheck = true;   //아이디 중복 유효성 O
					}
					else {   //중복 아이디 존재할 경우
						$('.id_input_re_2').css("display","inline-block");   //중복 아이디 문구 보이게
						$('.id_input_re_1').css("display", "none");   //사용 가능한 아이디 문구 안 보이게
						idckCheck = false;   //아이디 중복 유효성 X
					}
				}
			});   // ajax 종료
		});   //아이디 중복검사 종료
		
		
		/* 인증번호 이메일 전송 */
		/* 이메일 입력란에 이메일을 입력 후 [인증번호 전송] 버튼을 클릭하면 작동하는 메서드를 추가
		해당 메서드는 controller로 작성한 이메일 주소를 보내고, 인증번호 생성하여 전달받은 이메일로 전송한 뒤 전송된 인증번호를 뷰(회원가입페이지)로 다시 반환
		controller에 요청할 때 화면이 전환되면 안 되기 때문에 ajax를 사용 */
		$(".mail_check_button").click(function(){   //class명이 "mail_check_button" input 태그를 클릭하였을 때 실행
			var email = $(".mail_input").val();   // 입력한 이메일
			var cehckBox = $(".mail_check_input");   // 인증번호 입력란 (인증번호 입력란 태그의 disabled 속성 값 변경을 위해)
		    var boxWrap = $(".mail_check_input_box");   // 인증번호 입력란 박스 (인증번호 입력란의 배경색 변경을 위해)
		    var warnMsg = $(".mail_input_box_warn");    // 이메일 입력 경고글 (입력한 이메일이 정규표현식 형식에 맞지 않을 시)
		    
		    /* 이메일 형식 유효성 검사 */
		    if(mailFormCheck(email)){
		        warnMsg.html("이메일이 전송 되었습니다. 이메일을 확인해주세요.");
		        warnMsg.css("display", "inline-block");
		    } else {
		        warnMsg.html("올바르지 못한 이메일 형식입니다.");
		        warnMsg.css("display", "inline-block");
		        return false;
		    }
			
			$.ajax({
		        type : "GET",   //전송 방식
		        url : "mailCheck?email=" + email,   //전송 받을 url과 입력한 email 쿼리 스트링
		        success : function(data){   //전송지(url)에서 응답 성공 시
		        	//console.log("data : " + data);   //확인용
		        	cehckBox.attr("disabled", false);   //해당 요소의 "disabled" 속성을 false 로 설정
		        	boxWrap.attr("id", "mail_check_input_box_true");   //해당 요소의 id 속성 값 설정 (기본 false로 배경이 회색이지만 true로 바꿔 흰색으로)
		        	code = data;   //서버에서 반환 받은 인증번호를 code 변수에 저장
		        }
		    });   // ajax 종료
		});   //인증번호 이메일 전송 종료
		
		
		/* 인증번호 비교 */
		$(".mail_check_input").blur(function(){   //인증번호 입력란에 데이터를 입력한 뒤 마우스로 다른 곳을 클릭 시에 실행
			var inputCode = $(".mail_check_input").val();   //사용자가 입력하는 인증번호   
		    var checkResult = $("#mail_check_input_box_warn");    //추가한 span태그 인증번호 비교 결과
		    
		    if(inputCode == code){   //사용자가 입력한 인증번호와 서버에서 응답한 인증번호가 일치할 경우
		        checkResult.html("인증번호가 일치합니다.");   //해당 요소에 HTML 텍스트 추가
		        checkResult.attr("class", "correct");   //해당 요소의 클래스 속성 값 설정
		        mailnumCheck = true;   //인증번호 유효성 O
		    }
		    else {   // 일치하지 않을 경우
		        checkResult.html("인증번호를 다시 확인해주세요.");
		        checkResult.attr("class", "incorrect");
		        mailnumCheck = false;   //인증번호 유효성 X
		    }
		});   //인증번호 비교 종료
		
		
		/* 다음 주소 API 연동 ( https://postcode.map.daum.net/guide ) */
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
	                    
	                    /* 현 예제 코드의 경우는 사용자가 도로명주소를 선택하였을 때 추가적으로 입력되어야 할 정보를 참고 항목 필드 입력되도록 되어 있다
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
	                $(".address_input_1").val(data.zonecode);   // 신규 병경 코드
		            //$("[name=memberAddr1]").val(data.zonecode);   // 신규 병경 코드 대체가능
		            $(".address_input_2").val(addr);   // 신규 병경 코드
		            //$("[name=memberAddr2]").val(addr);   // 신규 병경 코드 대체가능
		            
	                // 커서를 상세주소 필드로 이동한다.
	                //document.getElementById("sample6_detailAddress").focus();   // 기존 예제 코드
	                
					// 상세주소 입력란 읽기전용 속성 비활성으로 변경 및 커서를 상세주소 필드로 이동한다
					//$(".address_input_3").attr("readonly", "false");   // 신규 병경 코드
					/* HTML 버전이 변경 되며 readonly 속성은 readonly="readonly" 만 되기 때문에 false 동작을 안함, 따라서 아예 속성 자체를 없앰 */
					$(".address_input_3").removeAttr("readonly");
					$(".address_input_3").focus();   // 신규 병경 코드
		        }   //팝업에서 검색결과 항목을 클릭했을때 실행할 코드 종료
		    }).open();   //주소를 검색하는 팝업창을 띄우는 코드 종료
		}   //다음 주소 API 연동 종료
		
		
		/* 비밀번호 확인 일치 유효성 검사 (input 태그(class="pwck_input")에 변화가 있을 때마다 실행) */
		$('.pwck_input').on("propertychange change keyup paste input", function(){
			var pw = $('.pw_input').val();   //비밀번호 입력란 변수
		    var pwck = $('.pwck_input').val();   //비밀번호 확인 입력란 변수
		    $('.final_pwck_ck').css('display', 'none');   //'비밀번호 확인을 입력해주세요'(final_pwck_ck) 경고글 안 보이게
		    
		    if(pw == pwck){   //비밀번호 일치
		        $('.pwck_input_re_1').css('display','block');
		        $('.pwck_input_re_2').css('display','none');
		        pwckcorCheck = true;
		    }else{   //불일치
		        $('.pwck_input_re_1').css('display','none');
		        $('.pwck_input_re_2').css('display','block');
		        pwckcorCheck = false;
		    } 
		});   //비밀번호 확인 일치 유효성 검사 종료
		
		/* 입력 이메일 형식 유효성 검사 */
		function mailFormCheck(email){
			/* 이메일 형식 정규 표현식 */
				// /^ : 정규 표현식 시작
				// () : 괄호 안 내용들을 그룹으로 처리
				// [문자문자] : 문자 범위의 선택을 표현하며 문자 ~ 문자 아 아닌 문자, 문자 를 의미 (예 [ay] 는 a 와 y 중에 하나)
				// \w : word 를 표현하며 알파벳 + 숫자 + _ 중의 한 문자
				// 문자-문자 : 범위를 표현하며 문자 ~ 문자 사이의 문자를 의미 (범위 표현 문자도 포함, 예 a-z 는 a부터 z까지의 문자를 표현)
				// 문자+ : 반복여부를 표현하며 문자가 한번 이상 반복됨을 의미
				// (?:문자) : ?: 다음에 오는 문자가 그룹들의 집합에 대한 예외를 표현하며 그룹 집합으로 관리되지 않음을 의미
				// \. : 표현식 문자 . 을 일반 문자로 사용하기 위해 백슬래쉬(\) 사용 (이스케이프 문자)
				// 문자* : 반복여부를 표현하며 문자가 0번 또는 그 이상 반복됨을 의미 (없거나 1회 이상 반복)
				// 문자{n, m} : 문자가 최소 n번 이상 최대 m번 이하 만큼 반복
				// 문자{n} : 문자가 n번 반복
				// 문자? : 존재여부를 표현하며 문자가 존재할 수도, 존재하지 않을 수도 있음을 의미 (없거나 1회)
				// $/ : 정규표현식 끝
				// i : Ignore case 를 표현하며 대상 문자열에 대해서 대/소문자를 식별하지 않는 것을 의미
				// 해석 : ab_12  [.er_57]	  @[hk_98.]		t   n_65		. abc		   [.ab]
				//			    [없을수도]	   [없을수도]    필수 {0~66 반복}     {2~6 반복}  [없을수도{2회반복}]  대소문자 구별 없음
			var form = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
				
			/* test() 메서드 : 주어진 문자열이 정규 표현식을 만족하는지 판별하고, 그 여부를 true 또는 false로 반환 */
			return form.test(email);
		}
		
		</script>
	</body>
</html>