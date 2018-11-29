<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>

<style>
body {
  margin: 0;
  padding:0;
  font-size: 28px;
  font-family: Arial, Helvetica, sans-serif;
}
header {
	border-bottom: 2px solid black;
	padding: 2em;
	background-color: 
}
</style>
        <title>SocialBomb Checkout</title>
</head>
<body>
  <%
String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_mlockhar";
String uid = "mlockhar"; 
String pw = "65511917"; 

System.out.println("Connecting to database.");

Connection con = DriverManager.getConnection(url, uid, pw); 

String fileName = "data/order_sql.ddl";

Statement statement = connection.createStatement(
		ResultSet.TYPE_SCROLL_INSENSITIVE,
        ResultSet.CONCUR_READ_ONLY);

try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

//Integer userid = Integer.parseInt(session.getAttribute("UserId"));
%>

<header>
<h1>SocialBomb</h1>
<h3>Checkout</h3>
</header>

<div id="checkoutTable">
	<form>
	<%
	//getting current user ID
	int currentUser = session.getAttribute("UserId");
	//getting article data of articles in users cart
	String command = "SELECT ArticleID, ArticleTitle, FirstName, LastName, Price FROM (ArtOrder JOIN Articles ON ArtOrder.ArticleID=Articles.ArticleID) NATURAL JOIN Candidate Where CartID = "+ currentUser;
	ResultSet cartSet = statement.executeQuery(command);
	//creating checkout table
	out.println("<table>")
	out.println("<tr><th>Article #</th><th>Title</th><th>Target</th><th>Price</th></tr>")
	//creating each row of the table, and creating sum of prices.
	double totalPrice = 0;
	cartSet.beforeFirst();
	while(cartSet.next()){
		
		int aId = cartSet.getInt("ArticleID");
		int aTitle = cartSet.getString("ArticleTitle");
		int tFName = cartSet.getString("FirstName");
		int tLName = cartSet.getString("LastName");
		double aPrice = (double) cartSet.getDouble("Price");
		DecimalFormat df = new DecimalFormat("#.00");
		String pPrice = df.format(aPrice);
		totalPrice += aPrice;
		
		
		out.println("<tr><td>"+aId+"</td><td>"+aTitle+"</td><td>"+tFName+" "+tLName+"</td><td>$"+pPrice+"</td></tr>")
		
	}
	
	out.println("</table>")
	%>
	</form>
</div>

</body>
</head>