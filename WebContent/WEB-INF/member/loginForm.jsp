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
<!--Load the AJAX API-->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=62d0555a5a3a2619b1fde57f1e78032e&libraries=services,clusterer,drawing"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/react/0.14.0/react.js"></script> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/react/0.14.0/react-dom.js"></script> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/babel-core/5.8.23/browser.min.js"></script> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script>
	function addMember() {
		location.href = "addMemberForm.nao";
	}
</script>
</head>

<body>

<!--           <div id="map" style="width:500px; height:400px;"></div> -->
          <div id="result"></div>
          <div>
          		<input id="test1">
          		<input id="test2">
          		<input id="bdNm"> 
          		<input id="login-form-result">
          </div>
		  <script type="text/javascript">

			    Kakao.init('62d0555a5a3a2619b1fde57f1e78032e');
		  
		  
		  
				var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
				
				var options = { //지도를 생성할 때 필요한 기본 옵션
					center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
					level: 3 //지도의 레벨(확대, 축소 정도)
				};
				
				var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
				
				// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
				var mapTypeControl = new kakao.maps.MapTypeControl();

				// 지도 타입 컨트롤을 지도에 표시합니다
				map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
				
				// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
				var zoomControl = new kakao.maps.ZoomControl();
				map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
				
				
				var positions = [
				    {
				        title: '카카오', 
				        latlng: new kakao.maps.LatLng(33.450705, 126.570677)
				    },
				    {
				        title: '생태연못', 
				        latlng: new kakao.maps.LatLng(33.450936, 126.569477)
				    },
				    {
				        title: '텃밭', 
				        latlng: new kakao.maps.LatLng(33.450879, 126.569940)
				    },
				    {
				        title: '근린공원',
				        latlng: new kakao.maps.LatLng(33.451393, 126.570738)
				    }
				];
				
// 				var markerImageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/category.png';
				var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/category.png'; 
