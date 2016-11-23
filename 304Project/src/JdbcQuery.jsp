<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<title>Query Results Using JSP</title>
</head>

<body>

<% 
Connection con = null;
/* String url = "jdbc:mysql://cosc304.ok.ubc.ca/db_vchiu/WorksOn";
String uid = "vchiu";
String pw = "70462080"; THIS IS AN IMPORTANT COMMENT, PLEASE READ*/

String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_lkyllone;";
String uid = "lkyllone";
String pw = "15760127";


try {	
	con = DriverManager.getConnection(url, uid, pw);
	Statement stmt = con.createStatement();
	ResultSet rst = stmt.executeQuery("SELECT * from Product");		
	out.println("<table><tr><th>Name</th><th>Salary</th></tr>");
	while (rst.next())
	{	out.println("<tr><td>"+rst.getString(1)+"</td>"+"<td>"+rst.getDouble(2)+"</td></tr>");
	}
	out.println("</table>");
}
catch (SQLException ex) 
{ 	out.println(ex); 
}
finally                
{
	if (con != null)
		try
                {
                        con.close();
                }
                catch (SQLException ex)
                {           
                        System.err.println("SQLException: " + ex);
                }
}
%>
</body>
</html>
