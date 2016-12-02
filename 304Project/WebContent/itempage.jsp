<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<%@ page import="dance.AuctionInstance" %>
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
		if (winner==null){
			winner = "No bids.";
		}
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
					out.print("<h3 class=\"greentext\">You are now watching this auction.</h3>");
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
