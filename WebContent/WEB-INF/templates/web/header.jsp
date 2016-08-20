<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
	<div class="top-header">
		<div class="logo1">
			<a href="#"><img alt=""
				src="${pageContext.request.contextPath }/resources/images/logo.png"></a>
			<p>Movie Theater</p>
		</div>
		<div class="search">
			<form action="${pageContext.request.contextPath }/movielist" method="get">
				<input type="text" name="search" value="Search.."
					onfocus="this.value = '';"
					onblur="if (this.value == '') {this.value = 'Search..';}" /> <input
					type="submit" value="">
			</form>
		</div>
		<div class="clearfix"></div>
	</div>
</body>
</html>