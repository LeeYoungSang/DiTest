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

</head>
<script>
	function selectImg(fileNum, fileName) {
		var id = $("#layer option:selected", opener.document).val();
		$("#" + id, opener.document).html("<img  src='upload/" + fileName + "'  style='width:100%' />");
		opener.updateFileNum(fileNum);
		window.close();
	}

</script>

<body>

<!-- 스킵 네비게이션 -->
<div class="skip_navi">
    <a href="#contents">본문으로 가기</a>
    <a href="#gnb">주메뉴로 가기</a>
    <a href="#footer">카피라이트로 가기</a>
</div>
<!-- // 스킵 네비게이션 -->

<%
	ArrayList<Map<String, Object>> fileList = (ArrayList<Map<String, Object>>)request.getAttribute("fileList");
%>

<!-- wrapper -->
<div class="wrapper group" style="min-width: auto">

    <!-- contents -->
    <div id="contents" class="contents">  
    
       <!-- article --> 
      <div class="article">
                
        <div class="cnt"> 
          <h3>File 목록</h3>     
          
          <div class="t_w">
            <table class="tb tb_col tb_result">
              <caption>File 목록</caption>
              <colgroup>
                <!-- <col width="5%"> -->
                <col width="8%">
                <col width="15%">
                <col width="*">
                <col width="18%">
              </colgroup>                
              <thead>
              <tr>
                <!-- <th></th> -->
                <th>번호</th>
                <th></th>
                <th>파일명</th>
                <th>등록일자</th>
              </tr>
              </thead>
              <tbody>
<%
	if(fileList != null && fileList.size() > 0) {
		for(int i = 0; i < fileList.size(); i++) {
			Map<String, Object> file = fileList.get(i);
			
%>
              <tr>
<!--               
                <td class="td_ch">
                  <label for="ch_01" class="ch">
                    <input type="checkbox" name="sd1" id="ch_01"><span></span>
                  </label>
                </td>
 -->
                <td><%= file.get("file_num") %></td>
                <td class="tit"><img onClick="selectImg(<%= file.get("file_num") %>, '<%= file.get("file_name") %>')" src="upload/<%= file.get("file_name") %>"  width="100"/></td>
                <td><%= file.get("real_file_name") %></td>
                <td><%= file.get("add_date") %></td>
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