<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

[<a href="machineList.nao">Machine</a>]
[<a href="fileList.nao">File</a>]
[<a href="contentsList.nao">Contents</a>]
[<a href="scheduleList.nao">Schedule</a>]
[<a href="noticeList.nao">Community</a>]
[<a href="client.nao">Client</a>]
<hr/>

<%
	Map<String, Object> member  = (Map<String, Object>)session.getAttribute("member");
%>
[<%= member.get("id") %>]님 
<a href="logout.nao">로그아웃</a>
<a href="updateMemberForm.nao">마이페이지</a><p/>

</body>
</html>