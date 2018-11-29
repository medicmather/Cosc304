<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import = "java.io.*,java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<style>
body {
  margin: 0;
  font-size: 28px;
  font-family: Arial, Helvetica, sans-serif;
}

.header {
  background-color: #7B241C;
  padding: 30px;
  text-align: center;
}

#navbar {
  overflow: hidden;
  background-color: #333;
}

#navbar a {
  float: left;
  display: block;
  color: #f2f2f2;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
  font-size: 17px;
}

#navbar a:hover {
  background-color: #ddd;
  color: black;
}

#navbar a.active {
  background-color: #4CAF50;
  color: white;
}

.content {
  padding: 16px;
}

.sticky {
  position: fixed;
  top: 0;
  width: 100%;
}

.sticky + .content {
  padding-top: 60px;
}
</style>
        <title>Fake News</title>
</head>
<body>
<div class="header">
  <h1 align="center"><img src="https://i.ibb.co/JqxHZp4/Social-Bomb.png" alt="Social-Bomb" border="1"></h1>
  <p>Articles About Your Enemies</p>
</div>

<div id="navbar">
  <a class="active" href="FrontPage.jsp">Home</a>
  <a href="ListAllAuthors.jsp">Authors</a>
  <a href="ListCandidates.jsp">Candidates</a>
  <a href = "">                                                         </a>
</div>
<!--Image hosted on a image hosting website. May not be the best but it worked easier than trying to get it from file -->

<form method="get" action="login.jsp">
<table align = "center">
<tr><td>Customer ID:</td><td><input type="text" name="UserName" size="20"></td></tr>
<tr><td>Password:</td><td><input type="password" name="password" size="20"></td></tr>
<tr><td><input type="submit" value="Submit"></td><td><input type="reset" value="Reset"></td></tr>
</table>
</form>
<%
//Note: Forces loading of SQL Server driver
//Make connection
String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_mlockhar";
String uid = "mlockhar"; 
String pw = "65511917"; 

System.out.println("Connecting to database.");

Connection con = DriverManager.getConnection(url, uid, pw); 

String fileName = "data/order_sql.ddl";

try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

String AID = request.getParameter("AID");
if(session.getAttribute("UserID")==null){
	String redirectURL = "login.jsp";
	response.sendRedirect(redirectURL);
}
else{
String SQL2="select price from Articles where AID = ?";
PreparedStatement pstmt = con.prepareStatement(SQL2);
ResultSet rst = pstmt.executeQuery();
rst.next();
String SQL3 = "INSERT INTO ArtOrder Values("+ AID +", "+session.getAttribute("UserID")+", "+Double.toString(rst.getDouble(1))+")";
}
/*
if(session.getAttribute("Cart")==null){
	ArrayList<Integer> cart = new ArrayList<>();
	cart.add(Integer.parseInt(AID));
}
else{
	ArrayList<Integer> cart = (ArrayList<Integer>)session.getAttribute("Cart");
	cart.add(Integer.parseInt(AID));
}*/
String site = new String("FrontPage.jsp");
response.sendRedirect("site");

%>

<script>
window.onscroll = function() {myFunction()};

var navbar = document.getElementById("navbar");
var sticky = navbar.offsetTop;

function myFunction() {
  if (window.pageYOffset >= sticky) {
    navbar.classList.add("sticky")
  } else {
    navbar.classList.remove("sticky");
  }
}
</script>
</body>
</head>


