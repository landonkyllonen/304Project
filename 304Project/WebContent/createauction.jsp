<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<%@ page import="dance.AuctionInstance" %>
<%@ include file="jdbc.jsp" %>


<HTML>
<HEAD>
<TITLE>This is an auction</TITLE>
<link href="css/bootstrap.min.css" rel="stylesheet">
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
</HEAD>
<BODY>

<%@ include file="header.jsp" %>
<div class="form">
      
      <div class="center-div">
        <div id="signup">   
          <h4>Put an item up for auction!</h4>
          
          <form action="submitauction.jsp" method="get">
          
	        <input type="file" name="fileupload" value="fileupload" id="fileupload">
			<label for="fileupload"> Select a file to upload</label>
          
          	<br></br>
        
            <div class="container">
              <label>
                Item Name<span class="req">*</span>
              </label>
              <input type="text"required autocomplete="off" name="name" size="50" maxlength="50"/>
            </div>
        
        	<br></br>
        	
            <div class="container">
              <label>
                Item Description<span class="req">*</span>
              </label>
              <input type="text"required autocomplete="off" name="desc" size="100" maxlength="1000"/>
            </div>

          <br></br>
          <div class="container" >
            <label>
              Select a Category<span class="req">*</span>
            </label>
            
            <p align="left">
			  	<select size="1" name="categoryName">
				  	<option>All</option>
				  	<option>Books</option>
				  	<option>Cosmetics</option>
				  	<option>Electronics</option>
				  	<option>Food</option>
				  	<option>Home&Garden</option>
				  	<option>Jewelry</option>
				  	<option>Sports</option>
			  	</select>
		  	</p>
          </div>
          
          <button type="submit" class="button button-block">List my item!</button>
          
          </form>

        </div>
        
      </div><!-- tab-content -->
      
</div> <!-- /form -->
<%

%>
</BODY>
</HTML> 