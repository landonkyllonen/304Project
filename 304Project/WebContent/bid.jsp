<%@ include file="jdbc.jsp" %>
<%@ page import="dance.AuctionInstance" %>

<%
	//String forward = "<jsp:forward page=\"itempage.jsp?";
	AuctionInstance auction = (AuctionInstance)session.getAttribute("auction");
	String userID = (String)session.getAttribute("username");
	getConnection();
	String sql = "UPDATE Auction SET currentPrice = currentPrice+0.01 WHERE auctionID = ?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, auction.getAuctionID());
	pstmt.executeUpdate();
	System.out.println("Updated currentprice");
	String sql2 = "UPDATE Auction SET winner = userID WHERE auctionID = ?";
	PreparedStatement pstmt2 = con.prepareStatement(sql);
	pstmt2.setString(1, auction.getAuctionID());
	pstmt2.executeUpdate();
	System.out.println("Updated auction topbidder");
	String sql3 = "UPDATE Users SET bidBalance = bidBalance-1 WHERE userID = ?";
	PreparedStatement pstmt3 = con.prepareStatement(sql);
	pstmt3.setString(1, userID);
	pstmt3.executeUpdate();
	System.out.println("bid balance decremented for this user");
%>

<jsp:forward page="itempage.jsp?id=3&start=2016-11-27+00%3A00%3A00.0&end=2016-12-08+00%3A00%3A00.0&price=5.00&itemNo=1&seller=landon&winner=null&name=Galaxy+S2&desc=Stock+Phone+Details&image=http%3A%2F%2Fimg.xda-cdn.com%2FUmUf40rkQCe2ANXzbkECV_XVLbU%3D%2F300x300%2Fsmart%2Fforum.xda-developers.com%2Fdevdb%2FdeviceForum%2Fscreenshots%2F1055%2F20130327T094824.jpg&category=Electronics" />
