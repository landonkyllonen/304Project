<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="dance.*"%>
<%@ page import="java.net.URLEncoder" %>
<%@ include file="jdbc.jsp" %>

<!-- TODO
AUCTIONS
	Allow bidding on auctions (auctions you bid on are placed on your watch list)
	Allow payment for auctions won
	Display watch list on view profile link from listprod
	Allow auction creation(need to allow picture selection)
	Countdown, smarter end time display MATT
	Get pictures for items, set them to be loaded from server instead of from url. LANDON
PROFILEPAGE
	Display profile info (#bids, etc)
	Link from profile page to auctions won, shipping status, purchase history etc
	Optional: Add option to change password
MANAGER
	Generate reports
	Recover system(ddl already in place, link button to file that executes it)
	Change details/remove auction.
	
 -->
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
            	<li class="menuitem"><a href="">Home</a></li>
                <li class="menuitem"><a href="">About</a></li>
                <li class="menuitem"><a href="">Services</a></li>
                <li class="menuitem"><a href="">Design</a></li>
                <li class="menuitem"><a href="listprods.jsp">Products</a></li>
                <li class="menuitem"><a href="showcart.jsp">Cart</a></li>
            </ul>
        </div>
                
		<div class="lol" id="content">
        <div id="content_top" ></div>
        <div id="content_main" ><h1>Welcome the TSLRG Auctions Online Store!</h1>
          <p>&nbsp;</p>



<%
//Determine what user is trying to do
String action = request.getParameter("action");
if(action!=null){
	session.removeAttribute("username");
	session.removeAttribute("password");
	//Can use this for more actions, right now action only 1 value, simpler to remove if action not null
	/* switch(action){
		case "logout":
			session.removeAttribute("username");
			session.removeAttribute("password");
			break;
		default:
			break;
	} */
}


//Try to get login info, 
String username = request.getParameter("username");
String password = request.getParameter("password");
//If not trying to log in, check if should already be logged in.
if(username==null&&password==null){
	username = (String)session.getAttribute("username");
	password = (String)session.getAttribute("password");
}

//if logged in, display link to profile, else, 
//make login elements visible.
String elements="";
if(username!=null&&password!=null){
	//Verify details
	getConnection();
	System.out.println(username + password);
	                		
    String sql = "SELECT * FROM Users WHERE userID = ? AND password = ?";	
				      
    //con = DriverManager.getConnection(url, uid, pw);
   	PreparedStatement pstmt = con.prepareStatement(sql);
   	pstmt.setString(1, username);
   	pstmt.setString(2, password);
   	ResultSet rst = pstmt.executeQuery();
    
   	//If user/pass combo doesn't exist
   	if (!rst.isBeforeFirst() ) {   
   					//Error message
   	    elements += "<div align=\"right\">" +
						"<h3 class=\"redtext\">Wrong username or password</h3>"+
					"</div>"+
							
					//Login fields
					"<form method=\"get\" action=\"listprod.jsp\">"+
						"<div align=\"right\">"+
							"<pre>Username    Password   </pre>"+
					"</div>"+

						"<p align=\"right\">"+
							"<input type=\"text\" name=\"username\" size=\"10\">"+
							"<input type=\"text\" name=\"password\" size=\"10\">"+
						"</p>"+

						"<p align=\"right\">"+
							"<input type=\"submit\" value=\"Log In\">"+
						"</p>"+
					"</form>"+

				"<form method=\"get\" action=\"register.jsp\">"+
					"<p align=\"right\">"+
						"<input type=\"submit\" value=\"Register\">"+
					"</p>"+
				"</form>";
   	}else{
   		rst.next();
   		int balance = rst.getInt("bidBalance"); 
   		session.setAttribute("username", username);
   		session.setAttribute("password", password);
   		session.setAttribute("balance", balance);
   					//Link to profile and greeting
   		elements += "<div align=\"right\">" +
						"<h3>Hi, "+username+"!</h3>"+
					"</div>"+
					"<div align=\"right\">"+
						"<a href=\"profile.jsp?username=" + username +
						"\">View Profile</a>"+
					"</div>"+
					"<div align=\"right\">"+
						"<a href=\"listprod.jsp?action=logout=\">Log Out</a>"+
					"</div>";
   	}
	out.print(elements);
	
}else{
	elements += 
			//Login fields
	"<form method=\"get\" action=\"listprod.jsp\">"+
		"<div align=\"right\">"+
			"<pre>Username    Password   </pre>"+
		"</div>"+

		"<p align=\"right\">"+
			"<input type=\"text\" name=\"username\" size=\"10\">"+
			"<input type=\"text\" name=\"password\" size=\"10\">"+
		"</p>"+

		"<p align=\"right\">"+
			"<input type=\"submit\" value=\"Log In\">"+
		"</p>"+
	"</form>"+

	"<form method=\"get\" action=\"register.jsp\">"+
		"<p align=\"right\">"+
			"<input type=\"submit\" value=\"Register\">"+
		"</p>"+
	"</form>";

	out.print(elements);
}
%>


  

<h2>Browse Products By Category and Search by Product Name:</h2>

<form method="get" action="listprod.jsp">
  <p align="left">
  <select size="1" name="categoryName">
  <option>All</option>

<%
/*
// Could create category list dynamically - more adaptable, but a little more costly
try               
{
	getConnection();
 	ResultSet rst = executeQuery("SELECT DISTINCT categoryName FROM Product");
        while (rst.next()) 
		out.println("<option>"+rst.getString(1)+"</option>");
}
catch (SQLException ex)
{       out.println(ex);
}
<jsp:include page="csss/css.css"/>
*/
%>

  <option>Books</option>
  <option>Cosmetics</option>
  <option>Electronics</option>
  <option>Food</option>
  <option>Home&Garden</option>
  <option>Jewelry</option>
  <option>Sports</option>

  <input type="text" name="productName" size="50">    
  </select><input type="submit" value="Submit"><input type="reset" value="Reset"></p>
</form>

<%
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
%>

<%
	// Get product name to search for
	
String name = request.getParameter("productName");
String category = request.getParameter("categoryName");

boolean hasNameParam = name != null && !name.equals("");
boolean hasCategoryParam = category != null && !category.equals("") && !category.equals("All");
String filter = "", sql = "";

if (hasNameParam && hasCategoryParam)
{
	filter = "<h3>Products containing '"+name+"' in category: '"+category+"'</h3>";
	name = '%'+name+'%';
	sql = "SELECT * FROM Auction JOIN Item ON Auction.itemNo=Item.itemNo WHERE name LIKE ? AND category = ?";
}
else if (hasNameParam)
{
	filter = "<h3>Products containing '"+name+"'</h3>";
	name = '%'+name+'%';
	sql = "SELECT * FROM Auction JOIN Item ON Auction.itemNo=Item.itemNo WHERE name LIKE ?";
}
else if (hasCategoryParam)
{
	filter = "<h3>Products in category: '"+category+"'</h3>";
	sql = "SELECT * FROM Auction JOIN Item ON Auction.itemNo=Item.itemNo WHERE category = ?";
}
else
{
	filter = "<h3>All Products</h3>";
	sql = "SELECT * FROM Auction JOIN Item ON Auction.itemNo=Item.itemNo";
}

out.println(filter);

NumberFormat currFormat = NumberFormat.getCurrencyInstance();

try 
{
	getConnection();
	PreparedStatement pstmt = con.prepareStatement(sql);
	if (hasNameParam)
	{
		pstmt.setString(1, name);	
		if (hasCategoryParam)
		{
	pstmt.setString(2, category);
		}
	}
	else if (hasCategoryParam)
	{
		pstmt.setString(1, category);
	}
	
	ResultSet rst = pstmt.executeQuery();
	
	out.print("<font face=\"Century Gothic\" size=\"2\"><table class=\"table\" border=\"1\"><tr><th class=\"col-md-1\"></th><th>Product Name</th>");
	out.println("<th>Category</th><th>Price</th><th>Ending</th></tr>");
	while (rst.next()) 
	{
		String winner = rst.getString(7);
		if(winner==null){
			winner="null";
		}
		//Form: aucId, start, end, price, itemno, seller, winner, itemno, name, desc, image, category
		out.print("<td class=\"col-md-1\"><a href=\"itempage.jsp?id=" + URLEncoder.encode(rst.getString(1))+"\">View Auction</a></td>");

		String itemCategory = rst.getString(12);
		String color = (String) colors.get(itemCategory);
		if (color == null)
	color = "#FFFFFF";

		out.println("<td><font color=\"" + color + "\">" + rst.getString(9) + "</font></td>"
		+ "<td><font color=\"" + color + "\">" + itemCategory + "</font></td>"
		+ "<td><font color=\"" + color + "\">" + currFormat.format(rst.getDouble(4))
		+ "</font></td><td>"+rst.getString(3)+"</td></tr>");
	}
	out.println("</table></font>");
	closeConnection();
} catch (SQLException ex) {
	out.println(ex);
}
%>


<p>&nbsp;</p>
<p class="CenterTag"><a href="#top">Back to Top          </a></p>
        </div>
        <div id="content_bottom" align="center"></div>
	  </div>
   </div>
</body>

</html>