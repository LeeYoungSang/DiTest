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
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script type="text/javascript" src="common/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="common/js/design.js"></script>

<%
	Map<String, Object> schedule = (Map<String, Object>)request.getAttribute("schedule");
%>

<script>
	function timeBtn() {
		var machine_num = $("#machine_num").val();
		var schedule_date = $("#datepicker").val();
		var schedule_start_time = $("#schedule_start_time").val();
		
		window.open("searchTime.nao?machine_num=" + machine_num + "&schedule_date=" + schedule_date + "&schedule_start_time=" + schedule_start_time, "", "width=1300, height=900");
	};
	
	function machineBtn() {
		window.open("searchMachine.nao?mode=1", "", "width=800, height=600");
	};
	
	function contentsBtn() {
    	window.open("searchContents.nao", "", "width=800, height=700");
	};
	
	function updateBtn() {
		$("form").submit();
	};	
	
	$(document).ready(function(){
		$("#datepicker").datepicker({
			 dateFormat: 'yy-mm-dd' 
		});
	});

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
<div class="wrapper tranfer">

	<%@ include file="../common/header.jsp" %>

    <!-- contents -->
    <div id="contents" class="contents">  
      
      <!-- article --> 
      <div class="article">
                
        <div class="cnt"> 
          <h3>schedule 정보</h3>  
          
			<form action="updateSchedule.nao" method="post">
          
          <div class="t_w">
            <table class="tb tb_row tb_ip st01">
              <caption>세미나 정보</caption>
              <colgroup>
                <col width="18%">
                <col width="82%"> 
              </colgroup>
              <tbody>
                <tr>
                  <th>schedule 번호</th>
                  <td>
						<%=  schedule.get("schedule_num") %>
						<input type="hidden" name="schedule_num" value="<%=  schedule.get("schedule_num") %>" />
                  </td>
                </tr>              
                <tr>
                  <th>schedule 날짜</th>
                  <td>
                  		<input type="text" name="schedule_date" id="datepicker" value="<%= schedule.get("schedule_date") %>" />
                  </td>
                </tr>
				<tr>
					<th>시작시간</th>
					<td>
<%
	int second = (Integer)(schedule.get("schedule_start_time"));
	int hour = second / (60 * 60);
	second = second - (hour * 60 * 60);
	int minute = second / 60;
	second = second - (minute * 60);
%>		
						<a href="javascript:timeBtn()" class="btn btn_tranfer">시간선택</a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="timeText"><%= hour %>시<%= minute %>분 <%= second %>초</span> 
						<input type="hidden" id="schedule_start_time" name="schedule_start_time" value="<%= schedule.get("schedule_start_time") %>" />
					</td>
				</tr>
                <tr>
                  <th>적용 machine</th>
                  <td>
						<a href="javascript:machineBtn()" class="btn btn_tranfer">머신선택</a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="machineText"><%= schedule.get("machine_type") %></span>
						<input type="hidden" id="machine_num" name="machine_num" value="<%= schedule.get("machine_num") %>" />
				</td>              
                <tr>
                  <th>적용 contents</th>
                  <td>
						<a href="javascript:contentsBtn()" class="btn btn_tranfer">컨텐츠선택</a>                  
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="contentsText"><%= schedule.get("contents_title") %></span>
						<input type="hidden" name="contents_num" id="contents_num" value="<%= schedule.get("contents_num") %>" />
					</td>                        
                </tr>         
              </tbody>
            </table>
          </div>
          
          <div class="btn_area_b">             
            <a href="javascript:updateBtn()" class="btn btn_tranfer"><span>수정</span></a>     
            <a href="deleteSchedule.nao?schedule_num=<%= schedule.get("schedule_num") %>" class="btn btn_reset"><span>삭제</span></a>               	         	
          </div>
          <hr/>
          
          	<table id="addTimeList" border="1">
			</table>
          </form>			
        </div>
        
      </div>
      <!--// article --> 
    
    	   
    </div>
    <!--// contents -->
    
  <!-- footer -->
  <div id="footer" class="footer" > 
    <p class="c">Copyright ⓒ. All rights reserved.</p>

  </div>
  <!--// footer --> 

</div>
<!--// wrapper -->

</body>
</html>