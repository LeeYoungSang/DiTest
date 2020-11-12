<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

					<div class="divi divi1"> <!-- 설명 : 분할 개수에 따라 클래스 적용, divi1, divi2, divi3, divi21, divi12 -->
<%
	ArrayList<Map<String, Object>> layerList = (ArrayList<Map<String, Object>>)request.getAttribute("layerList");

	if(layerList != null) {
		for(int i = 0; i < layerList.size(); i++) {
			Map<String, Object> layer = layerList.get(i);
			
			String [] filePath = layer.get("file_name").toString().split("\\.");
			String ext = filePath[filePath.length - 1];
			
			String viewData = "";
			
 	    	if(ext.toLowerCase().equals("mp4")) {
 				viewData = "<video  src='upload/" + layer.get("file_name") + "'  style='width:100%' type='video/mp4' muted autoplay/>"; 				
 				
 	    	} else {
 	    		viewData = "<img  src='upload/" + layer.get("file_name") + "'  style='width:100%; height:100%' />";
			}
%>
						<div style="width:<%= layer.get("layer_width") %>px; height: <%= layer.get("layer_height") %>px; background-color: black; position: absolute; left: <%= layer.get("layer_x") %>px; top: <%= layer.get("layer_y") %>px">
							<%= viewData %>			
						</div>
<%
		}
	}
%>					
					</div>

