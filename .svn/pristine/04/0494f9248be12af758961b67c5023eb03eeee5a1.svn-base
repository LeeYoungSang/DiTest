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
              <a href="addScheduleForm.nao" class="btn btn_white" style="width:130px"><span>상세 등록</span></a>
              <!-- <a href="addScheduleSimpleForm.nao" class="btn btn_white" style="width:130px"><span>간편 등록</span></a> -->
            </div>
          </div>
        </div>
      </div>
    </div>
    <!--// search area -->
    
<%
	ArrayList<Map<String, Object>> scheduleList = (ArrayList<Map<String, Object>>)request.getAttribute("scheduleList");
%>
    
    <!-- contents -->
    <div id="contents" class="contents">  
      
      <!-- article --> 
      <div class="article">
                
        <div class="cnt"> 
          <h3>schedule 목록</h3>     
          
          <div class="t_w">
            <table class="tb tb_col tb_result">
              <caption>컨텐츠 목록</caption>
              <colgroup>
                <!-- <col width="5%"> -->
                <col width="8%">
                <col width="20%">
                <col width="20%">
                <col width="*">
                <col width="15%">
              </colgroup>                
              <thead>
              <tr>
                <!-- <th></th> -->
                <th>번호</th>
                <th>schedule 일자</th>
                <th>시작시간</th>
                <th>적용 machine</th>
                <th>적용 contents</th>
              </tr>
              </thead>
              <tbody>
<%
if(scheduleList != null && scheduleList.size() > 0) {
	for(int i = 0; i < scheduleList.size(); i++) {
		Map<String, Object> schedule = scheduleList.get(i);
		
		int start_time = (Integer)schedule.get("schedule_start_time");
		int h = start_time / (60 * 60);
		
		start_time = start_time - (h * 60 * 60);
		int m = start_time / 60;
		int s = start_time % 60;		
%> 
              <tr>
<!--               
                <td class="td_ch">
                  <label for="ch_01" class="ch">
                    <input type="checkbox" name="sd1" id="ch_01"><span></span>
                  </label>
                </td>
 -->                
				<td><%= schedule.get("num") %></td>
                <td><a href="updateScheduleForm.nao?schedule_num=<%= schedule.get("num") %>"><%= schedule.get("schedule_date") %></a></td>
                <td class="tit"><%= h %>시 <%= m %>분 <%= s %>초 (<%= schedule.get("schedule_start_time") %>)</a></td>
                <td><a href="updateMachineForm.nao?machine_num=<%= schedule.get("machine_num") %>"><%= schedule.get("machine_num") %></a></td>
                <td><a href="updateContentsForm.nao?contents_num=<%= schedule.get("contents_num") %>"><%= schedule.get("contents_num") %></a></td>
              </tr>
 <%
		}
	
	} else {
%> 
              <tr>
				<th colspan="5">등록된 공지사항이 없습니다.</th>
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
              <a href="scheduleList.nao?pn=1" class="pagn_btn page_first">처음</a>
              <a href="scheduleList.nao?pn=<%= startPage - 1 %>" class="pagn_btn page_before">이전</a>
<%
	}

	for(int i = startPage; i < startPage + 10; i++) {
		if(i > totalPage ) {
			break;
		}
		
		if(i == pn) {
%>              
              <a href="scheduleList.nao?pn=<%= i %>" class="ac"><span><%= i %></span></a>
<%			
		} else {
%>
              <a href="scheduleList.nao?pn=<%= i %>"><span><%= i %></span></a>
<%			
		}
	}
	
	if(startPage + 10 <= totalPage) {
%>      
              <a href="scheduleList.nao?pn=<%= startPage + 10 %>" class="pagn_btn page_next">다음</a>
              <a href="scheduleList.nao?pn=<%= totalPage %>" class="pagn_btn page_last">마지막</a>
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
