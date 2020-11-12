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
<script>
	function selectMachine(machineNum, machineType) {
		$("#machineText", opener.document).html(machineType);
		$("#machine_num", opener.document).attr("value", machineNum);
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
<div class="wrapper group" style="min-width: auto">

<%
	ArrayList<Map<String, Object>> machineList = (ArrayList<Map<String, Object>>)request.getAttribute("machineList");
%>

    <!-- contents -->
    <div id="contents" class="contents">  
    
      <!-- article --> 
      <div class="article">
                
        <div class="cnt"> 
          <h3>Machine 목록</h3>     
          
          <div class="t_w">
            <table class="tb tb_col tb_result">
              <caption>Machine 목록</caption>
              <colgroup>
                <!-- <col width="5%"> -->
                <col width="25%">
                <col width="8%">
                <col width="*">
                <col width="10%">
              </colgroup>                
              <thead>
              <tr>
                <!-- <th></th> -->
                <th>일련번호</th>
                <th>Type</th>
                <th>설치 장소</th>
                <th>&nbsp;</th>
              </tr>
              </thead>
              <tbody>    
<%
	if(machineList != null && machineList.size() > 0) {
		for(int i = 0; i < machineList.size(); i++) {
			Map<String, Object> machine = machineList.get(i);
			
%>
              <tr>
                <td><%= machine.get("machine_num") %></td>
                <td class="tit"><%= machine.get("machine_type") %></td>
                <td><%= machine.get("installed_place") %></td>
                <td><a href="javascript:selectMachine('<%= machine.get("machine_num") %>', '<%= machine.get("machine_type") %>')" class="btn btn_tranfer">선택</a></td>
              </tr>
<%
		}
	
	} else {
%>
				<tr>
					<th colspan="4">등록된 머신이 없습니다.</th>
				</tr>
<%		
	}
%>	
              </tbody>
            </table>
            
            <div class="paging">
              <a href="#" class="pagn_btn page_first">처음</a>
              <a href="#" class="pagn_btn page_before">이전</a>
              <a href="#" class="ac"><span>1</span></a>
              <a href="#"><span>2</span></a>
              <a href="#"><span>3</span></a>
              <a href="#"><span>4</span></a>
              <a href="#"><span>5</span></a>
              <a href="#"><span>6</span></a>
              <a href="#"><span>7</span></a>
              <a href="#"><span>8</span></a>
              <a href="#"><span>9</span></a>
              <a href="#"><span>10</span></a>
              <a href="#" class="pagn_btn page_next">다음</a>
              <a href="#" class="pagn_btn page_last">마지막</a>
            </div>

          </div>
          
        </div>
        
      </div>
      <!--// article --> 
    
    	   
    </div>
    <!--// contents -->            

</div>
<!--// wrapper -->

</body>
</html>