<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko" xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="">
<meta name="keywords" content="">
<title>Naosoft</title>
<link type="text/css" rel="stylesheet" href="common/css/default.css" />
<script type="text/javascript" src="common/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="common/js/design.js"></script>

<%
	String machine_num = request.getParameter("machine_num");
	String schedule_date = request.getParameter("schedule_date");
	String start_time = request.getParameter("schedule_start_time");	
%>

<script>
	function selectTime(start_time) {
		opener.addTime(start_time);
		window.close();
	}
	
	function getTime() {
		var hour = $("#hour option:selected").val();
		var time = hour * 3600;
		
		location.href = "searchTime.nao?machine_num=<%= machine_num %>&schedule_date=<%= schedule_date %>&schedule_start_time=" + time;
	}

	function setTime() {
		$('input:checkbox:checked').each(function(e){
			var start_time = $(this).val();

			selectTime(start_time);
	    });
	};
</script>
</head>
<body>

<!-- 스킵 네비게이션 -->
<div class="skip_navi">
    <a href="#contents">본문으로 가기</a>
    <a href="#gnb">주메뉴로 가기</a>
    <a href="#footer">카피라이트로 가기</a>
</div>
<!-- // 스킵 네비게이션 -->

<!-- wrapper -->
<div class="wrapper group" style="min-width: auto">

<%
	ArrayList<Map<String, Object>> scheduleList = (ArrayList<Map<String, Object>>)request.getAttribute("scheduleList");
	
	System.out.println(" :::::::::: " + scheduleList);
	
	int schedule_start_time = 0;	
	
	if(start_time != null) {
		schedule_start_time = Integer.parseInt(start_time);
	}
%>

    <!-- contents -->
    <div id="contents" class="contents" style="margin: 0;">  
      
      <!-- article --> 
      <div class="article">
                
        <div class="cnt"> 
          <h3>시간 선택</h3>  
          
          <div class="t_w">
            <table class="tb tb_col tb_result">
              <caption>시간 선택</caption>
              <colgroup>
                <col width="5%">
                <col width="5%">
                <col width="5*">
                <col width="5%">
                <col width="5%">
                <col width="5%">
                <col width="5%">
                <col width="5%">
                <col width="5%">
                <col width="5%">
                <col width="5%">
                <col width="5%">
                <col width="5%">
                <col width="5%">
                <col width="5%">
                <col width="5%">
                <col width="5%">
                <col width="5%">
                <col width="5%">
                <col width="5%">
              </colgroup>                
              <thead>
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
<%-- 						<a href="searchTime.nao?machine_num=<%= machine_num %>&schedule_date=<%= schedule_date %>&schedule_start_time=<%= pre_start_time %>">&lt;</a> --%>
						<select style="width: 100px" id="hour" onChange="getTime()">
<%
	for(int i = 0; i < 24; i++) {
		
		if((schedule_start_time / 3600) == i) {
%>						
							<option value="<%= i  %>" selected="selected"><%= i %>시</option>
<%
		} else {
%>
							<option value="<%= i  %>"><%= i %>시</option>
<%
		}
	}
%>							
						</select> 
<!-- 						시작시간 <input type="text" sty/>
						종료시간 <input type="text" /> -->
<%-- 						<a href="searchTime.nao?machine_num=<%= machine_num %>&schedule_date=<%= schedule_date %>&schedule_start_time=<%= next_start_time %>">&gt;</a> --%>
					</th>
				</tr>
              </thead>
              <tbody>
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
			
			boolean isChecked = false;
			int total = schedule_start_time + (i * 5* 60)+ (j * 15);
			
			for(int k = 0; k < scheduleList.size(); k++) {
				Map<String, Object> schedule = scheduleList.get(k);
				
				if( (Integer)(schedule.get("schedule_start_time")) == total ) {
%>
							<td style="color: white; background-color: red;">X</td>
<%-- 					<td><input type="checkbox" name="schedule_time" id="ch_01" value="<%= schedule_start_time + (i * 5* 60)+ (j * 15) %>" checked="checked" disabled="disabled"/></td> --%>
<%
					scheduleList.remove(k);
					isChecked = true;
					break;
				}
			}
			
			if( ! isChecked ) {
%>		
					<td><input type="checkbox" name="schedule_time" id="ch_01" value="<%= schedule_start_time + (i * 5* 60)+ (j * 15) %>"/></td>
<%
			}
		}
%>
				</tr>
<%
	}
%>		
              </tbody>
            </table>
            
          </div>
          
        </div>         

      </div>
      <!--// article -->            

		<p/>
		<a href="javascript:setTime()" class="btn btn_tranfer">적용</a>

    </div>
    <!--// contents -->      
    
</div>
<!--// wrapper -->        

</body>
</html>