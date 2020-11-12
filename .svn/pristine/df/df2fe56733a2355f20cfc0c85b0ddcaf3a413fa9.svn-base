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
	function selectContents(contentsNum, contentsTitle) {
		$("#contentsText", opener.document).html(contentsTitle);
		$("#contents_num", opener.document).attr("value", contentsNum);
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
                <col width="10%">
                <col width="25%">
                <col width="*">
                <col width="10%">
              </colgroup>                
              <thead>
              <tr>
                <!-- <th></th> -->
                <th>번호</th>
                <th>제목</th>
                <th>설명</th>
                <th>&nbsp;</th>
              </tr>
              </thead>
              <tbody>
<%
	if(contentsList != null && contentsList.size() > 0) {
		for(int i = 0; i < contentsList.size(); i++) {
			Map<String, Object> contents = contentsList.get(i);
			
%>
              <tr>
                <td><%= contents.get("contents_num") %></td>
<%--                 <td class="tit"><%= contents.get("contents_title") %></td> --%>
                <td><%= contents.get("contents_title") %></td>
                <td><%= contents.get("contents_content") %></td>
                <td><a href="javascript:selectContents('<%= contents.get("contents_num") %>', '<%= contents.get("contents_title") %>')" class="btn btn_tranfer">선택</a></td>
              </tr>
<%
		}
	
	} else {
%>
				<tr>
					<th colspan="4">등록된 파일이 없습니다.</th>
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