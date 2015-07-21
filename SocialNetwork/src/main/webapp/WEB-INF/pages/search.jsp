<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="security"	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"	href="${pageContext.request.contextPath}/resources/css/bootstrap.css" />
<link rel="stylesheet"	href="${pageContext.request.contextPath}/resources/css/style.css" />
<link href='http://fonts.googleapis.com/css?family=Open+Sans'	rel='stylesheet' type='text/css'>
<link rel="stylesheet"	href="http://fontawesome.io/assets/font-awesome/css/font-awesome.css">
<link href="<c:url value="/resources/js/autocomplete/main.css" />" rel="stylesheet">
<script src="<c:url value="/resources/js/autocomplete/jquery.1.10.2.min.js" />"></script>
<script src="<c:url value="/resources/js/autocomplete/jquery.autocomplete.min.js" />"></script>


<title><spring:message code="label.search" /></title>
</head>
<body>

 <security:authentication property="principal.username" var="usernameWho"/>
  <security:authentication property="principal" var="usernameWhoObj"/>
    <security:authentication property="principal.userRoles.listRole" var="usernameWhoRole"/>
    
  <c:url value="/list/${usernameWho}/buttonSearch" var="urlSearchFull"></c:url>

	<div class="allContent" >
		<c:import url="header.jsp"></c:import>
		<div class="containerAll" >
			<div class="container">
				<div class="searchResutlContainer">
					<br /> <br />
					<div id="custom-search-input">
						<div class="input-group col-md-12">
						<input type="text" hidden="true" name="${usernameWhoRole}" class ="prn-hidden"   id="${usernameWhoRole}" value="${usernameWhoRole}">
						<form action="">
						
						
							<input type="text" class="search-query form-control"
									placeholder="<spring:message code="label.search" />" value="" id="w-input-searchFull"
									name="mess" required="required" autofocus="autofocus"/>
								<span	class="input-group-btn" >
								<button class="btn btn-danger" type="submit" id="btnSearch" >
									<spring:message code="label.search" />
								</button>
								
								
								</span>
						</form>
						</div>
					</div>

		<div class="panel panel-primary" style="margin-top:50px;">
			 <div class="panel-heading">
    	     	<h3 class="panel-title"><spring:message code="label.searchResult" /></h3>
  		     </div>
  
  			<div class="panel-body">
					<table class="table table-striped" >
						<thead>
							<tr>
								<th width="20%"><i class="glyphicon glyphicon-camera"></i><spring:message code="label.image" /></th>
								<th width="20%"><i class="glyphicon glyphicon-info-sign"></i><spring:message code="label.information" /></th>
								<th width="20%"><i class="glyphicon glyphicon-map-marker"> </i><spring:message code="label.location" /></th>
								<th width="20%"><i class="glyphicon glyphicon-envelope"></i><spring:message code="label.email" /></th>
								<th width="20%"><i class="glyphicon glyphicon-user"></i><spring:message code="label.link" /></th>
							</tr>
						</thead>
						
						<tbody id="searchResult">
							<c:forEach var="i" items="${searchList}">
								<tr>
									<th><c:url value="/list/${i.username}/imageDisplay?scale=true&w=100&h=100"	var="avaUrl">
									</c:url> <img src="${avaUrl}" alt="avatar"	class="fb-image-small img-rounded img-responsive " style="width:100ps;height:90px;"/></th>
									<th>
										${i.firstName}, ${i.lastName} <br/>
										<fmt:formatDate pattern="yyyy-MM-dd" value="${i.dateOfBirth}" />
									</th>
									<th>
										${i.city.cityName}<br/>
										${i.city.countryIn.countryName }
									</th>
									<th>${i.email}</th>
									<th>
										<c:url value="/list/${i.username}" var="contUrl"></c:url>
										<a href="${contUrl}" class="btn btn-primary"><spring:message code="label.social" /></a>
										
									<c:if test="${usernameWhoObj.userRoles.listRole == 'ADMIN' }">
											<c:url value="/list/credentials/${i.username}" var="contUrl"></c:url>
											<a href="${contUrl}" class="btn btn-primary"><span class="glyphicon glyphicon-cog" aria-hidden="true"></span></a>
										
											 <c:if test="${i.accountNonLocked == false }"> 
				  		    						<h4 class="bg-danger disableUserAlertinSearch text-center contentTwits-dark" >
				  		    						<strong><spring:message code="label.locked" /></strong> 
				  		    						<span class=" glyphicon glyphicon-remove-sign" aria-hidden="true"></span> 
				  		    						</h4>
				  							 </c:if>
									</c:if>	
									</th>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					</div>
				   </div>
				</div>
			</div>
		</div>
	</div>

	<c:url value="${pageContext.request.contextPath}/list/${usernameWho}/getTags" var="temp"></c:url>
	
	
																										<!-- Autocomplete in search field -->
