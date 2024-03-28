<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>InsertForm</title>
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
<body>
	<jsp:include page="header.jsp"/>

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
        게시물 등록양식 
    </h1>
    <h3>로그인 : ${loginVO.mname} </h3>
    <form id="rForm" action="boards" method="post">
    	<input type="hidden" name="action" value="insert">
        <label>제목 : </label><input type="text" id="tbtitle" name="tbtitle" ><br/>
        <label>내용 : </label><input type="text" id="tbcontent" name="tbcontent" ><br/>
    <div>
        <input type="submit" value="등록">
        <a href="boards1?action=list">취소</a>
    </div>
    
    </form>
        
    <script type="text/javascript" src="<c:url value='/js/common.js'/>"></script>
    
    <script type="text/javascript">
    const rForm = document.getElementById("rForm");
    
    rForm.addEventListener("submit", e => {
    	//서버에 form data를 전송하지 않는다 
    	e.preventDefault();
    	
		myFetch("boards1", "rForm", json => {
			if(json.status == 0) {
				//성공
				alert("게시물 작성에 성공 하였습니다");
				location = "boards1?action=list";
			} else {
				alert(json.statusMessage);
			}
		});
    });
    </script>
    
</body>
</html>