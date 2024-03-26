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

	<h1>회원목록</h1>
	  
    <form id="searchForm" action="members1" method="post" >
    	<input type="hidden" id="action" name="action" value="list">
    	<label>이름 : </label>
    	<input type="text" id="searchKey" name="searchKey" value="${param.searchKey}">
    	<input type="submit" value="검색">
    </form>
    
    <form id="listForm" action="members1" method="post">
    	<input type="hidden" id="action" name="action" value="view">
    	<input type="hidden" id="mid" name="mid" >
    </form>
    
    <table>
        <tr>
            <th>ID</th>
            <th>이름</th>
            <th>나이</th>
            <th>이메일</th>
        </tr>
        <c:forEach var="member" items="${list}">
        <tr>
            <td onclick="jsView('${member.mid}')"  style="cursor:pointer;">${member.mid}</td>
            <td>${member.mname}</td>
            <td>${member.mage}</td>
            <td>${member.memail}</td>
        </tr>
        </c:forEach>
    </table>
    
	<script>
	function jsView(memberid) {
		//인자의 값을 설정한다 
		mid.value = memberid;
		
		//양식을 통해서 서버의 URL로 값을 전달한다
		listForm.submit();
		
	}
	</script>
</body>
</html>