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
	<jsp:include page="../include/header.jsp"/>

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
        회원가입 정보 입력
    </h1>
    <form id="rForm" action="members1" method="post">
    	<input type="hidden" name="action" value="insert">
        <label>아이디 : </label> <input type="text" id="mid" name="mid" required="required"><input type="button" id="duplicateId" value="중복확인"><br/>
        <label>비밀번호 : </label>   <input type="password" id="mpassword" name="mpassword" required="required"><br/>
        <label>비밀번호확인 : </label>   <input type="password" id="mpassword2" name="mpassword2" required="required"><br/>
        <label>이름 : </label>   <input type="text" id="mname" name="mname" required="required"><br/>
        <label>나이: </label>    <input type="text" id="mage" name="mage" required="required"><br/>
        <label>이메일: </label>  <input type="text" id="memail" name="memail" required="required"><br/>
        <h4>취미: </h4>
        <label>게임</label><input type="checkbox" id="mhabbit1" name="mhabbit" value="1"><br/>
        <label>책 읽기</label><input type="checkbox" id="mhabbit2" name="mhabbit" value="2"><br/>
        <label>운동</label><input type="checkbox" id="mhabbit3" name="mhabbit" value="3"><br/>
        
	    <div>
	        <input type="submit" value="등록">
	        <a href="members1?action=list">취소</a>
	    </div>
    </form>
        
    <script type="text/javascript">
    const rForm = document.getElementById("rForm");
    const mid = document.getElementById("mid");
    const mpassword = document.getElementById("mpassword");
    const mpassword2 = document.getElementById("mpassword2");
    const mname = document.getElementById("mname");
    const mage = document.getElementById("mage");
    const memail = document.getElementById("memail");
    //아이디 사용 여부 확인 
    let validUserId = "";
    
    rForm.addEventListener("submit", e => {
    	//서버에 form data를 전송하지 않는다 
    	e.preventDefault();
    	
    	if (validUserId == "" || mid.value != validUserId) {
    		alert("아이디 중복확인 해주세요");
    		return false;
    	}
    	
    	if (mpassword.value != mpassword2.value) {
        	
    		alert("비밀번호가 잘못되었습니다.")
    		mpassword2.value = "";
    		mpassword2.focus();
    		return false;
    	}
		myFetch("members1", "rForm", json => {
			if(json.status == 0) {
				//성공
				alert("회원가입을 성공 하였습니다");
				location = "members1?action=loginForm";
			} else {
				alert(json.statusMessage);
			}
		});
    });
    
    //id의 객체를 얻는다
	const duplicateId = document.getElementById("duplicateId");
    //click 이벤트 핸들러 등록
	duplicateId.addEventListener("click", () => {
		const mid = document.getElementById("mid");
		if (mid.value == "") {
			alert("아이디를 입력해주세요");
			mid.focus();
			return;
		}
		const param = {
			action : "existUserId",
			mid : mid.value
		}
		fetch("members1", {
			method:"POST",
			body:JSON.stringify(param),
			headers : {"Content-type" : "application/json; charset=utf-8"}
		}).then(res => res.json()).then(json => {
			//서버로 부터 받은 결과를 사용해서 처리 루틴 구현  
			console.log("json ", json );
			if (json.existUser == true) {
				alert("해당 아이디는 사용 중 입니다.");
				validUserId = "";
			} else {
				alert("사용가능한 아이디 입니다.");
				validUserId = mid.value;
			}
		});
	});
    </script>
    
</body>
</html>