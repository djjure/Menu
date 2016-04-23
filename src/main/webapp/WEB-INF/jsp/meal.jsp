<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<style>
td.suma {
	font-weight: bold;
}
</style>
</head>
<body>

	<form id='form1' action="<c:url value='/meal/add' />" method='POST'>
		Korisnik:&nbsp;${currentUser.userName}
		<input type="text" name="korisnik" value="${currentUser.id}" hidden>
		<br>
		Datum:&nbsp;<fmt:formatDate value="${datum}" pattern="dd.MM.yyyy." />
		<input type="date" name="datum" value="<fmt:formatDate value="${datum}" pattern="yyyy-MM-dd" />" hidden>
		<br>
		<input id='input1' type="submit" name="spremi" value="Spremi" />
		<br>
		<br>
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
	</form>
	<br>
	<form action="<c:url value='/meal/all' />" method="GET">
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
	</form>

	<script>
var namir=[
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

var obrok=[
    <c:forEach items="${meals}" var="meal" varStatus="status">
        {
         jelo:'${meal.mealType.id}',
         namir:'${meal.food.id}',
         kolicina:'${meal.quantityInGrams}'
        },
    </c:forEach>
    {jelo:0, namir:-1, kolicina:''},
    {jelo:1, namir:-1, kolicina:''},
    {jelo:2, namir:-1, kolicina:''},
    {jelo:3, namir:-1, kolicina:''},
    {jelo:4, namir:-1, kolicina:''}
];    
  
  function r(num,dec){
	  if(num==""){
		  num=0;
	  }else{
		  num=Number(num);
	  }
	  return Number(num.toFixed(dec));
  }
  
  function calculateRow(tr){
    var sel=tr.getElementsByClassName("sel-nam")[0];
    var input=tr.getElementsByClassName("inp-kol")[0];
    var td3=tr.getElementsByClassName("td-kal")[0];
    td3.innerHTML=r(input.value*namir[sel.selectedIndex].kalorije/
      namir[sel.selectedIndex].kolicina,2);
    var td4=tr.getElementsByClassName("td-mas")[0];
    td4.innerHTML=r(input.value*namir[sel.selectedIndex].masti/
      namir[sel.selectedIndex].kolicina,2);
    var td5=tr.getElementsByClassName("td-bje")[0];
    td5.innerHTML=r(input.value*namir[sel.selectedIndex].bjel/
      namir[sel.selectedIndex].kolicina,2);
    var td6=tr.getElementsByClassName("td-ugl")[0];
    td6.innerHTML=r(input.value*namir[sel.selectedIndex].uglj/
      namir[sel.selectedIndex].kolicina,2);
    var td7=tr.getElementsByClassName("td-kls")[0];
    td7.innerHTML=r(input.value*namir[sel.selectedIndex].koles/
      namir[sel.selectedIndex].kolicina,2);
    var td8=tr.getElementsByClassName("td-go")[0];
    td8.innerHTML=r(Number(td6.innerHTML)*namir[sel.selectedIndex].gi/100,2);
  };

  function calculateFooter(table){
    var trs=table.getElementsByTagName("tr");

    var td2=trs[trs.length-2].getElementsByClassName("td-kol")[0];
    td2.innerHTML="";
    var td3=trs[trs.length-2].getElementsByClassName("td-kal")[0];
    td3.innerHTML="";
    var td4=trs[trs.length-2].getElementsByClassName("td-mas")[0];
    td4.innerHTML="";
    var td5=trs[trs.length-2].getElementsByClassName("td-bje")[0];
    td5.innerHTML="";
    var td6=trs[trs.length-2].getElementsByClassName("td-ugl")[0];
    td6.innerHTML="";
    var td7=trs[trs.length-2].getElementsByClassName("td-kls")[0];
    td7.innerHTML="";
    var td8=trs[trs.length-2].getElementsByClassName("td-go")[0];
    td8.innerHTML="";

    var td24=trs[trs.length-1].getElementsByClassName("td-mas")[0];
    td24.innerHTML="";
    var td25=trs[trs.length-1].getElementsByClassName("td-bje")[0];
    td25.innerHTML="";
    var td26=trs[trs.length-1].getElementsByClassName("td-ugl")[0];
    td26.innerHTML="";

    for(var i=1;i<trs.length-2;i++){
      td2.innerHTML=r(Number(td2.innerHTML)
        +Number(trs[i].getElementsByClassName("inp-kol")[0].value),2);
      td3.innerHTML=r(Number(td3.innerHTML)
        +Number(trs[i].getElementsByClassName("td-kal")[0].innerHTML),2);
      td4.innerHTML=r(Number(td4.innerHTML)
        +Number(trs[i].getElementsByClassName("td-mas")[0].innerHTML),2);
      td5.innerHTML=r(Number(td5.innerHTML)
        +Number(trs[i].getElementsByClassName("td-bje")[0].innerHTML),2);
      td6.innerHTML=r(Number(td6.innerHTML)
        +Number(trs[i].getElementsByClassName("td-ugl")[0].innerHTML),2);
      td7.innerHTML=r(Number(td7.innerHTML)
        +Number(trs[i].getElementsByClassName("td-kls")[0].innerHTML),2);
      td8.innerHTML=r(Number(td8.innerHTML)
        +Number(trs[i].getElementsByClassName("td-go")[0].innerHTML),2);
    };
    
    var sum=Number(td4.innerHTML)*9+Number(td5.innerHTML)*4+Number(td6.innerHTML)*4;

    if(sum>0){
      td24.innerHTML=Number(Number(td4.innerHTML)*9/sum*100).toPrecision(2)+" % kcal";
      td25.innerHTML=Number(Number(td5.innerHTML)*4/sum*100).toPrecision(2)+" % kcal";
      td26.innerHTML=Number(Number(td6.innerHTML)*4/sum*100).toPrecision(2)+" % kcal";
    }else if (sum==0){
      td24.innerHTML="0 % kcal";
      td25.innerHTML="0 % kcal";
      td26.innerHTML="0 % kcal";
    }
  };

  function calculateMasterFooter(mastertable, tables){
    var trs=mastertable.getElementsByTagName("tr");

    var td2=trs[1].getElementsByClassName("td-kol")[0];
    td2.innerHTML="";
    var td3=trs[1].getElementsByClassName("td-kal")[0];
    td3.innerHTML="";
    var td4=trs[1].getElementsByClassName("td-mas")[0];
    td4.innerHTML="";
    var td5=trs[1].getElementsByClassName("td-bje")[0];
    td5.innerHTML="";
    var td6=trs[1].getElementsByClassName("td-ugl")[0];
    td6.innerHTML="";
    var td7=trs[1].getElementsByClassName("td-kls")[0];
    td7.innerHTML="";
    var td8=trs[1].getElementsByClassName("td-go")[0];
    td8.innerHTML="";

    var td24=trs[2].getElementsByClassName("td-mas")[0];
    td24.innerHTML="";
    var td25=trs[2].getElementsByClassName("td-bje")[0];
    td25.innerHTML="";
    var td26=trs[2].getElementsByClassName("td-ugl")[0];
    td26.innerHTML="";

    for(var i=0;i<tables.length;i++){
      var tabletrs=tables[i].getElementsByTagName("tr");
      var tablefootertr1=tabletrs[tabletrs.length-2];
      td2.innerHTML=r(Number(td2.innerHTML)
        +Number(tablefootertr1.getElementsByClassName("td-kol")[0].innerHTML),2);
      td3.innerHTML=r(Number(td3.innerHTML)
        +Number(tablefootertr1.getElementsByClassName("td-kal")[0].innerHTML),2);
      td4.innerHTML=r(Number(td4.innerHTML)
        +Number(tablefootertr1.getElementsByClassName("td-mas")[0].innerHTML),2);
      td5.innerHTML=r(Number(td5.innerHTML)
        +Number(tablefootertr1.getElementsByClassName("td-bje")[0].innerHTML),2);
      td6.innerHTML=r(Number(td6.innerHTML)
        +Number(tablefootertr1.getElementsByClassName("td-ugl")[0].innerHTML),2);
      td7.innerHTML=r(Number(td7.innerHTML)
        +Number(tablefootertr1.getElementsByClassName("td-kls")[0].innerHTML),2);
      td8.innerHTML=r(Number(td8.innerHTML)
        +Number(tablefootertr1.getElementsByClassName("td-go")[0].innerHTML),2);
    };
    
    var sum=Number(td4.innerHTML)*9+Number(td5.innerHTML)*4+Number(td6.innerHTML)*4;

    if(sum>0){
        td24.innerHTML=Number(Number(td4.innerHTML)*9/sum*100).toPrecision(2)+" % kcal";
        td25.innerHTML=Number(Number(td5.innerHTML)*4/sum*100).toPrecision(2)+" % kcal";
        td26.innerHTML=Number(Number(td6.innerHTML)*4/sum*100).toPrecision(2)+" % kcal";
      }else if (sum==0){
        td24.innerHTML="0 % kcal";
        td25.innerHTML="0 % kcal";
        td26.innerHTML="0 % kcal";
      }
  };

  function createHeader(table){
    var tr=document.createElement("tr");
      var td1=document.createElement("td");
      td1.innerHTML="Namirnica";
      td1.style.fontWeight="bold";
      tr.appendChild(td1);

      var td2=document.createElement("td");
      td2.innerHTML="Koli&#269;ina (g)";
      td2.style.fontWeight="bold";
      tr.appendChild(td2);

      var td3=document.createElement("td");
      td3.innerHTML="Kalorije (kcal)";
      td3.style.fontWeight="bold";
      tr.appendChild(td3);

      var td4=document.createElement("td");
      td4.innerHTML="Masti (g)";
      td4.style.fontWeight="bold";
      tr.appendChild(td4);

      var td5=document.createElement("td");
      td5.innerHTML="Bjelan&#269;evine (g)";
      td5.style.fontWeight="bold";
      tr.appendChild(td5);

      var td6=document.createElement("td");
      td6.innerHTML="Ugljikohidrati (g)";
      td6.style.fontWeight="bold";
      tr.appendChild(td6);

      var td7=document.createElement("td");
      td7.innerHTML="Kolesterol (mg)";
      td7.style.fontWeight="bold";
      tr.appendChild(td7);

      var td8=document.createElement("td");
      td8.innerHTML="Glik. opter.";
      td8.style.fontWeight="bold";
      tr.appendChild(td8);

    table.appendChild(tr);
  };

  function createFooter(table){
    var tr=document.createElement("tr");
      var td1=document.createElement("td");
      td1.setAttribute("class", "td-nam");
      td1.innerHTML="Ukupno";
      td1.style.fontWeight="bold";
      tr.appendChild(td1);

      var td2=document.createElement("td");
      td2.setAttribute("class", "td-kol");
      td2.style.fontWeight="bold";
      tr.appendChild(td2);

      var td3=document.createElement("td");
      td3.setAttribute("class", "td-kal");
      td3.style.fontWeight="bold";
      tr.appendChild(td3);

      var td4=document.createElement("td");
      td4.setAttribute("class", "td-mas");
      td4.style.fontWeight="bold";
      tr.appendChild(td4);

      var td5=document.createElement("td");
      td5.setAttribute("class", "td-bje");
      td5.style.fontWeight="bold";
      tr.appendChild(td5);

      var td6=document.createElement("td");
      td6.setAttribute("class", "td-ugl");
      td6.style.fontWeight="bold";
      tr.appendChild(td6);

      var td7=document.createElement("td");
      td7.setAttribute("class", "td-kls");
      td7.style.fontWeight="bold";
      tr.appendChild(td7);

      var td8=document.createElement("td");
      td8.setAttribute("class", "td-go");
      td8.style.fontWeight="bold";
      tr.appendChild(td8);

    table.appendChild(tr);

    var tr=document.createElement("tr");
      var td1=document.createElement("td");
      td1.setAttribute("class", "td-nam");
      td1.style.fontWeight="bold";
      tr.appendChild(td1);

      var td2=document.createElement("td");
      td2.setAttribute("class", "td-kol");
      td2.style.fontWeight="bold";
      tr.appendChild(td2);

      var td3=document.createElement("td");
      td3.setAttribute("class", "td-kal");
      td3.style.fontWeight="bold";
      tr.appendChild(td3);

      var td4=document.createElement("td");
      td4.setAttribute("class", "td-mas");
      td4.style.fontWeight="bold";
      tr.appendChild(td4);

      var td5=document.createElement("td");
      td5.setAttribute("class", "td-bje");
      td5.style.fontWeight="bold";
      tr.appendChild(td5);

      var td6=document.createElement("td");
      td6.setAttribute("class", "td-ugl");
      td6.style.fontWeight="bold";
      tr.appendChild(td6);

      var td7=document.createElement("td");
      td7.setAttribute("class", "td-kls");
      td7.style.fontWeight="bold";
      tr.appendChild(td7);

      var td8=document.createElement("td");
      td8.setAttribute("class", "td-go");
      td8.style.fontWeight="bold";
      tr.appendChild(td8);

    table.appendChild(tr);
  };

  function createRow(item, table, mastertable){
	trs=table.getElementsByTagName("tr");
    var tr=document.createElement("tr");
    tr.name="";//Number(trs.length-3);
      var td1=document.createElement("td");      
        var sel=document.createElement("select");    
        var frag=document.createDocumentFragment();
        namir.forEach(function(item, index){
          var opt=document.createElement("option");
          opt.text=item.naziv;
          opt.value=item.id;
          frag.appendChild(opt);
        });
        sel.appendChild(frag);
        sel.setAttribute("class", "sel-nam");
        sel.value=item.namir;
        sel.name="namir["+table.name+"]["+tr.name+"]";
        sel.onchange=function(){
          calculateRow(tr);
          calculateFooter(table);     
          calculateMasterFooter(mastertable, tables);
          trs=table.getElementsByTagName("tr");
          trbeforelast=trs[trs.length-3];
          if(tr==trbeforelast){
            createRow({namir:-1, kolicina:''},table,mastertable);
          };
        };
      td1.appendChild(sel);
    tr.appendChild(td1);

      var td2=document.createElement("td");
        var input=document.createElement("input");
        input.setAttribute("class", "inp-kol");
        input.type="text";
        input.size=8;
        input.value=item.kolicina;
        input.name="kolicina["+table.name+"]["+tr.name+"]";
        input.onchange=function(){
          calculateRow(tr);
          calculateFooter(table);
          calculateMasterFooter(mastertable, tables);
          trs=table.getElementsByTagName("tr");
          trbeforelast=trs[trs.length-3];
          if(tr==trbeforelast){
            createRow({namir:-1, kolicina:''},table,mastertable);
          };
        };
      td2.appendChild(input);
    tr.appendChild(td2);
  
      var td3=document.createElement("td");
      td3.setAttribute("class", "td-kal");
    tr.appendChild(td3);

      var td4=document.createElement("td");
      td4.setAttribute("class", "td-mas");
    tr.appendChild(td4);

      var td5=document.createElement("td");
      td5.setAttribute("class", "td-bje");
    tr.appendChild(td5);

      var td6=document.createElement("td");
      td6.setAttribute("class", "td-ugl");
    tr.appendChild(td6);

      var td7=document.createElement("td");
      td7.setAttribute("class", "td-kls");
    tr.appendChild(td7);

      var td8=document.createElement("td");
      td8.setAttribute("class", "td-go");
    tr.appendChild(td8);

    calculateRow(tr);
    trs=table.getElementsByTagName("tr");
    table.insertBefore(tr, trs[trs.length-2]);
  };

  function createMasterHeaderFooter(mastertable){
    var tr=document.createElement("tr");
      var td1=document.createElement("td");
      td1.innerHTML="";
      td1.style.fontWeight="bold";
      tr.appendChild(td1);

      var td2=document.createElement("td");
      td2.innerHTML="Koli&#269;ina (g)";
      td2.style.fontWeight="bold";
      tr.appendChild(td2);

      var td3=document.createElement("td");
      td3.innerHTML="Kalorije (kcal)";
      td3.style.fontWeight="bold";
      tr.appendChild(td3);

      var td4=document.createElement("td");
      td4.innerHTML="Masti (g)";
      td4.style.fontWeight="bold";
      tr.appendChild(td4);

      var td5=document.createElement("td");
      td5.innerHTML="Bjelan&#269;evine (g)";
      td5.style.fontWeight="bold";
      tr.appendChild(td5);

      var td6=document.createElement("td");
      td6.innerHTML="Ugljikohidrati (g)";
      td6.style.fontWeight="bold";
      tr.appendChild(td6);

      var td7=document.createElement("td");
      td7.innerHTML="Kolesterol (mg)";
      td7.style.fontWeight="bold";
      tr.appendChild(td7);

      var td8=document.createElement("td");
      td8.innerHTML="Glik. opter.";
      td8.style.fontWeight="bold";
      tr.appendChild(td8);

    mastertable.appendChild(tr);

    var tr=document.createElement("tr");
      var td1=document.createElement("td");
      td1.setAttribute("class", "td-nam");
      td1.innerHTML="Ukupno";
      td1.style.fontWeight="bold";
      tr.appendChild(td1);

      var td2=document.createElement("td");
      td2.setAttribute("class", "td-kol");
      td2.style.fontWeight="bold";
      tr.appendChild(td2);

      var td3=document.createElement("td");
      td3.setAttribute("class", "td-kal");
      td3.style.fontWeight="bold";
      tr.appendChild(td3);

      var td4=document.createElement("td");
      td4.setAttribute("class", "td-mas");
      td4.style.fontWeight="bold";
      tr.appendChild(td4);

      var td5=document.createElement("td");
      td5.setAttribute("class", "td-bje");
      td5.style.fontWeight="bold";
      tr.appendChild(td5);

      var td6=document.createElement("td");
      td6.setAttribute("class", "td-ugl");
      td6.style.fontWeight="bold";
      tr.appendChild(td6);

      var td7=document.createElement("td");
      td7.setAttribute("class", "td-kls");
      td7.style.fontWeight="bold";
      tr.appendChild(td7);

      var td8=document.createElement("td");
      td8.setAttribute("class", "td-go");
      td8.style.fontWeight="bold";
      tr.appendChild(td8);

    mastertable.appendChild(tr);

    var tr=document.createElement("tr");
      var td1=document.createElement("td");
      td1.setAttribute("class", "td-nam");
      td1.style.fontWeight="bold";
      tr.appendChild(td1);

      var td2=document.createElement("td");
      td2.setAttribute("class", "td-kol");
      td2.style.fontWeight="bold";
      tr.appendChild(td2);

      var td3=document.createElement("td");
      td3.setAttribute("class", "td-kal");
      td3.style.fontWeight="bold";
      tr.appendChild(td3);

      var td4=document.createElement("td");
      td4.setAttribute("class", "td-mas");
      td4.style.fontWeight="bold";
      tr.appendChild(td4);

      var td5=document.createElement("td");
      td5.setAttribute("class", "td-bje");
      td5.style.fontWeight="bold";
      tr.appendChild(td5);

      var td6=document.createElement("td");
      td6.setAttribute("class", "td-ugl");
      td6.style.fontWeight="bold";
      tr.appendChild(td6);

      var td7=document.createElement("td");
      td7.setAttribute("class", "td-kls");
      td7.style.fontWeight="bold";
      tr.appendChild(td7);

      var td8=document.createElement("td");
      td8.setAttribute("class", "td-go");
      td8.style.fontWeight="bold";
      tr.appendChild(td8);

    mastertable.appendChild(tr);
  };

  var form=document.getElementById("form1");
  var input=document.getElementById("input1");
  
  var mastertable=document.createElement("table");

  var tables=[];
  for(var i=0;i<5;i++){
    var table=document.createElement("table");
    table.name=i;
    tables.push(table);
    form.insertBefore(table, input);
    var br=document.createElement("br");
    form.insertBefore(br, input);
    createHeader(table);
    createFooter(table);
    obrok.forEach(function(item, index){
      if(i==item.jelo){
        createRow(item,table,mastertable);
      };
    });
    calculateFooter(table);
  };

  form.insertBefore(mastertable, input);
  br=document.createElement("br");
  form.insertBefore(br, input);
  createMasterHeaderFooter(mastertable);
  calculateMasterFooter(mastertable, tables);

</script>

	<br />
	<br />
	<a href="<c:url value="/" />">Home</a>
	<br />
	<br />
	<a href="<c:url value="/j_spring_security_logout" />">Logout</a>
</body>
</html>
