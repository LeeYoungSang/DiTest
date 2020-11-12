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
                <th>제목</th>
                <td><input type="text" name="" value=""></td>
              </tr>
            </tbody>
          </table>
          <div class="btn_w">
            <div class="w">
              <a href="#" class="btn btn_sch"><span>검색</span></a>
              <a href="addContentsForm.nao" class="btn btn_white"><span>컨텐츠 등록</span></a>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!--// search area -->
    
<%
	ArrayList<Map<String, Object>> contentsList = (ArrayList<Map<String, Object>>)request.getAttribute("contentsList");
%>
    
    <!-- contents -->
    <div id="contents" class="contents">  
      
      <!-- article --> 
      <div class="article">
                
        <div class="cnt"> 
          <h3>컨텐츠 목록</h3>     
          
          <div class="t_w">
            <table class="tb tb_col tb_result">
              <caption>컨텐츠 목록</caption>
              <colgroup>
                <!-- <col width="5%"> -->
                <col width="8%">
                <col width="20%">
                <col width="*">
                <col width="15%">
              </colgroup>                
              <thead>
              <tr>
                <!-- <th></th> -->
                <th>번호</th>
                <th>제목</th>
                <th>등록자</th>
                <th>등록 일자</th>
              </tr>
              </thead>
              <tbody>
<%
	if(contentsList != null && contentsList.size() > 0) {
		for(int i = 0; i < contentsList.size(); i++) {
			Map<String, Object> contents = contentsList.get(i);
%> 
              <tr>
<!--               
                <td class="td_ch">
                  <label for="ch_01" class="ch">
                    <input type="checkbox" name="sd1" id="ch_01"><span></span>
                  </label>
                </td>
 -->                
                <td><%= contents.get("contents_num") %></td>
                <td class="tit"><a href="updateContentsForm.nao?contents_num=<%= contents.get("contents_num") %>"><%= contents.get("contents_title") %></a></td>
                <td><%= contents.get("member_id") %></td>
                <td><%= contents.get("add_date") %></td>
              </tr>
 <%
		}
	
	} else {
%> 
              <tr>
				<th colspan="4">등록된 공지사항이 없습니다.</th>
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
              <a href="contentsList.nao?pn=1" class="pagn_btn page_first">처음</a>
              <a href="contentsList.nao?pn=<%= startPage - 1 %>" class="pagn_btn page_before">이전</a>
<%
	}

	for(int i = startPage; i < startPage + 10; i++) {
		if(i > totalPage ) {
			break;
		}
		
		if(i == pn) {
%>              
              <a href="contentsList.nao?pn=<%= i %>" class="ac"><span><%= i %></span></a>
<%			
		} else {
%>
              <a href="contentsList.nao?pn=<%= i %>"><span><%= i %></span></a>
<%			
		}
	}
	
	if(startPage + 10 <= totalPage) {
%>  	
              <a href="contentsList.nao?pn=<%= startPage + 10 %>" class="pagn_btn page_next">다음</a>
              <a href="contentsList.nao?pn=<%= totalPage %>" class="pagn_btn page_last">마지막</a>
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
