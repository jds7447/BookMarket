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
		<link rel="stylesheet" href="/resources/css/member/login.css">
		<!--  jquery를 사용할 것이기 때문에 jquery url 코드 추가 -->
		<script src="https://code.jquery.com/jquery-3.4.1.js"
  				integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  				crossorigin="anonymous"></script>
	</head>
	
	<body>
		<div class="wrapper">
			<div class="wrap">
				<form id="login_form" method="post">   <!-- 로그인 정보 검사를 위해 id, 비번 서버로 넘기기 위한 form 태그 추가 -->
					<div class="logo_wrap">
						<!-- <a href="/main"><span>Book Market</span></a> -->
						<a href="/main"><img src="/resources/img/Logo2.png"></a>
					</div>
					<div class="login_wrap"> 
						<div class="id_wrap">
							<div class="id_input_box">
								<input class="id_input" name="memberId" placeholder="아이디">   <!-- id와 비번을 VO객체에 넣어 전달하기 위해 -->
							</div>
						</div>
						<div class="pw_wrap">
							<div class="pw_input_box">
								<input type="password" class="pw_iput" name="memberPw" placeholder="비밀번호">   <!-- VO객체의 멤버변수 명과 같은 이름으로 name 설정 -->
							</div>
						</div>
						
						<!-- 서버로부터 받은 result 변수에 담긴 데이터를 활용하여 로그인에 실패하였다는 경고 문구 -->
						<c:if test = "${result == 0 }">
							<div class="login_warn">사용자 ID 또는 비밀번호를 잘못 입력하셨습니다.</div>
						</c:if>
						
						<div class="login_button_wrap">
							<input type="button" class="login_button" value="로그인">
							<br>
							<a href="/member/join" class="join_button">회원가입</a>
						</div>			
					</div>
    			</form>
			</div>
		</div>
		
		<script>
		 
		    /* 로그인 버튼 클릭 메서드 */
		    $(".login_button").click(function(){
		        //alert("로그인 버튼 작동");   //시험용 알림 메시지
		        
		    	/* 로그인 메서드 서버 요청 */
		        $("#login_form").attr("action", "/member/login.do");   //컨트롤러 로그인 url "login" -> "login.do" 변경
		        $("#login_form").submit();
		    });
		    
		    
		    /* 아이디, 비밀번호 입력란 클릭(focus) 시 도움말(placeholder) 삭제, 입력란 벗어나면(blur) 도움말 다시 추가 */
		    $(".id_input").focus(function(){
		    	$(this).removeAttr("placeholder");
		    });
		    $(".id_input").blur(function(){
		    	$(this).attr("placeholder", "아이디");
		    });
		    $(".pw_iput").focus(function(){
		    	$(this).removeAttr("placeholder");
		    });
		    $(".pw_iput").blur(function(){
		    	$(this).attr("placeholder", "아이디");
		    });
		 
		</script>
	</body>
</html>