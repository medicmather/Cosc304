<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<!-- SOURCE FOR BAREBONES STICKY NAVIGATOR BAR https://www.w3schools.com/howto/howto_js_navbar_sticky.asp (follows you as you scroll down).-->
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
  background-color: #cc6600;
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
        <title>Create Account</title>
</head>
<body>
<div class="header">
  <h1 align="center"><img src="https://i.ibb.co/JqxHZp4/Social-Bomb.png" alt="Social-Bomb" border="1"></h1>
  <p>Articles About Your Enemies</p>
</div>
  <%
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

//Integer userid = Integer.parseInt(session.getAttribute("UserId"));
%>
<div id="navbar">
  <a class="active" href="FrontPage.jsp">Home</a>

<%   if(session.getAttribute("UserId")==null&&session.getAttribute("UserId") != "")out.print("<a href=\"login.jsp\">Login</a><a href =\"CreateAccount.jsp\">Create Account</a>");
else{
Integer UserId = Integer.parseInt(session.getAttribute("UserId").toString());
String SQL = "select FirstName, Lastname from Account where UserId = ?";
PreparedStatement pstmt = con.prepareStatement(SQL);
pstmt.setInt(1,UserId);
ResultSet rst = pstmt.executeQuery();
rst.next();
out.print("<a href=\"FrontPage.jsp\">Hello, "+rst.getString(1)+"</a>");
out.print("<a href=\"Shipment.jsp\">Purchased Articles</a>");
out.print("<a href=\"Shipment.jsp\">Shipments</a>");
out.print("<a href =\"Logout.jsp\">Logout</a>");
}

%>
  
  <a href="ListAllAuthors.jsp">Authors</a>
  <a href="ListCandidates.jsp">Candidates</a> 
  <a href="MemorabiliaProducts.jsp">Memorabilia</a>
   <a href="advancedSearch.jsp">Advanced Search</a>
      <form action="/action_page.php">
      <input type="text" placeholder="Search People..." name="search" cols = "50">
      <button type="Search">Search</button>
    </form>
</div>
<!--Image hosted on a image hosting website. May not be the best but it worked easier than trying to get it from file -->
<form method="get" action="CreateAccount.jsp">
<table align = "center">
<tr><td>UserName:</td><td><input type="text" name="UserName" size="20"></td></tr>
<tr><td>Password:</td><td><input type="password" name="password" size="20"></td></tr>
<tr><td>First Name:</td><td><input type="text" name="First Name" size="20"></td></tr>
<tr><td>Last Name:</td><td><input type="text" name="Last Name" size="20"></td></tr>
<tr><td>address:</td><td><input type="text" name="Address" size="50"></td></tr>
<tr><td>Email:</td><td><input type="text" name="Email" size="50"></td></tr>
<tr><td>Age:</td><td><select name="Age">
  <option value="18">18</option>
  <option value="19">19</option>
  <option value="20">20</option>
  <option value="21">21</option>
  <option value="22">22</option>
  <option value="23">23</option>
  <option value="24">24</option>
  <option value="25">25</option>
  <option value="26">26</option>
  <option value="27">27</option>
  <option value="28">28</option>
  <option value="29">29</option>
  <option value="30">30</option>
  <option value="31">31</option>
  <option value="32">32</option>
  <option value="33">33</option>
  <option value="34">34</option>
  <option value="35">35</option>
  <option value="36">36</option>
  <option value="37">37</option>
</select></td></tr>
<tr><td>Do you want this account to be an Author?</td><td><select name =  "yesno"> <option value="yes"> Yes</option><option value = "no"> No </option></select></td></tr>
<!-- Time to test if the submitted values are good T_T First make sure username not taken -->
<% 

HttpSession sess = request.getSession(true);
try{
String UserName = request.getParameter("UserName").toString();
String Password = request.getParameter("password").toString();
String FirstName = request.getParameter("First Name").toString();
String LastName = request.getParameter("Last Name").toString();
String address = request.getParameter("Address").toString();
String Email = request.getParameter("Email").toString();
int age = Integer.parseInt(request.getParameter("Age").toString());
String yesno = request.getParameter("yesno").toString();

String SQL = "select UserName from Account where UserName = ?";
PreparedStatement pstmt = con.prepareStatement(SQL);
pstmt.setString(1, UserName);
ResultSet rst = pstmt.executeQuery();
String SQL2 = "Select UserId from Account ORDER BY UserId DESC";
pstmt=con.prepareStatement(SQL2);
ResultSet rst2 = pstmt.executeQuery();
rst2.next();
//temporary autoincrement
int Usernum = rst2.getInt(1);
Usernum++;
if(rst.next()==false){
//	Insert INTO ACCOUNT
	String SQLInsert="INSERT INTO Account (UserID, UserName, Password, FirstName, LastName, Address, email, Age, isAdmin) VALUES (Usernum, UserName, Password, FirstName, LastName, Address, Email, age, 0)";
	pstmt=con.prepareStatement(SQLInsert);
	pstmt.executeUpdate();
	if(yesno.equals("yes")) {
		String SQLInsert2 = "INSERT INTO Author VALUES(Usernum, UserName, Password, FirstName, LastName, Address, Email, age, 0, 0)";
	
	}
out.println("Account Created!");
	}
else {
	out.println("Username is Taken, Choose Another");
	}
}

catch(java.lang.NullPointerException e){
//	out.println("Incorrect infomation, check your data, NULL" + e.fillInStackTrace());
}
catch(Exception e){
	out.println("Error Creating account, check DATA");
}

//checking if the username is taken, thus valid (who cares about password, email, address, optional values really.)

%>
<tr><td><input type="submit" value="Submit"></td><td><input type="reset" value="Reset"></td></tr>
</table>
</form>
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


