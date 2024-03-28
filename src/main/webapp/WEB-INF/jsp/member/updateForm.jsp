<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>UpdateForm</title>
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

	<h1>
        회원정보 수정양식 
    </h1>
    <form id="rForm" action="members1" method="post">
    	<input type="hidden" name="action" value="update">
        <label>아이디 : </label> <input type="text" id="mid" name="mid" value="${member.mid}" readonly="readonly"> <br/>
        <label>비밀번호 : </label>   <input type="password" id="mpassword" name="mpassword" required="required"><br/>
        <label>비밀번호확인 : </label>   <input type="password" id="mpassword2" name="mpassword2" required="required"><br/>
        <label>이름 : </label>   <input type="text" id="mname" name="mname" value="${member.mname}"><br/>
        <label>나이: </label>    <input type="text" id="mage" name="mage" value="${member.mage}"><br/>
        <label>이메일: </label>  <input type="text" id="memail" name="memail" value="${member.memail}"><br/>
	    <div>
	        <input type="submit" value="수정">
	        <a href="members1?action=view&mid=${member.mid}">취소</a>
	    </div>
    </form>
        
    <script type="text/javascript">
    
    const rForm = document.getElementById("rForm");
     
    rForm.addEventListener("submit", e => {
    	//서버에 form data를 전송하지 않는다 
    	e.preventDefault();
    	
    	if (mpassword.value != mpassword2.value) {
        	
    		alert("비밀번호가 잘못되었습니다.")
    		mpassword2.value = "";
    		mpassword2.focus();
    		return false;
    	}
    	
    	myFetch("members1", "rForm", json => {
    		if(json.status == 0) {
    			//성공
    			alert("회원 정보 수정을 성공 하였습니다");
    			location = "members1?action=mypage&mid=" + mid.value;
    		} else {
    			alert(json.statusMessage);
    		}
    	});
    });
    </script>
    
</body>
</html>