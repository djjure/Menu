<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html ng-app="menuApp" ng-controller="MenuController as menu">
<head>
<style>
</style>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.3/angular.min.js"></script>
<script>

angular.module('menuApp', [])
  .controller('MenuController', function() {
    var menu = this;
    
    menu.namirnica=[
      {id:-1, naziv:'', kolicina:100, kalorije:0, masti:0, bjel:0, uglj:0, koles:0, gi:0}
      <c:forEach items="${foods}" var="food" varStatus="status">
         ,{
           id:'${food.id}', 
           naziv:'${food.name}', 
           kolicina:'${food.quantityInGrams}',
           kalorije:'${food.kiloCalories}',
           masti:'${food.lipidsInGrams}',
           bjel:'${food.proteinsInGrams}',
           uglj:'${food.carbonHydratesInGrams}',
           koles:'${food.kolesterolInMiligrams}',
           gi:'${food.gi}'
          }
      </c:forEach>
    ];
    
    menu.obrok = [
      <c:forEach items="${dnevniMeni}" var="obrok" varStatus="obrokStatus">
        [
        <c:forEach items="${obrok}" var="so" varStatus="soStatus">
          { namirnica:menu.namirnica[${so.namirnica}], kolicina:${so.kolicina} }
          <c:if test="${!soStatus.last}">,</c:if>
        </c:forEach>
        ]
        <c:if test="${!obrokStatus.last}">,</c:if>
      </c:forEach>
    ];

    function r(num,dec){
      if(num==""){
        num=0;
      }else if(isNaN(num)){
          num=0;
      }else{
          num=Number(num);
      }
      return Number(num.toFixed(dec));
    }

    menu.dodajNamirnicuObroku = function(obrok, tipobroka) {
      if(obrok==tipobroka[tipobroka.length-1]){
        tipobroka.push({namirnica:menu.namirnica[0], kolicina:''});
      };
    };
 
    menu.kalorije=function(obrok){
      return r(obrok.kolicina/obrok.namirnica.kolicina*obrok.namirnica.kalorije,2);
    };

    menu.masti=function(obrok){
      return r(obrok.kolicina/obrok.namirnica.kolicina*obrok.namirnica.masti,2);
    };

    menu.bjel=function(obrok){
      return r(obrok.kolicina/obrok.namirnica.kolicina*obrok.namirnica.bjel,2);
    };

    menu.uglj=function(obrok){
      return r(obrok.kolicina/obrok.namirnica.kolicina*obrok.namirnica.uglj,2);
    };

    menu.koles=function(obrok){
      return r(obrok.kolicina/obrok.namirnica.kolicina*obrok.namirnica.koles,2);
    };

    menu.go=function(obrok){
      return r(menu.uglj(obrok)*obrok.namirnica.gi/100,2);
    };

    menu.ukupnoKolicina=function(tipobroka){
      var sum=0;
      angular.forEach(tipobroka, function(obrok){
        sum=sum+Number(obrok.kolicina);
      });
      return r(sum,2);
    };
    menu.ukupnoKalorije=function(tipobroka){
      var sum=0;
      angular.forEach(tipobroka, function(obrok){
        sum=sum+Number(menu.kalorije(obrok));
      });
      return r(sum,2);
    };

    menu.ukupnoMasti=function(tipobroka){
      var sum=0;
      angular.forEach(tipobroka, function(obrok){
        sum=sum+Number(menu.masti(obrok));
      });
      return r(sum,2);
    };

    menu.ukupnoBjel=function(tipobroka){
      var sum=0;
      angular.forEach(tipobroka, function(obrok){
        sum=sum+Number(menu.bjel(obrok));
      });
      return r(sum,2);
    };

    menu.ukupnoUglj=function(tipobroka){
      var sum=0;
      angular.forEach(tipobroka, function(obrok){
        sum=sum+Number(menu.uglj(obrok));
      });
      return r(sum,2);
    };

    menu.ukupnoKoles=function(tipobroka){
      var sum=0;
      angular.forEach(tipobroka, function(obrok){
        sum=sum+Number(menu.koles(obrok));
      });
      return r(sum,2);
    };

    menu.ukupnoGo=function(tipobroka){
      var sum=0;
      angular.forEach(tipobroka, function(obrok){
        sum=sum+Number(menu.go(obrok));
      });
      return r(sum,2);
    };

    menu.postoMasti=function(tipobroka){
      return r(menu.ukupnoMasti(tipobroka)*9/(menu.ukupnoMasti(tipobroka)*9+menu.ukupnoBjel(tipobroka)*4+menu.ukupnoUglj(tipobroka)*4)*100,0)+" % kcal";
    };

    menu.postoBjel=function(tipobroka){
      return r(menu.ukupnoBjel(tipobroka)*4/(menu.ukupnoMasti(tipobroka)*9+menu.ukupnoBjel(tipobroka)*4+menu.ukupnoUglj(tipobroka)*4)*100,0)+" % kcal";
    };

    menu.postoUglj=function(tipobroka){
      return r(menu.ukupnoUglj(tipobroka)*4/(menu.ukupnoMasti(tipobroka)*9+menu.ukupnoBjel(tipobroka)*4+menu.ukupnoUglj(tipobroka)*4)*100,0)+" % kcal";
    };

    menu.sveUkupnoKolicina=function(){
      var sum=0;
      angular.forEach(menu.obrok, function(tipobroka){
        sum=sum+Number(menu.ukupnoKolicina(tipobroka));
      });
      return r(sum,2);
    };

    menu.sveUkupnoKalorije=function(){
      var sum=0;
      angular.forEach(menu.obrok, function(tipobroka){
        sum=sum+Number(menu.ukupnoKalorije(tipobroka));
      });
      return r(sum,2);
    };

   menu.sveUkupnoMasti=function(){
      var sum=0;
      angular.forEach(menu.obrok, function(tipobroka){
        sum=sum+Number(menu.ukupnoMasti(tipobroka));
      });
      return r(sum,2);
    };

    menu.sveUkupnoBjel=function(){
      var sum=0;
      angular.forEach(menu.obrok, function(tipobroka){
        sum=sum+Number(menu.ukupnoBjel(tipobroka));
      });
      return r(sum,2);
    };

    menu.sveUkupnoUglj=function(){
      var sum=0;
      angular.forEach(menu.obrok, function(tipobroka){
        sum=sum+Number(menu.ukupnoUglj(tipobroka));
      });
      return r(sum,2);
    };

    menu.sveUkupnoKoles=function(){
      var sum=0;
      angular.forEach(menu.obrok, function(tipobroka){
        sum=sum+Number(menu.ukupnoKoles(tipobroka));
      });
      return r(sum,2);
    };

    menu.sveUkupnoGo=function(){
      var sum=0;
      angular.forEach(menu.obrok, function(tipobroka){
        sum=sum+Number(menu.ukupnoGo(tipobroka));
      });
      return r(sum,2);
    };

    menu.svePostoMasti=function(){
      return r(menu.sveUkupnoMasti()*9/(menu.sveUkupnoMasti()*9+menu.sveUkupnoBjel()*4+menu.sveUkupnoUglj()*4)*100,0)+" % kcal";
    };

    menu.svePostoBjel=function(){
      return r(menu.sveUkupnoBjel()*4/(menu.sveUkupnoMasti()*9+menu.sveUkupnoBjel()*4+menu.sveUkupnoUglj()*4)*100,0)+" % kcal";
    };

    menu.svePostoUglj=function(){
      return r(menu.sveUkupnoUglj()*4/(menu.sveUkupnoMasti()*9+menu.sveUkupnoBjel()*4+menu.sveUkupnoUglj()*4)*100,0)+" % kcal";
    };

  });

