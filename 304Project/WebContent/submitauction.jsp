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
String path = request.getParameter("fileupload");
String name = request.getParameter("name");
String desc = request.getParameter("desc");
String category = request.getParameter("itemCategory");
//Get date
DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
Date date = new Date();
String start = dateFormat.format(date); //2016/11/16 12:08:43
//End date 5 days after
Calendar c = Calendar.getInstance();
c.setTime(new Date()); // Now use today date.
c.add(Calendar.DATE, 5); // Adding 5 days
String end = dateFormat.format(c.getTime());

//Check if item is new
getConnection();
String sql = "SELECT * FROM Item WHERE name = ?";
PreparedStatement check = con.prepareStatement(sql);
check.setString(1,name);
ResultSet rst = check.executeQuery();
int itemId=-1;
//if new, create new item as well as auction
if(!rst.next()){
	//if new, create new item as well as auction
	sql="INSERT INTO Item VALUES (?, ?, ?, ?)";
	PreparedStatement pstmt1 = con.prepareStatement(sql);
	pstmt1.setString(1,name);
	pstmt1.setString(2,desc);
	pstmt1.setString(3,path);
	pstmt1.setString(4,category);
	pstmt1.executeUpdate();
	
	//Get that auto generated id
	sql="SELECT itemNo FROM Item WHERE name=?";
	PreparedStatement retrieve = con.prepareStatement(sql);
	retrieve.setString(1,name);
	ResultSet rst2=retrieve.executeQuery();
	rst2.next();
	itemId=rst2.getInt("itemNo");
	
	//create new auction
	sql="INSERT INTO Auction VALUES (?, ?, ?, ?, ?, NULL)";
	PreparedStatement pstmt2 = con.prepareStatement(sql);
	pstmt2.setString(1,start);
	pstmt2.setString(2,end);
	pstmt2.setDouble(3,0.01);
	pstmt2.setInt(4,itemId);
	pstmt2.setString(5,(String)session.getAttribute("username"));
	pstmt2.executeUpdate();
	closeConnection();
	response.sendRedirect("profile.jsp?created=true");
}else{
	itemId=rst.getInt("itemNo");
	//create new auction
	sql="INSERT INTO Auction VALUES (?, ?, ?, ?, ?, NULL)";
	PreparedStatement pstmt2 = con.prepareStatement(sql);
	pstmt2.setString(1,start);
	pstmt2.setString(2,end);
	pstmt2.setDouble(3,0.01);
	pstmt2.setInt(4,itemId);
	pstmt2.setString(5,(String)session.getAttribute("username"));
	pstmt2.executeUpdate();
	closeConnection();
	response.sendRedirect("profile.jsp?created=true");
}

%>