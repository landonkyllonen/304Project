import java.sql.*;

public class testDriver {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
//		<% 
		Connection con = null;
		/* String url = "jdbc:mysql://cosc304.ok.ubc.ca/db_vchiu/WorksOn";
		String uid = "vchiu";
		String pw = "70462080"; */

		String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_lkyllone;";
		String uid = "lkyllone";
		String pw = "15760127";


		try {	
			con = DriverManager.getConnection(url, uid, pw);
			Statement stmt = con.createStatement();
			ResultSet rst = stmt.executeQuery("SELECT * from Product");		
			System.out.println("<table><tr><th>Name</th><th>Salary</th></tr>");
			while (rst.next())
			{	System.out.println("<tr><td>"+rst.getString(1)+"</td>"+"<td>"+rst.getString(2)+"</td></tr>");
			}
			System.out.println("</table>");
		}
		catch (SQLException ex) 
		{ 	System.out.println(ex); 
		}
		finally                
		{
			if (con != null)
				try
		                {
		                        con.close();
		                }
		                catch (SQLException ex)
		                {           
		                        System.err.println("SQLException: " + ex);
		                }
		}
//		%>

	}

}
