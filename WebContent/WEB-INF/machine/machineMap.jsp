<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Script-Type" content="text/javascript">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Naosoft</title>
<link type="text/css" rel="stylesheet" href="common/css/default.css" />
<script type="text/javascript" src="common/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="common/js/design.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2654049729dce48bda3591703459a8f4&libraries=services"></script>
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
	
	
<div id="map" style="width:90%;height:800px; margin-left:5%; margin-top:1%"></div>

</div>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
mapOption = {
	center: new kakao.maps.LatLng(37.4976917409292, 126.892254708438), // 지도의 중심좌표
    level: 4 // 지도의 확대 레벨
};  

//지도생성
var map = new kakao.maps.Map(mapContainer, mapOption); 

var positions = []; //마커를 표시할 위치 배열입니다 

var info = []; //info를 push할 배열입니다


<%
	ArrayList<Map<String, Object>> markerList = (ArrayList<Map<String, Object>>)request.getAttribute("markerList");

if(markerList != null && markerList.size() > 0) {
	for(int i = 0; i < markerList.size(); i++) {
		Map<String, Object> marker = markerList.get(i);
/* 		System.out.println("도착한 정보 :::::::::" + markerList.get(i).get("location_type"));
		System.out.println("상세주소 :::::" + markerList.get(i).get("detail_place")); */
		
%>
	positions.push({latlng : new kakao.maps.LatLng(<%= marker.get("location_y") %>, <%= marker.get("location_x") %>)});
	info.push('<%= marker.get("location_type") %>');
<%

	}
}
%> 


//마커 이미지의 이미지 주소입니다
var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
    
for (var i = 0; i < positions.length; i ++) {
    
    // 마커 이미지의 이미지 크기 입니다
    var imageSize = new kakao.maps.Size(24, 35); 
    
    // 마커 이미지를 생성합니다    
    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
    
/*     alert("프론트    :::::::::::" + positions.get(i).get("location_x")); */
   
    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
        map: map, // 마커를 표시할 지도
        position: positions[i].latlng, // 마커를 표시할 위치
        image : markerImage,// 마커 이미지 
        clickable: true // 마커를 클릭했을 때 지도의 클릭 이벤트가 발생하지 않도록 설정합니다
    });
 // 마커를 지도에 표시합니다.
    marker.setMap(map);
 
 // 인포윈도우를 생성합니다
    var infowindow = new kakao.maps.InfoWindow({
        content : info[i],
    Removeable : true
    });
 
    kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
    
 // 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
    function makeOverListener(map, marker, infowindow) {
        return function() {
            infowindow.open(map, marker);
        };
    }

    // 인포윈도우를 닫는 클로저를 만드는 함수입니다 
    function makeOutListener(infowindow) {
        return function() {
            infowindow.close();
        };
    }
}
</script>
 <!-- footer -->
  <div id="footer" class="footer" > 
    <p class="c">Copyright ⓒ. All rights reserved.</p>

  </div>
  <!--// footer -->   

</body>
</html>