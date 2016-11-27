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

<div class="form">
      
      <div class="center-div">
        <div id="signup">   
          <h1>Register for Free</h1>
          
          <form action="listprod.jsp" method="get">
          
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

<%
//Try to create a user with these details, if conflicts, notify user, else
//return to listprod as logged in.

%>

</body>
</html>

