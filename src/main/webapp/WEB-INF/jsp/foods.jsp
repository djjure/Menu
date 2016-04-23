<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<body>
	<h1>Popis namirnica</h1>
	<table>
		<tr>
			<th>Naziv</th>
			<th>Koli&#269;ina (g)</th>
			<th>Kalorije (kcal)</th>
			<th>Bjalan&#269;evine (g)</th>
			<th>Ugljikohidrati (g)</th>
			<th>Masti (g)</th>
			<th>Kolesterol (mg)</th>
			<th>Glik. indeks</th>
		</tr>
	<c:forEach items="${foods}" var="food">
		<tr>
			<td><a href="<c:url value="/food/${food.id}" />" >${food.name}</a></td>
			<td>${food.quantityInGrams}</td>
			<td>${food.kiloCalories}</td>
			<td>${food.proteinsInGrams}</td>
			<td>${food.carbonHydratesInGrams}</td>
			<td>${food.lipidsInGrams}</td>
			<td>${food.kolesterolInMiligrams}</td>
			<td>${food.gi}</td>
		</tr>
	</c:forEach>
	</table>
	<br/>
	<a href="<c:url value="/food/add" />" >Dodaj namirnicu</a>
	<br/>
	<br/>
	<a href="<c:url value="/" />" >Home</a>
	<br/>
	<br/>
	<a href="<c:url value="/j_spring_security_logout" />" >Logout</a>
</body>
</html>