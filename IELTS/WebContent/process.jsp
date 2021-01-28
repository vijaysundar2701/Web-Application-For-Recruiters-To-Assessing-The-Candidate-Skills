<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style>
a {
  text-decoration: none;
  display: inline-block;
  padding: 8px 16px;
}

a:hover {
  background-color: #ddd;
  color: black;
}

.previous {
  background-color: #f1f1f1;
  color: black;
}

</style>
</head>
<body>
<a href="clustering.jsp" class="Back">&laquo;Back</a>
<%
                  String show=(String)session.getAttribute("msg");%>
                               <span style="color:Blue;font-size:35px;"><b><%=show%></b></span> 
<%if (show == "Segregated Succesfully"){
%>

<%}else{ %>
<form action="Segregate" method="post" name="segregate"></form>
<%
}%> 
<script>
window.onload = function(){
	document.forms['segregate'].submit();
}
</script>

</body>
</html>