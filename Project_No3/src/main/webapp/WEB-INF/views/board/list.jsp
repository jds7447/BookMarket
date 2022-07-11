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
			a{
				text-decoration : none;
			}
			table{
				border-collapse: collapse;
				width: 1000px;    
				margin-top : 20px;
				text-align: center;
			}
			td, th{
				border : 1px solid black;
				height: 50px;
			}
			th{
				font-size : 17px;
			}
			thead{
				font-weight: 700;
			}
			.table_wrap{
				margin : 50px 0 0 50px;
			}
			.bno_width{
				width: 12%;
			}
			.writer_width{
				width: 20%;
			}
			.regdate_width{
				width: 15%;
			}
			.updatedate_width{
				width: 15%;
			}
			.top_btn{
				font-size: 20px;
				padding: 6px 12px;
				background-color: #fff;
				border: 1px solid #ddd;
				font-weight: 600;
			}
			/* 페이지 이동 인터페이스 start */
			.pageInfo{
				list-style : none;
				display: inline-block;
				margin: 50px 0 0 100px;   /* margin 상, 우, 하 ,좌 */
			}
			.pageInfo li{
				float: left;   /* 각 '이전' '페이지번호' '다음' 요소들이 왼쪽 정렬되어 다음 요소들이 순서대로 오른쪽에 붙도록 "이전 1 2 3 .... 다음" */
				font-size: 20px;
				margin-left: 18px;
				padding: 7px;
				font-weight: 500;
			}
			a:link {color:black; text-decoration: none;}
			a:visited {color:black; text-decoration: none;}
			a:hover {color:black; text-decoration: underline;}
			.active{
				background-color: #cdd5ec;   /* 현재 페이지 번호 버튼에 배경색 */
			}
			/* 페이지 이동 인터페이스 end */
			/* 게시글 검색 인터페이스 start */
			.search_area{
				display: inline-block;
				margin-top: 30px;
				margin-left: 260px;
			}
			.search_area input{
				width: 250px;
				height: 30px;
			}
			.search_area button{
				width: 100px;
				height: 36px;
			}
			.search_area select{
				height: 35px;
			}
			/* 게시글 검색 인터페이스 end */
		</style>
	</head>
	
	<body>
		<h1>게시글 목록</h1>
		
		<div class="table_wrap">
			<a href="/board/enroll" class="top_btn">게시글 등록</a>
			<table>
				<thead>
					<tr>
						<th class="bno_width">번호</th>
						<th class="title_width">제목</th>
						<th class="writer_width">작성자</th>
						<th class="regdate_width">작성일</th>
						<th class="updatedate_width">수정일</th>
					</tr>
				</thead>
				<%-- c:forEach 태그는 전달받은 "list"가 가진 요소 개수만큼 반복하여 처리 --%>
				<c:forEach items="${list}" var="list">   <%-- 'items' = 전달받은 List 객체를 속성 값으로 부여, 'var' = 배열 객체를 부를 변수명 --%>
		            <tr>   <%-- 표현 언어(EL) ${list.bno}를 사용해도 되지만 c:out 태그의 여러 이점 때문에 c:out value="${list.bno}" 사용 --%>
		                <td><c:out value="${list.bno}"/></td>   <%-- ${변수명.BoardVO멤버 변수명} 을 통해 각 요소가 가진 멤버들의 값을 호출 --%>
		                <td>   <!-- '목록 페이지(list.jsp)'에서 제목을 클릭했을 때 해당 '조회 페이지(get.jsp)' 페이지로 이동할 수 있도록 -->
		                	<a class="move" href='<c:out value="${list.bno}"/>'>
                        		<c:out value="${list.title}"/>
                    		</a>
						</td>
		                <td><c:out value="${list.writer}"/></td>
		                <%-- c:out으로 하면 시/분/초 까지 출력 되기 때문에 원하는 날짜 형식(년/월/일)으로 출력하기 위해 fmt:formatDate 태그 사용 --%>
		                <%-- <td><c:out value="${list.regdate}"/></td> --%>
		                <%-- <td><c:out value="${list.updateDate}"/></td> --%>
		                <td><fmt:formatDate pattern="yyyy/MM/dd" value="${list.regdate}"/></td>
                		<td><fmt:formatDate pattern="yyyy/MM/dd" value="${list.updateDate}"/></td>
		            </tr>
		        </c:forEach>
			</table>
			
			<%-- '게시글 검색 인터페이스' 게시글 중에 특정 keyword가 포함된 게시글만 조회하기 위한 검색 요소 --%>
			<div class="search_wrap">
		        <div class="search_area">
		        	<%-- 검색 옵션을 선택하기 위한 드롭다운 메뉴 인터페이스 --%>
		        	<select name="type">   <%-- 검색으로 페이지 이동 시 기존 선택한 <option>이 기본적으로 선택되도록 하기 위해 삼항 연산자 사용 --%>
		                <option value="" <c:out value="${pageMaker.cri.type == null ? 'selected' : '' }"/>>--</option>
		                <option value="T" <c:out value="${pageMaker.cri.type eq 'T' ? 'selected' : '' }"/>>제목</option>
		                <option value="C" <c:out value="${pageMaker.cri.type eq 'C' ? 'selected' : '' }"/>>내용</option>
		                <option value="W" <c:out value="${pageMaker.cri.type eq 'W' ? 'selected' : '' }"/>>작성자</option>
		                <option value="TC" <c:out value="${pageMaker.cri.type eq 'TC' ? 'selected' : '' }"/>>제목 + 내용</option>
		                <option value="TW" <c:out value="${pageMaker.cri.type eq 'TW' ? 'selected' : '' }"/>>제목 + 작성자</option>
		                <option value="TCW" <c:out value="${pageMaker.cri.type eq 'TCW' ? 'selected' : '' }"/>>제목 + 내용 + 작성자</option>
		            </select>
		        	<%-- input 태그에 value속성과 속성 값을 부여한 이유는 페이지 이동시에도 검색한 키워드 데이터를 계속 남기기 위함 --%>
		            <input type="text" name="keyword" value="${pageMaker.cri.keyword}">
		            <button>Search</button>
		        </div>
		    </div>
			
			<%-- '페이지 인터페이스'를 작업을 위한 (페이징 기능 사용을 위한 요소) --%>
			<div class="pageInfo_wrap" >
		        <div class="pageInfo_area">
		        	<ul id="pageInfo" class="pageInfo">
		        		<%-- 이전페이지 버튼 --%>
		                <c:if test="${pageMaker.prev}">   <%-- 컨트롤러에서 전달받은 pageMaker.prev 값이 true일 때 이전 버튼이 보이도록 --%>
		                    <li class="pageInfo_btn previous"><a href="${pageMaker.startPage - 1}">Previous</a></li>
		                </c:if>									<!-- startPgae-1 현재 보이는 10개의 페이지 번호 이전으로 이동하기 위함 -->
		        		<%-- 각 페이지 이동 번호 버튼 --%>
		                <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
		                	<%--  '현재 페이지' <a> 태그의 class 속성 값에 "active"문자를 추가하고,
		                			변경된 <a>태그의 class 속성값을 활용하여 css 설정을 줘서 '현재 페이지' 버튼에 배경색을 추가하기 위해 코드 수정 --%>
		                    <%-- <li class="pageInfo_btn"><a href="${num}">${num}</a></li> --%>
		                    <li class="pageInfo_btn ${pageMaker.cri.pageNum == num ? "active":""}"><a href="${num}">${num}</a></li>
		                </c:forEach>
		                <%-- 다음페이지 버튼 --%>
		                <c:if test="${pageMaker.next}">   <%-- 컨트롤러에서 전달받은 pageMaker.next 값이 true일 때 다음 버튼이 보이도록 --%>
		                    <li class="pageInfo_btn next"><a href="${pageMaker.endPage + 1}">Next</a></li>
		                </c:if>									<%-- startPgae+1 현재 보이는 10개의 페이지 번호 다음으로 이동하기 위함 --%>
		        	</ul>
		        </div>
		    </div>
    
			<%-- '조회 페이지' 이동 구현 또한 나중에 추가될 기능에 따라 유연하게 동작할 수 있도록 <form> 태그를 통해 페이지 이동되도록 --%>
			<form id="moveForm" method="get">
				<%-- '조회, 수정 페이지'로 이동하였다가 다시 현재 번호(페이징) 목록 페이지로 이동하기 위해 현재 페이지 번호와 표시할 페이지 개수 요소 전달 --%>
				<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
        		<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
        		<%-- 검색 키워드 요소도 전달 --%>
        		<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
        		<%-- 검색 주제 요소도 전달 --%>
        		<input type="hidden" name="type" value="${pageMaker.cri.type}">
    		</form>
		</div>
		
		<script>
			/* 현재 페이지(게시글 목록) 진입 시 게시글 등록 완료 후 진입한 것이라면 게시글 등록 완료 다이얼로그 박스를 띄우기 */
			/* 페이지 로딩 시 반드시 실행이 되는 $(document).ready(function(){}) 함수를 추가 */
		    $(document).ready(function(){
		    	/* 초기화 값으로 EL(표현식)을 사용해도 문제는 없지만, 주로 EL을 그대로 사용하지 않고 jstl의 <c:out value=""/> 태그를 사용한다
		    	굳이 jstl을 사용하는 이유는 html 문자 탈락시키는 기능, 엄격한 태그 규칙, 개행 문자 파싱의 차이, 보다 나은 보안성 등의 이점이 있기 때문 */
//		    	let result = "${result}";   //서버로부터 전달받은 값을 저장하기 위한 result 변수를 선언 한 뒤, 전달받은 값으로 초기화
		    	let result = '<c:out value="${result}"/>';   //let : 블록 내에서 변수 중복 선언 불가, 재할당 가능
		    	
		    	checkAlert(result);
	
	            /* result에 담긴 값이 아무것도 없을 경우 실행되지 않고, 값이 있을 경우 메시지가 체크 후 게시판 등록이 완료되었다는 경고창을 띄우는 로직 */
		    	function checkAlert(result) {
		            if(result === '') {
		                return;
		            }
		            if(result === "enrol success") {
		                alert("등록이 완료되었습니다.");
		            }
		            if(result === "modify success"){
		                alert("수정이 완료되었습니다.");
		            }
		            if(result === "delete success"){
		                alert("삭제가 완료되었습니다.");
		            }
		        }
		    });
			
			/* 페이지 이동에 대한 JS */
		    let moveForm = $("#moveForm");   //id가 moveForm(form 태그)인 요소를 지역 변수로 설정

			/* '조회 페이지' 이동 <a> 태그가 동작하도록 Javascript코드를 추가  */
		    $(".move").on("click", function(e){   //class가 move인 요소의 클릭 이벤트 발생 시 해당 이벤트의 동작을 함수로 정의한다
		        e.preventDefault();   //해당 이벤트 발생 요소의 기본적인 동작을 억제한다 (a태그 요소 클릭 시 href 속성값 페이지로 이동하는 링크 기능 억제)
		        //form 태그에 input 요소를 추가하며, 이벤트가 발생한 a 태그의 href 요소 값을 가져다 추가한 input 태그의 value 값에 적용한다
		        moveForm.append("<input type='hidden' name='bno' value='" + $(this).attr("href") + "'>");
		        moveForm.attr("action", "/board/get");   //form 태그의 action 속성 값을 조회 페이지 url로 변경한다
		        moveForm.submit();   //form 제출
		    });
		    
		    /* 페이징 기능인 '페이지 이동 번호'가 동작하기 위한 JS코드 */
		    $(".pageInfo a").on("click", function(e){   //페이지 번호(a태그) 클릭하였을 때 동작 (pageInfo 클래스 요소 내의 a태그)
		    	e.preventDefault();   //a태그 동작 멈춤
		    	//<form> 태그 내부 name 값이 pageNum인 <input> 요소의 vlaue 속성값을 클릭한 <a> 태그의 페이지 번호(href)를 삽입
		    	moveForm.find("input[name='pageNum']").val($(this).attr("href"));
		        moveForm.attr("action", "/board/list");   //<form>태그 action 속성 추가 및 '/board/list'을 속성값으로 추가
		        moveForm.submit();
		    });
		    
		    /* 게시글 검색 버튼이 동작하기 위한 js 코드 */
		    $(".search_area button").on("click", function(e){   //'검색 버튼'을 눌렀을 때 동작
		        e.preventDefault();   //먼저 버튼의 기능을 막고
		        
		        /* 주제결 검색을 위해 수정 및 추가 */
		        //let val = $("input[name='keyword']").val();   //사용자가 작성한 'keyword'데이터를
		        let type = $(".search_area select").val();
        		let keyword = $(".search_area input[name='keyword']").val();
        		
        		//검색 주제 미선택 또는 검색어 미입력 후 검색 버튼 클릭 시 알림 창 발생 및 검색 버튼 메서드 종료
        		if(!type){
                    alert("검색 종류를 선택하세요.");
                    return false;
                }
                
                if(!keyword){
                    alert("키워드를 입력하세요.");
                    return false;
                }
        		
                /* 주제결 검색을 위해 수정 및 추가 */
		        //moveForm.find("input[name='keyword']").val(val);   //<form> 태그 내부에 있는 name 속성이 'keyword'인 <input>태그에 저장
		        moveForm.find("input[name='type']").val(type);
        		moveForm.find("input[name='keyword']").val(keyword);
		        
		        //<form>태그 내부 name 속성이 'pageNum'인 <input>에 저장되어 있는 값을 1로 변경
		        //pageNum 데이터를 변경해준 이유는 검색을 통해 '목록 페이지'를 이동했을 때 1페이지로 이동을 지정해주기 위함
		        moveForm.find("input[name='pageNum']").val(1);
		        //<form> 태그에 action 속성을 통해 url을 지정해주지 않으면 전송하였을 때 현재의 url경로의 매핑 메서드를 호출
		        //검색 버튼을 통해 사용되어야 할 url 경로 또한 "/board/list"이기 때문에 "moverForm.attr("action", "/board/list")"를 따로 추가 않함
		        moveForm.submit();
		    });
		</script>
	</body>
</html>