<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
		String url = request.getContextPath() + "/";
	%>
	<div class="menu">
		<ul>
			<li><a class="active" href='<%=url + "home"%>'><i
					class="home"></i></a></li>
			<li><a href='<%=url + "movie-trailer"%>'><div class="video">
						<i class="videos"></i><i class="videos1"></i>
					</div></a></li>
			<li><a href='<%=url + "movielist"%>'><div class="cat">
						<i class="watching"></i><i class="watching1"></i>
					</div></a></li>
			<li><a href="404.html"><div class="bk">
						<i class="booking"></i><i class="booking1"></i>
					</div></a></li>
			<li><a href="contact.html"><div class="cnt">
						<i class="contact"></i><i class="contact1"></i>
					</div></a></li>
		</ul>
	</div>
</body>
</html>