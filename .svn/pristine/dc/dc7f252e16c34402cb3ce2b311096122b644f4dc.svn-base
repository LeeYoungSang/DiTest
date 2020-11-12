<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script src="/DiClean/js/jquery-1.11.0.min.js"></script>

<%
	ArrayList<Map<String, Object>> layerList = (ArrayList<Map<String, Object>>)request.getAttribute("layerList");
%>

<script>
	var layerList = [];
	
	function Layer(id, width, height, x, y, backgroundColor, priority, fileNum, text, fileName) {
		this.id = id;
		this.width = width;
		this.height = height;
		this.x = x;
		this.y = y;
		this.backgroundColor = backgroundColor;
		this.priority = priority;
		this.fileNum = fileNum;		// 이미지 파일 번호
		this.text = text;
		this.fileName = fileName;	// 이미지 파일 명
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
	
	// Div 추가
	function addDiv(layer) {
		
		if(layer) {
	    	$("#div").append("<div id='" + layer.id + "' style='width: " + layer.width + "px; height: " + layer.height + "px; background-color: " + layer.backgroundColor + "; position: absolute; left: " + layer.x + "px; top: "+ layer.y +"px' onclick='divClick(\"" + layer.id + "\")'>" + layer.id + "</div>");
 	    	$("#layer").append("<option>" + layer.id + "</option>" );
 	    	
 	    	var arry = layer.fileName.split("\.");
 	    	var ext = arry[arry.length - 1];
 	    	
 	    	if(ext.toLowerCase() == "mp4") {
 				$("#" + layer.id).html("<video  src='upload/" + layer.fileName + "'  width='100%' autoplay/>");
 				
 	    	} else {
 				$("#" + layer.id).html("<img  src='upload/" + layer.fileName + "'  width='100%' />");
			}


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
<%

	if(layerList != null) {
		for(int i = 0; i < layerList.size(); i++) {
			Map<String, Object> layer = layerList.get(i);
%>
		addDiv(new Layer('<%= layer.get("layer_id") %>', 
													<%= layer.get("layer_width") %>, 
													<%= layer.get("layer_height") %>, 
													<%= layer.get("layer_x") %>, 
													<%= layer.get("layer_y") %>, 
													'<%= layer.get("layer_background") %>', 
													<%= layer.get("layer_priority") %>, 
													'<%= layer.get("layer_file_num") %>', 
													'<%= layer.get("layer_text") %>',
													'<%= layer.get("file_name") %>'));
<%
		}
	}
%>

	});
</script>

					<div class="divi divi1"> <!-- 설명 : 분할 개수에 따라 클래스 적용, divi1, divi2, divi3, divi21, divi12 -->
					  <div class="div1"> <!-- 설명 : div 순서에 따라 클래스 번호 적용, div1, div2, div3 -->
						<div class="w">
							<img src="images/adv_preview01.jpg" style="width:100%"/>
						  <p class="tit">제목글 텍스트</p>
						  <p class="txt">설명글 텍스트 입니다.<br> 폰트 스타일은 style 으로  변경하시면 됩니다. </p>
						</div>
					  </div>
					</div>




<div id="div_k" style="width: 300px; height: 400px; position: relative; border-style: dotted; text-align:center;display:table-cell;vertical-align:middle;">
화면 로딩 중입니다.
</div>
