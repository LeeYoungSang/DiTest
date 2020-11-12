<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

</head>
<body>
<h1>DiClean Platform</h1>
<hr/>

<%@ include file="../common/topMenu.jsp" %>

공지관리<br/>

<%
	String error = request.getParameter("error");

	if(error != null) {
		if(error.equals("1")) {
%>
			<br/>공지 등록 중 오류가 발생했습니다.<br/>
<%			
		} else if(error.equals("2")) {
%>
			<br/>공지 수정 중 오류가 발생했습니다.<br/>
<%			
		} else if(error.equals("3")) {
%>
			<br/>공지 삭제 중 오류가 발생했습니다.<br/>
<%			
		}
	}
%>

<br/>
<a href="noticeList.nao">공지목록</a>

</body>
</html>