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
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> 
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2654049729dce48bda3591703459a8f4&libraries=services"></script>
<script>
var geocoder = new kakao.maps.services.Geocoder();

function search(){	
	var address = $("#sample6_address").val();
	
	console.log("address:"+address);
	
	geocoder.addressSearch(address, function(result, status) {
	    // 정상적으로 검색이 완료됐으면 
	     if (status === kakao.maps.services.Status.OK) {
	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	        $("#x").val(result[0].x);
	        $("#y").val(result[0].y);
	        
	        console.log("#x:"+result[0].x);
	        console.log("#y:"+result[0].y);
	        
	        $("form").submit();
// 	        $("form").submit();
	    }
	    else
	    {
	    	alert("주소찾기 버튼을 통해 주소를 입력해주세요.");	 
	    	sample6_execDaumPostcode();
	    }
	});    
}

function formSubmit() {
	search();
}
	
	
	function sample6_execDaumPostcode() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var addr = ''; // 주소 변수
	            var extraAddr = ''; // 참고항목 변수

	            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                addr = data.roadAddress;
	            } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                addr = data.jibunAddress;
	            }

	            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	            if(data.userSelectedType === 'R'){
	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if(extraAddr !== ''){
	                    extraAddr = ' (' + extraAddr + ')';
	                }
	                // 조합된 참고항목을 해당 필드에 넣는다.
	                document.getElementById("sample6_extraAddress").value = extraAddr;
	            
	            } else {
	                document.getElementById("sample6_extraAddress").value = '';
	            }

	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	           // document.getElementById('sample6_postcode').value = data.zonecode;
	            document.getElementById("sample6_address").value = addr;
	            // 커서를 상세주소 필드로 이동한다.
	            document.getElementById("sample6_detailAddress").focus();
	        }
	    }).open();
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
        <h2 class="h2">Machine 정보</h2>
        
        <div class="cnt"> 
          <h3>Machine 정보</h3>     
          
          <div class="t_w">
            <!-- <p class="tb_top_txt"><em class="must">*</em>항목 필수 입력</p> -->
            
<%
	Map<String, Object> machine = (Map<String, Object>)request.getAttribute("machine");
%>
            
			<form action="updateMachine.nao" method="post">
			            
            <table class="tb tb_row tb_ip">
              <caption>세미나 정보</caption>
              <colgroup>
                <col width="18%">
                <col width="82%"> 
              </colgroup>
              <tbody>
                <tr>
                  <th><em class="must">*</em>일련번호</th>
                  <td><%= machine.get("machine_num") %></td>
                </tr>
                <tr>
                  <th><em class="must">*</em>머신타입</th>
                  <td><input type="text" name="machine_type" value="<%= machine.get("machine_type") %>"></td>
                </tr>
                <tr>
                  <th><em class="must">*</em>매장종류</th>
                  <td><input type="text" name="location_type" value="<%= machine.get("location_type") %>"></td>
                </tr>
                <tr>
                  <th><em class="must">*</em>설치장소</th>
                  <td>
                  	<input type="hidden" id="sample6_postcode" placeholder="우편번호" onclick="sample6_execDaumPostcode();">
                  	<input type="text" id="sample6_address" name="installed_place" value="<%= machine.get("installed_place") %>" onclick="sample6_execDaumPostcode();">
                  	<input type="text" id="sample6_detailAddress" name="detail_place" placeholder="상세주소" value="<%= machine.get("detail_place") %>">
                	<input type="button" value="주소찾기" onclick="sample6_execDaumPostcode();" class="btn btn_check">
                	<input type="hidden" id="sample6_extraAddress" placeholder="참고항목" onclick="sample6_execDaumPostcode();"></td>
                </tr>
                <input type="hidden" name="x" id="x" >
                <input type="hidden" name="y" id="y" >
                <tr>
                  <th><em class="must">*</em>부팅시</th>
                  <td>
                  	<span style="padding-right:24px;">분사시간</span>
                  	<select id="injectionTime_BT" name="injectionTime_BT">
<%
					 if("0".equals(machine.get("injectionTime_BT")))
					 {
%>
						<option value="3" style="display: none;" selected="selected">3초</option>
<% 						 
					 }
					 else
					 {
%>
                  		<option value="<%=machine.get("injectionTime_BT")%>" style="display: none;"><%=machine.get("injectionTime_BT")%>초</option>
<%
					 }
