<%@page import="java.util.ArrayList"%>
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
<h1>DiClean Platform</h1>
<hr/>

<%@ include file="../common/topMenu.jsp" %>

<%
	ArrayList<Map<String, Object>> scheduleList = (ArrayList<Map<String, Object>>)request.getAttribute("scheduleList");
%>

스케줄관리 > 스케줄목록<br/>
<table border="1">
	<tr>
		<th>번호</th>
		<th>스케줄 일자</th>
		<th>시작시간</th>
		<th>적용 machine</th>
		<th>적용 contents</th>
	</tr>
<%
	if(scheduleList != null && scheduleList.size() > 0) {
		for(int i = 0; i < scheduleList.size(); i++) {
			Map<String, Object> schedule = scheduleList.get(i);
			
			int start_time = (Integer)schedule.get("schedule_start_time");
			int h = start_time / (60 * 60);
			
			start_time = start_time - (h * 60 * 60);
			int m = start_time / 60;
			int s = start_time % 60;			
%>
	<tr>
		<td><%= schedule.get("num") %></td>
		<td><a href="updateScheduleForm.nao?schedule_num=<%= schedule.get("num") %>"><%= schedule.get("schedule_date") %></a></td>
		<td><%= h %>시 <%= m %>분 <%= s %>초 (<%= schedule.get("schedule_start_time") %>)</td>
		<td><a href="updateMachineForm.nao?machine_num=<%= schedule.get("machine_num") %>"><%= schedule.get("machine_num") %></a></td>
		<td><a href="updateContentsForm.nao?contents_num=<%= schedule.get("contents_num") %>"><%= schedule.get("contents_num") %></a></td>
	</tr>
<%
		}
	
	} else {
%>
	<tr>
		<th colspan="5">등록된 스케줄이 없습니다.</th>
	</tr>
<%		
	}
%>	
</table>
<br/>
<a href="addScheduleForm.nao">스케줄 등록</a>

</body>
</html>