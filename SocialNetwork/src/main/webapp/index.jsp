<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="security"	uri="http://www.springframework.org/security/tags"%>
<html>
<head>
<script src="<c:url value="/resources/js/autocomplete/jquery.1.10.2.min.js" />"></script>
<script src="<c:url value="/resources/js/autocomplete/jquery.autocomplete.min.js" />"></script>
<link href="<c:url value="/resources/js/autocomplete/main.css" />" rel="stylesheet">
</head>
<body>

<jsp:forward page="/signin"/>
	
	
</body>
</html>