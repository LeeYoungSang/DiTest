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
	function formSubmit() {
		$("form").submit();
	}
	
	function formReset() {
		$("form").each(function() {  
			this.reset();  
		}); 
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
          <h3>공지사항 수정</h3>  
<%
	Map<String, Object> notice = (Map<String, Object>)request.getAttribute("notice");
%>      
			<form action="updateNotice.nao" method="post">
          
          <div class="t_w">
            <table class="tb tb_row tb_ip st01">
              <caption>세미나 정보</caption>
              <colgroup>
                <col width="18%">
                <col width="82%"> 
              </colgroup>
              <tbody>
                <tr>
                  <th>번호</th>
                  <td>
                  		<%= notice.get("notice_num") %>
                  		<input type="hidden" name="notice_num" value="<%= notice.get("notice_num") %>"/>
                  </td>
                </tr>                  
                <tr>
                  <th>제목</th>
                  <td><input type="text" name="notice_title" value="<%= notice.get("notice_title") %>"/></td>
                </tr>              
                <tr>
                  <th class="v_t">내용</th>
                  <td><textarea class="st01" name="notice_content"><%= notice.get("notice_content") %></textarea></td>
                </tr>
              </tbody>
            </table>
          </div>

          </form>
          
          <div class="btn_area_b">             
            <a href="javascript:formSubmit()" class="btn btn_tranfer"><span>수정</span></a>
            <a href="javascript:formReset()" class="btn btn_reset"><span>초기화</span></a>               	
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
