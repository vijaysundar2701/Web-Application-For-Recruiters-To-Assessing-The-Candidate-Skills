
<%@ page import="java.util.*" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="javax.activation.*"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%String status="Decline"; %>
   <%String loc=request.getParameter("nloc");%>
    <%String name=request.getParameter("na");%>
    <%String email=request.getParameter("em"); %>
     <%String preloc=request.getParameter("ploc"); %>
<%

String driver = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String database = "ielts";
String userid = "root";
String password = "root";
try {
Class.forName(driver);
} catch (ClassNotFoundException e) {
e.printStackTrace();
}
Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
%>
<!DOCTYPE html>
<html>
<body>


<%
try{
connection = DriverManager.getConnection(connectionUrl+database, userid, password);
Statement stmt=connection.createStatement();
PreparedStatement ps=connection.prepareStatement("Update reqloc set status=? where name='"+name+"'");

ps.setString(1,status);
stmt.executeBatch();
int x=ps.executeUpdate();
%>
 <% 
String host="", user="", pass="";

host ="smtp.gmail.com"; //"smtp.gmail.com";

user ="vijaysundars99@gmail.com"; //"YourEmailId@gmail.com" // email id to send the emails

pass ="vijaysundar@2701"; //Your gmail password

String SSL_FACTORY = "javax.net.ssl.SSLSocketFactory";

String to =email;// out going email id

String from ="vijaysundars99@gmail.com"; //Email id of the recipient
//String subject ="welcome";

String subject1="Request Accepted!!!!!";
		String msg1="Dear "+name+", \nyour request for new  "+loc+"  has been "+status+"\n Due to inavailablity of vacant";


//session.setAttribute("emailid",emailid);
boolean sessionDebug = true;

Properties props = System.getProperties();
props.put("mail.host", host);
props.put("mail.transport.protocol.", "smtp");
props.put("mail.smtp.auth", "true");
props.put("mail.smtp.", "true");
props.put("mail.smtp.port", "465");
props.put("mail.smtp.socketFactory.fallback", "false");
props.put("mail.smtp.socketFactory.class", SSL_FACTORY);
Session mailSession = Session.getDefaultInstance(props, null);
mailSession.setDebug(sessionDebug);
Message msg = new MimeMessage(mailSession);
msg.setFrom(new InternetAddress(from));
InternetAddress[] address = {new InternetAddress(to)};
msg.setRecipients(Message.RecipientType.TO, address);
msg.setSubject(subject1);
msg.setText(msg1); // use setText if you want to send text
Transport transport = mailSession.getTransport("smtp");
transport.connect(host, user, pass);
try {
transport.sendMessage(msg, msg.getAllRecipients());%>

<%}
catch (Exception err) {

out.println("message not successfully sended"); // assume it’s a fail
}
transport.close();
%>
<script>
alert("Request Update Successfully");
window.location="regch.jsp";
</script>
<%

}
catch (Exception ex) 
{
	out.println(ex.getMessage());
}
%>
</body>
</html>