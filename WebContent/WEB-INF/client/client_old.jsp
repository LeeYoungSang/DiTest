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
	var machineNum = "2020-01-13-002";
	
	// 컨텐츠 검식
	function searchSchedule() {
		$.ajax({
			url				: "searchSchedule.nao",
			method		: "POST",
			dataType		: "html",
			data				: {
				machine_num	: machineNum
			},
			success		: function(data) {
				$("#div").html(data);
			},
			error 			: function(xhr, data, error) {
	   			alert("컨텐츠 등록 실패 : " + data);
			}
		});		
	}
	
	function searchTime() {
        var date 		= new Date();
        var year 		= date.getFullYear();
        var month 	= (date.getMonth() + 1) < 10 ? "0" + (date.getMonth() + 1) : (date.getMonth() + 1);
        var day 			= date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
        var hour 		= date.getHours() < 10 ? "0" + date.getHours() : (date.getHours() > 12 ? date.getHours() - 12 : date.getHours());
        var minute 	= date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
        var second 	= date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();
        var am 			= date.getHours() >= 12 ? "PM" : "AM";
        
        $(".date").html(year + "." + month + "." + day);
        $(".time").html(am + " " + hour + " : " + minute);
	}
	
	$(document).ready(function() {
		// 정확하게 0, 15, 30 , 45가 되기 위해서는 약간의 수정이 필요함.
		setInterval("searchSchedule()", 15000);
		setInterval("searchTime()", 1000);
	});
		
</script>
</head>

<body>
<!-- wrapper -->
<div class="wrapper tranfer adv_k">
    <!-- contents -->

		<div class="cnt_k">

				<div class="adv_preview_k">            
      
				  <div class="adv_preview">
					<div class="hd_top">
					  <p class="date">2020.03.23</p>
					  <p class="time">PM 3 : 00</p>
					  <p class="weather"><span>오늘날씨</span> <em class="ico w_02"><span>맑음</span></em></p>
					</div>
					<div id="div" style="height:100%">
						<div class="divi divi1"> <!-- 설명 : 분할 개수에 따라 클래스 적용, divi1, divi2, divi3, divi21, divi12 -->
 							<img src="images/adv_preview01.jpg" style="width:100%; height:100%" />
 						</div>
<!-- 					  <div class="div1"> <!-- 설명 : div 순서에 따라 클래스 번호 적용, div1, div2, div3 ->
						<div class="w">
 							<img src="images/adv_preview01.jpg" style="width:100%"/>
						  <p class="tit">제목글 텍스트</p>
						  <p class="txt">설명글 텍스트 입니다.<br> 폰트 스타일은 style 으로  변경하시면 됩니다. </p>
						</div>
					  </div>-->
					</div>
				  </div>	<!--// adv_preview -->


			    </div>	<!--// adv_preview_w -->

	    </div>	<!--// cnt_k -->

</div>	<!--// wrapper -->

</body>
</html>

<!-- 
<body>
<h1>DiClean Platform</h1>
<hr/>

<%--@ include file="../common/topMenu.jsp" --%>

클라이언트<br/>

<table border="0">
	<tr>
		<td>
			<div id="div" style="width: 300px; height: 400px; position: relative; border-style: dotted; text-align:center;display:table-cell;vertical-align:middle;">
			화면 로딩 중입니다.
			</div>
		</td>
	</tr>
</table>
</body>
</html>
-->