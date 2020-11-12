<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	ArrayList<Map<String, Object>> reservationList = (ArrayList<Map<String, Object>>)request.getAttribute("reservationList");
	System.out.println(reservationList);
	
	int index = 0;
	
	for(int i = 0; i < 5760; i++) {
//		System.out.println( (i * 15) + " : " + (Integer)(reservationList.get(index).get("schedule_start_time")) );
		
		if(index < reservationList.size() && (i * 15) == (Integer)(reservationList.get(index).get("schedule_start_time"))) {
			index++;
%>
		<td><input type="checkbox" name="schedule_time" value="<%= i * 15 %>" checked="checked" disabled="disabled"/></td>
<%		
		} else {
%>		
		<td><input type="checkbox" name="schedule_time" value="<%= i * 15 %>"/></td>
<%
		}
	}
%>

