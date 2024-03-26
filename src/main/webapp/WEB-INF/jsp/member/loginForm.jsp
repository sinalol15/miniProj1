<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>LoginForm</title>
    <style>
        label {
            display: inline-block;
            width: 120px;
        }
        input {
            margin-bottom: 10px; 
        }
    </style>
</head>
<c:if test="${not empty param.err}">
<script>
	alert("아이디 또는 비밀번호가 잘못되었습니다");
</script>	
</c:if>
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
    <h1>
        로그인 화면
    </h1>
    <form id="rForm" action="members1" method="post">
    	<input type="hidden" name="action" value="login">
        <label>아이디 : </label> <input type="text" id="mid" name="mid" required="required"><br/>
        <label>비밀번호 : </label>   <input type="password" id="mpassword" name="mpassword" required="required"><br/>
    	<label for="autologin">자동로그인</label><input type="checkbox" id="autologin" name="autologin" value="Y">
	    <div>
	        <input type="submit" value="로그인">
	        <a href="members1?action=list">취소</a>
	    </div>
    </form>    
</body>
</html>