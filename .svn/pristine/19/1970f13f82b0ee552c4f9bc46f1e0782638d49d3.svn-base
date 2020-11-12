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
	function selectImg(fileNum, fileName) {
		var id = $("#layer option:selected", opener.document).val();
		$("#" + id, opener.document).html("<img  src='upload/" + fileName + "'  style='width:100%' />");
		opener.updateFileNum(fileNum);
		window.close();
	}

</script>
</head>
<body>
<h1>DiClean Platform</h1>
<hr/>

<%
	ArrayList<Map<String, Object>> fileList = (ArrayList<Map<String, Object>>)request.getAttribute("fileList");
%>

<table border="1">
	<tr>
		<th>번호</th>
		<th colspan="2">파일</th>
		<th>등록 일자</th>
	</tr>
	
<%
	if(fileList != null && fileList.size() > 0) {
		for(int i = 0; i < fileList.size(); i++) {
			Map<String, Object> file = fileList.get(i);
			
%>
	<tr>
		<td><%= file.get("file_num") %></td>
		<td><img onClick="selectImg(<%= file.get("file_num") %>, '<%= file.get("file_name") %>')" src="upload/<%= file.get("file_name") %>"  width="100" /></td>
		<td><%= file.get("real_file_name") %></td>
		<td><%= file.get("add_date") %></td>
	</tr>
<%
		}
	
	} else {
%>
	<tr>
		<th colspan="4">등록된 파일이 없습니다.</th>
	</tr>
<%		
	}
%>	
</table>

</body>
</html>