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
                <th>일자</th>
                <td><input type="text" name="" value=""></td>
              </tr>
            </tbody>
          </table>
          <div class="btn_w">
            <div class="w">
              <a href="#" class="btn btn_sch" style="width:130px"><span>검색</span></a>
              <!-- <a href="addSpecialScheduleForm.nao" class="btn btn_white" style="width:130px"><span>상세 등록</span></a> -->
            </div>
          </div>
        </div>
      </div>
    </div>
    <!--// search area -->
    
<%
	ArrayList<Map<String, Object>> scheduleList = (ArrayList<Map<String, Object>>)request.getAttribute("specialScheduleList");
	String schedule_date = (String)request.getAttribute("schedule_date");
%>
    
    <!-- contents -->
    <div id="contents" class="contents">  
      
      <!-- article --> 
      <div class="article">
                
        <div class="cnt"> 
          <h3>Special schedule 등록 현황</h3>     
          
          <div class="t_w">
            <table class="tb tb_col tb_result">
              <caption>special schedule 목록</caption>
              <colgroup>
                <!-- <col width="5%"> -->
                <col width="20%">
                <col width="*">
                <col width="20%">
              </colgroup>                
              <thead>
              <tr>
                <!-- <th></th> -->
                <th>machine 번호</th>
                <th>설치 장소</th>
                <th>프리미엄 스케줄 등록 겟수</th>
              </tr>
              </thead>
              <tbody>
<%
if(scheduleList != null && scheduleList.size() > 0) {
	for(int i = 0; i < scheduleList.size(); i++) {
		Map<String, Object> schedule = scheduleList.get(i);
%> 
              <tr>             
				<td><%= schedule.get("machine_num") %></td>
                <td><%= schedule.get("installed_place") %></td>
                <td><a href="specialScheduleListByMachine.nao?machine_num=<%= schedule.get("machine_num") %>&schedule_date=<%= schedule_date %>"><%= schedule.get("cnt") %></a></td>
              </tr>
 <%
		}
	
	} else {
%> 
              <tr>
				<th colspan="3">등록된 스케줄이 없습니다.</th>
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
              <a href="specialScheduleList.nao?pn=1" class="pagn_btn page_first">처음</a>
              <a href="specialScheduleList.nao?pn=<%= startPage - 1 %>" class="pagn_btn page_before">이전</a>
<%
	}

	for(int i = startPage; i < startPage + 10; i++) {
		if(i > totalPage ) {
			break;
		}
		
		if(i == pn) {
%>              
              <a href="specialScheduleList.nao?pn=<%= i %>" class="ac"><span><%= i %></span></a>
<%			
		} else {
%>
              <a href="specialScheduleList.nao?pn=<%= i %>"><span><%= i %></span></a>
<%			
		}
	}
	
	if(startPage + 10 <= totalPage) {
%>      
              <a href="specialScheduleList.nao?pn=<%= startPage + 10 %>" class="pagn_btn page_next">다음</a>
              <a href="specialScheduleList.nao?pn=<%= totalPage %>" class="pagn_btn page_last">마지막</a>
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
