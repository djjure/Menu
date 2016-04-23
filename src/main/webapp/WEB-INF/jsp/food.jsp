<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<style>
.errorblock {
	color: #ff0000;
	background-color: #ffEEEE;
	border: 3px solid #ff0000;
	padding: 8px;
	margin: 16px;
},
table {
	width: 500;
}
</style>
</head>
<body>
	<h1>Namirnica</h1>

	<c:if test="${not empty error}">
		<div class="errorblock">
			Ne može se izbrisati namirnica
			<br />
			Razlog: ${error}
			<br />
		</div>
	</c:if>
	
	<table>
		<tr>
			<td>Naziv</td>
			<td>${food.name}</td>
		</tr>
		<tr>
			<td>Koli&#269;ina (g)</td>
			<td>${food.quantityInGrams}</td>
		</tr>
		<tr>
			<td>Kalorije (kcal)</td>
			<td>${food.kiloCalories}</td>
		</tr>
		<tr>
			<td>Bjalan&#269;evine (g)</td>
			<td>${food.proteinsInGrams}</td>
		</tr>
		<tr>
			<td>Ugljikohidrati (g)</td>
			<td>${food.carbonHydratesInGrams}</td>
		</tr>
		<tr>
			<td>Masti (g)</td>
			<td>${food.lipidsInGrams}</td>
		</tr>
		<tr>
			<td>Kolesterol (mg)</td>
			<td>${food.kolesterolInMiligrams}</td>
		</tr>
		<tr>
			<td>Glik. indeks</td>
			<td>${food.gi}</td>
		</tr>
	</table>
	
	<br />
	<a href="<c:url value="/food/add/${food.id}" />">Uredi</a>
	<br />
	<br />
	<a href="<c:url value="/food/delete/${food.id}" />">Izbriši</a>
	<br />
	<br />
	<a href="<c:url value="/food/all" />">Popis namirnica</a>
</body>
</html>