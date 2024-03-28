<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Company-info</title>
        <meta charset="utf-8">
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
		
        <h1 style="background-color:rgba(255, 95, 140, 0.5); color:white;">사용 언어</h1>
        <ol>
            <li>HTML</li>
            <li>CSS</li>
            <li>JavaScript</li>
        </ol>
        <h1 style="background-color:powderblue; color:white;">HTML이란 무엇인가?</h1>
        <p><a href="https://www.w3.org/TR/html5/" target="_blank" title="HTML5 specification">Hypertext Markup Language (HTML)</a> is the standard markup language for <strong>creating <u>web</u> pages</strong> and web applications. Web browsers receive HTML documents from a web server or from local storage and render them into multimedia web pages. HTML describes the structure of a web page semantically and originally included cues for the appearance of the document.
        </p>
        <p style="margin-top:40px;">HTML elements are the building blocks of HTML pages. With HTML constructs, images and other objects, such as interactive forms, may be embedded into the rendered page. It provides a means to create structured documents by denoting structural semantics for text such as headings, paragraphs, lists, links, quotes and other items. HTML elements are delineated by tags, written using angle brackets.</p>
        <br><img src="images/img.webp" width="500" title="차은우" alt = "이미지가 안 나올때 나오는 텍스트 설명">
    </body>
</html>