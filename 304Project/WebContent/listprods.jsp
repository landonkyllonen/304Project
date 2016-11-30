<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
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
                <li class="menuitem"><a href="">Products</a></li>
                <li class="menuitem"><a href="">Login</a></li>
            </ul>
        </div>
                
		<div class="lol" id="content">
        <div id="content_top" ></div>
        <div id="content_main" ><h1>Welcome the TSLRG Auctions Online Store!</h1>
          <p>&nbsp;</p>
         
          
          <form method="get" action="listprods.jsp">
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>

<% // Get product name to search for

String name = request.getParameter("productName");
		
	boolean hasParameter = false;
	String sql = "";

	if (name == null)
		name = "";

	if (name.equals("")) 
	{
		out.println("</br>" + "<h1>All Products</h1>" + "</br>");
		sql = "SELECT productId, productName, price FROM Product";
	} 
	else 
	{
		out.println("</br>"+ "<h2>Products containing '" + name + "'</h2>" + "</br>");
		hasParameter = true;
		sql = "SELECT productId, productName, price FROM Product WHERE productName LIKE ?";
		name = '%' + name + '%';
	}

Connection con = null;
	String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_rwong;";
	String uid = "rwong";
	String pw = "41106139";
	
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();

	try 
	{
		con = DriverManager.getConnection(url, uid, pw);
		PreparedStatement pstmt = con.prepareStatement(sql, 
				 ResultSet.TYPE_SCROLL_INSENSITIVE,
				 ResultSet.CONCUR_READ_ONLY);
		if (hasParameter)
			pstmt.setString(1, name);
		
		ResultSet rst = pstmt.executeQuery();
		
		out.println("<table width='900' border='0' cellspacing='5'>");
		
		while (rst.next()) 
		{
			out.println("<tr><td width='210'>" + "<img src='images/pic.jpg' width='210' height='105' />" + "</td>");
			if(rst.next()){
				out.println("<td width='210'>" + "<img src='images/pic.jpg' width='210' height='105' />" + "</td>");
				if(rst.next()){
					out.println("<td width='210'>" + "<img src='images/pic.jpg' width='210' height='105' />" + "</td>");
					if(rst.next()){
						out.println("<td width='210'>" + "<img src='images/pic.jpg' width='210' height='105' />" + "</td>");
						out.println("</tr>");
						rst.previous();
						rst.previous();
						rst.previous();
						out.println("<tr><td><p>" + rst.getString(2) + "</p></td>");
						rst.next();
						out.println("<td><p>" + rst.getString(2) + "</p></td>");
						rst.next();
						out.println("<td><p>" + rst.getString(2) + "</p></td>");
						rst.next();
						out.println("<td><p>" + rst.getString(2) + "</p></td></tr>");
						rst.previous();
						rst.previous();
						rst.previous();
						out.println("<tr><td><table width='200' height='24' border='0' cellpadding='0' cellspacing='0'>" +
				                "<tr><td width='149'><h5>" + "Price:" + "</h5></td><td width='41'><h5>" + 
								currFormat.format(rst.getDouble(3)) + "</h5></td></tr></table></td>");
						rst.next();
						out.println("<td><table width='200' height='24' border='0' cellpadding='0' cellspacing='0'>" +
				                "<tr><td width='149'><h5>" + "Price:" + "</h5></td><td width='41'><h5>" + 
								currFormat.format(rst.getDouble(3)) + "</h5></td></tr></table></td>");
						rst.next();
						out.println("<td><table width='200' height='24' border='0' cellpadding='0' cellspacing='0'>" +
				                "<tr><td width='149'><h5>" + "Price:" + "</h5></td><td width='41'><h5>" + 
								currFormat.format(rst.getDouble(3)) + "</h5></td></tr></table></td>");
						rst.next();
						out.println("<td><table width='200' height='24' border='0' cellpadding='0' cellspacing='0'>" +
				                "<tr><td width='149'><h5>" + "Price:" + "</h5></td><td width='41'><h5>" + 
								currFormat.format(rst.getDouble(3)) + "</h5></td></tr></table></td></tr>");
						rst.previous();
						rst.previous();
						rst.previous();
						out.println("<tr><td><table width='200' height='24' border='0' cellpadding='0' cellspacing='0'><tr><td width='128'>&nbsp;</td>" +
					                  "<td width='72'>" + "<a href=\"addcart.jsp?id=" + rst.getInt(1) + "&name=" + rst.getString(2)
						      			+ "&price=" + rst.getDouble(3) + "\">Add to Cart</a>" +"</td></tr></table></td>");
						rst.next();
						out.println("<td><table width='200' height='24' border='0' cellpadding='0' cellspacing='0'><tr><td width='128'>&nbsp;</td>" +
				                  "<td width='72'>" + "<a href=\"addcart.jsp?id=" + rst.getInt(1) + "&name=" + rst.getString(2)
					      			+ "&price=" + rst.getDouble(3) + "\">Add to Cart</a>" +"</td></tr></table></td>");
						rst.next();
						out.println("<td><table width='200' height='24' border='0' cellpadding='0' cellspacing='0'><tr><td width='128'>&nbsp;</td>" +
				                  "<td width='72'>" + "<a href=\"addcart.jsp?id=" + rst.getInt(1) + "&name=" + rst.getString(2)
				      			+ "&price=" + rst.getDouble(3) + "\">Add to Cart</a>" +"</td></tr></table></td>");
						rst.next();
						out.println("<td><table width='200' height='24' border='0' cellpadding='0' cellspacing='0'><tr><td width='128'>&nbsp;</td>" +
				                  "<td width='72'>" + "<a href=\"addcart.jsp?id=" + rst.getInt(1) + "&name=" + rst.getString(2)
				      			+ "&price=" + rst.getDouble(3) + "\">Add to Cart</a>" +"</td></tr></table></td></tr>");

						
						
						}
					else{
						
						out.println("</tr>");
						rst.previous();
						rst.previous();
						rst.previous();
						out.println("<tr><td><p>" + rst.getString(2) + "</p></td>");
						rst.next();
						out.println("<td><p>" + rst.getString(2) + "</p></td>");
						rst.next();
						out.println("<td><p>" + rst.getString(2) + "</p></td></tr>");
						rst.previous();
						rst.previous();
						out.println("<tr><td><table width='200' height='24' border='0' cellpadding='0' cellspacing='0'>" +
				                "<tr><td width='149'><h5>" + "Price:" + "</h5></td><td width='41'><h5>" + 
								currFormat.format(rst.getDouble(3)) + "</h5></td></tr></table></td>");
						rst.next();
						out.println("<td><table width='200' height='24' border='0' cellpadding='0' cellspacing='0'>" +
				                "<tr><td width='149'><h5>" + "Price:" + "</h5></td><td width='41'><h5>" + 
								currFormat.format(rst.getDouble(3)) + "</h5></td></tr></table></td>");
						rst.next();
						out.println("<td><table width='200' height='24' border='0' cellpadding='0' cellspacing='0'>" +
				                "<tr><td width='149'><h5>" + "Price:" + "</h5></td><td width='41'><h5>" + 
								currFormat.format(rst.getDouble(3)) + "</h5></td></tr></table></td></tr>");
						rst.previous();
						rst.previous();
						out.println("<tr><td><table width='200' height='24' border='0' cellpadding='0' cellspacing='0'><tr><td width='128'>&nbsp;</td>" +
					                  "<td width='72'>" + "<a href=\"addcart.jsp?id=" + rst.getInt(1) + "&name=" + rst.getString(2)
						      			+ "&price=" + rst.getDouble(3) + "\">Add to Cart</a>" +"</td></tr></table></td>");
						rst.next();
						out.println("<td><table width='200' height='24' border='0' cellpadding='0' cellspacing='0'><tr><td width='128'>&nbsp;</td>" +
				                  "<td width='72'>" + "<a href=\"addcart.jsp?id=" + rst.getInt(1) + "&name=" + rst.getString(2)
					      			+ "&price=" + rst.getDouble(3) + "\">Add to Cart</a>" +"</td></tr></table></td>");
						rst.next();
						out.println("<td><table width='200' height='24' border='0' cellpadding='0' cellspacing='0'><tr><td width='128'>&nbsp;</td>" +
				                  "<td width='72'>" + "<a href=\"addcart.jsp?id=" + rst.getInt(1) + "&name=" + rst.getString(2)
					      			+ "&price=" + rst.getDouble(3) + "\">Add to Cart</a>" +"</td></tr></table></td>");
						
						out.println("<td></td></tr>");
						
						}
					}
				else{
					out.println("</tr>");
					rst.previous();
					rst.previous();
					out.println("<tr><td><p>" + rst.getString(2) + "</p></td>");
					rst.next();
					out.println("<td><p>" + rst.getString(2) + "</p></td></tr>");
					rst.previous();
					out.println("<tr><td><table width='200' height='24' border='0' cellpadding='0' cellspacing='0'>" +
			                "<tr><td width='149'><h5>" + "Price:" + "</h5></td><td width='41'><h5>" + 
							currFormat.format(rst.getDouble(3)) + "</h5></td></tr></table></td>");
					rst.next();
					out.println("<td><table width='200' height='24' border='0' cellpadding='0' cellspacing='0'>" +
			                "<tr><td width='149'><h5>" + "Price:" + "</h5></td><td width='41'><h5>" + 
							currFormat.format(rst.getDouble(3)) + "</h5></td></tr></table></td></tr>");
					
					rst.previous();
					out.println("<tr><td><table width='200' height='24' border='0' cellpadding='0' cellspacing='0'><tr><td width='128'>&nbsp;</td>" +
				                  "<td width='72'>" + "<a href=\"addcart.jsp?id=" + rst.getInt(1) + "&name=" + rst.getString(2)
					      			+ "&price=" + rst.getDouble(3) + "\">Add to Cart</a>" +"</td></tr></table></td>");
					rst.next();
					out.println("<td><table width='200' height='24' border='0' cellpadding='0' cellspacing='0'><tr><td width='128'>&nbsp;</td>" +
			                  "<td width='72'>" + "<a href=\"addcart.jsp?id=" + rst.getInt(1) + "&name=" + rst.getString(2)
				      			+ "&price=" + rst.getDouble(3) + "\">Add to Cart</a>" +"</td></tr></table></td>");
	
					out.println("<td></td>");
					out.println("<td></td></tr>");
					
				}
			}
			
			else{
			out.println("</tr>");
			rst.previous();
			out.println("<tr><td><p>" + rst.getString(2) + "</p></td></tr>");
			
			out.println("<tr><td><table width='200' height='24' border='0' cellpadding='0' cellspacing='0'>" +
	                "<tr><td width='149'><h5>" + "Price:" + "</h5></td><td width='41'><h5>" + 
					currFormat.format(rst.getDouble(3)) + "</h5></td></tr></table></td></tr>");
			
			out.println("<tr><td><table width='200' height='24' border='0' cellpadding='0' cellspacing='0'><tr><td width='128'>&nbsp;</td>" +
		                  "<td width='72'>" + "<a href=\"addcart.jsp?id=" + rst.getInt(1) + "&name=" + rst.getString(2)
			      			+ "&price=" + rst.getDouble(3) + "\">Add to Cart</a>" +"</td></tr></table></td>");

			out.println("<td></td>");
			out.println("<td></td>");
			out.println("<td></td></tr>");
			}
			
			out.println("<tr height = '30'></tr>");
		}
				
		
		out.println("</table>");
	} 
	
	catch (SQLException ex) 
	{
		out.println(ex);
	} 
	finally 
	{
		try 
		{
			if (con != null)
				con.close();
		} 
		catch (SQLException ex) 
		{
			out.println(ex);
		}
	}

%>
          
          </hr>

<p>&nbsp;</p>
<p class="CenterTag"><a href="#top">Back to Top          </a></p>
        </div>
        <div id="content_bottom" align="center"></div>
	  </div>
   </div>
</body>

</html>