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
	var layerList = [];
	var topHeight = 75;
	var w = 1080;
	var h = 1920 - topHeight;
	
	var persent = 1 / 3.0;

	function Layer(id, width, height, x, y, backgroundColor, priority, fileNum, text) {
		this.id = id;
		this.width = width;
		this.height = height;
		this.x = x;
		this.y = y;
		this.backgroundColor = backgroundColor;
		this.priority = priority;
		this.fileNum = fileNum;		// 이미지 파일 경로? 파일 PK ?
		this.text = text;
	}

	// File 찾기
	function findFile() {
    	window.open("searchFile.nao", "", "width=800, height=700");
    };
    
	// layer 클릭
	function divClick(id) {
		for(i = 0; i < layerList.length; i++) {
			
			if(id == layerList[i].id) {
				printConf(layerList[i]);
				break;	
			}
		}
	}

	// 화면 구성 설정 출력
	function printConf(layer) {
		$("#width").val(layer.width);
		$("#height").val(layer.height);
		$("#x").val(layer.x);
		$("#y").val(layer.y);
		$("#layer").val(layer.id).attr("selected", "selected");
		$("#color").val(layer.backgroundColor).attr("selected", "selected");
	}
	
	// 레이어 선택 변경
	function changeLayer() {
		var id = $("#layer option:selected").val();

		for(i = 0; i < layerList.length; i++) {
			if(id == layerList[i].id) {
				printConf(layerList[i]);
				break;
			}
		}
	}

	// 파일 데이터 적용 (searchFile에서 사용)
	function updateFileNum(fileNum) {
		var id = $("#layer option:selected").text();

		for(i = 0; i < layerList.length; i++) {
			if(id == layerList[i].id) {
				layerList[i].fileNum = fileNum;
				break;	
			}
		}
	}
	
	// Div 추가
	function addDiv() {
		var part = $("#divide option:selected").val();
		
		var xValue = w * persent;
		var yValue = h * persent;
		
		layerList = [];									// 배열 초기화
		$("#layer").empty();						// select 초기화
		$("#div").empty();					// div 초기화
		
		if(part == "one")	 {
	    	layerList.push(new Layer('one', xValue, yValue, 0, 0, 'white', 1, '', ''));

	    	$("#div").append("<div id='one' style='overflow: hidden; width: " + xValue + "px; height: " + yValue + "px; background: #61bde833; position: absolute' onclick='divClick(\"one\")'>1080 x 1920</div>");
 	    	$("#layer").append("<option>one</option>" );

		} else if(part == "two") {
	    	layerList.push(new Layer('one', xValue, (yValue / 2), 0, 0, 'white', 1, '', ''));
	    	layerList.push(new Layer('two', xValue, (yValue / 2), 0, (yValue / 2), 'white', 1, '', ''));

	    	$("#div").append("<div id='one' style='overflow: hidden; width: " + xValue + "px; height: " + (yValue / 2) + "px; left: 0px; top: 0px; background: #61bde833; position: absolute' onclick='divClick(\"one\")'>1080 x 960</div>");
	    	$("#div").append("<div id='two' style='overflow: hidden; width: " + xValue + "px; height: " + (yValue / 2) + "px; left: 0px; top: " + (yValue / 2) + "px; background: #b2e8f1; position: absolute' onclick='divClick(\"two\")'>1080 x 960</div>");

	    	$("#layer").append("<option>one</option>" );
 	    	$("#layer").append("<option>two</option>" );

		} else if(part == "three") {
	    	layerList.push(new Layer('one', xValue, (yValue / 3), 0, 0, 'white', 1, '', ''));
	    	layerList.push(new Layer('two', xValue, (yValue / 3), 0, (yValue / 3), 'white', 1, '', ''));
	    	layerList.push(new Layer('three', xValue, yValue / 3, 0, yValue * 2 / 3, 'white', 1, '', ''));

	    	$("#div").append("<div id='one' style='overflow: hidden; width: " + xValue + "px; height: " + (yValue / 3) + "px; left: 0px; top: 0px; background: #61bde833; position: absolute' onclick='divClick(\"one\")'>1080 x 640</div>");
	    	$("#div").append("<div id='two' style='overflow: hidden; width: " + xValue + "px; height: " + (yValue / 3) + "px; left: 0px; top: " + (yValue / 3) + "px; background: #b2e8f1; position: absolute' onclick='divClick(\"two\")'>1080 x 640</div>");
	    	$("#div").append("<div id='three' style='overflow: hidden; width: " + xValue + "px; height: " + (yValue / 3) + "px; left: 0px; top: " + (yValue * 2 / 3) + "px; background: #8fd8bd; position: absolute' onclick='divClick(\"three\")'>1080 x 640</div>");

	    	$("#layer").append("<option>one</option>" );
 	    	$("#layer").append("<option>two</option>" );
 	    	$("#layer").append("<option>three</option>" );

		} else if(part == "twoOne") {
	    	layerList.push(new Layer('one', xValue, yValue * 2 / 3, 0, 0, 'white', 1, '', ''));
	    	layerList.push(new Layer('two', xValue, yValue / 3, 0, yValue * 2 / 3, 'white', 1, '', ''));

	    	$("#div").append("<div id='one' style='overflow: hidden; width: " + xValue + "px; height: " + (yValue * 2 / 3) + "px; left: 0px; top: 0px; background: #61bde833; position: absolute' onclick='divClick(\"one\")'>1080 x 1280</div>");
	    	$("#div").append("<div id='two' style='overflow: hidden; width: " + xValue + "px; height: " + (yValue / 3) + "px; left: 0px; top: " + (yValue * 2 / 3) + "px; background: #b2e8f1; position: absolute' onclick='divClick(\"two\")'>1080 x 640</div>");

	    	$("#layer").append("<option>one</option>" );
 	    	$("#layer").append("<option>two</option>" );

		} else if(part == "oneTwo") {
	    	layerList.push(new Layer('one', xValue, yValue / 3, 0, 0, 'white', 1, '', ''));
	    	layerList.push(new Layer('two', xValue, yValue * 2 / 3, 0, yValue / 3, 'white', 1, '', ''));

	    	$("#div").append("<div id='one' style='overflow: hidden; width: " + xValue + "px; height: " + (yValue / 3) + "px; left: 0px; top: 0px; background: #61bde833; position: absolute' onclick='divClick(\"one\")'>1080 x 640</div>");
	    	$("#div").append("<div id='two' style='overflow: hidden; width: " + xValue + "px; height: " + (yValue * 2 / 3) + "px; left: 0px; top: " + (yValue / 3) + "px; background: #b2e8f1; position: absolute' onclick='divClick(\"two\")'>1080 x 1280</div>");

	    	$("#layer").append("<option>one</option>" );
 	    	$("#layer").append("<option>two</option>" );
		}
	}
	
	// 컨텐츠 저장
	function saveContent() {
    	var title = $("#title").val();
    	var content = $("#content").val();
    	var advertiser = $("#advertiser option:selected").val();
    	
    	$("form").append("<input type='hidden' name='title' value='" + title + "' />");
    	$("form").append("<input type='hidden' name='content' value='" + content + "'/>");
    	$("form").append("<input type='hidden' name='persent' value='" + persent + "'/>");
    	$("form").append("<input type='hidden' name='advertiser_num' value='" + advertiser + "'/>");

			for(i = 0; i < layerList.length; i++) {
		    	$("form").append("<input type='hidden' name='layerId' value='" +  layerList[i].id + "'/>");
		    	$("form").append("<input type='hidden' name='layerWidth' value='" + layerList[i].id + layerList[i].width + "'/>");
		    	$("form").append("<input type='hidden' name='layerHeight' value='" + layerList[i].id + layerList[i].height + "'/>");
		    	$("form").append("<input type='hidden' name='layerX' value='" + layerList[i].id + layerList[i].x + "'/>");
		    	$("form").append("<input type='hidden' name='layerY' value='" + layerList[i].id + layerList[i].y + "'/>");
		    	$("form").append("<input type='hidden' name='layerBGColor' value='" + layerList[i].id + layerList[i].backgroundColor + "'/>");
		    	$("form").append("<input type='hidden' name='layerPriority' value='" + layerList[i].id + layerList[i].priority + "'/>");
		    	$("form").append("<input type='hidden' name='layerFileNum' value='" + layerList[i].id + layerList[i].fileNum + "'/>");
		    	$("form").append("<input type='hidden' name='layerText' value='" + layerList[i].id + layerList[i].text + "'/>");
		}	 	

    	$("form").submit();
    };
	
	$(document).ready(function(){
		addDiv("one");
	});
	
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
<div class="wrapper tranfer adv">

	<%@ include file="../common/header.jsp" %>
   
    <!-- contents -->
    <div id="contents" class="contents">  
      
      <!-- article --> 
      <div class="article">

        <div class="cnt"> 
          <h3>컨텐츠 등록</h3>  
      
          <div class="t_w fix">
            
            <div class="adv_preview_w">                 
              <div class="adv_preview "> 
                <div class="hd_top">
                  <p class="date">2020.03.23</p>
                  <p class="time">PM 3 : 00</p>
                  <p class="weather"><span>오늘날씨</span> <em class="ico w_01"><span>맑음</span></em></p><!-- 설명 : 날씨에 따라 클래스 변경 -->
                  
                  <!-- w_01 : 맑음
                      		 w_02 : 구름조금
                           w_03 : 구름많음
                           w_04 : 흐림
                           w_05 : 약한비
                           w_06 : 비
                           w_07 : 강한비
                           w_08 : 약한눈
                           w_09 : 눈
                           w_10 : 강한눈
                           w_12 : 진눈깨비
                           w_13 : 소나기
                           w_14 : 소낙 눈
                           w_15 : 안개
                           w_16 : 번개,뇌우
                           w_17 : 우박
                           w_18 : 황사
                           w_19 : 비 또는 눈
                           w_20 : 가끔 비
                           w_21 : 가끔 눈
                           w_22 : 가끔 비 또는 눈
                           w_23 : 흐린 후 갬
                           w_24 : 뇌우 후 갬
                           w_25 : 비 후 갬
                           w_26 : 눈 후 갬
                           w_27 : 흐려져 비
                           w_28 : 흐려져 눈
                       -->
                </div>
                <div class="divi divi1"><!-- 설명 : 분할 개수에 따라 클래스 적용, divi1, divi2, divi3, divi21, divi12 -->
                  <div class="div1"> <!-- 설명 : div 순서에 따라 클래스 번호 적용, div1, div2, div3 -->
                    <div id="div" class="w" style=" background-image: url('../images/adv_preview01.jpg');">
                    </div>
                  </div>
                </div>
              </div>
            </div>
            
            <table class="tb tb_row tb_ip st01">
              <caption>세미나 정보</caption>
              <colgroup>
                <col width="30%">
                <col width="70%"> 
              </colgroup>
              <tbody>
                <tr>
                  <th>제목</th>
                  <td><input type="text" id="title" name="id"/></td>
                </tr>
                <tr>
                  <th class="v_t">메모</th>
                  <td>
                    <textarea id="content" name="content"></textarea>
                  </td>
                </tr>
                <tr>
                  <th>분할</th>
                  <td>
                    <select class="" id="divide" onChange="addDiv()">
                      <option value="one">전체</option>
                      <option value="two">2분할</option>
                      <option value="three">3분할</option>
                      <option value="twoOne">2:1분할</option>
                      <option value="oneTwo">1:2분할</option>
                    </select>
                  </td>
                </tr>
                <tr>
                  <th>Layer</th>
                  <td>
                    <select class="" id="layer" onChange="changeLayer()">
                      <option>전체</option>
                      <option value="">one</option>
                    </select>
                  </td>
                </tr>
                <tr>
                  <th>File</th>
                  <td>
                    <a href="javascript:findFile()" class="btn btn_check"><span>찾기</span></a>
                  </td>
                </tr>
                <tr>
                  <th>광고주</th>
                  <td>
                    <select id="advertiser" name="advertiser">
<%
	ArrayList<Map<String, Object>> advertiserList = (ArrayList<Map<String, Object>>)request.getAttribute("advertiserList");
	
	for(int i = 0; i < advertiserList.size(); i++) {
		Map<String, Object> advertiser = advertiserList.get(i);
%>                    
                      <option value="<%= advertiser.get("advertiser_num") %>"><%= advertiser.get("advertiser_name") %></option>
<%
	}
%>                      
                    </select>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
          
          <div class="btn_area_b">             
            <a href="javascript:saveContent()" class="btn btn_tranfer"><span>저장</span></a>              	
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

<form action="addContents.nao" method="post"></form>

</body>
</html>
