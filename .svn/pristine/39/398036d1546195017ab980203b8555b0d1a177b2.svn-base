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
	function updateMember() {
		$("#memberForm").submit();
	}
	
	function deleteMember() {
		location.href = "deleteMember.nao";
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
        <h2 class="h2">사용자 수정</h2>
        
        <div class="cnt"> 
          <h3>개인정보</h3>     
          
          <div class="t_w">
<!--             <p class="tb_top_txt"><em class="must">*</em>항목 필수 입력</p> -->
            
			<form id="memberForm" action="updateMember.nao" method="post">
			            
            <table class="tb tb_row tb_ip">
              <caption>세미나 정보</caption>
              <colgroup>
                <col width="18%">
                <col width="82%"> 
              </colgroup>
              <tbody>
                <tr>
                  <th><em class="must">*</em>ID</th>
                  <td>
                  	<%= member.get("id") %>
                  	<input type="hidden" id="id" name="id" value="<%= member.get("id") %>"> 
                  	<!-- <a href="javascript:idCheck()" class="btn btn_check"><span>중복확인</span></a> -->
                  </td>
                </tr>
                <tr>
                  <th><em class="must">*</em>사용자명</th>
                  <td><input type="text" name="name" value="<%= member.get("name") %>"></td>
                </tr>
                <tr>
                  <th><em class="must">*</em>Password</th>
                  <td><input type="password" name="pw" value="<%= member.get("pw") %>"></td>
                </tr>
                <tr>
                  <th><em class="must">*</em>주소</th>
                  <td><input type="text" name="address" value="<%= member.get("address") %>"></td>
                </tr>
<!--                 
                <tr>
                  <th><em class="must">*</em>Confirm Password</th>
                  <td><input type="text" name="pw" value=""> <span class="td_sTxt">비밀번호 확인</span></td>
                </tr>
                <tr>
                  <th>Email</th>
                  <td>
                    <div class="email_w">
                      <input type="text" name="email1" maxlength="70" class="email1"><span class="bar"> @ </span>
                      <input type="text" name="email2" class="email2">
                      <select onchange="send(this.value)" class="email">
                          <option>직접입력</option>
                          <option value="hanmail.net">한메일</option>
                          <option value="naver.com">네이버</option>
                          <option value="nate.com">네이트</option>
                          <option value="lycos.co.kr">라이코스</option>
                          <option value="yahoo.com">야후</option>
                          <option value="nate.com">엠파스</option>
                          <option value="intizen.com">인티즌</option>
                          <option value="korea.com">코리아닷컴</option>
                          <option value="paran.com">파란</option>
                          <option value="freecjal.com">프리첼</option>
                          <option value="hanafos.com">하나포스</option>
                          <option value="netian.com">네띠앙</option>
                          <option value="hanmir.com">한미르</option>
                          <option value="hotmail.co.kr">핫메일</option>
                      </select>
                    </div>
                  </td>
                </tr>
                <tr>
                  <th>부서 <em class="s">(Department)</em></th>
                  <td>
                    <select name="tel1" class="tel1">
                      <option value="">선택</option>
                      <option value=""></option>
                    </select>
                  </td>
                </tr>
 -->
              </tbody>
            </table>
            
            </form>
            
          </div>
          
          <div class="btn_area_b">                  
            <a href="javascript:updateMember()" class="btn btn_regi"><span>수정</span></a> 
            <a href="javascript:deleteMember()" class="btn btn_reset"><span>삭제</span></a>               	
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
