<%@page import="dance.LoadData"%>
<%@ include file="jdbc.jsp" %>

<%
	LoadData.loadData();
	response.sendRedirect("manage.jsp?msg=recover");
%>