<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
	function idCheck() {
		window.open("idDupsCheckForm.nao", "", "width=350, height=100");
	}
</script>
</head>
<body>
<h1>DiClean Platform</h1>
<hr/>

<%@ include file="../common/topMenu.jsp" %>

<%
	Map<String, Object> file = (Map<String, Object>)request.getAttribute("file");
%>
파일관리 > 파일상세<br/>

<form action="updateFile.nao" method="post">
<table border="1">
	<tr>
		<th>이미지</th>
		<td><img src="upload/<%= file.get("file_name") %>"  width="250"/></td>
	</tr>
	<tr>
		<th>파일명</th>
		<td><%= file.get("real_file_name") %></td>
	</tr>
	<tr>
		<th>설명</th>
		<td><textarea name="file_content" cols="30" rows="5"><%= file.get("file_content") %></textarea></td>
	</tr>
	<tr>
		<th>등록자</th>
		<td><%= file.get("member_id") %></td>
	</tr>
	<tr>
		<th>등록일자</th>
		<td><%= file.get("add_date") %></td>
	</tr>
	<tr>
		<th colspan="2">
			<input type="submit" value="수정" />
			<a href="deleteFile.nao?file_num=<%= file.get("file_num") %>">삭제</a>
		</th>
	</tr>
</table>
<input type="hidden" name="file_num" value="<%= file.get("file_num") %>" />
</form>

</body>
</html>