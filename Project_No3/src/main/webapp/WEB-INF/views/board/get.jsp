<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- jstl 라이브러리를 추가해주는 지시자 태그(Directive Tag)를 추가 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<!--  Jquery를 사용할 것이기 때문에 Jquery 라이브러리를 추가해주는 script 코드 -->
		<script src="https://code.jquery.com/jquery-3.4.1.js" 
				integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" 
				crossorigin="anonymous"></script>
		<style type="text/css">
			.input_wrap{
				padding: 5px 20px;
			}
			label{
			    display: block;
			    margin: 10px 0;
			    font-size: 20px;	
			}
			input{
				padding: 5px;
			    font-size: 17px;
			}
			textarea{
				width: 800px;
			    height: 200px;
			    font-size: 15px;
			    padding: 10px;
			}
			.btn{
			  	display: inline-block;
			    font-size: 22px;
			    padding: 6px 12px;
			    background-color: #fff;
			    border: 1px solid #ddd;
			    font-weight: 600;
			    width: 140px;
			    height: 41px;
			    line-height: 39px;
			    text-align : center;
			    margin-left : 30px;
			    cursor : pointer;
			}
			.btn_wrap{
				padding-left : 80px;
				margin-top : 50px;
			}
		</style>
	</head>
	
	<body>
		<h1>게시글 조회</h1>
		
		<div class="input_wrap">
			<label>게시글 번호</label>			<%-- 기존의 데이터를 수정할 수 없어야 하기 때문에 "readonly" 속성을 부여 --%>
			<input name="bno" readonly="readonly" value='<c:out value="${pageInfo.bno}"/>' >
		</div>
		<div class="input_wrap">
			<label>게시글 제목</label>
			<input name="title" readonly="readonly" value='<c:out value="${pageInfo.title}"/>' >
		</div>
		<div class="input_wrap">
			<label>게시글 내용</label>
			<textarea rows="3" name="content" readonly="readonly"><c:out value="${pageInfo.content}"/></textarea>
		</div>
		<div class="input_wrap">
			<label>게시글 작성자</label>
			<input name="writer" readonly="readonly" value='<c:out value="${pageInfo.writer}"/>' >
		</div>
		<div class="input_wrap">
			<label>게시글 등록일</label>
			<input name="regdate" readonly="readonly" value='<fmt:formatDate pattern="yyyy/MM/dd" value="${pageInfo.regdate}"/>' >
		</div>
		<div class="input_wrap">
			<label>게시글 수정일</label>
			<input name="updateDate" readonly="readonly" value='<fmt:formatDate pattern="yyyy/MM/dd" value="${pageInfo.updateDate}"/>' >
		</div>		
		<div class="btn_wrap">
			<a class="btn" id="list_btn">목록 페이지</a> 
			<a class="btn" id="modify_btn">수정 하기</a>
		</div>
		
		<form id="infoForm" action="/board/modify" method="get">
			<%-- 버튼 클릭 시 DB 테이블의 기본 키 컬럼인 bno 값을 넘겨 해당 게시글을 특정한다 --%>
			<input type="hidden" id="bno" name="bno" value='<c:out value="${pageInfo.bno}"/>'>
			<%-- '조회, 수정 페이지'로 이동하였다가 다시 현재 번호(페이징) 목록 페이지로 이동하기 위해 현재 페이지 번호와 표시할 페이지 개수 요소 전달 --%>
			<input type="hidden" name="pageNum" value="${cri.pageNum}">
       		<input type="hidden" name="amount" value="${cri.amount}">
       		<%-- 검색 키워드 요소도 전달 --%>
       		<input type="hidden" name="keyword" value="${cri.keyword}">
       		<%-- 검색 주제 요소도 전달 --%>
       		<input type="hidden" name="type" value="${cri.type}">
		</form>
		
		<%-- 버튼 클릭 시 동작에 대한 제이쿼리 스크립트 --%>
		<script>
			let form = $("#infoForm");
			/* 목록 페이지 버튼 클릭 시, form 태그의 id가 bno인 요소를 삭제하고 form 태그의 action 속성 값을 목록 페이지 url로 변경 후 적용(제출)한다 */
			$("#list_btn").on("click", function(e){   //id가 list_btn인 요소의 클릭 이벤트 발생 시 해당 이벤트의 동작을 함수로 정의한다
				form.find("#bno").remove();
				form.attr("action", "/board/list");
				form.submit();
			});
			
			/* 수정 하기 버튼 클릭 시, form 태그의 action 속성 값을 게시글 수정 url로 변경 후 적용(제출)한다 */
			$("#modify_btn").on("click", function(e){   //id가 modify_btn인 요소의 클릭 이벤트 발생 시 해당 이벤트의 동작을 함수로 정의한다
				form.attr("action", "/board/modify");
				form.submit();
			});	
		</script>	
	</body>
</html>