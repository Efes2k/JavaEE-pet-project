<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet"	href="${pageContext.request.contextPath}/resources/css/bootstrap.css" />
<link rel="stylesheet"	href="${pageContext.request.contextPath}/resources/css/style.css" />
<link href='http://fonts.googleapis.com/css?family=Open+Sans'	rel='stylesheet' type='text/css'>
<link rel="stylesheet"	href="http://fontawesome.io/assets/font-awesome/css/font-awesome.css">
<script src="<c:url value="/resources/js/autocomplete/jquery.1.10.2.min.js" />"></script>
<script src="<c:url value="/resources/js/autocomplete/jquery.autocomplete.min.js" />"></script>

<link href="<c:url value="/resources/js/autocomplete/main.css" />" rel="stylesheet">
<title><spring:message code="label.friends" /></title>
</head>
<body>

 <security:authentication property="principal.username" var="usernameWho"/>
  

	<div class="allContent">
		<c:import url="header.jsp"></c:import>
		<div class="containerAll">
			<div class="container">
				<div class="searchResutlContainer">
					<br /> <br />
				

		<div class="panel panel-primary" style="margin-top:50px;">
		 <div class="panel-heading">
			<spring:message code="label.friends" />

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
							<c:forEach var="i" items="${friendList}">
								<tr>
									<th><c:url value="/list/${i.myFriend.username}/imageDisplay?scale=true&w=100&h=100"	var="avaUrl">
									</c:url> <img src="${avaUrl}" alt="avatar"	class="fb-image-small img-rounded img-responsive " style="width:90ps;height:90px;"/></th>
									<th>${i.myFriend.firstName}, ${i.myFriend.lastName} <br/>
										<fmt:formatDate pattern="yyyy-MM-dd" value="${i.myFriend.dateOfBirth}" />
									</th>
									<th>
										${i.myFriend.city.cityName}<br/>
										${i.myFriend.city.countryIn.countryName }
									</th>
									<th>${i.myFriend.email}</th>
									<th><c:url value="/list/${i.myFriend.username}" var="contUrl"></c:url>
										<a href="${contUrl}" class="btn btn-primary"><spring:message code="label.social" /></a></th>
								</tr>

							</c:forEach>
							<!--       Info from Ajax here -->

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

		$('#w-input-search').autocomplete({
			serviceUrl: '${pageContext.request.contextPath}/list/${usernameWho}/getTags',
			paramName: "tagName",
			delimiter: ",",
			minLength: 3,
		    transformResult: function(response) {
		    	
		        return {   suggestions: $.map($.parseJSON(response), function(item) {
		                return { 
		                	value: item.firstName + "  " + item.lastName, 
		                	data:item.firstName + " " +item.lastName };
		            })
		        };
		    }
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