<%@ include file="jdbc.jsp" %>
<%@ page import="dance.AuctionInstance" %>

<%
	int balance=0;
	String userID="";
	AuctionInstance auction = (AuctionInstance)session.getAttribute("auction");
	
	//response.sendRedirect("itempage.jsp?bid=&id="+auction.getWinner());
	
	if(session.getAttribute("balance")!=null){
		balance = (int)session.getAttribute("balance");
	}
	if(session.getAttribute("username")!=null){
		userID = (String)session.getAttribute("username");
	}
	if(userID.equalsIgnoreCase("")||userID==null){
		//If not logged in, redirect to register page.
		response.sendRedirect("register.jsp?error=register");
	}else if(balance<1){
		//If out of bids, send them to purchase bids.
		response.sendRedirect("purchasebids.jsp");
	}else{
		//THIS SHOULD BE A TRANSACTION
		//Place bid: This updates the current price of the auction...
		getConnection();
		String sql = "UPDATE Auction SET currentPrice = currentPrice+0.01 WHERE auctionID = ?";
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setString(1, auction.getAuctionID());
		pstmt.executeUpdate();
		//Sets the new top bidder to the user...
		System.out.println("Updated currentprice");
		String sql2 = "UPDATE Auction SET winner = ? WHERE auctionID = ?";
		PreparedStatement pstmt2 = con.prepareStatement(sql2);
		pstmt2.setString(1, userID);
		pstmt2.setInt(2, Integer.parseInt(auction.getAuctionID()));
		pstmt2.executeUpdate();
		//and takes one bid away from the user...
		System.out.println("Updated auction topbidder");
		String sql3 = "UPDATE Users SET bidBalance = bidBalance-1 WHERE userID = ?";
		PreparedStatement pstmt3 = con.prepareStatement(sql3);
		pstmt3.setString(1, userID);
		pstmt3.executeUpdate();
		System.out.println("bid balance decremented for this user");
		String sql4="SELECT * FROM Auction WHERE auctionID =?";
		PreparedStatement pstmt4 = con.prepareStatement(sql4);
		pstmt4.setString(1, auction.getAuctionID());
		pstmt4.executeQuery();
		//and if not already watching, watch this auction
		String check = "SELECT * FROM watches WHERE userID = ? AND auctionID = ?";
		PreparedStatement checking = con.prepareStatement(check);
		checking.setString(1, userID);
		checking.setInt(2, Integer.parseInt(auction.getAuctionID()));
		ResultSet res = checking.executeQuery();
		if(!res.next()){
			String sql5="INSERT INTO watches VALUES(?,?)";
			PreparedStatement pstmt5 = con.prepareStatement(sql5);
			pstmt5.setString(1,userID);
			pstmt5.setInt(2,Integer.parseInt(auction.getAuctionID()));
			pstmt5.executeUpdate();
			System.out.println("added to watchlist");
		}else{
			System.out.println("Already in watchlist");
		}
		
		closeConnection();
		response.sendRedirect("itempage.jsp?bid=success&id="+auction.getAuctionID());
	}
	
%>