<script>
	$(document).ready(function() {

		$('#w-input-searchFull').autocomplete({
			serviceUrl: '${pageContext.request.contextPath}/list/${usernameWho}/getTags',
			paramName: "tagName",
			delimiter: ",",
			minLength: 3,
		    transformResult: function(response) {
		    	
		        return {
		        	
		            suggestions: $.map($.parseJSON(response), function(item) {
		            	
		                return { 
		                	value: item.firstName + "  " + item.lastName, 
		                	data:item.firstName + " " +item.lastName };
		            })
		        };
		    }
		    
		});
	});
	</script>
	
																										<!-- Autocomplete in header -->
	<script>
	$(document).ready(function() {

		$('#w-input-search').autocomplete({
			serviceUrl: '${pageContext.request.contextPath}/list/${usernameWho}/getTags',
			paramName: "tagName",
			delimiter: ",",
			minLength: 3,
		    transformResult: function(response) {
		    	
		        return {
		        	
		            suggestions: $.map($.parseJSON(response), function(item) {
		            	
		                return { 
		                	value: item.firstName + "  " + item.lastName, 
		                	data:item.firstName + " " +item.lastName };
		            })
		        };
		    }
		});
	});
	</script>
	
																													<!-- Search by press button 'Search' -->	
	<script type="text/javascript">
	$(document).ready(function(){
	
		$('#btnSearch').click(function(event){
			event.preventDefault();
			var searchString = $('#w-input-searchFull').val();
			var prn = $('.prn-hidden').val();
		
			$.ajax({
				url: "${pageContext.request.contextPath}/list/${usernameWho}/buttonSearchAjax",
				data:{'mess' : searchString},
				dataType: 'json',
				type: 'GET',
				success: function(data){
					var respContent = "";
 
					$.each(data, function(index, currEmp) {	
						var d = new Date(currEmp.dateOfBirth);
						
						respContent +="<tr> <th> <c:url value='/list/" + currEmp.username + "/imageDisplay?scale=true&w=100&h=100' var='avaUrl'></c:url>";
						respContent +="<img src='${avaUrl}' alt='avatar'	class='img-rounded img-responsive'style='width:100px;height:90px;' /> </th>";
						respContent +="<th>" + currEmp.firstName +  ", "+currEmp.lastName  +" <br/>";
						respContent += d.getFullYear() + "-"  + ("0" + (d.getMonth() + 1)).slice(-2)  + "-" + ("0" + d.getDate()).slice(-2) +"</th>";
						respContent +="<th>" +currEmp.city.cityName  + "<br/>" + currEmp.city.countryIn.countryName+ "</th>";
						respContent +="<th>" + currEmp.email +  "</th>";
						respContent +="<th><c:url value='/list/" + currEmp.username + "' var='contUrl'></c:url>";
						respContent +="<a href='${contUrl}'  class='btn btn-primary'><spring:message code='label.social' /></a>";
						if(prn == 'ADMIN'){
							respContent +="<c:url value='/list/credentials/" + currEmp.username+ "' var='contUrl' />";
							respContent +="<a href='${contUrl}' class='btn btn-primary'><span class='glyphicon glyphicon-cog' aria-hidden='true'></span></a>";
						if(currEmp.accountNonLocked == false)	{
							respContent +="<div class='bg-danger disableUserAlertinSearch text-center contentTwits-dark'>";
							respContent +="<strong><spring:message code='label.locked' /></strong>";
							respContent +="<span class=' glyphicon glyphicon-remove-sign' aria-hidden='true'></span> ";
							respContent +="</div>  ";
						}
						}
						
						respContent +="</th></tr>";
						
			         }); 
		            $("#searchResult").html(respContent);    
					
				},
				error: function(xhr, status, errorThrown){
					alert('failed with status' + status + ". " + errorThrown);
										
				}
			});
		});
	});
	
</script>
	
		
																											<!-- Sumbitting form by Enter -->
<script type="text/javascript">
$(function() {
    $('form').each(function() {
        $(this).find('input').keypress(function(e) {
            // Enter pressed?
            if(e.which == 10 || e.which == 13) {
                this.form.submit();
            }
        });

        $(this).find('input[type=submit]').hide();
    });
});
</script>	
	
	
	
	<c:import url="footer.jsp"></c:import>

</body>
</html>