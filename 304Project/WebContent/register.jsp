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

<%@ include file="header.jsp" %>

<%
String error = request.getParameter("error");
if (error!=null&&!error.equalsIgnoreCase("")){
	switch(error){
		case "taken":
			out.print("<h3 class=\"redtext\">Username or email already in use.</h3>");
			break;
		case "register":
			out.print("<h3 class=\"redtext\">You must be a member to bid, please register now, or log in from the main page.</h3>");
			break;		
		default:
			break;
	}
}


%>

<div class="form">
      
      <div class="center-div">
        <div id="signup">   
          <h1>Register for Free</h1>
          
          <form action="createuser.jsp" method="get">
          
          <div class="container">
            <div class="container">
              <label>
                First Name<span class="req">*</span>
              </label>
              <input type="text" required autocomplete="off" name="fn" />
            </div>
        
            <div class="container">
              <label>
                Last Name<span class="req">*</span>
              </label>
              <input type="text"required autocomplete="off" name="ln"/>
            </div>
          </div>
          
          <div class="container" >
            <label>
              Date of Birth<span class="req">*</span>
            </label>
            <input type="text"required autocomplete="off" name="DOB"/>
          </div>

          <div class="container" >
            <label>
              Email Address<span class="req">*</span>
            </label>
            <input type="email"required autocomplete="off" name="email"/>
          </div>
          
          <div class="container">
            <label>
              Create Your Username<span class="req">*</span>
            </label>
            <input type="text"required autocomplete="off" name="username"/>
          </div>
          
          <div class="container">
            <label>
              Set A Password<span class="req">*</span>
            </label>
            <input type="password"required autocomplete="off" name="password"/>
          </div>
          
          <button type="submit" class="button button-block">Get Started</button>
          
          </form>

        </div>
        
      </div><!-- tab-content -->
      
</div> <!-- /form -->

</body>
</html>

