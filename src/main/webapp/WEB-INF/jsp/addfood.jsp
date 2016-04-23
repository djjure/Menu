<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<body onload='document.f.name.focus();'>
	<c:choose>
		<c:when test="${food.id==-1}">
			<h1>Dodaj namirnicu</h1>
		</c:when>    
		<c:otherwise>
			<h1>Uredi namirnicu</h1>
		</c:otherwise>
	</c:choose>
	<form name='f' action="<c:url value='/food/add' />" method='POST'>

		<input type='hidden' name='id' value='${food.id}' />
		<table>
			<tr>
				<td>Naziv:</td>
				<td><input type='text' name='name' value='${food.name}'></td>
			</tr>
			<tr>
				<td>Koli&#269;ina (g):</td>											
				<td><input type='text' name='quantityInGrams' value='<c:if test="${food.quantityInGrams!=0}">${food.quantityInGrams}</c:if>' /></td>
			</tr>
			<tr>
				<td>Kalorija (kcal):</td>
				<td><input type='text' name='kiloCalories' value='<c:if test="${food.kiloCalories!=0}">${food.kiloCalories}</c:if>' /></td>
			</tr>
			<tr>
				<td>Bjalan&#269;evine (g):</td>
				<td><input type='text' name='proteinsInGrams' value='<c:if test="${food.proteinsInGrams!=0}">${food.proteinsInGrams}</c:if>' /></td>
			</tr>
			<tr>
				<td>Ugljikohidrati (g):</td>
				<td><input type='text' name='carbonHydratesInGrams' value='<c:if test="${food.carbonHydratesInGrams!=0}">${food.carbonHydratesInGrams}</c:if>' /></td>
			</tr>
			<tr>
				<td>Masti (g):</td>
				<td><input type='text' name='lipidsInGrams' value='<c:if test="${food.lipidsInGrams!=0}">${food.lipidsInGrams}</c:if>' /></td>
			</tr>
			<tr>
				<td>Kolesterol (mg):</td>
				<td><input type='text' name='kolesterolInMiligrams' value='<c:if test="${food.kolesterolInMiligrams!=0}">${food.kolesterolInMiligrams}</c:if>' /></td>
			</tr>
			<tr>
				<td>Glik. indeks:</td>
				<td><input type='text' name='gi' value='<c:if test="${food.gi!=0}">${food.gi}</c:if>' /></td>
			</tr>
			<tr>
				<td colspan='2'><input type="submit" name="addFood" value="Add food" /></td>
			</tr>
			<tr>
				<td colspan='2'><input type="reset" name="clear" value="Clear" />
				</td>
			</tr>
		</table>

	</form>
	<a href="<c:url value="/food/all" />" >Popis namirnica</a>
</body>
</html>