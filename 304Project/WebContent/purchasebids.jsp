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
          <h4>Purchase Bids</h4>
          
          <form action="processpayment.jsp" method="get">
        
        	<input type="radio" name="price" value="10"> 10 bids: $10.00<br>
  			<input type="radio" name="price" value="50"> 50 bids: $45.00<br>
  			<input type="radio" name="price" value="250"> 250 bids: $212.00<br>
  			<input type="radio" name="price" value="1000"> 1000 bids: $800.00<br></br>
        
            <div class="container">
              <label>
                Card number (16 digits)<span class="req">*</span>
              </label>
              <input type="text"required autocomplete="off" name="cardnum" size="50" maxlength="50"/>
            </div>
        
        	<br></br>
        	
            <div class="container">
              <label>
                Full Name (As it appears)<span class="req">*</span>
              </label>
              <input type="text"required autocomplete="off" name="fullname" size="50" maxlength="50"/>
            </div>

          <br></br>
          
          <div class="container">
              <label>
                CVC Code(3 digits)<span class="req">*</span>
              </label>
              <input type="password"required autocomplete="off" name="cvc" size="7" maxlength="3"/>
            </div>
            
            <div class="container">
              <label>
                Expiry(MM/YY)<span class="req">*</span>
              </label>
              <input type="text"required autocomplete="off" name="expm" size="5" maxlength="2"/>
              <input type="text"required autocomplete="off" name="expy" size="5" maxlength="2"/>
            </div>
            
            <br></br>
        	
            <div class="container">
              <label>
                Billing Address<span class="req">*</span>
              </label>
              <input type="text"required autocomplete="off" name="address" size="50" maxlength="50"/>
            </div>
            
            <br></br>
            
            <button type="submit" class="button button-block">Confirm Payment</button>
          
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
