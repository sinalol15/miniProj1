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
<div id="after"></div>
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
            <th>작성자</th>
            <th>작성일</th>
        </tr>
        <c:forEach var="board" items="${list}">
        <tr>
            <td onclick="jsView('${board.tbno}', '${loginVO.mid}')"  style="cursor:pointer;">${board.tbno}</td>
            <td>${board.tbtitle}</td>
            <td>${board.tbwriter}</td>
            <td>${board.tbdate}</td>
        </tr>
        </c:forEach>
    </table>
    
    
	<script type="text/javascript" src="<c:url value='/js/common.js'/>"></script>
	<script>
	function jsView(bn, id1) {
		//인자의 값을 설정한다 
		tbno.value = bn;
		tmid.value = id1;
		
		//양식을 통해서 서버의 URL로 값을 전달한다
		listForm.submit();
		
	}
	</script>

	<form action = "boards1" method = "post">
		<input type = "hidden" name = "action" value="insertForm">
		<input type = "hidden" name = "tbwriter" value="${loginVO.mname}">
		<input type = "submit" value = "등록">
	</form>
</body>
</html>