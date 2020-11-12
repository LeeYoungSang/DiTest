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
<div class="wrapper join">

	<%@ include file="../common/header.jsp" %>
      
    <!-- contents -->
    <div id="contents" class="contents">  
      
      <!-- article --> 
      <div class="article">
        <h2 class="h2">광고주 등록</h2>
        
        <div class="cnt"> 
          <h3>광고주 정보입력</h3>     
          
          <div class="t_w">
            <p class="tb_top_txt"><em class="must">*</em>항목 필수 입력</p>
            
			<form action="addAdvertiser.nao" method="post">
			            
            <table class="tb tb_row tb_ip">
              <caption>세미나 정보</caption>
              <colgroup>
                <col width="18%">
                <col width="82%"> 
              </colgroup>
              <tbody>
                <tr>
                  <th><em class="must">*</em>광고주 명</th>
                  <td><input type="text" id="advertiser_name" name="advertiser_name" value=""></td>
                </tr>
                <tr>
                  <th class="v_t">설명</th>
                  <td><textarea class="st01" name="advertiser_info"></textarea></td>
                </tr>

              </tbody>
            </table>
            </form>
            
          </div>
          
          <div class="btn_area_b">                  
            <a href="javascript:formSubmit()" class="btn btn_regi"><span>등록</span></a> 
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
