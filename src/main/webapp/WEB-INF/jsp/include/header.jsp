<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Menu</title>
</head>
<body>
	<script type="text/javascript" src="<c:url value='/js/common.js'/>"></script>
	
	<c:if test="${empty loginVO.mname}">
	    <div id="before"></div>
	    <script>
	    	before();
	    </script>
	</c:if>
	<c:if test="${!empty loginVO.mname && loginVO.mid ne 'park'}">
	    <div id="after"></div>
	    <script>
	    	after();
	    </script>
	</c:if>
	<c:if test="${!empty loginVO.mname && loginVO.mid eq 'park'}">
	    <div id="manager"></div>
	    <script>
	    	manager();
	    </script>
	</c:if>
</body>
</html>