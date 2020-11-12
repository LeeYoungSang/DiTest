<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	ArrayList<Map<String, Object>> scheduleList = (ArrayList<Map<String, Object>>)request.getAttribute("specialScheduleList");

	String scheduleJson = "{\"SCHEDULE_LIST\":[";
	
	boolean isFirst = true;
	
	for(int i = 0; i < scheduleList.size();  ) {
		
		if(isFirst) {
			isFirst = false;
		} else {
			scheduleJson += ",";
		}
		
		Map<String, Object> schedule = scheduleList.get(i);
		
		scheduleJson += "{\"CONTENTS_NUM\":\"" + schedule.get("contents_num") + "\",";

		if( i + 1 < scheduleList.size()) {
			Map<String, Object> nextSchedule = scheduleList.get(i + 1);
			
			if(schedule.get("contents_num").equals(nextSchedule.get("contents_num"))) {
				scheduleJson +="\"SCHEDULE\": [{\"LOCATION\":\"" + schedule.get("layer_id") + "\",";
				scheduleJson +="\"FILE_NAME\":\"" + schedule.get("file_name") + "\"} , ";
				scheduleJson +="{\"LOCATION\":\"" + nextSchedule.get("layer_id") + "\",";
				scheduleJson +="\"FILE_NAME\":\"" + nextSchedule.get("file_name") + "\"}]}  ";
				
				i = i + 2;
			
			} else {
				scheduleJson +="\"SCHEDULE\": [{\"LOCATION\":\"" + schedule.get("layer_id") + "\",";
				scheduleJson +="\"FILE_NAME\":\"" + schedule.get("file_name") + "\"}]} ";
				
				i = i + 1;
			}
		
		} else {
			scheduleJson +="\"SCHEDULE\": [{\"LOCATION\":\"" + schedule.get("layer_id") + "\",";
			scheduleJson +="\"FILE_NAME\":\"" + schedule.get("file_name") + "\"}]} ";
			
			i = i + 1;
		}
	}

	scheduleJson += "]}";
%>

<%= scheduleJson %>