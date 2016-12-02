<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<%@ page import="dance.AuctionInstance" %>
<%@ include file="jdbc.jsp" %>


<HTML>
<HEAD>
<TITLE>This is an auction</TITLE>
<link href="css/bootstrap.min.css" rel="stylesheet">
<style>
#itemdetails{
    display:inline-block;
    width:300px; /* Adjust this */
}
.center-div
{
     margin: 0 auto;
     width: 250px; 
}
.redtext {
        color: red;
}
.greentext {
        color: green;
}
</style>
</HEAD>
<BODY>

<%@ include file="header.jsp" %>

<div class="center-div">
<%
// Get the auction clicked or the current sessAuction
	AuctionInstance auction = (AuctionInstance)session.getAttribute("auction");
	String userID = (String)session.getAttribute("username");
	
	//Get auction details on page load, done this way so it can be refreshed.
	getConnection();
	String sql = "SELECT * FROM Auction JOIN Item ON Auction.itemNo = Item.itemNo WHERE auctionID = ?";
	PreparedStatement pstmt=con.prepareStatement(sql);
	String aucId = request.getParameter("id");
	if(aucId!=null){
		pstmt.setInt(1,Integer.parseInt(aucId));
	}else{
		pstmt.setInt(1,Integer.parseInt(auction.getAuctionID()));
	}
	
	ResultSet rst = pstmt.executeQuery();
	
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();
	String name, desc, seller, winner, start, end, price, image, category, itemNo, aucID;
	
	if(rst.next()){
		//Auction exists, load it
		//Form: aucId, start, end, price, itemno, seller, winner, itemno, name, desc, image, category
		auction = new AuctionInstance(rst.getString(1), rst.getString(2),rst.getString(3)
				,rst.getString(4),rst.getString(5),rst.getString(6),rst.getString(7),rst.getString(9),
				rst.getString(10),rst.getString(11),rst.getString(12));
		name = auction.getName();
		desc = auction.getDesc();
		seller = auction.getSeller();
		winner = auction.getWinner();
		start = auction.getStart();
		end = auction.getEnd();
		price = auction.getPrice();
		image = auction.getImage();
		category = auction.getCategory();
		itemNo = auction.getItemNo();
		aucID = auction.getAuctionID();
		
		session.setAttribute("auction", auction);
		
		double pr = Double.parseDouble(price);
		
		String action = request.getParameter("bid");
		if(action!=null){
			switch(action){
				case "success":
					out.print("<h3 class=\"greentext\">You are the new top bidder!</h3>");
					break;
				case "failedwatch":
					out.print("<h3 class=\"redtext\">You are already watching this auction.</h3>");
					break;
				case "watch":
					out.print("<h3 class=\"redtext\">You are already watching this auction.</h3>");
					break;
				default:
					break;
			}
		}
		
		//Display item.
		out.print("<img src=\""+image+"\" alt=\"Item Pic\" style=\"width:100px;height:100px;\">"+
		"<h5>End Date: "+end+"</h5><h5>Seller: "+seller+"</h5><h5>Top Bidder: "+winner+"</h5>");
		out.print("<h3>"+name+"</h3>");
		out.print("<h3>"+desc+"</h3>");
		out.print("<h3>Current Bid: $"+price+"</h3>");
	}else{
		//Display item not found
		out.print("<h3 class=\"redtext\">That auction does not exist.</h3>");
	}
	
	out.print("<H2><A HREF=\"bid.jsp\">Place Bid!</A></H2>"+
			"<H2><A HREF=\"watch.jsp?aucID="+auction.getAuctionID()+"&userID="+userID+"\">Watch this auction</A></H2>"+
			"<H2><A HREF=\"listprod.jsp?watch=true\">Continue Shopping</A></H2>");
%>
</div>
</BODY>
</HTML> 