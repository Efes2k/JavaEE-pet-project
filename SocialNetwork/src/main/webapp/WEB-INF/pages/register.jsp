<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code="label.registration" /></title>

<link rel="stylesheet"	href="${pageContext.request.contextPath}/resources/css/bootstrap.css" />
<link rel="stylesheet"	href="${pageContext.request.contextPath}/resources/css/style.css" />
<link rel="stylesheet"	href="${pageContext.request.contextPath}/resources/css/bootstrap-select.css" />
<link href='http://fonts.googleapis.com/css?family=Open+Sans'	rel='stylesheet' type='text/css'>
<link rel="stylesheet"	href="http://fontawesome.io/assets/font-awesome/css/font-awesome.css">
<link href='http://fonts.googleapis.com/css?family=Open+Sans'	rel='stylesheet' type='text/css'>


<title><spring:message code="label.registration" /></title>
</head>
<body>

	<div class="containerAll" style="min-height: 1000px;">

		<div class="containerRegistration">
			<form:form method="POST" action="add" commandName="user"
				cssClass="form-horizontal" id="contact-form">
				<fieldset>
					<div class="panel panel-primary">
						<div class="panel-heading">
							<h3 class="panel-title"><spring:message code='label.registration' /></h3>
						</div>


						<div class="panel-body">
							<div class="control-group">
							<c:if test="${not empty error}">
						<div class="alert alert-danger" 	>
							${error}
					</div>
						</c:if>
							</div>																										<!-- username -->
							<div class="control-group">
								<form:label path="username" for="username"><spring:message code='label.username' /></form:label>
								<div class="controls">
									<form:input path="username" cssClass="input-xlarge"
										id="username" />
									<label class="errorText"><form:errors path="username" /></label>
									<p class="help-block">Username can contain any letters or
										numbers, without spaces</p>
								</div>
							</div>
							<hr class="registrationForm">

																																		<!-- Date -->

							<div class="control-group">
								<form:label path="dateOfBirth"><spring:message code='label.date' /></form:label>
								<div class="controls">
																																		<!-- Year -->
									<strong> Y </strong>
									<form:select path="dateOfBirth.year" cssClass="selectContainer">
										<c:forEach var="year" begin="1900" end="2000">
											<form:option value="${year-1900}">
												<c:out value="${year}"></c:out>
											</form:option>
										</c:forEach>
									</form:select>
																																		<!-- Month -->
									<strong> M </strong>
									<form:select path="dateOfBirth.month" cssClass="selectContainerMin">
										<c:forEach var="month" begin="1" end="12">
											<form:option value="${month}">
												<c:out value="${month}"></c:out>
											</form:option>
										</c:forEach>
									</form:select>
																																		<!-- Day -->
									<strong> D </strong>
									<form:select path="dateOfBirth.date" cssClass="selectContainerMin">
										<c:forEach var="date" begin="1" end="31">
											<form:option value="${date}">
												<c:out value="${date}"></c:out>
											</form:option>
										</c:forEach>
									</form:select>
								</div>
								<p class="help-block">Date of birth</p>
							</div>
							<hr class="registrationForm">
							
																																	<!-- Password -->

							<div class="control-group">
								<form:label path="password"><spring:message code='label.password' /></form:label>
								<div class="controls">
									<form:input path="password" cssClass="input-xlarge"
										id="password" />
									<label class="errorText"><form:errors path="password" /></label>
									<p class="help-block">Password can contain any letters or
										numbers, without spaces</p>
								</div>
							</div>
							<hr class="registrationForm">

																																<!-- First name -->

							<div class="control-group">
								<form:label path="firstName"><spring:message code='label.fName' /></form:label>
								<div class="controls">
									<form:input path="firstName" cssClass="input-xlarge"
										id="firstName" />
									<label class="errorText"><form:errors path="firstName" /></label>
									<p class="help-block">First name can contain any letters or
										numbers, without spaces</p>
								</div>
							</div>
							<hr class="registrationForm">

																																<!-- Last name -->

							<div class="control-group">
								<form:label path="lastName"><spring:message code='label.lName' /></form:label>
								<div class="controls">

									<form:input path="lastName" cssClass="input-xlarge" />
									<label class="errorText"><form:errors path="lastName"
											id="lastName" /></label>
									<p class="help-block">Last name can contain any letters or
										numbers, without spaces</p>
								</div>
							</div>
							<hr class="registrationForm">

																																<!-- E-mail -->

							<div class="control-group">
								<form:label path="email"><spring:message code='label.email' /></form:label>
								<div class="controls">
									<form:input path="email" cssClass="input-xlarge" id="email" />
									<label class="errorText"><form:errors path="email" /></label>
									<p class="help-block">E-mail</p>
								</div>
							</div>
							<hr class="registrationForm">

																																<!-- Phone -->

							<div class="control-group">
								<form:label path="phoneNumber"><spring:message code='label.phone' /></form:label>
								<div class="controls">
									<form:input path="phoneNumber" cssClass="input-xlarge"
										id="phoneNumber" />
									<label class="errorText"><form:errors path="phoneNumber" /></label>
									<p class="help-block">Phone number</p>
								</div>
							</div>
							<hr class="registrationForm">

											<c:out value=""></c:out>																					<!-- Country -->

							<div class="control-group">
								<label for="country"><spring:message code='label.country' /></label> 
								<label for="country"style="padding-left: 90px;"><spring:message code='label.city' /></label>
								<div class="controls">

									<select name="country" id="country" >
										<option value="0"><spring:message code="label.country" /></option>
										<c:forEach var="countryList" items="${countryList}">
											<option value="${countryList.id}">${countryList.countryName}</option>
										</c:forEach>
									</select>
																																<!-- City -->
									<select name="cityId" id="cityOptions">
										<option value="0"><spring:message code="label.city" /></option>

									</select>

									<input type="text" name="othstate" value="" class="textBox"
										style="display: none;">
								</div>
								<p class="help-block">Select your location</p>
							</div>

						</div>

						<div class="panel-footer clearfix">
							<div class="pull-center">
								<input type="submit" class="btn btn-success"
									value="<spring:message code="label.submit"/>" /> <a
									href="index.jsp" class="btn btn-danger"><spring:message
										code="label.back" /></a>
							</div>
						</div>

					</div>
				</fieldset>
			</form:form>
		</div>
	</div>


	<c:import url="footer.jsp"></c:import>

	<script	src="<c:url value="/resources/js/autocomplete/jquery.1.10.2.min.js" />"></script>
	<script	src="<c:url value="/resources/js/autocomplete/jquery.autocomplete.min.js" />"></script>
	<script	src="${pageContext.request.contextPath}/resources/js/bootstrap.js"></script>
	<script	src="${pageContext.request.contextPath}/resources/js/comment.js"></script>
	<script	src="${pageContext.request.contextPath}/resources/js/jquery.validate.js"></script>



	<!-- Country and City lists -->
	<script type="text/javascript">
		$(document).ready(function() {$('#country').change(function() {
												var countryId = $(this).val();
												$.ajax({
													url : '${pageContext.request.contextPath}/register/getCities',
													contentType : 'text/plain',
													data : {countryId : countryId},
													dataType : 'json',
													type : 'GET',
													success : function(data) {
														var respContent = "";
												 		respContent += "<option value='0'>Select city</option>"
														$.each(	data,function(index,i) {
															respContent += "<option value='"+ i.id +"'>"+ i.cityName + " </option>"
																	});
												 		
																$("#cityOptions").html(respContent);
															}
														});

											});
						});
	</script>


																<!-- Validate form with jQuery -->
	<script type="text/javascript">
		$(document).ready(
				function() {
					$('#contact-form').validate(
							{
								rules : {
									username : {
										minlength : 3,
										maxlength : 15,
										required : true
									},
									password : {
										minlength : 3,
										maxlength : 15,
										required : true
									},
									email : {
										required : true,
										email : true
									},
									firstName : {
										minlength : 3,
										maxlength : 15,
										required : true
									},
									phoneNumber : {
										minlength : 7,
										maxlength : 15,
										number : true,
										required : true
									},
									lastName : {
										minlength : 3,
										maxlength : 15,
										required : true
									},
									state : {
										min:1
									}

								},
								highlight : function(element) {
									$(element).closest('.control-group')
											.removeClass('success').addClass(
													'error');
								},
								success : function(element) {
									element.text('OK!').addClass('valid')
											.closest('.control-group')
											.removeClass('error').addClass(
													'success');
								}
							});
				});
	</script>



</body>
</html>