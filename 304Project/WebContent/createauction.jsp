<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<%@ page import="dance.AuctionInstance" %>
<%@ include file="jdbc.jsp" %>


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
            	<li class="menuitem"><a href="listprod.jsp">Products</a></li>
                <li class="menuitem"><a href="">About</a></li>
                <li class="menuitem"><a href="">Services</a></li>
                <li class="menuitem"><a href="">Design</a></li>
            </ul>
        </div>
                
		<div class="lol" id="content">
        <div id="content_top" ></div>
        <div id="content_main" ><h1>Welcome the TSLRG Auctions Online Store!</h1>
          <p>&nbsp;</p>

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
<p>&nbsp;</p>
<p class="CenterTag"><a href="#top">Back to Top          </a></p>
        </div>
        <div id="content_bottom" align="center"></div>
	  </div>
   </div>
</body>

</html>
