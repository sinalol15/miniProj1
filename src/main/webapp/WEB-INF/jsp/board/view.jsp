<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <title>View</title>
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
        게시물 상세보기
    </h1>
   
	<label>게시물 번호: ${board.tbno}</label> <br/>
	<label>제목 : ${board.tbtitle}</label><br/>
	<label>내용 : ${board.tbcontent}</label><br/>
	<label>작성자 : ${board.tbwriter}</label><br/>
	<label>작성일 : ${board.tbdate}</label><br/>
	<label>작성일 : ${board.tmid}</label><br/>

	<script type="text/javascript" src="<c:url value='/js/common.js'/>"></script>
	
	<script>
	function jsList() {
		action.value = "list";
		
		viewForm.submit();
	}
	//tmid
	function jsDelete(a, b) {
		if(a != b){
			alert("아이디가 일치하지 않습니다.");
			return;
		}
		if (confirm("정말로 삭제하시겠습니까?")) {
			/*
			//서버의 URL을 설정한다 
			action.value = "delete";
		
			//서버의 URL로 전송한다 
			viewForm.submit();
			*/
			action.value = "delete";
			myFetch("boards1", "viewForm", json => {
				if(json.status == 0) {
					//성공
					alert("게시물을 삭제 하였습니다");
					location = "boards1?action=list";
				} else {
					alert(json.statusMessage);
				}
			});
		}
	}
	
	function jsUpdateForm(a, b) {
		if(a != b){
			alert("아이디가 일치하지 않습니다.");
			return;
		}
		//서버의 URL을 설정한다 
		action.value = "updateForm";
	
		//서버의 URL로 전송한다 
		viewForm.submit();
	}
	</script>
	<!-- 두개의 폼을 하나로 합치는 방법 , js를 사용하여 처리  -->
	<form id="viewForm" method="post" action="boards1">
		<input type="hidden" id="action" name="action" value="">
		<input type="hidden" name="tbno" value="${board.tbno}">
		<input type="button" value="목록" onclick="jsList()">
		<input type="button" value="삭제" onclick="jsDelete('${loginVO.mid}', '${board.tmid}')">
		<input type="button" value="수정" onclick="jsUpdateForm('${loginVO.mid}', '${board.tmid}')">
	</form>
</body>
</html>