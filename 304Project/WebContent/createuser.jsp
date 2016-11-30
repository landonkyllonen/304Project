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
   .container {
        width: 500px;
        clear: both;
    }
    .container input {
        width: 100%;
        clear: both;
    }
.center-div
{
     margin: 0 auto;
     width: 250px; 
}
.redtext {
        color: red;
}
</style>
</head>
<body>

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

%>

</body>
</html>

