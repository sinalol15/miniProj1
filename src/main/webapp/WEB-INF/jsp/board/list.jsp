<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>List</title>
	<style>
		th, td {
		  border: 1px solid;
		}
		th {
			border-color : #96D4D4;
		}
		td {
			border-color : #D6EEEE;
		}
		tr:nth-child(even) {
		  background-color: #D6EEEE;
		  color:#96D4D4;
		}
		tr:nth-child(odd) {
		  background-color: #96D4D4;
		  color:white;
		}
	</style>
</head>
<body>

<c:if test="${empty loginVO.mname}">
    <div id="before"></div>
</c:if>
<c:if test="${!empty loginVO.mname && loginVO.mid ne 'park'}">
    <div id="after"></div>
</c:if>
<c:if test="${!empty loginVO.mname && loginVO.mid eq 'park'}">
    <div id="manager"></div>
</c:if>

<h1>게시물목록</h1>
	<h3>로그인 : ${loginVO.mname}</h3>
    <form id="searchForm" action="boards1" method="post">
    	<input type="hidden" id="action" name="action" value="list">
    	<label>제목</label>
    	<input type="text" id="searchKey" name="searchKey" value="${param.searchKey}">
    	<input type="submit" value="검색">
    </form>
    
   	<form id="listForm" action="boards1" method="post">
    	<input type="hidden" id="action" name="action" value="view">
    	<input type="hidden" id="tbno" name="tbno">
    	<input type="hidden" id="tmid" name="tmid">
    </form>
    
    <table>
        <tr>
            <th>게시물번호</th>
            <th>제목</th>
            <th>작성일</th>
            <th>작성자</th>
            <th>조회수</th>
        </tr>
        <c:forEach var="board" items="${list}">
        <tr>
            <td onclick="jsView('${board.tbno}', '${loginVO.mid}')"  style="cursor:pointer;">${board.tbno}</td>
            <td>${board.tbtitle}</td>
            <td>${board.tbdate}</td>
            <td>${board.mname}</td>
            <td>${board.viewcount}</td>
        </tr>
        </c:forEach>
    </table>
    
    <form id="insertForm" method="post" action="boards1">
		<input type="hidden" id="action" name="action" value="insertForm">
		<input type="button" value="등록" onclick="jsInsertForm('${loginVO.mid}')">
	</form>
	
	<script type="text/javascript" src="<c:url value='/js/common.js'/>"></script>
	
	<script>
	function jsView(bn, id1) {
		//인자의 값을 설정한다 
		tbno.value = bn;
		tmid.value = id1;
		
		//양식을 통해서 서버의 URL로 값을 전달한다
		listForm.submit();
		
	}
	
	function jsInsertForm(a) {
	    if(a === null || a === undefined || a === ""){
	        alert("로그인을 해야 등록이 가능합니다.");
	        return;
	    }
		//서버의 URL로 전송한다 
		insertForm.submit();
	}
	</script>


</body>
</html>