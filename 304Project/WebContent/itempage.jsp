<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<%@ page import="dance.AuctionInstance" %>

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
</style>
</HEAD>
<BODY>

<%@ include file="header.jsp" %>

<div class="center-div">
<%
// Get the auction clicked
	AuctionInstance sessAuction = (AuctionInstance)session.getAttribute("auction");
	@SuppressWarnings({"unchecked"})

	NumberFormat currFormat = NumberFormat.getCurrencyInstance();
	String name, desc, seller, winner, start, end, price, image, category, itemNo, aucID;
	// Get product information
	if(sessAuction==null){
		name = request.getParameter("name");
		desc = request.getParameter("desc");
		seller = request.getParameter("seller");
		winner = request.getParameter("winner");
		start = request.getParameter("start");
		end = request.getParameter("end");
		price = request.getParameter("price");
		image = request.getParameter("image");
		category = request.getParameter("category");
		itemNo = request.getParameter("itemNo");
		aucID = request.getParameter("aucID");
		AuctionInstance auction = new AuctionInstance(aucID,start,end,price,itemNo,seller,winner,name,desc,image,category);
		session.setAttribute("auction", auction);
	}else{
		name=sessAuction.getName();
		desc=sessAuction.getDesc();
		seller=sessAuction.getSeller();
		winner=sessAuction.getWinner();
		start=sessAuction.getStart();
		end=sessAuction.getEnd();
		price=sessAuction.getPrice();
		image=sessAuction.getImage();
		category=sessAuction.getDesc();
		itemNo=sessAuction.getItemNo();
		aucID=sessAuction.getAuctionID();
		session.setAttribute("auction", sessAuction);
	}

	double pr = Double.parseDouble(price);
	
	out.print("<img src=\""+image+"\" alt=\"Item Pic\" style=\"width:100px;height:100px;\">"+
	"<h5>End Date: "+end+"</h5><h5>Seller: "+seller+"</h5><h5>Top Bidder: "+winner+"</h5>");
	out.print("<h3>"+name+"</h3>");
	out.print("<h3>Current Bid: $"+price+"</h3>");
	
	
%>
<H2><A HREF="itempage.jsp?bid=true">Place Bid!</A></H2>
<H2><A HREF="watchAuction.jsp">Watch this auction</A></H2>
<H2><A HREF="listprod.jsp?watch=true">Continue Shopping</A></H2>
</div>
</BODY>
</HTML> 