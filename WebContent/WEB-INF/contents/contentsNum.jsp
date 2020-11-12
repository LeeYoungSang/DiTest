<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	Integer contentsNum = (Integer)request.getAttribute("contentsNum");
%>
{"contentsNum":"<%= contentsNum %>"}