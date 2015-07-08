<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"	href="${pageContext.request.contextPath}/resources/css/bootstrap.css" />
<link rel="stylesheet"	href="${pageContext.request.contextPath}/resources/css/style.css" />
<link href='http://fonts.googleapis.com/css?family=Open+Sans'	rel='stylesheet' type='text/css'>
<link rel="stylesheet"	href="http://fontawesome.io/assets/font-awesome/css/font-awesome.css">
<script	src="<c:url value="/resources/js/autocomplete/jquery.1.10.2.min.js" />"></script>
<script	src="<c:url value="/resources/js/autocomplete/jquery.autocomplete.min.js" />"></script>
<link href="<c:url value="/resources/js/autocomplete/main.css" />"	rel="stylesheet">
<title><spring:message code="label.contactUs" /></title>
</head>
<body>

	<security:authentication property="principal.username"
		var="usernameWho" />
	<c:url value="/list/${usernameWho}/buttonSearch" var="urlSearchFull"></c:url>

	<div class="allContent">
		<c:import url="header.jsp"></c:import>
		<div class="containerAll">
			<div class="container">
				<div class="jumbotron jumbotron-sm">
					<div class="container">
						<div class="row">
							<div class="col-sm-12 col-lg-12">
								<h1 class="h1">
									<spring:message code="label.contactUsMessage" /> 
<!-- 									<small>Feel free to contact us</small> -->
								</h1>
							</div>
						</div>
					</div>
				</div>
				<div class="container">
					<div class="row">
						<div class="col-md-8">
							<div class="well well-sm">
								<form>
									<div class="row">
										<div class="col-md-6">
											<div class="form-group">
												<label for="name"> <spring:message code="label.name" /></label> <input type="text"
													class="form-control" id="name" placeholder="<spring:message code="label.name" />"
													required="required" />
											</div>
											<div class="form-group">
												<label for="email"> <spring:message code="label.email" /></label>
												<div class="input-group">
													<span class="input-group-addon"><span
														class="glyphicon glyphicon-envelope"></span> </span> <input
														type="email" class="form-control" id="email"
														placeholder="<spring:message code="label.email" />" required="required" />
												</div>
											</div>
											<div class="form-group">
												<label for="subject"> <spring:message code="label.subject" /></label> <select id="subject"
													name="subject" class="form-control" required="required">
													<option value="na"><spring:message code="label.choose" />:</option>
													<option value="service">General Customer Service</option>
													<option value="suggestions">Suggestions</option>
													<option value="product">Product Support</option>
												</select>
											</div>
										</div>
										<div class="col-md-6">
											<div class="form-group">
												<label for="name"> <spring:message code="label.message" /></label>
												<textarea name="message" id="message" class="form-control"
													rows="9" cols="25" required="required"
													placeholder="<spring:message code="label.message" />"></textarea>
											</div>
										</div>
										<div class="col-md-12">
											<button type="submit" class="btn btn-primary pull-right"
												id="btnContactUs"><spring:message code="label.send" /></button>
										</div>
									</div>
								</form>
							</div>
						</div>
						<div class="col-md-4">
							<form>
									<span class="glyphicon glyphicon-globe"></span><spring:message code="label.ourOffice" />
								<address>
									<strong>Efes, Inc.</strong><br> 17 Ostr str., Suite 126<br>
									Belarus, Minsk 220125<br> <abbr title="Phone"> P:</abbr>
									(029) 665-5588
								</address>
								<address>
									<strong><spring:message code="label.email" /></strong><br> <a href="mailto:#">efes2k@example.com</a>
								</address>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<c:url
		value="${pageContext.request.contextPath}/list/${usernameWho}/getTags"
		var="temp"></c:url>

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

	<script type="text/javascript">
	$(document).ready(function(){
	
		$('#btnSearch').click(function(){
			var searchString = $('#w-input-searchFull').val();
			
			$.ajax({
				url: "${pageContext.request.contextPath}/list/${usernameWho}/buttonSearchAjax",
				contentType: 'text/plain',
				data:{mess : searchString},
				dataType: 'json',
				type: 'GET',
				success: function(data){
					var respContent = "";
		             
					$.each(data, function(index, currEmp) {			
						respContent +="<tr> <th> <c:url value='/list/" + currEmp.username + "/imageDisplay' var='avaUrl'></c:url>";
						respContent +="<img src='${avaUrl}' alt='avatar'	class='img-rounded img-responsive'style='width:90ps;height:90px;' /> </th>";
						respContent +="<th>" + currEmp.firstName +  "</th>";
						respContent +="<th>" + currEmp.lastName +  "</th>";
						respContent +="<th>" + currEmp.email +  "</th>";
						respContent +="<th><c:url value='/list/" + currEmp.username + "' var='contUrl'></c:url>";
						respContent +="<a href='${contUrl}'  class='btn btn-primary'>Social</a></th></tr>";

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