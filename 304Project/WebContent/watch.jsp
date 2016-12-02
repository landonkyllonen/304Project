<%@ include file="jdbc.jsp" %>
<%@ page import="dance.AuctionInstance" %>

<%
	int aucID = Integer.parseInt(request.getParameter("aucID"));
	String userID = request.getParameter("userID");
	
	//response.sendRedirect("itempage.jsp?bid=&id="+auction.getWinner());
	
	
		getConnection();
		String check = "SELECT * FROM watches WHERE userID = ? AND auctionID = ?";
		PreparedStatement pstmt = con.prepareStatement(check);
		pstmt.setString(1, userID);
		pstmt.setInt(2, aucID);
		ResultSet rst = pstmt.executeQuery();
		if(rst.next()){
			//return to itempage with error
			System.out.println("Already watching");
			closeConnection();
			response.sendRedirect("itempage.jsp?bid=failedwatch");
		}else{
			//add to server, return to itempage with success
			String sql="INSERT INTO watches VALUES (?,?)";
			PreparedStatement insert = con.prepareStatement(sql);
			insert.setString(1, userID);
			insert.setInt(2, aucID);
			insert.executeUpdate();
			closeConnection();
			response.sendRedirect("itempage.jsp?bid=watch");
		}
	
%>