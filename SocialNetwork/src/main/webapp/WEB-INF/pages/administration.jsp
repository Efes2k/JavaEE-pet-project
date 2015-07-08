<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
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
<title><spring:message code='label.adm.settings' /></title>
</head>
<body>

 <security:authentication property="principal.username" var="usernameWho"/>
  <c:url value="/list/${usernameWho}/buttonSearch" var="urlSearchFull"></c:url>

	<div class="allContent">
		<c:import url="header.jsp"></c:import>
		<div class="containerAll">
			<div class="container">
					<div class="searchResutlContainer">
				      <div class="row">
				      <div class="col-md-5  toppad  pull-right col-md-offset-3 ">
				      </div>
				        <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 col-xs-offset-0 col-sm-offset-0 col-md-offset-3 col-lg-offset-3 toppad" >
				   		  <div class="panel panel-info" id="panel-status">
				            <div class="panel-heading" >
				             <h3 class="panel-title">${userInfo.firstName} ${userInfo.lastName},${userInfo.id}</h3>
				              <div class="pull-right"   id="p-heading">
				              		
				              		 <c:if test="${userInfo.accountNonLocked == false }"> 
								  		    	<h4 class="bg-danger disableUserAlert text-center contentTwits-dark" >
								  		    			<strong><spring:message code="label.locked" /></strong> 
								  		    			<span class=" glyphicon glyphicon-remove-sign" aria-hidden="true"></span> 
								  		    	</h4>
								      </c:if>
				              </div>
				            
				            </div>
				            <div class="panel-body">
				              <div class="row">
				              
				              	<c:url value="/list/${userInfo.username}/imageDisplay?scale=true&w=100&h=100" var="avaUrl"></c:url>
				                <div class="col-md-3 col-lg-3 " align="center"> <img alt="User Pic" src="${avaUrl}" width="100px" height="110px"> </div>
				                <div class=" col-md-9 col-lg-9 "> 
				                  <table class="table table-user-information">
				                    <tbody>
				                      <tr>
				                        <td>Hire date:</td>
				                        <td>06/23/2013</td>
				                      </tr>
				                      <tr>
				                        <td><spring:message code='label.dateOfBirth' /></td>
				                        <td><fmt:formatDate pattern="dd-MMM-yyyy" value="${userInfo.dateOfBirth}" /></td>
				                      </tr>
				                        <tr>
				                        <td><spring:message code='label.location' /></td>
				                        <td>${userInfo.city.cityName},${userInfo.city.countryIn.countryName}</td>
				                      </tr>
				                      <tr>
				                        <td><spring:message code='label.email' /></td>
				                        <td><a href="mailto:info@support.com">${userInfo.email}</a></td>
				                      </tr>
				                      <tr>
				                        <td><spring:message code='label.phoneNumber' /></td>
				                        <td>${userInfo.phoneNumber}<br>
				                        </td>
				                      </tr>
				                      <tr>
				                        <td><spring:message code='label.adm.status' /></td>
				                        <td>
											<select id="selectStatus">
												<option value="true"><spring:message code='label.adm.enable' /></option>
												<option value="false"><spring:message code='label.adm.disable' /></option>
											</select>                        	
				                        </td>
				                      </tr>
				                    </tbody>
				                  </table>
				                  
				               			   <button class="btn btn-success" id="statusSave"><spring:message code='label.save' /></button>
				                </div>
				              </div>
				            </div>
				                 <div class="panel-footer">
				                        <a href="mailto:${userInfo.email}" data-original-title="Broadcast Message" data-toggle="tooltip" type="button" class="btn btn-sm btn-primary"><i class="glyphicon glyphicon-envelope"></i></a>
				                        <a href="${removeUserUrl}" data-original-title="Remove this user" data-toggle="tooltip" type="button" class="btn btn-sm btn-danger"><i class="glyphicon glyphicon-remove"></i></a>
				                        <span class="pull-right">
				                        <a href="" class="btn btn-danger" onclick="history.back()"><spring:message code='label.back' /></a>
				                        </span>
				                    </div>
				          </div>
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
	
		$('#statusSave').click(function(){
			var status = $('#selectStatus').val();
			$.ajax({
				url: "${pageContext.request.contextPath}/list/credentials/${userInfo.username}/statusChange",
			
				data:{status : status},
				type: 'POST',
				success: function(data){
					var respContent = "";
					if(data == false){  
						respContent = 	'<h4 class="bg-danger disableUserAlert text-center contentTwits-dark" ><strong><spring:message code="label.locked" /></strong> <span class=" glyphicon glyphicon-remove-sign" aria-hidden="true"></span> </h4>';
						
						$("#p-heading").html(respContent);
					}
					if(data == true)  {
						$("#p-heading").html("");
					}
					
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