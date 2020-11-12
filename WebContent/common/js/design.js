$(window).on('load', function(){
	
	var winW = $(window).width();
	var winH = $(window).height();
	
	/* common  */
	$('.wrapper').addClass("on");
	
	
});
	
	
$(document).ready(function(){
	

	$('#top').click(function(){ 
			$("html, body").animate({ scrollTop: 0 }, 600); 
			return false; 
	}); 
	
	$('.btn_tg_w').click(function(){ 
		var f = $(this).siblings('#filter');
		if($(f).css("display") == "none"){
			$( ".btn_tg_w a " ).removeClass( "ac" ).hide();
			$( ".btn_tg_w a.btn_tg_c" ).addClass( "ac" ).show();
			$(f).show();
		}else{
			$( ".btn_tg_w a " ).removeClass( "ac" ).hide();
			$( ".btn_tg_w a.btn_tg_o" ).addClass( "ac" ).show();
			$(f).hide();
		};
	}); 
	
	/* datePicker : 년-월-일 */
	$( ".date" ).datepicker
	({
		 changeMonth: true, 
	     changeYear: true,
	     nextText: '다음 달',
	     prevText: '이전 달',
	     dateFormat : "yy-mm-dd",
	     monthNamesShort : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	     monthNames :['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	     dayNames 	:['월요일','화요일','수요일','목요일','금요일','토요일','일요일'], 
	     dayNamesMin:['월','화','수','목','금','토','일']
	});	
	
	
	/* datePicker : 년-월 */
	
	$( ".dateM" ).datepicker
	({
		 changeMonth: true, 
	     changeYear: true,
	     nextText: '다음 달',
	     prevText: '이전 달',
	     dateFormat : "yy-mm",
	     monthNamesShort : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	     monthNames :['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	     dayNames 	:['월요일','화요일','수요일','목요일','금요일','토요일','일요일'], 
	     dayNamesMin:['월','화','수','목','금','토','일']
	});	
	
	
	
	
});


$(function(){ 		
	
	/* header menu gnb */
	$("#gnb").hover(function () {
		$("#header .hd_bg").addClass("act");
		$("#header .hd_g_bg").addClass("act");
		$('#header').addClass("act");				
	});
  $("#gnb > li").hover(function () {
		$("#gnb > li").removeClass("act").addClass("off");				
		$(this).addClass("act");	
		
	});
	$("#gnb > li").mouseleave(function () {
		$(this).removeClass("act");	
		$("#gnb > li").removeClass("off");
		
	});
	$("#header .hd_gnb").mouseleave(function () {		
		$("#header").removeClass("act");	
		$("#header .hd_g_bg").removeClass("act");	
		$("#header .hd_bg").removeClass("act");	
	});	
	
	$("#gnb").focusin(function () {
		$("#header .hd_bg").addClass("act");
		$("#header .hd_g_bg").addClass("act");
		$('#header').addClass("act");				
	});
  $("#gnb > li").focusin(function () {
		$("#gnb > li").removeClass("act").addClass("off");				
		$(this).addClass("act");	
		
	});
	$("#gnb > li").focusout(function () {
		$(this).removeClass("act");	
		$("#gnb > li").removeClass("off");
		
	});
	$("#header .hd_gnb").focusout(function () {		
		$("#header").removeClass("act");	
		$("#header .hd_g_bg").removeClass("act");	
		$("#header .hd_bg").removeClass("act");	
	});	

});

$(function(){ 		

	/* nav select */	
	$(".dep1_list .dep1").click(function(){
		var list = $(this).parents('.depth');
		
		if($(list).hasClass("ac")){
			$(list).removeClass('ac');
		}else{
			$(list).addClass('ac');
		}
		
	});
	
	/* nav select */	
	$(".nav_list .txt_w").click(function(){
		var list = $(this).siblings('.select_list');
		if($(list).css("display") == "none"){
			$( ".nav_list li" ).removeClass( "ac" );
			$( ".nav_list .select_list" ).hide();
			$( ".nav_list .select_list" ).removeClass( "ac" );
			$(this).parents('li').addClass( "ac" );
			$(list).show();
		}else{
			$( ".nav_list li" ).removeClass( "ac" );
			$(list).hide();
		};
		$(".nav_list .select_wrap").focusout(function () {				
			$( ".nav_list li" ).removeClass( "ac" );
			$(list).hide();
			$(list).hide().removeClass( "ac" );	
		});
	});
	
	
	/* tab list */
	$(".tab_list a").click(function() {
		var tab_p = $(this).parents('.tab_box');
		var tab_a = $(tab_p).find('a');
		var tab_cnt = $(tab_p).siblings('.tab_cnt');
		var acTab = $(this).attr("href"); 
		
		$(tab_a).removeClass('ac');
		$(this).addClass("ac"); 
		$(tab_cnt).hide(); 		
		$(acTab).show(); 
		return false;	
	});

	
	/* tab */
	$(".tab a").click(function() {
		var tab_p = $(this).parents('.tab');
		var tab_a = $(tab_p).find('a');
		var tab_cnt = $(tab_p).siblings('.tab_cnt');
		var acTab = $(this).attr("href"); 
		
		$(tab_a).removeClass('ac');
		$(this).addClass("ac"); 
		$(tab_cnt).hide(); 		
		$(acTab).show() 
		return false;	
	});
	
		/* tab_info */
	$(".tab_info a").click(function() {
		var tab_p = $(this).parents('.tab_info');
		var tab_a = $(tab_p).find('a');
		var tab_cnt = $(tab_p).siblings('.tab_cnt');
		var acTab = $(this).attr("href"); 
		
		$(tab_a).removeClass('ac');
		$(this).addClass("ac"); 
		$(tab_cnt).removeClass('ac').removeClass('a');
		$(acTab).addClass("ac"); 
		return false;	
	});

	
	/* FAQ */		
	$('.faq_list a.tit').click(function(){ 
		var txt = $(this).siblings('.txt_w');
		var li = $(this).parent('li');
		if($(txt).css("display") == "none"){
			$(".faq_list .txt_w").hide();
			$(".faq_list li ").removeClass('ac');
			$(li).addClass('ac');
			$(txt).show();
		}else{
			$(".faq_list li ").removeClass('ac');
			$(txt).hide();
		};
	}); 
	

	/* sitemap */
  $(".ico_menuAll").click(function () {
		$('#sitemap').show().addClass('ac').animate({'opacity': 1}, 100);
		$('.wrapper').addClass('f');
	});
	 $("#sitemap .sm_btn_c").click(function () {
		$('#sitemap').hide().removeClass('ac').animate({'opacity': 0}, 0);;
		$('.wrapper').removeClass('f');
	});
	
});

