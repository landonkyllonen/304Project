<%@ page import="java.sql.*" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<%
String firstname = request.getParameter("fn");
String lastname = request.getParameter("ln");
String email = request.getParameter("email");
String username = request.getParameter("username");
String password = request.getParameter("password");
String DOB = request.getParameter("DOB");
int startingBids=0;
String perms = "user";
//Try to create a user with these details, if conflicts, notify user, else
//return to listprod as logged in.
getConnection();
String sql="SELECT * FROM Users WHERE email=? OR userID = ?";
PreparedStatement pstmt=con.prepareStatement(sql);
pstmt.setString(1,email);
pstmt.setString(2,username);
ResultSet rst = pstmt.executeQuery();
//If no result
if(rst.next()==false){
	//Create user on database, forward to listprod and login.
	sql="INSERT INTO Users VALUES (?,?,?,?,?,?,?,?)";
	pstmt = con.prepareStatement(sql);
	pstmt.setString(1,username);
	pstmt.setString(2,password);
	pstmt.setString(3,firstname);
	pstmt.setString(4,lastname);
	pstmt.setString(5,email);
	pstmt.setString(6,DOB);
	pstmt.setInt(7,startingBids);
	pstmt.setString(8,firstname);
	pstmt.executeUpdate();
	
	response.sendRedirect("listprod.jsp?username="+username+"&password="+password);
}else{
	//Return to register page with error
	response.sendRedirect("register.jsp?error=taken");
}
%>

</body>
</html>

