<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<html>
<head>
<link rel="stylesheet"	href="${pageContext.request.contextPath}/resources/css/bootstrap.css" />
	<title><spring:message code="label.login" /></title>

</head>

<body onload='document.f.j_username.focus();'>

        <div class="container" style="margin-top:40px;height:100%;" >
     
		<div class="row">
			<div class="col-sm-6 col-md-4 col-md-offset-4">
				<div class="panel panel-default">
					<div class="panel-heading">
						<strong> <spring:message code="label.signIn" /></strong>
						<span class="nav navbar-nav navbar-right">
							<a href="?lang=en"><img alt="<spring:message code="label.en" />" src="${pageContext.request.contextPath}/resources/images/en_flag.png" width="20px" height="20px"> </a>
							<a href="?lang=ru" ><img alt="<spring:message code="label.ru" />" src="${pageContext.request.contextPath}/resources/images/ru_flag.png" width="20px" height="20px"></a>
						</span>
					</div>
					<div class="panel-body">
						<form role="form" action="<c:url value='j_spring_security_check' />" method="POST">
							<fieldset>
								<div class="row">
									<div class="center-block">
										<img class="profile-img"  style="position:relative;left:110px;width:140px;height: 140px; padding: 10px"
											src="resources/images/login_ico.png" alt="" />
									</div>
								</div>
								<div class="row">
									<div class="col-sm-12 col-md-10  col-md-offset-1 ">
										<div class="form-group">
											<div class="input-group">
												<span class="input-group-addon">
													<i class="glyphicon glyphicon-user"></i>
												</span> 
												<input class="form-control" placeholder="<spring:message code='label.username' />" name="j_username" type="text" autofocus required >
											</div>
										</div>
										<div class="form-group">
											<div class="input-group">
												<span class="input-group-addon">
													<i class="glyphicon glyphicon-lock"></i>
												</span>
												<input class="form-control" placeholder="<spring:message code='label.password' />" name="j_password" type="password" value="" required>
											</div>
										</div>
										<div class="form-group">
											<input id="_spring_security_remember_me" name="_spring_security_remember_me" type="checkbox"	value="true" /> 
											<label for="_spring_security_remember_me"><spring:message code='label.rememberMe' /></label>
										</div>
										<div class="form-group">
											<input type="submit" class="btn btn-lg btn-primary btn-block" value="<spring:message code="label.login"/>">
										</div>
										
									</div>
								</div>
							</fieldset>
						</form>
					</div>
					<div class="panel-footer ">
						<spring:message code='label.dontHave' /> <a href="register" onClick=""> <spring:message code="label.signUp" /> </a>
					</div>
                </div>
			</div>
		</div>
		<c:if test="${not empty error}">
				<div class="alert alert-danger"
					style="width: 360px; margin: 0px auto;" role="alert">
					${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message}
					</div>
			</c:if>
			<c:if test="${not empty success}">
				<div class="alert alert-success"
					style="width: 360px; margin: 0px auto;" role="alert">
					${success}</div>
			</c:if>
		</div>
		<c:import url="footer.jsp"></c:import>
</body>
</html>