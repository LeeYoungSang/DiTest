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
	
	// 레이어 배경색 변경
	function changeColor() {
		var id = $("#layer option:selected").text();
		var color = $("#color option:selected").val();
		
		for(i = 0; i < layerList.length; i++) {
			
			if(id == layerList[i].id) {
				layerList[i].backgroundColor = color;
				$("#" + id).css("background-color", color);
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
	
	// 컨텐츠 저장
	function saveContent() {
		$.ajax({
			url				: "addContents.nao",
			method		: "POST",
			data				: {
				title			: $("#title").val(),
				content 	: $("#content").val()
			},
			dataType		: "json",
			success		: function(data) {
				alert("컨텐츠 등록 " + data.contentsNum);
 	 			for(i = 0; i < layerList.length; i++) {
					saveLayer(layerList[i], data);
				}	 			
			},
			error 			: function(xhr, data, error) {
	   			alert("컨텐츠 등록 실패");
			}
		});		
	}
	
	// 레이어 저장
	function saveLayer(layer, contentData) {
		$.ajax({
			url				: "addLayer.nao",
			method		: "POST",
			data				: {
				layer_id	: layer.id,
				layer_width : layer.width,
				layer_height : layer.height,
				layer_x : layer.x,
				layer_y : layer.y,
				layer_background : layer.backgroundColor,
				layer_priority : layer.priority,
				contents_num : contentData.contentsNum,
				layer_file_num : layer.fileNum,
				layer_text : layer.text
			},
			dataType		: "html",
			success		: function(data) {
//				alert("등록 성공");
			},
			error 			: function(xhr, data, error) {
	   			alert("레이어 등록 실패");
	   			isSuccess = false;
			}
		});		
	}

	// Div 추가
	function addDiv(isMain) {
		
		if(isMain) {
	    	layerList.push(new Layer('mainDiv', 300, 400, 0, 0, 'white', 1, '', ''));

	    	$("#div").append("<div id='mainDiv' style='width: 300px; height: 400px; border-style: dotted; position: absolute' onclick='divClick(\"mainDiv\")'>div 입니다.</div>");
 	    	$("#layer").append("<option>mainDiv</option>" );

		} else if($("#layerId").val()) {
	    	layerList.push(new Layer($("#layerId").val(), 150, 100, 0, 0, 'white', 1, '', ''));
	    	
 	    	$("#layer").append("<option>" + $("#layerId").val() + "</option>" );
	    	$("#div").append("<div id='" + $("#layerId").val() + "' style='width: 150px; height: 100px; border-style: solid; position: absolute' onclick='divClick(\"" + $("#layerId").val() + "\")'>" + $("#layerId").val() + "</div>");
	    	$("#layerId").val("");

    	} else {
    		alert("레이어 명을 입력해 주세요.");	
    	}
	}
	
	$(document).ready(function(){
		addDiv(true);
		
	    $("#fileBtn").click(function() {
	    	window.open("searchFile.nao", "", "width=400, height=400");
	    });
	    
	    $("#layerBtn").click(function() {
	    	addDiv();
	    });
	    
	    $("#sizeBtn").click(function() {
	    	var id = $("#layer option:selected").text();
	    	var width = $("#width").val();
	    	var height = $("#height").val();
	    	
			for(i = 0; i < layerList.length; i++) {
				if(id == layerList[i].id) {
					layerList[i].width = width;
					layerList[i].height = height;
					$("#" + id).css("width", width);
					$("#" + id).css("height", height);
					break;	
				}
			}
	    });
	    
	    $("#positionBtn").click(function() {
	    	var id = $("#layer option:selected").text();
	    	var x = $("#x").val();
	    	var y = $("#y").val();
	    	
			for(i = 0; i < layerList.length; i++) {
				if(id == layerList[i].id) {
					layerList[i].x = x;
					layerList[i].y = y;
					$("#" + id).css("left", x + "px").css("top", y + "px");
					break;	
				}
			}
	    });

	    $("#saveBtn").click(function() {
			// insert content
			saveContent();
			
			location.href = "contentsList.nao";
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
		<td colspan="3">
			<table border="0">
				<tr>
					<th>제목</th>
					<td><input type="text" id="title" size="80"/></td>
				</tr>
				<tr>
					<th>설명</th>
					<td colspan="2"><textarea id="content" cols="80" rows="5"></textarea></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<!-- 화면 구성 부분 -->
		<td>
			<div id="div" style="width: 300px; height: 400px; position: relative;">
			</div>
		</td>
		<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
		<!-- 설정 부분 -->
		<td>
			<b>화면 구성 설정</b><p/>
			<table border="1">
				<tr>
					<td>레이어 추가</td>
					<td><input type="text" id="layerId" /><input type="button" id="layerBtn" value="추가" /></td>
				</tr>
				<tr>
					<td>레이어 선택</td>
					<td>
						<select id="layer" onChange="changeLayer()">
						</select>
					</td>
				</tr>
				<tr>
					<td>레이어 크기</td>
					<td>
						<input id="width" type="text" size="6"/> X <input id="height" type="text" size="6"/>
						<input type="button" id="sizeBtn" value="적용" />
					</td>
				</tr>
				<tr>
					<td>레이어 위치</td>
					<td>
						<input id="x" type="text" size="6"/> X <input id="y" type="text" size="6"/>
						<input type="button" id="positionBtn" value="적용" />
					</td>
				</tr>
				<tr>
					<td>레이어 배경색</td>
					<td>
						<select id="color" onChange="changeColor()">
							<option value="white">하양</option>
							<option value="red">빨강</option>
							<option value="yellow">노랑</option>
							<option value="blue">파랑</option>
							<option value="green">초록</option>
							<option value="black">검정</option>
						</select>
					</td>
				</tr>				
				<tr>
					<td>레이어 우선순위</td>
					<td>
						<select>
							<option>1</option>
							<option>2</option>
							<option>3</option>
							<option>4</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>이미지 적용</td>
					<td><input type="button" id="fileBtn" value="파일선택" /></td>
				</tr>
				<tr>
					<td>텍스트</td>
					<td><input type="text" /></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<p/>
<input type="button" id="saveBtn" value="저장" />
</body>
</html>