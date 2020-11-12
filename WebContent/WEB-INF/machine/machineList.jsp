<%@page import="java.util.ArrayList"%>
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

	function fn_allUpdate()
	{
		window.open("machinePopList.nao","일괄 수정 ","width=1250,height=750,scrollbars=yes,resizable=yes");
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

	<%@ include file="../common/header.jsp" %>
  
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
                <th>Machine 명</th>
                <td><input type="text" name="" value=""></td>
              </tr>
            </tbody>
          </table>
          <div class="btn_w">
            <div class="w">
              <a href="#" class="btn btn_sch"><span>검색</span></a>
<%
	if("00".equals((String)member.get("division"))) {
%>
              <a href="addMachineForm.nao" class="btn btn_white"><span>Machine 등록</span></a>
<%		
	}
%>              
            </div>
          </div>
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
          <a href="javascript:fn_allUpdate();" class="btn btn_white" style="float: right; width: 200px;"><span>일괄 수정</span></a>    
          <div class="t_w">
            <table class="tb tb_col tb_result">
              <caption>Machine 목록</caption>
              <colgroup>
                <!-- <col width="5%"> -->
                <col width="20%">
                <col width="8%">
                <col width="*">
                <col width="18%">
              </colgroup>                
              <thead>
              <tr>
                <!-- <th></th> -->
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
<!--               
                <td class="td_ch">
                  <label for="ch_01" class="ch">
                    <input type="checkbox" name="sd1" id="ch_01"><span></span>
                  </label>
                </td>
 -->                
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
<%
	int totalRow = (Integer)request.getAttribute("totalRow");
	int pn = (Integer)request.getAttribute("pn");
	
	int startPage = (((pn - 1) / 10) * 10) + 1;
	int totalPage = ((totalRow - 1) / 10) + 1;
%>         
            <div class="paging">
<%
	if(startPage > 1) {
%>            
              <a href="machineList.nao?pn=1" class="pagn_btn page_first">처음</a>
              <a href="machineList.nao?pn=<%= startPage - 1 %>" class="pagn_btn page_before">이전</a>
<%
	}

	for(int i = startPage; i < startPage + 10; i++) {
		if(i > totalPage ) {
			break;
		}
		
		if(i == pn) {
%>
              <a href="machineList.nao?pn=<%= i %>" class="ac"><span><%= i %></span></a>
<%			
		} else {
%>
              <a href="machineList.nao?pn=<%= i %>"><span><%= i %></span></a>
<%			
		}
	}
	
	if(startPage + 10 <= totalPage) {
%>              
              <a href="machineList.nao?pn=<%= startPage + 10 %>" class="pagn_btn page_next">다음</a>
              <a href="machineList.nao?pn=<%= totalPage %>" class="pagn_btn page_last">마지막</a>
<%
	}
%>              
            </div>

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

</body>
</html>
