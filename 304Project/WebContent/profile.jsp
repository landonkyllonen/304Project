<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<%@ page import="dance.AuctionInstance" %>
<%@ page import="java.net.URLEncoder" %>
<%@ include file="jdbc.jsp" %>


<HTML>
<HEAD>
<TITLE>Your Profile</TITLE>
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
// Get user details
	String userID = (String)session.getAttribute("username");
	//Load most up to date information
	getConnection();
	String sql = "SELECT * FROM Users WHERE userID=?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1,userID);
	ResultSet rst = pstmt.executeQuery();
	//No situation when userid wont exist if youve logged in already.
	rst.next();
	String fn = rst.getString("firstName");
	String ln = rst.getString("lastName");
	int bidBalance = rst.getInt("bidBalance");
	
	out.print("<h2>"+fn+" "+ln+"'s Profile</h2>");
	out.print("<h3>Your bid balance:"+bidBalance+"</h3>");
	out.print("<p></p>");
	out.print("<h2>Here are the auctions you are currently watching:</h2>");
	//Get watched auctions.
	sql = "SELECT name, category, currentPrice, endDate, Auction.auctionID, winner FROM watches JOIN Auction ON watches.auctionID = Auction.auctionID JOIN "+
	"Item ON Auction.itemNo = Item.itemNo WHERE userID=?";
	PreparedStatement pstmt2 = con.prepareStatement(sql);
	pstmt2.setString(1,userID);
	ResultSet tablerows = pstmt2.executeQuery();
	
	//Now print table
	out.print("<font face=\"Century Gothic\" size=\"2\"><table class=\"table\" border=\"1\"><tr><th class=\"col-md-1\"></th><th>Product Name</th>");
	out.println("<th>Category</th><th>Price</th><th>Ending</th><th>Top Bidder</th></tr>");
	
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();
	// Colors for different item categories
	HashMap colors = new HashMap();		// This may be done dynamically as well, a little tricky...
	colors.put("Books", "#0000FF");
	colors.put("Cosmetics", "#FF0000");
	//colors.put("Electronics", "#FFFF00");
	colors.put("Electronics", "#000000");
	colors.put("Food", "#6600CC");
	colors.put("Home&Garden", "#55A5B3");
	colors.put("Jewelry", "#FF9900");
	colors.put("Sports", "#00CC00");
	
	while (tablerows.next()) 
	{
		String winner = tablerows.getString(5);
		//Form: name, category, currentPrice, endDate, auctionID, winner
		out.print("<td class=\"col-md-1\"><a href=\"itempage.jsp?id=" + URLEncoder.encode(tablerows.getString(5))+"\">View Auction</a></td>");

		String itemCategory = tablerows.getString(2);
		String color = (String) colors.get(itemCategory);
		if (color == null)
	color = "#FFFFFF";

		out.println("<td><font color=\"" + color + "\">" + tablerows.getString(1) + "</font></td>"
		+ "<td><font color=\"" + color + "\">" + itemCategory + "</font></td>"
		+ "<td><font color=\"" + color + "\">" + currFormat.format(Double.parseDouble(tablerows.getString(3)))
		+ "</font></td><td>"+tablerows.getString(4)+"</td><td>"+tablerows.getString(6)+"</td></tr>");
	}
	out.println("</table></font>");
	
%>
</div>
</BODY>
</HTML> 