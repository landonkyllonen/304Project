<%@ page import="java.sql.*" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>TSLRG</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<style>
.redtext {
        color: red;
}
</style>
</head>
<body>

<%@ include file="header.jsp" %>


<%
//Try to get login info, 
String username = request.getParameter("username");
String password = request.getParameter("password");


if(username!=null){
	
}

//if logged in, display link to profile, else, 
//make login elements visible.
String elements="";
if(username!=null&&password!=null){
	//Verify details
	getConnection();
	System.out.println(username + password);
	                		
    String sql = "SELECT * FROM Users WHERE userID = ? AND password = ?";	
				      
    con = DriverManager.getConnection(url, uid, pw);
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
					"<a href=\"profile.jsp?username=" + username +
					"\">View Profile</a>"+
							
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
   					//Link to profile and greeting
   		elements += "<div align=\"right\">" +
						"<h3>Hi, "+username+"!</h3>"+
					"</div>"+
					"<a href=\"profile.jsp?username=" + username +
					"\">View Profile</a>"+
					"<form method=\"get\" action=\"listprod.jsp\">"+
					"<p align=\"right\">"+
						"<input type=\"submit\" value=\"Log Out\">"+
					"</p>"+
				"</form>";
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
colors.put("Electronics", "#000000");
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
	sql = "SELECT Item.itemNo, name, currentPrice, category FROM Auction JOIN Item ON Auction.itemNo=Item.itemNo WHERE name LIKE ? AND category = ?";
}
else if (hasNameParam)
{
	filter = "<h3>Products containing '"+name+"'</h3>";
	name = '%'+name+'%';
	sql = "SELECT Item.itemNo, name, currentPrice, category FROM Auction JOIN Item ON Auction.itemNo=Item.itemNo WHERE productName LIKE ?";
}
else if (hasCategoryParam)
{
	filter = "<h3>Products in category: '"+category+"'</h3>";
	sql = "SELECT Item.itemNo, name, currentPrice, category FROM Auction JOIN Item ON Auction.itemNo=Item.itemNo WHERE categoryName = ?";
}
else
{
	filter = "<h3>All Products</h3>";
	sql = "SELECT Item.itemNo, name, currentPrice, category FROM Auction JOIN Item ON Auction.itemNo=Item.itemNo";
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
	out.println("<th>Category</th><th>Price</th></tr>");
	while (rst.next()) 
	{
		out.print("<td class=\"col-md-1\"><a href=\"addcart.jsp?id=" + rst.getInt(1) + "&name=" + rst.getString(2)
				+ "&price=" + rst.getDouble(3) + "\">Add to Cart</a></td>");

		String itemCategory = rst.getString(4);
		String color = (String) colors.get(itemCategory);
		if (color == null)
			color = "#FFFFFF";

		out.println("<td><font color=\"" + color + "\">" + rst.getString(2) + "</font></td>"
				+ "<td><font color=\"" + color + "\">" + itemCategory + "</font></td>"
				+ "<td><font color=\"" + color + "\">" + currFormat.format(rst.getDouble(3))
				+ "</font></td></tr>");
	}
	out.println("</table></font>");
	closeConnection();
} catch (SQLException ex) {
	out.println(ex);
}
%>

</body>
</html>

