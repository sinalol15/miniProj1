<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>View</title>
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
	<jsp:include page="../include/header.jsp"/>

    <h1>
        사용자 정보 상세보기
    </h1>
   
    <table>
        <tr>
            <th>ID</th>
            <th>이름</th>
            <th>나이</th>
            <th>이메일</th>
        </tr>
        <tr>
            <td>${member.mid}</td>
            <td>${member.mname}</td>
            <td>${member.mage}</td>
            <td>${member.memail}</td>
        </tr>
    </table>
	
	<script>
	function jsList() {
		action.value = "list";
		
		viewForm.submit();
	}
	
	function jsDelete(a, b) {
		if(a != 'park'){
			if(a != b){
				alert("아이디가 일치하지 않습니다.");
				return;
			}
		}
		if (confirm("정말로 삭제하시겠습니까?")) {
			/*
			//서버의 URL을 설정한다 
			action.value = "delete";
		
			//서버의 URL로 전송한다 
			viewForm.submit();
			*/
			action.value = "delete";
			myFetch("members1", "viewForm", json => {
				if(json.status == 0) {
					//성공
					alert("탈퇴 되었습니다");
					location = "members1?action=list";
				} else {
					alert(json.statusMessage);
				}
			});
		}
	}
	
	function jsUpdateForm(a, b) {
		if(a != 'park'){
			if(a != b){
				alert("아이디가 일치하지 않습니다.");
				return;
			}
		}
		//서버의 URL을 설정한다 
		action.value = "updateForm";
	
		//서버의 URL로 전송한다 
		viewForm.submit();
	}
	</script>
	<!-- 두개의 폼을 하나로 합치는 방법 , js를 사용하여 처리  -->
	<form id="viewForm" method="post" action="members1">
		<input type="hidden" id="action" name="action" value="">
		<input type="hidden" name="mid" value="${member.mid}">
		<input type="button" value="목록" onclick="jsList()">
		<input type="button" value="삭제" onclick="jsDelete('${loginVO.mid}', '${member.mid}')">
		<input type="button" value="수정" onclick="jsUpdateForm('${loginVO.mid}', '${member.mid}')">
	</form>
</body>
</html>