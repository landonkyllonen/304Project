<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<%@ page import="dance.AuctionInstance" %>
<%@ page import="java.net.URLEncoder" %>
<%@ include file="jdbc.jsp" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="style.css" />
<title>TSLRG Auctions</title>
<script type="text/javascript">
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
</script>
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
</head>



<body style="background-color:#05060a;">
<div id="container">
		<div id="header">
        
        <a name="top">
       	  <h1><img src="images/TSLRG.png" width="450" height="77" /></h1>
          </a>
            <h2>COSC 304</h2>
  </div>
		<div class="Color" id="menu">
        	<ul>
            	<li class="menuitem"><a href="listprod.jsp">Products</a></li>
                <li class="menuitem"><a href="">About</a></li>
                <li class="menuitem"><a href="">Services</a></li>
                <li class="menuitem"><a href="">Design</a></li>
            </ul>
        </div>
                
		<div class="lol" id="content">
        <div id="content_top" ></div>
        <div id="content_main" ><h1>Welcome the TSLRG Auctions Online Store!</h1>
          <p>&nbsp;</p>

<div class="center-div">
<%
	String purchase = request.getParameter("purchase");
	int purchased = 0;
	if(request.getParameter("created")!=null){
		out.print("<h3 class=\"greentext\">Auction successfully created!</h3>");
	}else if(purchase!=null){
		purchased = Integer.parseInt(purchase);
		out.print("<h3 class=\"greentext\">Thank you for your purchase of "+purchased+" bids!</h3>");
	}
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
	out.print("<a href=\"purchasebids.jsp\">Buy more bids!</a>");
	out.print("<p></p>");
	
	out.print("<p></p>");
	out.print("<a href=\"createauction.jsp?username=" + userID +
			"\">Create your own auction!</a>");
	out.print("<p></p>");
	
	out.print("<p></p>");
	out.print("<a href=\"listprod.jsp\">Back to auctions</a>");
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
	colors.put("Electronics", "#FFFF00");
	//colors.put("Electronics", "#000000");
	colors.put("Food", "#6600CC");
	colors.put("Home&Garden", "#55A5B3");
	colors.put("Jewelry", "#FF9900");
	colors.put("Sports", "#00CC00");
	
	while (tablerows.next()) 
	{
		String winner = tablerows.getString(6);
		if(winner==null){
			winner = "No bids";
		}
		//Form: name, category, currentPrice, endDate, auctionID, winner
		out.print("<td class=\"col-md-1\"><a href=\"itempage.jsp?id=" + URLEncoder.encode(tablerows.getString(5))+"\">View Auction</a></td>");

		String itemCategory = tablerows.getString(2);
		String color = (String) colors.get(itemCategory);
		if (color == null)
	color = "#FFFFFF";

		out.println("<td><font color=\"" + color + "\">" + tablerows.getString(1) + "</font></td>"
		+ "<td><font color=\"" + color + "\">" + itemCategory + "</font></td>"
		+ "<td><font color=\"" + color + "\">" + currFormat.format(Double.parseDouble(tablerows.getString(3)))
		+ "</font></td><td>"+tablerows.getString(4)+"</td><td>"+winner+"</td></tr>");
	}
	out.println("</table></font>");
	
	out.print("<br></br><h2>Here are the auctions you have listed:</h2>");
	//Get listed auctions.
	sql = "SELECT name, category, currentPrice, endDate, Auction.auctionID, winner FROM Auction JOIN Item ON Auction.itemNo = Item.itemNo WHERE seller =?";
	PreparedStatement pstmt3 = con.prepareStatement(sql);
	pstmt3.setString(1,userID);
	ResultSet tablerows2 = pstmt3.executeQuery();
	
	//Now print table
	out.print("<font face=\"Century Gothic\" size=\"2\"><table class=\"table\" border=\"1\"><tr><th class=\"col-md-1\"></th><th>Product Name</th>");
	out.println("<th>Category</th><th>Price</th><th>Ending</th><th>Top Bidder</th></tr>");
	
	while (tablerows2.next()) 
	{
		String winner = tablerows2.getString(6);
		if(winner==null){
			winner = "No bids";
		}
		//Form: name, category, currentPrice, endDate, auctionID, winner
		out.print("<td class=\"col-md-1\"><a href=\"itempage.jsp?id=" + URLEncoder.encode(tablerows2.getString(5))+"\">View Auction</a></td>");

		String itemCategory = tablerows2.getString(2);
		String color = (String) colors.get(itemCategory);
		if (color == null)
	color = "#FFFFFF";

		out.println("<td><font color=\"" + color + "\">" + tablerows2.getString(1) + "</font></td>"
		+ "<td><font color=\"" + color + "\">" + itemCategory + "</font></td>"
		+ "<td><font color=\"" + color + "\">" + currFormat.format(Double.parseDouble(tablerows2.getString(3)))
		+ "</font></td><td>"+tablerows2.getString(4)+"</td><td>"+winner+"</td></tr>");
	}
	out.println("</table></font>");
	closeConnection();
%>
<p>&nbsp;</p>
<p class="CenterTag"><a href="#top">Back to Top          </a></p>
        </div>
        <div id="content_bottom" align="center"></div>
	  </div>
   </div>
</body>

</html>
