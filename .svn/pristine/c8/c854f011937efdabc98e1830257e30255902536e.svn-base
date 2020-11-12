<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="/DiClean/js/jquery-1.11.0.min.js"></script>
<script>
	function selectContents(contentsNum, contentsTitle) {
		$("#contentsText", opener.document).html(contentsTitle);
		$("#contents_num", opener.document).attr("value", contentsNum);
		window.close();
	}

</script>
</head>
<body>
<h1>DiClean Platform</h1>
<hr/>

<%
	ArrayList<Map<String, Object>> contentsList = (ArrayList<Map<String, Object>>)request.getAttribute("contentsList");
%>

<table border="1">
	<tr>
		<th>컨텐츠 제목</th>
		<th>컨텐츠 설명</th>
		<th>&nbsp;</th>
	</tr>
	
<%
	if(contentsList != null && contentsList.size() > 0) {
		for(int i = 0; i < contentsList.size(); i++) {
			Map<String, Object> contents = contentsList.get(i);
			
%>
	<tr>
		<td><%= contents.get("contents_title") %></td>
		<td><%= contents.get("contents_content") %></td>
		<td><input type="button" value="선택" onClick="selectContents('<%= contents.get("contents_num") %>', '<%= contents.get("contents_title") %>')"/></td>
	</tr>
<%
		}
	
	} else {
%>
	<tr>
		<th colspan="3">등록된 파일이 없습니다.</th>
	</tr>
<%		
	}
%>	
</table>

</body>
</html>