</script>
</head>
<body>

	<form id='form1' action="<c:url value='/meal/add' />" method='POST'>
		Korisnik:&nbsp;${currentUser.userName}
		<input type="text" name="korisnik" value="${currentUser.id}" hidden>
		<br>
		Datum:&nbsp;<fmt:formatDate value="${datum}" pattern="dd.MM.yyyy." />
		<input type="date" name="datum" value="<fmt:formatDate value="${datum}" pattern="yyyy-MM-dd" />" hidden>
		<br>
		<table border="1" ng-repeat="tipobroka in menu.obrok">
		  <tr>
		    <th>Namirnica</th>
		    <th>Koli&#269;ina (g)</th>
		    <th>Kalorije (kcal)</th>
		    <th>Masti (g)</th>
		    <th>Bjelan&#269;evine (g)</th>
		    <th>Ugljikohidrati (g)</th>
		    <th>Kolesterol (mg)</th>
		    <th>Glik. opter.</th>
		  </tr>
		  <tr ng-repeat="obrok in tipobroka">
		    <td>
		      <select name="namir[{{$parent.$index}}][]" ng-options="item as item.naziv for item in menu.namirnica track by item.id" ng-model="obrok.namirnica" ng-change="menu.dodajNamirnicuObroku(obrok, tipobroka)">
		      </select>
		    </td>
		    <td>
		      <input name="kolicina[{{$parent.$index}}][]" type="text" size="8" ng-model="obrok.kolicina">
		    </td>
		    <td>{{menu.kalorije(obrok)}}</td>
		    <td>{{menu.masti(obrok)}}</td>
		    <td>{{menu.bjel(obrok)}}</td>
		    <td>{{menu.uglj(obrok)}}</td>
		    <td>{{menu.koles(obrok)}}</td>
		    <td>{{menu.go(obrok)}}</td>
		  </tr>
		  <tr>
		    <td style="font-weight:bold;">Ukupno</td>
		    <td style="font-weight:bold;">{{menu.ukupnoKolicina(tipobroka)}}</td>
		    <td style="font-weight:bold;">{{menu.ukupnoKalorije(tipobroka)}}</td>
		    <td style="font-weight:bold;">{{menu.ukupnoMasti(tipobroka)}}</td>
		    <td style="font-weight:bold;">{{menu.ukupnoBjel(tipobroka)}}</td>
		    <td style="font-weight:bold;">{{menu.ukupnoUglj(tipobroka)}}</td>
		    <td style="font-weight:bold;">{{menu.ukupnoKoles(tipobroka)}}</td>
		    <td style="font-weight:bold;">{{menu.ukupnoGo(tipobroka)}}</td>
		  </tr>
		  <tr>
		    <td style="font-weight:bold;"></td>
		    <td style="font-weight:bold;"></td>
		    <td style="font-weight:bold;"></td>
		    <td style="font-weight:bold;">{{menu.postoMasti(tipobroka)}}</td>
		    <td style="font-weight:bold;">{{menu.postoBjel(tipobroka)}}</td>
		    <td style="font-weight:bold;">{{menu.postoUglj(tipobroka)}}</td>
		    <td style="font-weight:bold;"></td>
		    <td style="font-weight:bold;"></td>
		  </tr>
		</table>
		<table border="1">
		  <tr>
		    <th>Namirnica</th>
		    <th>Koli&#269;ina (g)</th>
		    <th>Kalorije (kcal)</th>
		    <th>Masti (g)</th>
		    <th>Bjelan&#269;evine (g)</th>
		    <th>Ugljikohidrati (g)</th>
		    <th>Kolesterol (mg)</th>
		    <th>Glik. opter.</th>
		  </tr>
		  <tr>
		    <td style="font-weight:bold;">Ukupno</td>
		    <td style="font-weight:bold;">{{menu.sveUkupnoKolicina()}}</td>
		    <td style="font-weight:bold;">{{menu.sveUkupnoKalorije()}}</td>
		    <td style="font-weight:bold;">{{menu.sveUkupnoMasti()}}</td>
		    <td style="font-weight:bold;">{{menu.sveUkupnoBjel()}}</td>
		    <td style="font-weight:bold;">{{menu.sveUkupnoUglj()}}</td>
		    <td style="font-weight:bold;">{{menu.sveUkupnoKoles()}}</td>
		    <td style="font-weight:bold;">{{menu.sveUkupnoGo()}}</td>
		  </tr>
		  <tr>
		    <td style="font-weight:bold;"></td>
		    <td style="font-weight:bold;"></td>
		    <td style="font-weight:bold;"></td>
		    <td style="font-weight:bold;">{{menu.svePostoMasti()}}</td>
		    <td style="font-weight:bold;">{{menu.svePostoBjel()}}</td>
		    <td style="font-weight:bold;">{{menu.svePostoUglj()}}</td>
		    <td style="font-weight:bold;"></td>
		    <td style="font-weight:bold;"></td>
		  </tr>
		</table>
		<br>
		<input id='input1' type="submit" name="spremi" value="Spremi" />
		<br>
		<br>
		<div style="border:1px; border-style:solid; border-color:#000000; padding: 1em; display: inline-block;">
			Prenijeti na korisnika
			<select name="korisnik2">
				<c:forEach items="${users}" var="user" varStatus="status">
					<c:choose>
						<c:when test="${user.id==currentUser.id}">
						</c:when>
						<c:otherwise>
							<option value="${user.id}">${user.userName}</option>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</select>
			<br>
			Obrok
			<select name="obrok">
				<c:forEach items="${mealTypes}" var="mealType" varStatus="status">
					<option value="${mealType.id}">${mealType.name}</option>
				</c:forEach>
			</select>
			<br>
			Udio (%)
			<input type="text" name="udio" size="8">
			<br>
			<input type="submit" name="prenesi" value="Prenesi" />
		</div>
	</form>
	<br>
	<form action="<c:url value='/meal/all' />" method="GET">
		<div style="border:1px; border-style:solid; border-color:#000000; padding: 1em; display: inline-block;">
			Korisnik
			<select name="korisnik">
				<c:forEach items="${users}" var="user" varStatus="status">
					<c:choose>
						<c:when test="${user.id==currentUser.id}">
							<option value="${user.id}" selected>${user.userName}</option>
						</c:when>
						<c:otherwise>
							<option value="${user.id}">${user.userName}</option>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</select>
			<br>
			Datum
			<input type="date" name="datum" value="<fmt:formatDate value="${datum}" pattern="yyyy-MM-dd" />">
			<br>
			<input type="submit" value="Pogledaj">
		</div>
	</form>
	<br />
	<br />
	<a href="<c:url value="/" />">Home</a>
	<br />
	<br />
	<a href="<c:url value="/j_spring_security_logout" />">Logout</a>
</body>
</html>
