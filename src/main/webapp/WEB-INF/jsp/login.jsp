<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>Login stranica</title>
<style>
.errorblock {
	color: #ff0000;
	background-color: #ffEEEE;
	border: 3px solid #ff0000;
	padding: 8px;
	margin: 16px;
}
</style>
</head>
<body onload='document.f.j_username.focus();'>
	<h3>Login</h3>

	<c:if test="${not empty error}">
		<div class="errorblock">
			Ulogiravanje nije uspjelo. 
			<br /> 
			Razlog: ${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message}
		</div>
	</c:if>

	<form name='f' action="<c:url value='j_spring_security_check' />"
		method='POST'>

		<table>
			<tr>
				<td>Korisnik:</td>
				<td><input type='text' name='j_username' value=''></td>
			</tr>
			<tr>
				<td>Lozinka:</td>
				<td><input type='password' name='j_password' /></td>
			</tr>
			<tr>
				<td colspan='2'><input name="submit" type="submit"
					value="Submit" /></td>
			</tr>
			<tr>
				<td colspan='2'><input name="reset" type="reset" value="Reset" />
				</td>
			</tr>
		</table>

	</form>
</body>
</html>