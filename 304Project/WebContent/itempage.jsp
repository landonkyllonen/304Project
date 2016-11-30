<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>

<HTML>
<HEAD>
<TITLE>This is an auction</TITLE>
</HEAD>
<BODY>

<%@ include file="header.jsp" %>

<%
// Get the auction clicked
	@SuppressWarnings({"unchecked"})

	NumberFormat currFormat = NumberFormat.getCurrencyInstance();
	
	// Get product information
	String name = request.getParameter("name");
	String desc = request.getParameter("desc");
	String seller = request.getParameter("seller");
	String winner = request.getParameter("winner");
	String start = request.getParameter("start");
	String end = request.getParameter("end");
	String price = request.getParameter("price");
	String image = request.getParameter("image");
	String category = request.getParameter("category");
	String itemNo = request.getParameter("itemNo");
	String aucID = request.getParameter("aucID");
	Integer quantity = new Integer(1);

	double pr = Double.parseDouble(price);
		
%>
<H2><A HREF="watchAuction.jsp">Watch this auction</A></H2>
<H2><A HREF="listprod.jsp?watch=true">Continue Shopping</A></H2>
</FORM>
</BODY>
</HTML> 