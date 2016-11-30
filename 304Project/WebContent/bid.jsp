<%@ include file="jdbc.jsp" %>
<%@ page import="dance.AuctionInstance" %>

<%
	AuctionInstance auction = (AuctionInstance)session.getAttribute("auction");
	String userID = (String)session.getAttribute("username");
	getConnection();
	String sql = "UPDATE Auction SET currentPrice = currentPrice+0.01 WHERE auctionID = ?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, auction.getAuctionID());
	pstmt.executeUpdate();
	String sql2 = "UPDATE Auction SET winner = userID WHERE auctionID = ?";
	PreparedStatement pstmt2 = con.prepareStatement(sql);
	pstmt2.setString(1, auction.getAuctionID());
	pstmt2.executeUpdate();
	String sql3 = "UPDATE Users SET bidBalance = bidBalance-1 WHERE userID = ?";
	PreparedStatement pstmt3 = con.prepareStatement(sql);
	pstmt3.setString(1, userID);
	pstmt3.executeUpdate();
%>

<!--
<jsp:forward page="showcart.jsp" />
-->
