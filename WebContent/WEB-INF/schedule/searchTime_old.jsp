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
<%
	String machine_num = request.getParameter("machine_num");
	String schedule_date = request.getParameter("schedule_date");
	String start_time = request.getParameter("schedule_start_time");	
%>
<script>
	function selectTime(start_time) {
		opener.addTime(start_time);
		
/* 		$("#timeText", opener.document).html(timeText);
		$("#schedule_start_time", opener.document).attr("value", start_time);
 */		window.close();
	}
	
	function getTime() {
		var hour = $("#hour option:selected").val();
		var minute = $("#minute option:selected").val();

		var time = (hour * 60 * 60) + (minute * 60);
		
		location.href = "searchTime.nao?machine_num=<%= machine_num %>&schedule_date=<%= schedule_date %>&schedule_start_time=" + time;
	}

	$(document).ready(function() {
		$("#timeBtn").click(function() {
			$('input:checkbox:checked').each(function(e){
				var start_time = $(this).val();

				selectTime(start_time);
		    });
			
			
		});
	});
</script>
</head>
<body>
<h1>DiClean Platform</h1>
<hr/>

<%
	ArrayList<Map<String, Object>> scheduleList = (ArrayList<Map<String, Object>>)request.getAttribute("scheduleList");
	
	int schedule_start_time = 0;	
	
	if(start_time != null) {
		schedule_start_time = Integer.parseInt(start_time);
	}
%>

<table>
	<tr>
		<td>
			<div  style="border-style: solid; border-width: 1px">
			<table border="1">
				<tr>
					<th colspan="20">
<%
	int pre_start_time = schedule_start_time - 3600;

	if(pre_start_time < 0) {
		pre_start_time = 0;
	}
	
	int next_start_time = schedule_start_time + 3600;
	
	if(next_start_time >= 86400) {
		next_start_time = 82800;
	}
%>					
						<a href="searchTime.nao?machine_num=<%= machine_num %>&schedule_date=<%= schedule_date %>&schedule_start_time=<%= pre_start_time %>">&lt;</a> 
						&nbsp;&nbsp;&nbsp;<%= schedule_start_time / 3600 %>시&nbsp;&nbsp;&nbsp; 
						<a href="searchTime.nao?machine_num=<%= machine_num %>&schedule_date=<%= schedule_date %>&schedule_start_time=<%= next_start_time %>">&gt;</a>
					</th>
				</tr>
<%
	for(int i = 0; i < 12; i++) {
%>
				<tr id="timeTitle">
<%
		for(int j = 0; j < 20; j++) {
			int total = j * 15;
				
			// 5분단위로 줄바꿈
			int minute = (i * 5) + (total / 60);
			int second = total % 60;
%>				
					<td><%= minute %>m<%= second %>s</td>
<%
		}
%>
				</tr>
				<tr id="timeCheck">
<%
		for(int j = 0; j < 20; j++) {
%>		
					<td><input type="checkbox" name="schedule_time" value="<%= schedule_start_time + (i * 5* 60)+ (j * 15) %>"/></td>
<%
		}
%>
				</tr>
<%
	}
%>		
			</table>
			</div>
		</td>
	</tr>
</table>
<p/>
<input type="button" id="timeBtn" value="적용" />
</body>
</html>