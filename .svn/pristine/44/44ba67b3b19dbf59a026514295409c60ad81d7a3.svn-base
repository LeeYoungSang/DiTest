<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko" xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	Map<String, Object> member  = (Map<String, Object>)session.getAttribute("member");
%>
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
<script>

	$(function()
	{
		$("#allCheck").on("click", function() 
		{
		    if ($(this).is(":checked")) 
		    {
		         $("input[name=chk]").prop("checked",  true);
		    } 
		    else 
		    {
		         $("input[name=chk]").prop("checked",  false);
		    }
		});
	});


	function fn_curChk()
	{
		var allChk = document.getElementById("allCheck");
		  
		if ( ($('.chk:checked').length) == ($('.ch').length-1) ) 
		{
			allChk.checked=true;
		}
		else
		{
			allChk.checked=false;
		}
	}
	
	function fn_allUpdate()
	{
		var val0;
		var values = document.getElementsByName("chk");
		var val1   = document.getElementById("injectionTime_BT");
		var val2   = document.getElementById("unusedTime");
		var val3   = document.getElementById("injectionTime_UUT");
		var val4   = document.getElementById("usedTimes");
		var val5   = document.getElementById("injectionTime_UT");

		var chkCnt = 0;
		
		for( var a = 0; a < values.length; a++  )
		{
			if(values[a].checked == true)
			{
				chkCnt++;
			}
		}
		
		if(chkCnt > 0)
		{
			val0 = new Array();
		}
		else
		{
			alert("수정하려는 Machine을 체크해주세요.");
			return false;
		}
		
		for( var a = 0; a < values.length; a++  )
		{
			if(values[a].checked == true)
			{
				val0.push(values[a].value);
			}
		}
		
		location.href = "updatePopMachine.nao?chkVal="+val0+"&val1="+val1.value+"&val2="+val2.value+"&val3="+val3.value+"&val4="+val4.value+"&val5="+val5.value;
		window.close();
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
<div class="wrapper group">
  
    <!-- search area -->
    <div class="top_serch">
      <div class="search_w">
        <div class="box">
          <table class="tb tb_row">
            <caption>검색</caption>
            <colgroup>
              <col width="20%">
              <col width="80%">
            </colgroup>
            <tbody>
              <tr>
              		<th><em class="must"></em>부팅시</th>
              		<td>
              			<span style="padding-right:24px;">분사시간</span>
                  		<select id="injectionTime_BT" name="injectionTime_BT" style="width: 120px;">
                  		<option value="3" style="display: none;" selected="selected">3초</option>
                  		<option value="1">1초</option>
                  		<option value="2">2초</option>
                  		<option value="3">3초</option>
                  		<option value="4">4초</option>
                  		<option value="5">5초</option>
                  		<option value="6">6초</option>
                  		<option value="7">7초</option>
                  		<option value="8">8초</option>
                  		<option value="9">9초</option>
                  		<option value="10">10초</option>
                  	</select>
              		</td>
              </tr>
              <tr>
              		<th><em class="must"></em>미사용시</th>
              		<td>
                  	<span style="padding-right:10px;">미사용시간</span>
                  	<select id="unusedTime" name="unusedTime" style="width: 120px;">
                  		<option value="4" style="display: none;" selected="selected">4시간</option>
                  		<option value="1">1시간</option>
                  		<option value="2">2시간</option>
                  		<option value="3">3시간</option>
                  		<option value="4">4시간</option>
                  		<option value="5">5시간</option>
                  		<option value="6">6시간</option>
                  		<option value="7">7시간</option>
                  		<option value="8">8시간</option>
                  		<option value="9">9시간</option>
                  		<option value="10">10시간</option>
                  	</select>
                  	<span style="padding-right:10px; padding-left:10px;">분사시간</span>
                  	<select id="injectionTime_UUT" name="injectionTime_UUT" style="width: 120px;">
                  		<option value="3" style="display: none;" selected="selected">3초</option>
                  		<option value="1">1초</option>
                  		<option value="2">2초</option>
                  		<option value="3">3초</option>
                  		<option value="4">4초</option>
                  		<option value="5">5초</option>
                  		<option value="6">6초</option>
                  		<option value="7">7초</option>
                  		<option value="8">8초</option>
                  		<option value="9">9초</option>
                  		<option value="10">10초</option>
                  	</select>
                  </td>
              </tr>
              <tr>
              		<th><em class="must"></em>사용시</th>
                  <td>
                  	<span style="padding-right:24px;">사용횟수</span>
                  	<select id="usedTimes" name="usedTimes" style="width: 120px;">
                  		<option value="60" style="display: none;" selected="selected">60회</option>
                  		<option value="10">10회</option>
                  		<option value="20">20회</option>
                  		<option value="30">30회</option>
                  		<option value="40">40회</option>
                  		<option value="50">50회</option>
                  		<option value="60">60회</option>
                  		<option value="70">70회</option>
                  		<option value="80">80회</option>
                  		<option value="90">90회</option>
                  		<option value="100">100회</option>
                  	</select>
                  	<span style="padding-right:10px; padding-left:10px;">분사시간</span>
                  	<select id="injectionTime_UT" name="injectionTime_UT" style="width: 120px;">
                  		<option value="3" style="display: none;" selected="selected">3초</option>
                  		<option value="1">1초</option>
                  		<option value="2">2초</option>
                  		<option value="3">3초</option>
                  		<option value="4">4초</option>
                  		<option value="5">5초</option>
                  		<option value="6">6초</option>
                  		<option value="7">7초</option>
                  		<option value="8">8초</option>
                  		<option value="9">9초</option>
                  		<option value="10">10초</option>
                  	</select>
                  </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
    <!--// search area -->
    
<%
	ArrayList<Map<String, Object>> machineList = (ArrayList<Map<String, Object>>)request.getAttribute("machineList");
%>
    
    <!-- contents -->
    <div id="contents" class="contents">  
      
      <!-- article --> 
      <div class="article">
                
        <div class="cnt"> 
          <h3>Machine 목록</h3> 
          <a href="javascript:fn_allUpdate();" class="btn btn_white" style="float: right; width: 200px;"><span>수정</span></a>    
          <div class="t_w">
            <table class="tb tb_col tb_result">
              <caption>Machine 목록</caption>
              <colgroup>
                <col width="5%"> 
                <col width="20%">
                <col width="8%">
                <col width="*">
                <col width="18%">
              </colgroup>                
              <thead>
              <tr>
				<th class="td_ch">
                	<label for="allCheck" class="ch">
						<input id="allCheck" type="checkbox" title="머신 전체선택" alt="머신선택" onchange="javascript:fn_curChk();"><span></span>
                	</label>
				</th> 
                <th>일련번호</th>
                <th>Type</th>
                <th>설치 장소</th>
                <th>설치 일자</th>
              </tr>
              </thead>
              <tbody>
<%
	if(machineList != null && machineList.size() > 0) {
		for(int i = 0; i < machineList.size(); i++) {
			Map<String, Object> machine = machineList.get(i);
%>
              
              <tr>
                <td class="td_ch">
                  <label for="ch_<%=i%>" class="ch">
                    <input type="checkbox" name="chk" id="ch_<%=i%>" value="<%= machine.get("machine_num") %>" class="chk" onchange="javascript:fn_curChk();"><span></span>
                  </label>
                </td>
                <td><%= machine.get("machine_num") %></td>
                <td class="tit"><a href="updateMachineForm.nao?machine_num=<%= machine.get("machine_num") %>"><%= machine.get("machine_type") %></a></td>
                <td><%= machine.get("installed_place") %></td>
                <td><%= machine.get("install_date") %></td>
              </tr>
 <%
		}
	
	} else {
%> 
              <tr>
				<th colspan="5">등록된 머신이 없습니다.</th>
			  </tr>
<%		
	}
%>				  
              </tbody>
            </table>
<!--             
            <div class="btm_btn_l">
              <a href="#" class="btn btn_white"><span>선택 그룹 삭제</span></a>
            </div>
 -->    

          </div>
          
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

<form action="updatePopMachine.nao" method="post">
	<input type="hidden" name="chkVal" id="chkVal">
	<input type="hidden" name="val1" id="val1">
	<input type="hidden" name="val2" id="val2">
	<input type="hidden" name="val3" id="val3">
	<input type="hidden" name="val4" id="val4">
	<input type="hidden" name="val5" id="val5">
</form>

</body>
</html>
