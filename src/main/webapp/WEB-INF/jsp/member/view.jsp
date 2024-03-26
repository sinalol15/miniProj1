<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
            <td onclick="jsView('${member.mid}')" style="cursor:pointer;">${member.mid}</td>
            <td>${member.mname}</td>
            <td>${member.mage}</td>
            <td>${member.mmail}</td>
        </tr>
    </table>
	
	<script type="text/javascript" src="<c:url value='/js/common.js'/>"></script>

	<script>
	function jsList() {
		action.value = "list";
		
		viewForm.submit();
	}
	
	function jsView(memberid) {
	   //인자의 값을 설정한다 
	   mid.value = memberid;
	   
	   //양식을 통해서 서버의 URL로 값을 전달한다
	   viewForm.submit();   
	}
	
	function jsDelete() {
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
					alert("탈퇴가 되었습니다");
					location = "members1?action=list";
				} else {
					alert(json.statusMessage);
				}
			});
		}
	}
	
	function jsUpdateForm() {
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
		<input type="button" value="삭제" onclick="jsDelete()">
		<input type="button" value="수정" onclick="jsUpdateForm()">
	</form>
</body>
</html>