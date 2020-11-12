<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="/DiClean/js/jquery-1.11.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script>
	// 스케줄 출력
	function printSchedule(machineNum) {
		var scheduleDate = $("#datepicker").val();
		
		$.ajax({
			url				: "selectSchedule.nao",
			method		: "POST",
			data				: {
				machine_num	: machineNum,
				schedule_date : scheduleDate
			},
			dataType		: "html",
			success		: function(data) {
				$("#timeCheck").html(data);
			},
			error 			: function(xhr, data, error) {
	   			alert("스케줄 검색 실패");
			}
		});		
	}

	$(document).ready(function(){
	    $("#machineBtn").click(function() {
	    	window.open("searchMachine.nao", "", "width=400, height=400");
	    });
	    
	    $("#contentsBtn").click(function() {
	    	window.open("searchContents.nao", "", "width=400, height=400");
	    });
	    
	    $("#datepicker").datepicker({
	    	 dateFormat: 'yy-mm-dd' 
	    });
	    
	    //초기값을 오늘 날짜로 설정
        $('#datepicker').datepicker('setDate', 'today'); 
	    //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
	    
	    $("#datepicker").change(function() {
	    	
	    	if($("#machineText").html()) {
	    		printSchedule($("#machine_num").val());
	    	};
	    });
	});
</script>
</head>
<body>
<h1>DiClean Platform</h1>
<hr/>

<%@ include file="../common/topMenu.jsp" %>

스케줄관리 > 스케줄등록<br/>

<form action="addSchedule.nao" method="post">
<table>
	<tr>
		<td>
			<div  style="overflow: auto; width: 1000px; border-style: solid; border-width: 1px">
			<table border="1">
				<tr id="timeTitle">
<%
 	for(int i = 0; i < 5760; i++) {
		int second = (i * 15) % 60;
		int minute = (i * 15) / 60;
		int hour = minute / 60;
		minute = minute % 60; 
%>				
					<td><%= hour %>:<%= minute %>:<%= second %></td>
<%
	}
%>					
				</tr>
				<tr id="timeCheck">
<%
	for(int i = 0; i < 5760; i++) {
%>		
		<td><input type="checkbox" name="schedule_time" value="<%= i * 15 %>"/></td>
<%
	}
%>		
				</tr>
			</table>
			</div>
		</td>
	</tr>
</table>
<hr/>
선택 machine : <span id="machineText"></span><br/>
선택 contents : <span id="contentsText"></span>
<hr/>
<table border="1">
	<tr>
		<th>스케줄 날짜</th>
		<td><input type="text" name="schedule_date" id="datepicker"/></td>
	</tr>
	<tr>
		<th>적용 machine</th>
		<td>
			<input type="button" value="머신선택" id="machineBtn" />
			<input type="hidden" name="machine_num" id="machine_num" />
		</td>
	</tr>
	<tr>
		<th>적용 contents</th>
		<td>
			<input type="button" value="컨텐츠선택" id="contentsBtn"/>
			<input type="hidden" name="contents_num" id="contents_num" />
		</td>
	</tr>
	<tr>
		<th colspan="2">
			<input type="submit" value="등록" />
		</th>
	</tr>
</table>
</form>

</body>
</html>