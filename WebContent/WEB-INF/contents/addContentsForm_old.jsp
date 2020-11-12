<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="/DiClean/js/jquery-1.11.0.min.js"></script>
<script>
	var layerList = [];
	var w = 1080;
	var h = 1920;
	
	var persent = 0.25;
	
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
	
	// 파일 데이터 적용
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
	function addDiv(part) {
		var xValue = w * persent;
		var yValue = h * persent;
		
		layerList = [];									// 배열 초기화
		$("#layer").empty();						// select 초기화
		$("#div").empty();					// div 초기화
		
		if(part == "one")	 {
	    	layerList.push(new Layer('one', xValue, yValue, 0, 0, 'white', 1, '', ''));

	    	$("#div").append("<div id='one' style='overflow: hidden; width: " + xValue + "px; height: " + yValue + "px; border-style: dotted; position: absolute' onclick='divClick(\"one\")'>1080 x 1920</div>");
 	    	$("#layer").append("<option>one</option>" );

		} else if(part == "two") {
	    	layerList.push(new Layer('one', xValue, (yValue / 2), 0, 0, 'white', 1, '', ''));
	    	layerList.push(new Layer('two', xValue, (yValue / 2), 0, (yValue / 2), 'white', 1, '', ''));

	    	$("#div").append("<div id='one' style='overflow: hidden; width: " + xValue + "px; height: " + (yValue / 2) + "px; left: 0px; top: 0px; border-style: dotted; position: absolute' onclick='divClick(\"one\")'>1080 x 960</div>");
	    	$("#div").append("<div id='two' style='overflow: hidden; width: " + xValue + "px; height: " + (yValue / 2) + "px; left: 0px; top: " + (yValue / 2) + "px; border-style: dotted; position: absolute' onclick='divClick(\"two\")'>1080 x 960</div>");

	    	$("#layer").append("<option>one</option>" );
 	    	$("#layer").append("<option>two</option>" );

		} else if(part == "three") {
	    	layerList.push(new Layer('one', xValue, (yValue / 3), 0, 0, 'white', 1, '', ''));
	    	layerList.push(new Layer('two', xValue, (yValue / 3), 0, (yValue / 3), 'white', 1, '', ''));
	    	layerList.push(new Layer('three', xValue, yValue / 3, 0, yValue * 2 / 3, 'white', 1, '', ''));

	    	$("#div").append("<div id='one' style='overflow: hidden; width: " + xValue + "px; height: " + (yValue / 3) + "px; left: 0px; top: 0px; border-style: dotted; position: absolute' onclick='divClick(\"one\")'>1080 x 640</div>");
	    	$("#div").append("<div id='two' style='overflow: hidden; width: " + xValue + "px; height: " + (yValue / 3) + "px; left: 0px; top: " + (yValue / 3) + "px; border-style: dotted; position: absolute' onclick='divClick(\"two\")'>1080 x 640</div>");
	    	$("#div").append("<div id='three' style='overflow: hidden; width: " + xValue + "px; height: " + (yValue / 3) + "px; left: 0px; top: " + (yValue * 2 / 3) + "px; border-style: dotted; position: absolute' onclick='divClick(\"three\")'>1080 x 640</div>");

	    	$("#layer").append("<option>one</option>" );
 	    	$("#layer").append("<option>two</option>" );
 	    	$("#layer").append("<option>three</option>" );

		} else if(part == "twoOne") {
	    	layerList.push(new Layer('one', xValue, yValue * 2 / 3, 0, 0, 'white', 1, '', ''));
	    	layerList.push(new Layer('two', xValue, yValue / 3, 0, yValue * 2 / 3, 'white', 1, '', ''));

	    	$("#div").append("<div id='one' style='overflow: hidden; width: " + xValue + "px; height: " + (yValue * 2 / 3) + "px; left: 0px; top: 0px; border-style: dotted; position: absolute' onclick='divClick(\"one\")'>1080 x 1280</div>");
	    	$("#div").append("<div id='two' style='overflow: hidden; width: " + xValue + "px; height: " + (yValue / 3) + "px; left: 0px; top: " + (yValue * 2 / 3) + "px; border-style: dotted; position: absolute' onclick='divClick(\"two\")'>1080 x 640</div>");

	    	$("#layer").append("<option>one</option>" );
 	    	$("#layer").append("<option>two</option>" );

		} else if(part == "oneTwo") {
	    	layerList.push(new Layer('one', xValue, yValue / 3, 0, 0, 'white', 1, '', ''));
	    	layerList.push(new Layer('two', xValue, yValue * 2 / 3, 0, yValue / 3, 'white', 1, '', ''));

	    	$("#div").append("<div id='one' style='overflow: hidden; width: " + xValue + "px; height: " + (yValue / 3) + "px; left: 0px; top: 0px; border-style: dotted; position: absolute' onclick='divClick(\"one\")'>1080 x 640</div>");
	    	$("#div").append("<div id='two' style='overflow: hidden; width: " + xValue + "px; height: " + (yValue * 2 / 3) + "px; left: 0px; top: " + (yValue / 3) + "px; border-style: dotted; position: absolute' onclick='divClick(\"two\")'>1080 x 1280</div>");

	    	$("#layer").append("<option>one</option>" );
 	    	$("#layer").append("<option>two</option>" );
		}
	}

	$(document).ready(function(){
		addDiv("one");
		
	    $("#fileBtn").click(function() {
	    	window.open("searchFile.nao", "", "width=400, height=400");
	    });
	    
	    $("#saveBtn").click(function() {
	    	var title = $("#title").val();
	    	var content = $("#content").val();
	    	
	    	$("form").append("<input type='hidden' name='title' value='" + title + "' />");
	    	$("form").append("<input type='hidden' name='content' value='" + content + "'/>");
	    	$("form").append("<input type='hidden' name='persent' value='" + persent + "'/>");

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
	    	
	    });
	});

</script>
</head>
<body>
<h1>DiClean Platform</h1>
<hr/>

<%@ include file="../common/topMenu.jsp" %>

컨텐츠관리 > 컨텐츠등록<br/>

<table border="0">
	<tr>
		<!-- 화면 구성 부분 -->
		<td>
			<div id="div" style="width: 300px; height: 400px; position: relative;">
			</div>
		</td>
		<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
		<!-- 설정 부분 -->
		<td>
			<table border="0">
				<tr>
					<th>제목</th>
					<td><input type="text" id="title" size="50"/></td>
				</tr>
				<tr>
					<th>설명</th>
					<td colspan="2"><textarea id="content" cols="50" rows="4"></textarea></td>
				</tr>
			</table>
			<p/>
			
			<b>[ 화면 구성 설정 ]</b><p/>
			<a href="javascript:addDiv('one')">전체</a>
			<a href="javascript:addDiv('two')">2분할</a>
			<a href="javascript:addDiv('three')">3분할</a>
			<a href="javascript:addDiv('twoOne')">2:1분할</a>
			<a href="javascript:addDiv('oneTwo')">1:2분할</a>
			
			<table border="1">
				<tr>
					<td>레이어 선택</td>
					<td>
						<select id="layer" onChange="changeLayer()">
						</select>
					</td>
				</tr>
				<tr>
					<td>이미지 적용</td>
					<td><input type="button" id="fileBtn" value="파일선택" /></td>
				</tr>
			</table>
			<p/>
			
			<input type="button" id="saveBtn" value="저장" />
			
		</td>
	</tr>
</table>
<p/>

<form action="addContents.nao" method="post"></form>
</body>
</html>