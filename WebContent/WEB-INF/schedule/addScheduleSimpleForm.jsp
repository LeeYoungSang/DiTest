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
<script>
	var date;
	
	function addTime(start_time) {
		var hour = Math.floor(start_time / 3600);
		var minute = Math.floor((start_time / 60) % 60);
		var second = start_time % 60;
		
		var data = "<tr><td>";
		data += hour + "시" + minute + "분" + second + "초";
		data += "<input type='hidden' name='addTime' value='" + start_time + "' />";
		data += "</td></tr>";
		
		$("#addTimeList").append(data);
	}
	
    function searchMachine() {
    	window.open("searchMachine.nao", "", "width=800, height=600");
    };
    
    function searchContents() {
    	window.open("searchContents.nao", "", "width=800, height=700");
    };
    
    // 종료 시간 option 자동 입력
    function changeEndTime() {
    	var startTime = $("#start_time  option:selected").val();
    	
    	$("#end_time").html("");
    	
    	for(i = startTime; i <= 24; i++) {
    		$("#end_time").append("<option value='" + i + "'>" + i + "시</option>");
    	}
    	
    	countSchedule();
    }
    
    function countSchedule() {
   	    var fromDate =  new Date($('#from').val());
   	    var toDate = new Date($('#to').val());
   	 	
   	   	var days = ((toDate - fromDate) / 86400000) + 1;
   	   	
    	var startTime = $("#start_time option:selected").val();
    	var endTime = $("#end_time option:selected").val();
    	var termTime = $("#termTime option:selected").val();
    	
    	var machineNum = $("#machine_num").val();
    	
    	var test = (((endTime - startTime) * 3600) / termTime) * days; 
    	
		$.ajax({
			url					: "dupsSchedule.nao",
			method			: "POST",
			dataType		: "json",
			data				: {
				fromDate	: $('#from').val(),
				toDate		: $('#to').val(),
				startTime	: startTime,
				endTime	: endTime,
				termTime	: termTime,
				machineNum : machineNum
			},
			success		: function(data) {
				var dups = data.countDups;
				test -= dups;
		    	$("#countPrint").html(test + "회, " + (test * 150) + "원");
			},
			error 			: function(xhr, data, error) {
			}
		});		
    }
	
	$(document).ready(function() {
	    
	    $("#from").datepicker({
	    	 dateFormat: 'yy-mm-dd' 
	    });

	    $("#to").datepicker({
	    	 dateFormat: 'yy-mm-dd' 
	    });
	    
	    //초기값을 오늘 날짜로 설정
        $('#from').datepicker('setDate', 'today');
        $('#to').datepicker('setDate', 'today'); 
	    //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)

 	    $("#to").change(function() {
 	    	
 	   	    var fromDate =  $('#from').val();
 		    var toDate = $('#to').val();

 		    if(fromDate > toDate) {
 	    		alert("종료 일자가 시작 일자보다 작습니다.");
 	            $('#to').val('');
 	    	
 		    } else {
 		    	countSchedule(); 		    	
 		    } 	    	
	    }); 
	});
	
	function formSubmit() {
		$("form").submit();
	}
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
          <h3>schedule 등록</h3>  
          
			<form action="addSchedule.nao" method="post">
          
          <div class="t_w">
            <table class="tb tb_row tb_ip st01">
              <caption>세미나 정보</caption>
              <colgroup>
                <col width="18%">
                <col width="82%"> 
              </colgroup>
              <tbody>
                <tr>
                  <th>schedule 날짜</th>
                  <td>
                  		시작 일자 : <input type="text" name="schedule_date" id="from"/>
                  		종료 일자 : <input type="text" name="schedule_date" id="to"/>
                  </td>
                </tr>
                <tr>
                  <th>schedule 시간</th>
                  <td>
                  		시작 시간 : 
                  		<select id="start_time" onChange="changeEndTime()">
<%
	for(int i = 0; i < 24; i++) {
%>
							<option value="<%=i %>"><%= i %>시</option>                  		
<%
	}
%>
                  		</select>
                  		종료 시간 : 
                  		<select id="end_time" onChange="countSchedule()">
                  			<option value="1">1시</option>
                  		</select>
                  </td>
                </tr>
                <tr>
                  <th>schedule Option</th>
                  <td>
                  		시간 간격 : 
                  		<select id="termTime" onChange="countSchedule()">
							<option value="15">15초</option>                  		
							<option value="30">30초</option>                  		
							<option value="60">1분</option>                  		
							<option value="300">5분</option>                  		
							<option value="600">10분</option>                  		
                  		</select>
                  		<span id="countPrint"></span>        
                 </td>
                </tr>
                <tr>
                  <th>적용 machine</th>
                  <td>
                  		<a href="javascript:searchMachine()" class="btn btn_tranfer">머신 선택</a>                  
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="machineText"></span>
						<input type="hidden" name="machine_num" id="machine_num" />    
				</td>              
                <tr>
                  <th>적용 contents</th>
                  <td>
                  		<a href="javascript:searchContents()" class="btn btn_tranfer">컨텐츠 선택</a>                  
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="contentsText"></span>
						<input type="hidden" name="contents_num" id="contents_num" />
					</td>                        
                </tr>
              </tbody>
            </table>
          </div>
          
          <div class="btn_area_b">             
            <a href="javascript:formSubmit()" class="btn btn_tranfer"><span>등록</span></a>              	
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