%>
                  		<option value="1">1초</option>
                  		<option value="2">2초</option>
                  		<option value="3">3초</option>
                  		<option value="4">4초</option>
                  		<option value="5">5초</option>
                  		<option value="6">6초</option>
                  		<option value="7">7초</option>
                  		<option value="8">8초</option>
                  		<option value="9">9초</option>
                  		<option value="10">10초</option>
                  	</select>
                  </td>
                </tr>
                <tr>
                  <th><em class="must">*</em>미사용시</th>
                  <td>
                  	<span style="padding-right:10px;">미사용시간</span>
                  	<select id="unusedTime" name="unusedTime">
<%
					 if("0".equals(machine.get("unusedTime")))
					 {
%>
						<option value="4" style="display: none;" selected="selected">4시간</option>
<%
					 }
					 else
					 {
%>                  	
                  		<option value="<%=machine.get("unusedTime")%>" style="display: none;"><%=machine.get("unusedTime")%>시간</option>
<%
					 }
%>
                  		<option value="1">1시간</option>
                  		<option value="2">2시간</option>
                  		<option value="3">3시간</option>
                  		<option value="4">4시간</option>
                  		<option value="5">5시간</option>
                  		<option value="6">6시간</option>
                  		<option value="7">7시간</option>
                  		<option value="8">8시간</option>
                  		<option value="9">9시간</option>
                  		<option value="10">10시간</option>
                  	</select>
                  	<span style="padding-right:10px; padding-left:10px;">분사시간</span>
                  	<select id="injectionTime_UUT" name="injectionTime_UUT">
<%
					 if("0".equals(machine.get("injectionTime_UUT")))
					 {
%>                  	
						<option value="3" style="display: none;" selected="selected">3초</option>
<% 
					 }
					 else
					 {
%>
                  		<option value="<%=machine.get("injectionTime_UUT")%>" style="display: none;"><%=machine.get("injectionTime_UUT")%>초</option>
<% 
					 }
%>
                  		<option value="1">1초</option>
                  		<option value="2">2초</option>
                  		<option value="3">3초</option>
                  		<option value="4">4초</option>
                  		<option value="5">5초</option>
                  		<option value="6">6초</option>
                  		<option value="7">7초</option>
                  		<option value="8">8초</option>
                  		<option value="9">9초</option>
                  		<option value="10">10초</option>
                  	</select>
                  </td>
                </tr>
                <tr>
                  <th><em class="must">*</em>사용시</th>
                  <td>
                  	<span style="padding-right:24px;">사용횟수</span>
                  	<select id="usedTimes" name="usedTimes">
<%
					 if("0".equals(machine.get("usedTimes")))
					 {
%>                  	
						<option value="60" style="display: none;" selected="selected">60회</option>
<%
					 }
					 else
					 {
%>
                  		<option value="<%=machine.get("usedTimes")%>" style="display: none;"><%=machine.get("usedTimes")%>회</option>
<%
					 }		
%>

                  		<option value="10">10회</option>
                  		<option value="20">20회</option>
                  		<option value="30">30회</option>
                  		<option value="40">40회</option>
                  		<option value="50">50회</option>
                  		<option value="60">60회</option>
                  		<option value="70">70회</option>
                  		<option value="80">80회</option>
                  		<option value="90">90회</option>
                  		<option value="100">100회</option>
                  	</select>
                  	<span style="padding-right:10px; padding-left:10px;">분사시간</span>
                  	<select id="injectionTime_UT" name="injectionTime_UT">
<%
					 if("0".equals(machine.get("injectionTime_UT")))
					 {
%>                  	
						<option value="3" style="display: none;" selected="selected">3초</option>
<%
					 }
					 else
					 {
%>
                  		<option value="<%=machine.get("injectionTime_UT")%>" style="display: none;"><%=machine.get("injectionTime_UT")%>초</option>
<%
					 }
%>
                  		<option value="1">1초</option>
                  		<option value="2">2초</option>
                  		<option value="3">3초</option>
                  		<option value="4">4초</option>
                  		<option value="5">5초</option>
                  		<option value="6">6초</option>
                  		<option value="7">7초</option>
                  		<option value="8">8초</option>
                  		<option value="9">9초</option>
                  		<option value="10">10초</option>
                  	</select>
                  </td>
                </tr>
<!--                 
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
            <input type="hidden" name="machine_num" value="<%= machine.get("machine_num") %>" />
            </form>
            
          </div>
          
<%
	if("00".equals((String)member.get("division"))) {
%>          
          <div class="btn_area_b">                  
            <a href="javascript:formSubmit()" class="btn btn_regi"><span>수정</span></a> 
            <a href="deleteMachine.nao?machine_num=<%= machine.get("machine_num") %>" class="btn btn_reset"><span>삭제</span></a>               	
          </div>
<%
	}
%>          
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
