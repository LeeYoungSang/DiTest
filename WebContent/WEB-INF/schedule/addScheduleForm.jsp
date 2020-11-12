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
    
    function searchTime() {
    	var machineNum = $("#machine_num").val();
    	
    	if(!machineNum) {
    		alert("적용 머신을 선택하세요.");
    		return false;
    	}
    	
    	var scheduleDate = $("#datepicker").val();
    	window.open("searchTime.nao?machine_num=" + machineNum + "&schedule_date=" + scheduleDate + "&schedule_start_time=0", "", "width=1350, height=900");
    };    
	
	$(document).ready(function() {
	    
	    $("#datepicker").datepicker({
	    	 dateFormat: 'yy-mm-dd' 
	    });
		    
	    //초기값을 오늘 날짜로 설정
        $('#datepicker').datepicker('setDate', 'today'); 
	    //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)

   	    date =  $('#datepicker').val();
		    
	    $("#datepicker").change(function() {
	    	
	    	var result = confirm("날짜를 변경하면 선택한 시간의 스케줄은 초기화 됩니다.");
	    	
    		// 초기화
	    	if(result) {
				
			// 이전 일자로 유지	    
	    	} else {
	            $('#datepicker').datepicker('setDate', date);
	            $('#datepicker').blur();
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
                  <td><input type="text" name="schedule_date" id="datepicker"/></td>
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
				<tr>
					<th>시간 적용</th>
					<td>
                  		<a href="javascript:searchTime()" class="btn btn_tranfer">시간 선택</a>
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
