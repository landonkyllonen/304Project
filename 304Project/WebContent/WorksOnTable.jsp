<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ page import="java.sql.*"%>
	<%
		Connection con = null;
		
		String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=WorksOn;";
		String uid = "vchiu";
		String pw = "70462080";
		try {
			con = DriverManager.getConnection(url, uid, pw);
			Statement stmt = con.createStatement();
			ResultSet rst = stmt.executeQuery("SELECT ename,salary FROM Emp");
			out.println("");
			while (rst.next()) {
				out.println("" + "");
			}
			out.println("Name	Salary" + rst.getString(1) + "	" + rst.getDouble(2) + "");
		} catch (SQLException ex) {
			out.println(ex);
		} finally {
			if (con != null)
				try {
					con.close();
				} catch (SQLException ex) {
					System.err.println("SQLException: " + ex);
				}
		}
	%>
</body>
</html>