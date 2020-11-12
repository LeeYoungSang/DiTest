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
	function selectMachine(machineNum, machineType) {
		$("#machineText", opener.document).html(machineType);
		$("#machine_num", opener.document).attr("value", machineNum);
<%-- <%
	String mode = request.getParameter("mode");

	if(mode == null) {
%>
		opener.printSchedule(machineNum);
<%
	}
%>
 --%>		window.close();
	}

</script>
</head>
<body>
<h1>DiClean Platform</h1>
<hr/>

<%
	ArrayList<Map<String, Object>> machineList = (ArrayList<Map<String, Object>>)request.getAttribute("machineList");
%>

<table border="1">
	<tr>
		<th>machine Type</th>
		<th>설치 장소</th>
		<th>&nbsp;</th>
	</tr>	
<%
	if(machineList != null && machineList.size() > 0) {
		for(int i = 0; i < machineList.size(); i++) {
			Map<String, Object> machine = machineList.get(i);
			
%>
	<tr>
		<td><%= machine.get("machine_type") %></td>
		<td><%= machine.get("installed_place") %></td>
		<td><input type="button" value="선택" onClick="selectMachine('<%= machine.get("machine_num") %>', '<%= machine.get("machine_type") %>')"/></td>
	</tr>
<%
		}
	
	} else {
%>
	<tr>
		<th colspan="2">등록된 파일이 없습니다.</th>
	</tr>
<%		
	}
%>	
</table>

</body>
</html>