// 				var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
			    var imageOptions = {  
		                spriteOrigin: new kakao.maps.Point(10, 0),    
		                spriteSize: new kakao.maps.Size(36, 98)  
		            };
			    
			    
				for (var i = 0; i < positions.length; i ++) 
				{
				    
				    // 마커 이미지의 이미지 크기 입니다
				    var imageSize = new kakao.maps.Size(24, 35); 
				    
				    // 마커 이미지를 생성합니다    
				    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize,imageOptions); 
				    
				    // 마커를 생성합니다
				    var marker = new kakao.maps.Marker({
				        map: map, // 마커를 표시할 지도
				        position: positions[i].latlng, // 마커를 표시할 위치
				        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
				        image : markerImage // 마커 이미지 
				    });
				}
				
				//클릭이벤트(위도,경도)
				kakao.maps.event.addListener(map, 'click', function(mouseEvent) 
				{        
				    
				    // 클릭한 위도, 경도 정보를 가져옵니다 
				    var latlng = mouseEvent.latLng;
				    
				    var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
				    message += '경도는 ' + latlng.getLng() + ' 입니다';
				    
				    var resultDiv = document.getElementById('result'); 
				    resultDiv.innerHTML = message;
				    
				});
				
				// 주소-좌표 변환 객체를 생성합니다
				var geocoder = new kakao.maps.services.Geocoder();

				//devU01TX0FVVEgyMDlwMDkwODE0MzYxNjExMDE1NzA=
				function test3()
				{
					var test2 = document.getElementById("test2");
					
					if( test2.value == "")
					{
						alert("주소찾기를 통해 주소를 입력해주세요.");
					}
					
					// 주소로 좌표를 검색합니다
					geocoder.addressSearch(test2.value, function(result, status) 
					{
	
					    // 정상적으로 검색이 완료됐으면 
					     if (status === kakao.maps.services.Status.OK) 
					     {
	
					        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
							
					        console.log("result[0].y:"+result[0].y);
					        console.log("result[0].x:"+result[0].x);
					        
					        console.log("document.getElementById('bdNm'):"+ document.getElementById("bdNm").value);
					        
					        // 결과값으로 받은 위치를 마커로 표시합니다
					        var marker = new kakao.maps.Marker({
					            map: map,
					            position: coords
					        });
	
					        // 인포윈도우로 장소에 대한 설명을 표시합니다
					        var infowindow = new kakao.maps.InfoWindow({
					            content: '<div style="width:150px;text-align:center;padding:6px 0;">'+document.getElementById("bdNm").value+'</div>'
					        });
					        infowindow.open(map, marker);
	
					        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
					        map.setCenter(coords);
					    } 
					});
				};
				
				function fn_test()
				{
					 var pop = window.open("/DiClean/jusoPopup.jsp","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
				}
				
				function jusoCallBack(fullAddr,addr1,bdNm)
				{
					/*
						<input id="test1">
          				<input id="test2">
					*/
					var test1 = document.getElementById("test1");
					var test2 = document.getElementById("test2");
					var bdNm  = document.getElementById("bdNm");
					
					test1.value = fullAddr;
					test2.value = addr1;
					bdNm.value  = bdNm;
					
					console.log("bdNm:"+bdNm);
					
					test3();
				}
				
				function fn_test2()
				{
					
					/*
					 사용자정의템플릿 이용
					 Kakao.Link.sendCustom
						  ({
						    templateId: 36218,   // 15번 항목에서 확인하였던 이벤트번호 등록 
						    templateArgs: {
						        'title': '제목 영역입니다.',
						        'description': '설명 영역입니다.'
						      }
						  });
					*/
					
					/* 피드메세지
					Kakao.Link.sendDefault({
						  objectType: 'feed',
						  content: {
						    title: '디저트 사진',
						    description: '아메리카노, 빵, 케익',
						    imageUrl:
						      'http://mud-kage.kakao.co.kr/dn/NTmhS/btqfEUdFAUf/FjKzkZsnoeE4o19klTOVI1/openlink_640x640s.jpg',
						    link: {
						      mobileWebUrl: 'https://developers.kakao.com',
						      androidExecParams: 'test',
						    },
						  },
						  social: {
						    likeCount: 10,
						    commentCount: 20,
						    sharedCount: 30,
						  },
						  buttons: [
						    {
						      title: '웹으로 이동',
						      link: {
						        mobileWebUrl: 'https://developers.kakao.com',
						      },
						    },
						    {
						      title: '앱으로 이동',
						      link: {
						        mobileWebUrl: 'https://developers.kakao.com',
						      },
						    },
						  ]
// 						  serverCallbackArgs: 
// 						  	  { // 콜백 파라미터 설정
// 							    key: 'hi'
// 							  }
						  
						});
					*/
					Kakao.Link.sendDefault
					({
						objectType: 'text',
						text	  : '테스트',
						link	  :{	  
										  mobileWebUrl: 'https://www.naver.com',
					    				  androidExecParams: 'test'
					    		    },
						buttons: 
						  [
						    {
						      title: '웹1',
						      link: {
						        mobileWebUrl: 'https://developers.kakao.com',
						        webUrl:
						                 'https://www.naver.com',
						      }
						    },
						    {
						      title: '앱1',
						      link: {
						        mobileWebUrl: 'https://developers.kakao.com',
						        webUrl:
						                 'https://www.naver.com',
						      }
						    }
						  ]
					
					});
					
				}
					
				function fn_test4()
				{
					Kakao.Link.sendScrap
						({
						  requestUrl: 'https://developers.kakao.com'
						});
				}
				
				
				function loginFormWithKakao() 
				{
				    Kakao.Auth.loginForm({
				      success: function(authObj) {
				        showResult(JSON.stringify(authObj))
				      },
				      fail: function(err) {
				        showResult(JSON.stringify(err))
				      },
				    })
				 }
				
				 function showResult(result) 
				 {
				    document.getElementById('login-form-result').innerText = result
				 }
				
				
				
				
				/*
				Kakao.Link.sendDefault({
					  objectType: 'feed',
					  content: {
					    title: '디저트 사진',
					    description: '아메리카노, 빵, 케익',
					    imageUrl:
					      'http://mud-kage.kakao.co.kr/dn/NTmhS/btqfEUdFAUf/FjKzkZsnoeE4o19klTOVI1/openlink_640x640s.jpg',
					    link: {
					      mobileWebUrl: 'https://developers.kakao.com',
					      androidExecParams: 'test',
					    },
					  },
					  social: {
					    likeCount: 10,
					    commentCount: 20,
					    sharedCount: 30,
					  },
					  buttons: [
					    {
					      title: '웹으로 이동',
					      link: {
					        mobileWebUrl: 'https://developers.kakao.com',
					      },
					    },
					    {
					      title: '앱으로 이동',
					      link: {
					        mobileWebUrl: 'https://developers.kakao.com',
					      },
					    },
					  ]
					});
				    */
				    
					//e.preventDefault();   //이벤트 버블링 prevent
					
				
				
				
		  </script>
<!-- 스킵 네비게이션 -->
<div class="skip_navi">
    <a href="#contents">본문으로 가기</a>
    <a href="#gnb">주메뉴로 가기</a>
    <a href="#footer">카피라이트로 가기</a>
</div>
<!-- // 스킵 네비게이션 -->

<!-- wrapper -->
<div class="wrapper login">

	<%@ include file="../common/header.jsp" %>
    
    <!-- contents -->
    <div id="contents" class="contents">  
      
      <!-- article --> 
      <div class="article">
        
        <div class="cnt cnt_login  ">
          <p class="login_txt"><em>서비스 이용을 위해서 로그인하여 주시기 바랍니다.</em></p>
<!--           <div id="chart_div"></div> -->
          <div class="login_box">
            <form name="regiform" method="post" action="login.nao" id="regiform" onsubmit="return check_form( this )">
              <fieldset class="login_form">
                <legend class="blind">로그인</legend>
                <div class="c_w fix">
                  <p class="id_area">                    
                    <input type="text" id="id" name="id" maxlength="41" value="test">
                    <label for="id" id="">ID</label>
                  </p>
                  <p class="pw_area">                    
                    <input type="password" id="pw" name="pw" maxlength="16" onkeypress="" onkeyup="" onkeydown="" value="test">
                    <label for="pw" id="label_pw_area">Password</label>
                  </p>                  
                </div>
<!--                 
                <label for="agree01" class="ch">
                  <input type="checkbox" name="sd1" id="agree01"><span>아이디 저장</span>
                </label>
 -->                
                <div class="b_w">
                  <input type="button" value="주소등록" onclick="javascript:fn_test();">
                  <input type="button" value="메세지전송" onclick="javascript:fn_test2();">
                  <input type="button" value="스크랩메세지" onclick="javascript:fn_test4();">
                  <a href="javascript:loginFormWithKakao();"><img src="images/kakao_login_medium_wide.png" alt="login" width="100%" height="70px;" style="margin-bottom: 8px; " ></a>
                  <input type="submit" title="로그인" alt="로그인" value="로그인" class="btn" onclick="">
                  <input type="" title=" 등록" alt="등록" value="등록" class="btn btn_regist" onclick="addMember()">  
                  
                </div>
                <div class="b_w" > 
                </div>
              </fieldset>
            </form>  
          </div>
      </div>
      <!--// article --> 
    
    	   
    </div>
    <!--// contents -->
  </div>
  <!-- footer -->
  <div id="footer" class="footer" > 
    <p class="c">Copyright ⓒ. All rights reserved.</p>

  </div>
  <!--// footer -->   

</div>
<!--// wrapper -->

</body>
</html>
