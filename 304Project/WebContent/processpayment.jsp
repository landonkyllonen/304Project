<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.*" %>
<%@ page import="dance.AuctionInstance" %>
<%@ include file="jdbc.jsp" %>


<%
//Get params
String cardnum = request.getParameter("fileupload");
String price = request.getParameter("price");
String cvc = request.getParameter("cvc");
String address = request.getParameter("address");
String fullname = request.getParameter("fullname");
String expm = request.getParameter("expm");
String expy = request.getParameter("expy");
//Get date
DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
Date date = new Date();
String start = dateFormat.format(date); //2016/11/16 12:08:43

//Perform transaction
getConnection();
String sql = "UPDATE Users SET bidBalance = bidBalance + ? WHERE userID = ?";
PreparedStatement pstmt = con.prepareStatement(sql);
pstmt.setInt(1,Integer.parseInt(price));
pstmt.setString(2,(String)session.getAttribute("username"));
pstmt.executeUpdate();

response.sendRedirect("profile.jsp?purchase="+price);


%>