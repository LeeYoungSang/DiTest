<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
	function useId(id) {
		opener.document.getElementById("id").value = id;
		window.close();
	}
</script>
</head>
<body>
<form action="idDupsCheck.nao" method="post">
아이디 : <input type="text" name="id" />
<input type="submit" value="확인" />
</form>

<%
	Map<String, Object> result = (Map<String, Object>)request.getAttribute("result");
	
	if(result != null) {
		boolean value = (Boolean)result.get("result");
		
		if(value) {
%>
			이미 존재하는 아이디 입니다.
<%
		} else {
%>
			'<%= result.get("id") %>' 는 사용할 수 있는 아이디 입니다.
			<input type="button" value="적용" onClick="useId('<%= result.get("id") %>')" />
<%
		}
	}
%>
</body>
</html>