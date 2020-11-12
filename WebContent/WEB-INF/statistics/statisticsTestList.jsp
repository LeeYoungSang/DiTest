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
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
<script type="text/javascript" src="common/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="common/js/design.js"></script>
<!-- <script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script> -->
<!--Load the AJAX API-->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<%
		String selADT =  (String)request.getAttribute("selADT");

		//null 일시 임의값 설정
		if(selADT == null)
		{
			selADT = "aa";
		}
%>
<script type="text/javascript">

	$(document).ready(function()
	{
		//광고주 select 태그
		var adtVal ="<%=selADT%>";
		if(adtVal != "aa")
		{
			$("#selADT").val(adtVal);
			console.log("광고주select태그value:"+adtVal);
		}
		
		//검색 타입 맞는 chart 세팅
		var typeChk = document.getElementById("searchType");
		
		if("day" == typeChk.value)
		{
			google.charts.load('current', {packages : ['line']});
			//google.charts.load('current', {'packages':['corechart']});
			google.charts.setOnLoadCallback(dayChart);
			
			$("#day_chart").css("display","");
			$("#preDateTh").text("검색일자");
			$("#preDateTh").css("display","");
			$("#preDateTd").css("display","");
			$("#preDateTd").attr("colspan","3");
			$("#postDateTh").css("display","none");
			$("#postDateTd").css("display","none");
			$("#dayTable").css("display","");
		}
		
		if("month" == typeChk.value)
		{
			google.charts.load('current', {packages : ['line']});
// 			google.charts.load('current', {'packages':['corechart']});
			google.charts.setOnLoadCallback(monthChart);
			
			$("#month_chart").css("display","");
			$("#preDateTh").text("검색일자");
			$("#preDateTh").css("display","");
			$("#preDateMTd").css("display","");
			$("#postDateTh").css("display","none");
			$("#postDateTd").css("display","none");
			$("#monthTable").css("display","");
		}
		
		if("period" == typeChk.value)
		{
			//google.charts.load('current', {'packages':['corechart']});
			google.charts.load('current', {packages : ['line']});
			google.charts.setOnLoadCallback(periodChart);
			
			$("#period_chart").css("display","");
			$("#preDateTh").css("display","");
			$("#preDateTd").css("display","");
			$("#postDateTh").css("display","");
			$("#postDateTd").css("display","");
			$("#periodTable").css("display","");
		}
		
	});

	//검색
	function fn_search(pageNum)
	{
		
		var preDate  = document.getElementById("preDate");
		var postDate = document.getElementById("postDate");
		
		var preVal   =  preDate.value.split("-");
		var postVal  =  postDate.value.split("-");
		
		//검색 조건(일별, 월별, 기간별 )
		var type 	  = document.getElementById("searchType"); 
		
		//광고주
		var selADTval = document.getElementById("selADT");
		
		if("period" == type.value )
		{
			var preDay  = new Date (preVal[0], preVal[1], preVal[2]);
			var postDay = new Date (postVal[0], postVal[1], postVal[2]);
			
			if( preDay > postDay)
			{
				alert("시작일자가 종료일자보다 이전 날짜이여야 합니다.");
				return false;
			}
			
// 			if( preDay.getTime() == postDay.getTime() )
// 			{
// 				alert("같은일자 검색 시엔 일별 통계를 이용해주세요.");
// 				return false;
// 			}
		}
		
		if( type.value == "")
		{
			alert("통계종류를 선택해주세요.");
			return false;
		}
		
		if( selADTval.value != "")
		{
			document.cookie = "selADT="+selADTval.value ;
		}else{
			document.cookie = "selADT="+null ;
		}
		
		var form = document.getElementById("frm");
		
		form.action ="statisticsList.nao";
		form.submit();
	}
	
	function typeSelectFormCtrl()
	{
		var typeChk = document.getElementById("searchType");
		
		if("day" == typeChk.value)
		{
			$("#preDateTh").text("검색일자");
			$("#preDateTh").css("display","");
			$("#preDateTd").css("display","");
			$("#preDateTd").attr("colspan","3");
			$("#preDateMTd").css("display","none");
			$("#postDateTh").css("display","none");
			$("#postDateTd").css("display","none");
		}
		
		if("month" == typeChk.value)
		{
			$("#preDateTh").text("검색일자");
			$("#preDateTh").css("display","");
			$("#preDateMTd").css("display","");
			$("#preDateTd").css("display","none");
			$("#postDateTh").css("display","none");
			$("#postDateTd").css("display","none");
			
		}
		
		if("period" == typeChk.value)
		{
			$("#preDateTh").text("시작일자");
			$("#preDateMTd").css("display","none");
			$("#preDateTh").css("display","");
			$("#preDateTd").attr("colspan","1");
			$("#preDateTd").css("display","");
			$("#postDateTh").css("display","");
			$("#postDateTd").css("display","");
		}
	}
	
	//일일 통게 그래프
	function dayChart()
	{
		var data = new google.visualization.DataTable();
		
		 data.addColumn('number', 'HOUR');
         
         var datas = [];
         
         var searchType = document.getElementById("searchType");
         searchType.value = "day";
         
         var param = $("#frm").serialize();
         
         var cnt = 1;
         
		 $.ajax
		 ({
			 type: 'post',
			 data: param,
			 datatype : 'html',
		     url: 'statisticsAjax2.nao',
		     success: function (result) 
		      {	
		    	 
		    		result = result.replace(/\s+/, "");//왼쪽 공백제거
		    	    result = result.replace(/\s+$/g, "");//오른쪽 공백제거
					result = result.replace(/\n/g, "");//행바꿈제거
					result = result.replace(/\r/g, "");//엔터제거
		    	 	//console.log("result:"+result);
		    	 
		   	  		var dataVal1 = JSON.stringify(result);
		   	  		var dataVal2 = JSON.parse(result);
			
		   	  		//데이터 없을 시 예외처리
		   	  		if("{}" == result)
		   	  		{
		   	  			$("#day_chart").css("display","none");
		   	  			return false;
		   	  		}
		   	  		
		   	  		if(result !=null || result != undefined)
		   	  		{
			   	  		if(dataVal2.body.length>0)
			   	  		{
			   	  			var dataList = [];
			   	  			
			   	  			//시간별 단일배열생성
			   	  			for( var h = 0; h < 24; h++)
			   	  			{
			   	  				eval("var hour"+h+"= []");
			   	  				
			   	  			    var dayData = eval("hour"+h);
                          	    dayData.push(h);
                          	    
                          	    //컬럼 길이만큼 단일배열 0으로 초기값 세팅
                          	    for( var g = 0; g <dataVal2.body.length; g++ )
                          	    {
                          	    	dayData.push(0);
                          	    }
			   	  			}
			   	  			
				   	  		for(var a = 0; a < dataVal2.body.length; a++ )
				   	  		{
				   	  			//console.log("dataVal2"+a+".length:"+ dataVal2.body[a].dayList.length);
				   	  			//console.log("dataVal2"+a+".length:"+ dataVal2.body[a].dayList[0].ADT_NM);
				   	  			
				   	  			//해당컬럼 생성
				   	  			data.addColumn('number', dataVal2.body[a].dayList[0].ADT_NM);
				   	  			
				   	  			for(var b = 0; b < dataVal2.body[a].dayList.length ; b++  )
				   	  			{
				   	  				var hour    =  parseInt(dataVal2.body[a].dayList[b].HOUR);
				   	  				var ads_cnt =  dataVal2.body[a].dayList[b].ADS_CNT+0;
				   	  				
				   	  				var variable = eval("hour"+b);
				   	  				
				   	  				if(variable[0] == hour)
				   	  				{
					   	  				//variable.push(ads_cnt);
				   	  					variable[cnt] = ads_cnt;
				   	  				}
				   	  				
 				   	  				//console.log("variable[a]:"+variable[0]+" 1:"+variable[1]+" 2:"+variable[2]+" 3:"+variable[3]);
				   	  				//dataList.push([hour,abs_cnt]);	
				   	  			}
				   	  			
				   	  			cnt++;
				   	  		}
				   	  		
				   	  		for(var h = 0; h<24; h++)
				   	  		{
				   	  			var variable = eval("hour"+h);
				   	  			dataList.push(variable);
				   	  		}
				   	  		data.addRows(dataList);
			   	  		}
		   	  		}
		   	  		
		   	  		/*
		   	  		console.log("dataVal2.length:"+dataVal2.list.length);
		   	  		 data.addColumn('number', dataVal2.list[0].ADT_NM);
		   	  		
		   	  		for(var a = 0; a<dataVal2.list.length; a++ )
		   	  		{
		   	  			var hour    = 	parseInt(dataVal2.list[a].HOUR);
		   	  			var ads_cnt = 	dataVal2.list[a].ADS_CNT+0;
		   	  			
						console.log("Json배열:"+"["+hour+","+ads_cnt+"]");
		   	  			datas.push([hour,ads_cnt]);
		   	  		}
		   	  		data.addRows(datas);
		   	  		*/
		   	  		
			   	  	 var options = 
					 {
			            title : '일일 통계',
			            curveType: 'function',
//				            legend: { position: 'bottom' },
						 hAxis : 
						 {
			                title : '시간',
//				                minValue : 1,
//				                viewWindow: {
//			                        max: 24
//			                    }
			            }
			            ,
			            vAxis : {
			                title : '광고횟수',
			                minValue : 0
//				                viewWindow: {
//			                        max: 10
//			                    }
			            }
			         };
			 		//var chart = new google.visualization.Histogram(document.getElementById('day_chart'));
				    //var chart = new google.visualization.LineChart(document.getElementById('day_chart'));
					 var chart = new google.charts.Line(document.getElementById('day_chart'));
				     chart.draw(data, options);
			  }, 
		      error: function (error) 
		      {
		         console.log("error: " + JSON.stringify(error));
		      }
			 });
	}
	
	//월별차트 그래프
	function monthChart()
	{
		 var data = new google.visualization.DataTable();
			
		 data.addColumn('string', 'MONTH');
         var datas = [];
         
 		 var searchType = document.getElementById("searchType");
         searchType.value = "month";
         var param = $("#frm").serialize();
         
         var colCnt = 0;
         var monthData;         
         var colNM;
         
		 $.ajax
		 ({
			 type: 'post',
			 data: param,
		     dataType :"html",
		     url: 'statisticsAjax2.nao',
		     success: function (result) 
		      {	
		    	    result = result.replace(/\s+/, "");//왼쪽 공백제거
		    	    result = result.replace(/\s+$/g, "");//오른쪽 공백제거
					result = result.replace(/\n/g, "");//행바꿈제거
					result = result.replace(/\r/g, "");//엔터제거
		    	 	//console.log("result:"+result);
		    	 	
		   	  		var dataVal2 = JSON.parse(result);
		   	  		//console.log("dataVal2.list:"+dataVal2.list);
		   	  		//console.log("dataVal2.length:"+dataVal2.list.length);
		   	  		
		   	  		if(dataVal2.list.length == 0)
		   	  		{
		   	  			$("#month_chart").css("display","none");
		   	  			return false;
		   	  		}
		   	  		
		   	  		if(dataVal2.list.length>0)
		   	  		{
			   	  		colCnt = dataVal2.list[0].COL_CNT;
			   	  		
			   	  		var StringNM = dataVal2.list[0].COL_NM;
			   	  		colNM     =  StringNM.split("@@");
			   	  		
			   	  		monthDate =  dataVal2.list[0].DAY;
			   	  		monthDate =  monthDate.substring(0,7); 
			   	  		
			   	  		/*
			   	  		console.log("colCnt:"+colCnt);
			   	  		console.log("colNM(0):"+colNM[0]+" (1):"+colNM[1]+" (2):"+colNM[2]);
			   	  		console.log("monthDate:"+monthDate);
						console.log("monthDate.substring(0,4):"+ monthDate.substring(0,4) +" (5,7)"+monthDate.substring(5,7));
			   	  		*/
			   	  		
			   	  		//컬럼생성
			   	  		for(var i = 0; i < colCnt; i++ )
			   	  		{
			   	  			var colnm = colNM[i];
			   	  			colnm = colnm.replace(",","");
			   	  			
 			   	  			//data.addColumn('number', colNM[i]);
 			   	  			//console.log("colNM[i]:"+colNM[i]);
			   	  			data.addColumn('number', colnm);
			   	  			console.log("colNM[i]:"+colnm);

			   	  		}

			   	  		//해당 월 마지막일자 
						var lastDate = new Date(monthDate.substring(0,4),monthDate.substring(5,7),0).getDate();
						//console.log("laseDate:"+lastDate);
						
						
						//통계 차트에 뿌려줄 각 날짜에 대한 단일배열 세팅
						for(var h = 1; h <= lastDate ; h++ )
						{
							//var dayVal = monthDate.substring(0,4)+"-"+monthDate.substring(5,7)+"-";
							var dayVal;  
							
							if(h < 10)
							{
								//dayVal +="0"+h; 
								dayVal = "0"+h;
							}
							else
							{
								//dayVal += h;
								dayVal = h+"";
							}
							
							//배열생성
							eval("var day"+h+"= []");	
							var dayData = eval("day"+h);
							
							//dayData.push(dayVal);
							dayData.push(dayVal);
							
							//컬럼 length 만큼 배열내 0으로 세팅한다.
							for(var g = 0; g<colCnt; g++)
							{
								dayData.push(0);
							}
						}
						
			   	  		for(var a = 0; a<dataVal2.list.length; a++ )
			   	  		{
			   	  			var day 	 =  dataVal2.list[a].DAY			//날짜
			   	  			var ads_sum  = 	dataVal2.list[a].ADS_SUM+0;		//광고횟수
			   	  			var adt_nm   =  dataVal2.list[a].ADT_NM			//광고주이름
			   	  			
			   	  			day = day.substring(8,10);
			   	  			//console.log("day:"+day);
			   	  			
			   	  			for(var t = 1; t <= lastDate; t++  )
			   	  			{
			   	  				var variable = eval("day"+t);
			   	  				
			   	  				//날짜 별 단일배열로 세팅 했으므로, 날짜가 같을 시 배열 내 광고 횟수값 세팅
			   	  				if( variable[0] == day )
			   	  				{	
			   	  					//console.log("variable[0]:"+variable[0]);
			   	  					//variable.push(ads_sum);
			   	  					for( var h = 0; h<colCnt; h++  )
			   	  					{
			   	  						/*
			   	  							컬럼비교 후,
			   	  							비교한 컬럼에대한 index에 새로운 값을 대입
			   	  						*/
			   	  						var colnm = colNM[h];
			   	  						colnm = colnm.replace(",","");
			   	  						
			   	  						if(colnm == adt_nm)
			   	  						{
			   	  							variable[h+1] = ads_sum; 	
			   	  							//console.log("variable[h+1]:"+variable[h+1]);
			   	  							//console.log("ads_sum:"+ads_sum);
			   	  							//console.log("[h+1]:"+(h+1));
			   	  						}
			   	  					}
			   	  					
			   	  				  }
			   	  			  }
							//console.log("Json배열:"+"["+day+","+ads_sum+","+adt_nm+"]");
			   	  			//datas.push([month,ads_sum]);
			   	  	  	 }
			   	  		
				   	  	for(var j = 1; j <= lastDate; j++)
			   	  		{
				   	  		//세팅된 단일배열들을 다시 배열 내 세팅
			   	  			var variable = eval("day"+j);
			   	  			datas.push(variable);
			   	  			
			   	  			//console.log("variable:"+variable[0]+" "+variable[1]+" "+variable[2]+" "+variable[3]);
			   	  		}
			   	  		data.addRows(datas);
		   	  		}
		   	  		
			   	  	 var options = 
					 {
			            title : '월별 통계',
			            curveType: 'function',
						 hAxis : 
						{
			                title : '월',
				            minValue : 1,
			                viewWindow: 
			                {
		                        max: lastDate
		                    }
			            }
			            ,
			            vAxis : 
			            {
			                title : '광고횟수',
			                minValue : 0
			            }
			         };
//			 		 var chart = new google.visualization.Histogram(document.getElementById('month_chart'));
// 					 var chart = new google.visualization.LineChart(document.getElementById('month_chart'));
					 var chart = new google.charts.Line(document.getElementById('month_chart'));
				     chart.draw(data, options);
			  }, 
		      error: function (error) 
		      {
		         console.log("error: " + JSON.stringify(error));
		      }
			 });
	}
	
	//기간별차트 그래프
	function periodChart()
	{
		var data = new google.visualization.DataTable();
		
		data.addColumn('string', 'PERIOD');
        var datas = [];
         
 		var searchType = document.getElementById("searchType");
        searchType.value = "period";
        var param = $("#frm").serialize();
         
        var colCnt = 0;
        var monthData;         
        var colNM;

        //시작일자
        var preYearNum;
        var preMonthNum;  
        var preDayNum;
         
        //종료일자
        var postYearNum;
        var postMonthNum;  
        var postDayNum;
         
        var monthGap;
         
        var preDate = document.getElementById("preDate").value;//시작일자
        var postDate = document.getElementById("postDate").value;//종료일자
         
        console.log("preDate:"+preDate);
        console.log("postDate:"+postDate);
         
         
    	//시작일자
   	   	preYearNum   = preDate.substring(0,4);
        preMonthNum  = parseInt(preDate.substring(5,7)); 
        preDayNum    = preDate.substring(8,10);
        
        //종료일자
        postYearNum  = postDate.substring(0,4); 
        postMonthNum = parseInt(postDate.substring(5,7)); 
        postDayNum   = postDate.substring(8,10);
  		
        //종료일자 - 시작일자
        monthGap = postMonthNum-preMonthNum;
        
        console.log("monthGap:"+monthGap);
        
        //일자계산
        var preDay  = new Date(preYearNum,preMonthNum,preDayNum);
        var postDay = new Date(postYearNum,postMonthNum,postDayNum);
        
        preDay = new Date(preDay.getFullYear(), preDay.getMonth()+1, preDay.getDate());
        postDay = new Date(postDay.getFullYear(), postDay.getMonth()+1, postDay.getDate());
        
        var diff =  Math.abs(postDay.getTime() - preDay.getTime() );
        diff = Math.ceil(diff / (1000*3600*24));
        
        console.log("diff:"+diff);
        
        var sum = 0;
        var cnt = 0;
        
		 $.ajax
		 ({
			 type: 'post',
			 data: param,
			 dataType :"html",
		     url: 'statisticsAjax2.nao',
		     success: function (result) 
		      {	
		    	 	result = result.replace(/\s+/, "");//왼쪽 공백제거
		    	    result = result.replace(/\s+$/g, "");//오른쪽 공백제거
					result = result.replace(/\n/g, "");//행바꿈제거
					result = result.replace(/\r/g, "");//엔터제거
		    	 	//console.log("result:"+result);
		    	 	
		   	  		var dataVal2 = JSON.parse(result);
		   	  		var dataVal2 = JSON.parse(result);
		   	  		//console.log("dataVal2.length:"+dataVal2.list.length);
		   	  		
		   	  		if(dataVal2.list.length == 0)
		   	  		{
		   	  			$("#period_chart").css("display","none");
		   	  			return false;
		   	  		}
		   	  		
		   	  		if(dataVal2.list.length>0)
		   	  		{
			   	  		colCnt = dataVal2.list[0].COL_CNT;
			   	  		
			   	  		var StringNM = dataVal2.list[0].COL_NM;
			   	  		colNM     =  StringNM.split("@@");
			   	  		
			   	  		monthDate    =  dataVal2.list[0].DAY;
			   	  		monthDate    =  monthDate.substring(0,7); 

			   	  		//컬럼생성
			   	  		for(var i = 0; i < colCnt; i++ )
			   	  		{
			   	  			var colnm = colNM[i];
			   	  			colnm = colnm.replace(",","");
			   	  			
			   	  			data.addColumn('number', colnm);
			   	  			//console.log("colNM[i]:"+colnm);
			   	  		}

			   	  		//해당 월 마지막일자 
						var lastDate = new Date(monthDate.substring(0,4),monthDate.substring(5,7),0).getDate();
						//console.log("laseDate:"+lastDate);
						
						var increaseDay;
						
						/*
							시작일자와 종료일자의 month(달) 차이만큼 계산을하고 해당 차이만큼의 
							일자의 단일배열을 생성하는 과정
						*/
						// 달 차이 만큼 반복
						for( var gap = 0; gap <= monthGap ; gap++)
						{
							//시작일자 
							if(gap == 0)
							{
								var staDay 	   = new Date(preYearNum,(preMonthNum-1),preDayNum);
								var staLastDay = new Date(preYearNum,preMonthNum,0).getDate();
								
								//console.log("staDay:"+staDay);
								//console.log("staLastDay:"+staLastDay);
								
								for( var sta = preDayNum; sta <= staLastDay; sta++) 
								{
									var monthVal;
									var dayVal;
									var arrayNum;
									
									//월 세팅
									if(preMonthNum < 10)
									{
										monthVal = "0"+preMonthNum;
									}
									else
									{
										monthVal = preMonthNum+"";
									}
									
									//일자세팅
									if(sta < 10)
									{
										dayVal = "0"+sta; 
										
										if(dayVal.length == 3)
										{
											dayVal = dayVal.substring(1,3);
										}
									}
									else
									{
										dayVal = sta+"";
									}
									
									//날짜로 구분하기위해 세팅  예시) 07-29
									arrayNum = monthVal+"-"+dayVal 
									
									//날짜로 구분하는 단일배열 변수 생성
									eval("var perDay"+cnt+"= []");
									var dayData = eval("perDay"+cnt);
									dayData.push(arrayNum);
									
									//컬럼 수 만큼 0으로 단일배열 세팅
									for(var g = 0; g<colCnt; g++)
									{
										dayData.push(0);
									}
									//console.log("staDayData:"+dayData[0]+" [1]:"+dayData[1]+" [2]:"+dayData[2]+" [3]:"+dayData[3]);
									cnt++;
								}
								sum += staLastDay+1;
								
								staDay.setDate(cnt);
								//console.log("cnt:"+cnt);
								//console.log("sum:"+sum);
								//console.log("staDay+cnt:"+staDay);
								
								staDay.setDate(sum);
								
								increaseDay = staDay;
								
								//console.log("star increaseDay = staDay:"+increaseDay);
								//console.log("star increaseDay = staDay :month:"+increaseDay.getMonth());
							}
							//마지막 월 세팅
							else if(gap == monthGap)
							{
								var staDay 	   = new Date(preYearNum,(preMonthNum-1),preDayNum);
								var lastDay = new Date(postYearNum,(postMonthNum-1),postDayNum);
								
								for( var last = 1; last <= postDayNum; last++  )
								{
									var monthVal;
									var dayVal;
									var arrayNum;
									
									//월 세팅
									if(postMonthNum < 10)
									{
										monthVal = "0"+postMonthNum;
									}
									else
									{
										monthVal = postMonthNum+"";
									}
									
									//일자세팅
									if(last < 10)
									{
										dayVal = "0"+last; 
									}
									else
									{
										dayVal = last+"";
									}
									
									//날짜로 구분하기위해 세팅  예시) 07-29
									arrayNum = monthVal+"-"+dayVal 
									
									//날짜로 구분하는 단일배열 변수 생성
									eval("var perDay"+cnt+"= []");
									var dayData = eval("perDay"+cnt);
									dayData.push(arrayNum);
									
									//컬럼 수 만큼 0으로 단일배열 세팅
									for(var g = 0; g<colCnt; g++)
									{
										dayData.push(0);
									}
									//console.log("lastDayData:"+dayData[0]+" [1]:"+dayData[1]+" [2]:"+dayData[2]+" [3]:"+dayData[3]);
									cnt++;
								}
								//console.log("최종cnt:"+cnt)
								//console.log("종료일자-시작일자:"+diff);
							}
							else// 시작, 월 반복
							{
								
								var curLastDay = (new Date(increaseDay.getFullYear(), increaseDay.getMonth()+1 ,0)).getDate();
								var curDay = new Date(increaseDay.getFullYear(), increaseDay.getMonth(),increaseDay.getDate());
								
								//console.log("시작전 :curDay:"+curDay);
								//console.log("시작전 :curLastDay:"+curLastDay);
								//console.log("시작전 :curDay increaseDay.getMonth():month:"+increaseDay.getMonth());
								
								for( var aa = 1; aa <= curLastDay; aa++  )
								{
									var monthVal;
									var dayVal;
									var arrayNum;
									
									//월 세팅
									if( increaseDay.getMonth()+1 < 10)
									{
										monthVal = "0"+(increaseDay.getMonth()+1);
									}
									else
									{
										monthVal = (increaseDay.getMonth()+1)+"";
									}
									
									//일자세팅
									if(aa < 10)
									{
										dayVal = "0"+aa; 
										
										if(dayVal == "001")
										{
											dayVal = dayVal.subString(1,2);
										}
										console.log("dayVal 일자:"+dayVal);
										
									}
									else
									{
										dayVal = aa+"";
									}
									
									//날짜로 구분하기위해 세팅  예시) 07-29
									arrayNum = monthVal+"-"+dayVal 
									
									//날짜로 구분하는 단일배열 변수 생성
									eval("var perDay"+cnt+"= []");
									var dayData = eval("perDay"+cnt);
									dayData.push(arrayNum);
									
									//컬럼 수 만큼 0으로 단일배열 세팅
									for(var g = 0; g<colCnt; g++)
									{
										dayData.push(0);
									}
									
// 									console.log("curDayData:"+dayData[0]+" [1]:"+dayData[1]+" [2]:"+dayData[2]+" [3]:"+dayData[3]);
									cnt++;
								}
								sum = curLastDay+1;
								//console.log("완료:CurDay sum:"+sum);
								
								curDay.setDate(sum);
								increaseDay = curDay;
								
								//console.log("완료:CurDay increaseDay:"+increaseDay);
								//console.log("완료:CurDay increaseDay:month:"+increaseDay.getMonth());
							}
						}
			   	  			
			   	  		for(var a = 0; a<dataVal2.list.length; a++ )
			   	  		{
			   	  			var day 	 =  dataVal2.list[a].DAY			//날짜
			   	  			var ads_sum  = 	dataVal2.list[a].ADS_SUM+0;		//광고횟수
			   	  			var adt_nm   =  dataVal2.list[a].ADT_NM			//광고주이름
			   	  			
			   	  			day = day.substring(5,10);
			   	  			
				   	  		for(var t = 0; t < cnt; t++  )
			   	  			{
			   	  				var variable = eval("perDay"+t);
			   	  				
			   	  				//날짜 별 단일배열로 세팅 했으므로, 날짜가 같을 시 배열 내 광고 횟수값 세팅
			   	  				if( variable[0] == day )
			   	  				{	
			   	  					//console.log("variable[0]:"+variable[0]);
			   	  					//variable.push(ads_sum);
			   	  					for( var h = 0; h<colCnt; h++  )
			   	  					{
			   	  						/*
			   	  							컬럼비교 후,
			   	  							비교한 컬럼에대한 index에 새로운 값을 대입
			   	  						*/
			   	  						var colnm = colNM[h];
			   	  						colnm = colnm.replace(",","");
			   	  						
			   	  						if(colnm == adt_nm)
			   	  						{
			   	  							variable[h+1] = ads_sum; 	
			   	  							console.log("ads_sum:"+ads_sum);
			   	  						}
			   	  					}
			   	  				  }
			   	  			 }
			   	  		}
				   	  	for(var j = 0; j < cnt; j++)
			   	  		{
				   	  		//세팅된 단일배열들을 다시 배열 내 세팅
			   	  			var variable = eval("perDay"+j);
			   	  			datas.push(variable);
			   	  			
			   	  			console.log("variable:"+variable[0]+" "+variable[1]+" "+variable[2]+" "+variable[3]);
			   	  		}
				   	  	
			   	  		data.addRows(datas);
		   	  		}
		   	  		
			   	  	 var options = 
					 {
			            title : '기간별 통계',
			            curveType: 'function',
						 hAxis : 
						{
			                title : '월',
				            minValue : 1,
			                viewWindow: 
			                {
		                        max: cnt
		                    }
			            }
			            ,
			            vAxis : 
			            {
			                title : '광고횟수',
			                minValue : 0
			            }
			         };
//			 		 var chart = new google.visualization.Histogram(document.getElementById('month_chart'));
// 					 var chart = new google.visualization.LineChart(document.getElementById('month_chart'));
					 var chart = new google.charts.Line(document.getElementById('period_chart'));
				     chart.draw(data, options);
			  }, 
		      error: function (error) 
		      {
		         console.log("error: " + JSON.stringify(error));
		      }
			 });
	}
	//광고주 select 세팅
	function selectADTSet()
	{
		//var selADT = document.getElementById("ADTval");
		//console.log("selADT:"+selADT);
		
		var form = document.getElementById("frm");
		var frmChk = form.ADTval; 
		
		//console.log("frmChk:"+frmChk);	
		//console.log("frmChk:"+frmChk.value);
		
		$.ajax
		 ({
			 type: 'post',
		     url: 'statisticsSelectADT.nao',
		     success: function (result) 
		      {	
		    	 var dataVal = JSON.parse(result);
		    	 
		    	 $("#selADT").empty();
		    	 var html = "";
			     if( frmChk.value == null || frmChk.value == "" )
			     {
					 html += "<option value='' selected='selected'>전체</option>";
			     }else
			     {
			    	 html += "<option value=''>전체</option>";	 
			     }		    	 
		    	 for(var i = 0; i<dataVal.adtList.length; i++  )
				 {
		    	 	html += "<option value="+dataVal.adtList[i].ADT_NUM+">"+dataVal.adtList[i].ADT_NM+"</option>";
				 }
				 $("#selADT").html(html); 
		    	 
				 if(typeof frmChk != "undefined")
				 {
					 //console.log("@@@@@@@@@@@:"+frmChk)
					 //console.log("@@@@@@@@@@@:"+frmChk.value)
					 if(frmChk.value !=null)
					 {
						 $("#selADT").val(frmChk.value);
					 }
					 else
					 {
						 $("#selADT").val("");
					 }
				 }
				 
		      },
		      error: function (error) 
		      {
		         console.log("error: " + JSON.stringify(error));
		      }
	    });
	}
	
	//광고종류 select 세팅
	function selectADKSet()
	{
		
	}
	
	//Machine select 세팅
	function selectMacSet()
	{
		
	}
	
	function fn_tete()
	{
		google.charts.load('current', {packages : ['line']});
		//		google.charts.load('current', {'packages':['corechart']});
		google.charts.setOnLoadCallback(fn_test);
		$("#month_chart").css("display","");
		$("#preDateTh").text("검색일자");
		$("#preDateTh").css("display","");
		$("#preDateMTd").css("display","");
		$("#postDateTh").css("display","none");
		$("#postDateTd").css("display","none");
		$("#monthTable").css("display","");
		
	}
	
	//월별차트 그래프
	function fn_test()
	{
		 var data = new google.visualization.DataTable();
		
		 data.addColumn('string', 'PERIOD');
         var datas = [];
         
 		 var searchType = document.getElementById("searchType");
         searchType.value = "period";
         var param = $("#frm").serialize();
         
         var colCnt = 0;
         var monthData;         
         var colNM;
         
         //시작일자
         var preYearNum;
         var preMonthNum;  
         var preDayNum;
          
         //종료일자
         var postYearNum;
         var postMonthNum;  
         var postDayNum;
          
         var monthGap;
          
         var preDate = document.getElementById("preDate").value;//시작일자
         var postDate = document.getElementById("postDate").value;//종료일자
         
         //시작일자
    	 preYearNum   = preDate.substring(0,4);
         preMonthNum  = parseInt(preDate.substring(5,7)); 
         preDayNum    = preDate.substring(8,10);
         
         //종료일자
         postYearNum  = postDate.substring(0,4); 
         postMonthNum = parseInt(postDate.substring(5,7)); 
         postDayNum   = postDate.substring(8,10);
   		
         //종료일자 - 시작일자
         monthGap = postMonthNum-preMonthNum;
         
         console.log("monthGap:"+monthGap);
         
         //일자계산
         var preDay  = new Date(preYearNum,preMonthNum,preDayNum);
         var postDay = new Date(postYearNum,postMonthNum,postDayNum);
         
         preDay = new Date(preDay.getFullYear(), preDay.getMonth()+1, preDay.getDate());
         postDay = new Date(postDay.getFullYear(), postDay.getMonth()+1, postDay.getDate());
         
         var diff =  Math.abs(postDay.getTime() - preDay.getTime() );
         diff = Math.ceil(diff / (1000*3600*24));
         
         var sum = 0;
         var cnt = 0;
         
		 $.ajax
		 ({
			 type: 'post',
			 data: param,
		     dataType :"html",
		     url: 'statisticsAjax2.nao',
		     success: function (result) 
		      {	
		    	    result = result.replace(/\s+/, "");//왼쪽 공백제거
		    	    result = result.replace(/\s+$/g, "");//오른쪽 공백제거
					result = result.replace(/\n/g, "");//행바꿈제거
					result = result.replace(/\r/g, "");//엔터제거
		    	 	console.log("result:"+result);
		    	 	
		   	  		var dataVal2 = JSON.parse(result);
		   	  		//console.log("dataVal2.list:"+dataVal2.list);
		   	  		//console.log("dataVal2.length:"+dataVal2.list.length);
		   	  		
		   	  		if(dataVal2.list.length == 0)
		   	  		{
		   		  		$("#period_chart").css("display","none");
		   	  			return false;
		   	  		}
		   	  		
		   	  		if(dataVal2.list.length>0)
		   	  		{
			   	  		colCnt = dataVal2.list[0].COL_CNT;
			   	  		
			   	  		var StringNM = dataVal2.list[0].COL_NM;
			   	  		colNM     =  StringNM.split("@@");
			   	  		
			   	  		monthDate    =  dataVal2.list[0].DAY;
			   	  		monthDate    =  monthDate.substring(0,7); 
	
			   	  		//컬럼생성
			   	  		for(var i = 0; i < colCnt; i++ )
			   	  		{
			   	  			var colnm = colNM[i];
			   	  			colnm = colnm.replace(",","");
			   	  			
			   	  			data.addColumn('number', colnm);
			   	  			//console.log("colNM[i]:"+colnm);
			   	  		}
	
			   	  		//해당 월 마지막일자 
						var lastDate = new Date(monthDate.substring(0,4),monthDate.substring(5,7),0).getDate();
						//console.log("laseDate:"+lastDate);
						
						var increaseDay;
						
						/*
							시작일자와 종료일자의 month(달) 차이만큼 계산을하고 해당 차이만큼의 
							일자의 단일배열을 생성하는 과정
						*/
						// 달 차이 만큼 반복
						for( var gap = 0; gap <= monthGap ; gap++)
						{
							//시작일자 
							if(gap == 0)
							{
								var staDay 	   = new Date(preYearNum,(preMonthNum-1),preDayNum);
								var staLastDay = new Date(preYearNum,preMonthNum,0).getDate();
								
								//console.log("staDay:"+staDay);
								//console.log("staLastDay:"+staLastDay);
								
								for( var sta = preDayNum; sta <= staLastDay; sta++) 
								{
									var monthVal;
									var dayVal;
									var arrayNum;
									
									//월 세팅
									if(preMonthNum < 10)
									{
										monthVal = "0"+preMonthNum;
									}
									else
									{
										monthVal = preMonthNum+"";
									}
									
									//일자세팅
									if(sta < 10)
									{
										dayVal = "0"+sta; 
										
										if(dayVal.length == 3)
										{
											dayVal = dayVal.substring(1,3);
										}
									}
									else
									{
										dayVal = sta+"";
									}
									
									//날짜로 구분하기위해 세팅  예시) 07-29
									arrayNum = monthVal+"-"+dayVal 
									
									//날짜로 구분하는 단일배열 변수 생성
									eval("var perDay"+cnt+"= []");
									var dayData = eval("perDay"+cnt);
									dayData.push(arrayNum);
									
									//컬럼 수 만큼 0으로 단일배열 세팅
									for(var g = 0; g<colCnt; g++)
									{
										dayData.push(0);
									}
									//console.log("staDayData:"+dayData[0]+" [1]:"+dayData[1]+" [2]:"+dayData[2]+" [3]:"+dayData[3]);
									cnt++;
								}
								sum += staLastDay+1;
								
								staDay.setDate(cnt);
								//console.log("cnt:"+cnt);
								//console.log("sum:"+sum);
								//console.log("staDay+cnt:"+staDay);
								
								staDay.setDate(sum);
								
								increaseDay = staDay;
								
								//console.log("star increaseDay = staDay:"+increaseDay);
								//console.log("star increaseDay = staDay :month:"+increaseDay.getMonth());
							}
							//마지막 월 세팅
							else if(gap == monthGap)
							{
								var staDay 	   = new Date(preYearNum,(preMonthNum-1),preDayNum);
								var lastDay = new Date(postYearNum,(postMonthNum-1),postDayNum);
								
								for( var last = 1; last <= postDayNum; last++  )
								{
									var monthVal;
									var dayVal;
									var arrayNum;
									
									//월 세팅
									if(postMonthNum < 10)
									{
										monthVal = "0"+postMonthNum;
									}
									else
									{
										monthVal = postMonthNum+"";
									}
									
									//일자세팅
									if(last < 10)
									{
										dayVal = "0"+last; 
									}
									else
									{
										dayVal = last+"";
									}
									
									//날짜로 구분하기위해 세팅  예시) 07-29
									arrayNum = monthVal+"-"+dayVal 
									
									//날짜로 구분하는 단일배열 변수 생성
									eval("var perDay"+cnt+"= []");
									var dayData = eval("perDay"+cnt);
									dayData.push(arrayNum);
									
									//컬럼 수 만큼 0으로 단일배열 세팅
									for(var g = 0; g<colCnt; g++)
									{
										dayData.push(0);
									}
									//console.log("lastDayData:"+dayData[0]+" [1]:"+dayData[1]+" [2]:"+dayData[2]+" [3]:"+dayData[3]);
									cnt++;
								}
								//console.log("최종cnt:"+cnt)
								//console.log("종료일자-시작일자:"+diff);
							}
							else// 시작, 월 반복
							{
								
								var curLastDay = (new Date(increaseDay.getFullYear(), increaseDay.getMonth()+1 ,0)).getDate();
								var curDay = new Date(increaseDay.getFullYear(), increaseDay.getMonth(),increaseDay.getDate());
								
								//console.log("시작전 :curDay:"+curDay);
								//console.log("시작전 :curLastDay:"+curLastDay);
								//console.log("시작전 :curDay increaseDay.getMonth():month:"+increaseDay.getMonth());
								
								for( var aa = 1; aa <= curLastDay; aa++  )
								{
									var monthVal;
									var dayVal;
									var arrayNum;
									
									//월 세팅
									if( increaseDay.getMonth()+1 < 10)
									{
										monthVal = "0"+(increaseDay.getMonth()+1);
									}
									else
									{
										monthVal = (increaseDay.getMonth()+1)+"";
									}
									
									//일자세팅
									if(aa < 10)
									{
										dayVal = "0"+aa; 
										
										if(dayVal == "001")
										{
											dayVal = dayVal.subString(1,2);
										}
										console.log("dayVal 일자:"+dayVal);
										
									}
									else
									{
										dayVal = aa+"";
									}
									
									//날짜로 구분하기위해 세팅  예시) 07-29
									arrayNum = monthVal+"-"+dayVal 
									
									//날짜로 구분하는 단일배열 변수 생성
									eval("var perDay"+cnt+"= []");
									var dayData = eval("perDay"+cnt);
									dayData.push(arrayNum);
									
									//컬럼 수 만큼 0으로 단일배열 세팅
									for(var g = 0; g<colCnt; g++)
									{
										dayData.push(0);
									}
									
	//									console.log("curDayData:"+dayData[0]+" [1]:"+dayData[1]+" [2]:"+dayData[2]+" [3]:"+dayData[3]);
									cnt++;
								}
								sum = curLastDay+1;
								//console.log("완료:CurDay sum:"+sum);
								
								curDay.setDate(sum);
								increaseDay = curDay;
								
								//console.log("완료:CurDay increaseDay:"+increaseDay);
								//console.log("완료:CurDay increaseDay:month:"+increaseDay.getMonth());
							}
						}
			   	  			
			   	  		for(var a = 0; a<dataVal2.list.length; a++ )
			   	  		{
			   	  			var day 	 =  dataVal2.list[a].DAY			//날짜
			   	  			var ads_sum  = 	dataVal2.list[a].ADS_SUM+0;		//광고횟수
			   	  			var adt_nm   =  dataVal2.list[a].ADT_NM			//광고주이름
			   	  			
			   	  			day = day.substring(5,10);
			   	  			
				   	  		for(var t = 0; t < cnt; t++  )
			   	  			{
			   	  				var variable = eval("perDay"+t);
			   	  				
			   	  				//날짜 별 단일배열로 세팅 했으므로, 날짜가 같을 시 배열 내 광고 횟수값 세팅
			   	  				if( variable[0] == day )
			   	  				{	
			   	  					//console.log("variable[0]:"+variable[0]);
			   	  					//variable.push(ads_sum);
			   	  					for( var h = 0; h<colCnt; h++  )
			   	  					{
			   	  						/*
			   	  							컬럼비교 후,
			   	  							비교한 컬럼에대한 index에 새로운 값을 대입
			   	  						*/
			   	  						var colnm = colNM[h];
			   	  						colnm = colnm.replace(",","");
			   	  						
			   	  						if(colnm == adt_nm)
			   	  						{
			   	  							variable[h+1] = ads_sum; 	
			   	  							console.log("ads_sum:"+ads_sum);
			   	  						}
			   	  					}
			   	  				  }
			   	  			 }
			   	  		}
				   	  	for(var j = 0; j < cnt; j++)
			   	  		{
				   	  		//세팅된 단일배열들을 다시 배열 내 세팅
			   	  			var variable = eval("perDay"+j);
			   	  			datas.push(variable);
			   	  			
			   	  			console.log("variable:"+variable[0]+" "+variable[1]+" "+variable[2]+" "+variable[3]);
			   	  		}
				   	  	
			   	  		data.addRows(datas);
	   	  		}
	   	  		
		   	  	 var options = 
				 {
		            title : '기간별 통계',
		            curveType: 'function',
					 hAxis : 
					{
		                title : '월',
			            minValue : 1,
		                viewWindow: 
		                {
	                        max: cnt
	                    }
		            }
		            ,
		            vAxis : 
		            {
		                title : '광고횟수',
		                minValue : 0
		            }
		         };
//		 		 var chart = new google.visualization.Histogram(document.getElementById('month_chart'));
//					 var chart = new google.visualization.LineChart(document.getElementById('month_chart'));
				 var chart = new google.charts.Line(document.getElementById('period_chart'));
			     chart.draw(data, options);
		  }, 
	      error: function (error) 
	      {
	         console.log("error: " + JSON.stringify(error));
	      }
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
<div class="wrapper group">

	<%@ include file="../common/header.jsp" %>
  
    <!-- search area -->
    <div class="top_serch">
      <div class="search_w">
        <div class="box">
          <form id="frm" name="frm" method="post">
          <input type="hidden" id="ADTVal" name="ADTval" value="<%=request.getAttribute("selADT")%>"> 
          <table class="tb tb_row">
            <caption>검색</caption>
            <colgroup>
              <col width="20%">
              <col width="40%">
              <col width="40%">
            </colgroup>
            <tbody>
              <tr>
                <th>통계 검색창</th>
                <td>
                	<table>
                		<tr>
                			<th>통계종류</th>
							<td>
								<select id="searchType" name="searchType" style="width: 200px;" onchange="javascript:typeSelectFormCtrl();">
									<option value="">선택해주세요.</option>
<%
									if("day".equals((String)request.getAttribute("type")))
									{
%>
										<option value="day" selected="selected">일별</option>
<% 	
									}
									else
									{
%>
										<option value="day">일별</option>
<%
									}	
%>
<%
									if("month".equals((String)request.getAttribute("type")))
									{
%>
										<option value="month" selected="selected">월별</option>
<%
									}
									else
									{
%>
										<option value="month">월별</option>
<%
									}
%>
<%
									if("period".equals((String)request.getAttribute("type")))
									{
%>
										<option value="period" selected="selected">기간별</option>
<%
									}
									else
									{
%>
										<option value="period">기간별</option>
<%
									}
%>
								</select>
							</td>
							<th>광고주</th>
							<td>
								<select style="width: 200px;" id="selADT" name="selADT">
									<option value=''>전체</option>
<%
						ArrayList<Map<String, Object>> adtList = (ArrayList<Map<String, Object>>)request.getAttribute("adtList");

						if( adtList != null ) 
						{
							for(int i = 0; i < adtList.size(); i++) 
							{
								Map<String, Object> ad = (Map<String, Object>)adtList.get(i);
%>
									<option value="<%= ad.get("ADT_NUM") %>"><%= ad.get("ADT_NM") %></option>		
<%
							}
						}
%>
								</select>
							</td>
                			<th style="display:none;">광고종류</th>
							<td style="display:none;">
								<select style="width: 200px;" id="selAdKind" name="selAdKind" onchange="javascript:selectMacSet();">
									<option value="">선택해주세요</option>
								</select>
							</td> 
							<th style="display:none;">Machine</th>
							 <td style="display:none;">
								<select style="width: 200px;" id="selMc" name="selMc">
									<option value="">선택해주세요</option>
								</select>
							</td>
                		</tr>
                		<tr>
							<th id="preDateTh" style="display:none;">시작일자</th>
							<td id="preDateTd" style="display:none; width: 200px; height: 38px; ">
<!-- 								<select style="width: 200px;"> -->
<!-- 									<option value="">없음</option> -->
<!-- 								</select> -->
								 <input id="preDate" name="preDate" class="date" readonly="readonly" style="width:200px; height: 38px; padding: 0 28px 0 10px;" value="<%=request.getAttribute("preDate")%>" />
							</td>
							<td id="preDateMTd" style="display:none; width: 200px; height: 38px;"  > 
								 <input id="preDateM" name="preDateM" class="dateM" readonly="readonly" style="width:200px; height: 38px; padding: 0 28px 0 10px;"  value="<%=request.getAttribute("preDateM")%>" />
							</td>
							<th id="postDateTh" style="display:none;">종료일자</th>
							<td id="postDateTd" style="display:none; width: 200px; height: 38px; ">
<!-- 								<select style="width: 200px;"> -->
<!-- 									<option value="">없음</option> -->
<!-- 								</select> -->
								  <input id="postDate" name="postDate" class="date" readonly="readonly" style="width:200px; height: 38px; padding: 0 28px 0 10px;" value="<%=request.getAttribute("postDate")%>"/>
							</td>
                		</tr>
                	</table>
                </td>
              </tr>
            </tbody>
          </table>
          <div class="btn_w" style="position:static;" >
            <div class="w">
              <a href="javascript:fn_search(1);" class="btn btn_sch"><span>검색</span></a>
<!--               <a href="statisticsJson.nao" class="btn btn_white"><span>JSON파일등록</span></a> -->
            </div>
          </div>
          </form>
        </div>
      </div>
    </div>
    <!--// search area -->
    
<%
	ArrayList<Map<String, Object>> stList = (ArrayList<Map<String, Object>>)request.getAttribute("stList");
%>
    
    <!-- contents -->
    <div id="contents" class="contents">  
      
      <!-- article --> 
      <div class="article">
                
        <div class="cnt"> 
          <h3>통계 내역</h3>     
          
          <div id="day_chart" style="width: 100%; height: 500px; display:none"></div>
	      <div id="month_chart" style="width: 100%; height: 500px; display:none;  overflow:auto;"  ></div>
          <div id="period_chart" style="width: 100%; height: 500px; display:none;"></div>
          <div class="t_w">
            <table class="tb tb_col tb_result" id="dayTable" style="display:none";>
              <caption>통계 내역</caption>
              <colgroup>
                <col width="12%">
                <col width="*">
                <col width="12%">
                <col width="12%">
                <col width="12%">
           	 </colgroup>                
              <thead>
              <tr>
                <th>광고주</th>
                <th>날짜</th>
                <th>시간</th>
                <th>광고횟수</th>
                <th>Special 여부</th>
              </tr>
              </thead>
              <tbody>
<%
	if(stList != null && stList.size() > 0) {
		for(int i = 0; i < stList.size(); i++) {
			Map<String, Object> st = stList.get(i);
%>
              <tr>
<!--               
                <td class="td_ch">
                  <label for="ch_01" class="ch">
                    <input type="checkbox" name="sd1" id="ch_01"><span></span>
                  </label>
                </td>
 -->
                <td><%= st.get("ADT_NM") %></td>
                <td><%= st.get("DAY") %></td>
                <td><%= st.get("HOUR") %></td>
                <td><%= st.get("ADS_CNT") %></td>
                <td><%= st.get("SP_YN") %></td>
<%--                 <td><a href="updateAdvertiserForm.nao?advertiser_num=<%= st.get("advertiser_num") %>"><%= st.get("advertiser_name") %></a></td> --%>
              </tr>
 <%
		}
	
	} else {
%> 
              <tr>
				<th colspan="5">등록된 파일이 없습니다.</th>
			  </tr>
<%		
	}
%>				  
              </tbody>
            </table>
            <table class="tb tb_col tb_result" id="monthTable" style="display:none";>
              <caption>통계 내역</caption>
              <colgroup>
                <col width="12%">
                <col width="*">
                <col width="12%">
                <col width="12%">
                <col width="12%">
           	  </colgroup>                
              <thead>
              <tr>
                <th>광고주</th>
                <th>월</th>
                <th>광고횟수</th>
                <th>광고명</th>
                <th>담당자</th>
              </tr>
              </thead>
              <tbody>
<%
	if(stList != null && stList.size() > 0) 
	{
		for(int i = 0; i < stList.size(); i++) 
		{
			Map<String, Object> st = stList.get(i);
%>
              	<tr>
	                <td><%= st.get("ADT_NM") %></td>
	                <td><%= st.get("MONTH") %></td>
	                <td><%= st.get("ADS_SUM") %></td>
	                <td><%= st.get("C_TITLE") %></td>
	                <td><%= st.get("ID") %></td>
            	</tr>
 <%
		}
	
	} 
	else 
	{
%> 
              <tr>
				<th colspan="5">등록된 파일이 없습니다.</th>
			  </tr>
<%		
	}
%>				  
              </tbody>
            </table>
            <table class="tb tb_col tb_result" id="periodTable" style="display:none";>
              <caption>통계 내역</caption>
              <colgroup>
                <col width="12%">
                <col width="*">
                <col width="12%">
                <col width="12%">
                <col width="12%">
           	  </colgroup>                
              <thead>
              <tr>
                <th>광고주</th>
                <th>월</th>
                <th>광고횟수</th>
                <th>광고명</th>
                <th>담당자</th>
              </tr>
              </thead>
              <tbody>
<%
	if(stList != null && stList.size() > 0) 
	{
		for(int i = 0; i < stList.size(); i++) 
		{
			Map<String, Object> st = stList.get(i);
%>
              	<tr>
	                <td><%= st.get("ADT_NM") %></td>
	                <td><%= st.get("MONTH") %></td>
	                <td><%= st.get("ADS_SUM") %></td>
	                <td><%= st.get("C_TITLE") %></td>
	                <td><%= st.get("ID") %></td>
            	</tr>
 <%
		}
	
	} 
	else 
	{
%> 
              <tr>
				<th colspan="5">등록된 파일이 없습니다.</th>
			  </tr>
<%		
	}
%>				  
              </tbody>
            </table>
<!--             
            <div class="btm_btn_l">
              <a href="#" class="btn btn_white"><span>선택 그룹 삭제</span></a>
            </div>
 -->       
 <%
/* 	int totalRow = (Integer)request.getAttribute("totalRow");
	int pn = (Integer)request.getAttribute("pn");
	
	int startPage = (((pn - 1) / 10) * 10) + 1;
	int totalPage = ((totalRow - 1) / 10) + 1; */
%>           
            <div class="paging">
<%
//	if(startPage > 1) {
%>                  
              <a href="fileList.nao?pn=1" class="pagn_btn page_first">처음</a>
              <a href="fileList.nao?pn=<%//= startPage - 1 %>" class="pagn_btn page_before">이전</a>
<%
/* 	}

	for(int i = startPage; i < startPage + 10; i++) {
		if(i > totalPage ) {
			break;
		}
		
		if(i == pn) {
 */%>              
              <a href="fileList.nao?pn=<%//= i %>" class="ac"><span><%//= i %></span></a>
<%			
//		} else {
%>              
              <a href="fileList.nao?pn=<%//= i %>"><span><%//= i %></span></a>
<%			
/* 		}
	}
	
	if(startPage + 10 <= totalPage) {
 */%>                   
              <a href="fileList.nao?pn=<%//= startPage + 10 %>" class="pagn_btn page_next">다음</a>
              <a href="fileList.nao?pn=<%//= totalPage %>" class="pagn_btn page_last">마지막</a>
<%
//	}
%>               
            </div>

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
