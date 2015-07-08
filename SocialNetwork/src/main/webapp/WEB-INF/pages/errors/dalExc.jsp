<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="security"	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Error</title>
<link rel="stylesheet"	href="${pageContext.request.contextPath}/resources/css/bootstrap.css" />
</head>
<body>
	
	<div class="allContent">

		<div class="containerAll">
			<div class="container">
				<div class="row">
					<div class="col-md-4"></div>
					<div class="col-md-8">
						<div class="error-template">
							<h1>Oops!</h1>
							<h2>MySQL database error</h2>
							<div class="error-details">Sorry, an error has occured</div>
							<div class="error-actions">
							</div>
							
							
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
</body>
</html>