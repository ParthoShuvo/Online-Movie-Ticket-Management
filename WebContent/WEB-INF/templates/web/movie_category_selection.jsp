<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
	<div class="select-area">
		<!-- <form id='select' class="select" method='get'>
			<select name="select_item" class="select__sort" tabindex="0">
				<option value="1" selected='selected'>London</option>
				<option value="2">New York</option>
				<option value="3">Paris</option>
				<option value="4">Berlin</option>
				<option value="5">Moscow</option>
				<option value="3">Minsk</option>
				<option value="4">Warsawa</option>
				<option value="5">Kiev</option>
			</select>
		</form> -->

		<div class="datepicker">
			<%
				Date nowDate = new Date();
				SimpleDateFormat simpleDateFormat = new SimpleDateFormat("MM/dd/yyyy");
			%>
			<span class="datepicker__marker"><i class="fa fa-calendar"></i>Release Date</span>
			<input type="text" id="datepicker"
				value='<%=simpleDateFormat.format(nowDate)%>'
				class="datepicker__input">
		</div>

		<form class="select select--cinema" method='get'>
			<select id="maturity-select" name="select_item" class="select__sort"
				tabindex="0">
				<option value="1">G</option>
				<option value="2">PG</option>
				<option value="3">PG-13</option>
				<option value="4">R</option>
				<option value="5">NC-17</option>
			</select>
		</form>

		<form class="select select--film-category" method='get'>
			<select name="select_item" class="select__sort" id="genre-select"
				tabindex="0">
				<option value="1" selected='selected'>Action</option>
				<option value="2">Comedy</option>
				<option value="3">Animation</option>
				<option value="4">Horror</option>
				<option value="5">Drama</option>
				<option value="6">Romantic</option>
				<option value="7">Adventure</option>
				<option value="8">Sports</option>
				<option value="9">War</option>
			</select>
		</form>

	</div>
</body>
</html>