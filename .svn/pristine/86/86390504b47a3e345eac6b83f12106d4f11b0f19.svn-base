<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	Map<String, Object> member  = (Map<String, Object>)session.getAttribute("member");
%>
    
    <!-- head -->
    <div id="header" class="header">
    
    	<!-- head wrap -->
      <div class="hd_w fix">
            
        <h1><a href="#"><img src="images/hd_logo.png" alt="Naosoft" width="55%"></a></h1>    
        
        <!-- top navigation -->        
        <div class="hd_gnb">
          <ul id="gnb" class="dep1_list fix">
            <li class="li01"><a href="statisticsListByAdvertiser.nao" class="dep1"><span>광고 통계</span></a></li>
<!--             <li class="li02"><a href="fileList.nao" class="dep1"><span>파일관리</span></a></li>
            <li class="li03"><a href="contentsList.nao" class="dep1"><span>컨텐츠관리</span></a></li> 
            <li class="li04"><a href="scheduleList.nao" class="dep1"><span>스케줄관리</span></a></li>            
            <li class="li05"><a href="specialScheduleStatusList.nao" class="dep1"><span>Special 스케줄</span></a></li>            
            <li class="li05"><a href="noticeList.nao" class="dep1"><span>커뮤니티</span></a></li>            
 -->          </ul> 
        </div> 
        <!--// top navigation -->
        
        <div class="hd_sgnb">
 <%
 	if(member != null) {
 %>
          <a href="logout.nao" title="로그아웃"><span>Logout</span></a>
<%
 	} else {
%> 
          <a href="#" title="로그인"><span>Login</span></a>
          <a href="#" title="회원가입"><span>Join US</span></a>
<%
 	}
%>
        </div>
        
      </div>  
      <!--// head wrap -->  
      
    </div>
    <!--// head -->