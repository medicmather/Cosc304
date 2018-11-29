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
	background-color: #7B241C;
}
td, th {
    border: 1px solid #dddddd;
    text-align: left;
    padding: 8px;
}
tr:nth-child(even) {
    background-color: #dddddd;
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
Statement statement = con.createStatement(
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
	int currentUser = Integer.parseInt(session.getAttribute("UserId").toString());
	//getting article data of articles in users cart
	String command = "SELECT ArtOrder.ArticleID, Articles.ArticleTitle, FirstName, LastName, Articles.Price FROM ((ArtOrder JOIN Articles ON ArtOrder.ArticleID=Articles.ArticleID) JOIN Candidate ON Articles.CID=Candidate.CID)";
	ResultSet cartSet = statement.executeQuery(command);
	//creating checkout table
	out.println("<table>");
	out.println("<tr><th>Article #</th><th>Title</th><th>Target</th><th>Price</th></tr>");
	//creating each row of the table, and creating sum of prices.
	double totalPrice = 0;
	cartSet.beforeFirst();
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();
	out.println(currentUser);
	while(cartSet.next()){
		
		int aId = cartSet.getInt("ArticleID");
		String aTitle = cartSet.getString("ArticleTitle");
		String tFName = cartSet.getString("FirstName");
		String tLName = cartSet.getString("LastName");
		double aPrice = (double) cartSet.getDouble("Price");
		String pPrice = currFormat.format(aPrice);
		totalPrice += aPrice;
		
		
		out.println("<tr><td>"+aId+"</td><td>"+aTitle+"</td><td>"+tFName+" "+tLName+"</td><td>"+pPrice+"</td></tr>");
		
	}
	String fPrice = currFormat.format(totalPrice);
	out.println("<tr><th colspan='3'>Total: </th><th colspan='1'>"+fPrice+"</th></tr>");
	out.println("</table>");
	
	
	%>
	</form>
</div>

</body>
</head>