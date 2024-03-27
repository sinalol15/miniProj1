<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Mypage</title>
	<style>
	    label {
	        display: inline-block;
	        width: 200px;
	    }
	    input {
	        margin-bottom: 10px; 
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
	<h1>
       나의 페이지
    </h1>
   
	<label>아이디 : ${loginVO.mid}</label> <br/>
	<label>이름 : ${loginVO.mname}</label><br/>
	<label>나이: ${loginVO.mage}</label><br/>
	<label>이메일: ${loginVO.memail}</label><br/>

	<script type="text/javascript" src="<c:url value='/js/common.js'/>"></script>
	
	<script>
	function jsDelete() {
		if (confirm("정말로 탈퇴하시겠습니까?")) {
			action.value = "delete";
			myFetch("members1", "viewForm", json => {
				if(json.status == 0) {
					//성공
					alert("회원정보를 삭제 하였습니다");
					location = "members1?action=list";
				} else {
					alert(json.statusMessage);
				}
			});
		}
	}
	
	function jsUpdateForm() {
		if (confirm("정말로 수정하시겠습니까?")) {
			//서버의 URL을 설정한다 
			action.value = "updateForm";
		
			//서버의 URL로 전송한다 
			viewForm.submit();
		}	
	}
	
	</script>
	<!-- 두개의 폼을 하나로 합치는 방법 , js를 사용하여 처리  -->
	<form id="viewForm" method="post" action="members1">
		<input type="hidden" id="action" name="action" value="">
		<input type="hidden" id="mid" name="mid" value="${loginVO.mid}">
		<input type="button" value="삭제" onclick="jsDelete()">
		<input type="button" value="수정" onclick="jsUpdateForm()">
	</form>
</body>
</html>