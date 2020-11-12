<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
	String machineOption = (String)request.getAttribute("machineOption");
	String[] machineVal = null;

	if(!"등록된 내용이 없습니다.".equals(machineOption))
	{
		 machineVal = machineOption.split("§");	
	}

%>
</head>
<body>
<%
	if(!"등록된 내용이 없습니다.".equals(machineOption))
	{
		for( int i =0; i < machineVal.length; i++)
		{
			
%>		
		<%=machineVal[i]%></br>
<% 		
		}
	}else{
%>
		<%=machineOption %>
<% 
	}
%>
</body>
</html>