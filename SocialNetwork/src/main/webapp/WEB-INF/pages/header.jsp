<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<security:authentication property="principal.username"	var="userOwner" />
<security:authentication property="principal"	var="userOwnerObj" />

<div class="container">
	<nav class="navbar navbar-inverse navbar-fixed-top">
		<div class="container">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<c:url value="/list/${userOwner}" var="homeUrl"></c:url>
				<strong> <a class="navbar-brand" href="${homeUrl}">
				 <security:authentication	property="principal.firstName" /> 
				 <security:authentication	property="principal.lastName" />
				</a>
				</strong>
			</div>

			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse" id="navbar-collapse-3">
				<ul class="nav navbar-nav navbar-left" style="margin-right: 20px;">

					<c:url value="/list/${userOwner}/settings" var="urlSettings"></c:url>
					<c:url value="/list/${userOwner}/myFriends" var="urlMyFriends"></c:url>
					<c:url value="/list/${userOwner}/gallery" var="urlGallery"></c:url>
					<c:url value="/list/${userOwner}/contactUs" var="urlContactUs"></c:url>
					<c:url value="/list/${userOwner}/buttonSearch" var="urlSearch"></c:url>
					
					<li><a href="${homeUrl}"><spring:message code="label.home" /></a></li>
					<li><a href="${urlMyFriends}"><spring:message code="label.friends" /><span class="badge">${userOwnerObj.myFriends.size() }</span></a></li>
					<li><a href="${urlSettings}"><spring:message code="label.settings" /></a></li>
					<li><a href="${urlGallery}"><spring:message code="label.gallery" /></a></li>
					<li><a href="${urlContactUs}"><spring:message code="label.contactUs" /></a></li>
					<li> <form:form action="${urlSearch}"
							method="GET" cssClass="navbar-form navbar-right"
							cssStyle="margin-left:30%;" id="formSearch">
							<div class="form-group">

								<input type="text" class="  search-query form-control"
									placeholder="<spring:message code="label.search" />" value="" id="w-input-search" name="mess" />

							</div>
							<button type="submit" class="btn btn-danger">
								<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
							</button>
						</form:form></li>
				</ul>



				<ul class="nav navbar-nav">

					<li>
						<a href="<c:url value="/j_spring_security_logout" />">
						<span class="glyphicon glyphicon-log-out"></span> <spring:message code="label.logout" />
						</a>
					</li>
							
				
							
				</ul>
				<ul class="nav navbar-nav navbar-right" >
				 	
					<li class="localeSpan" id="localeSpan">
						<span >
							<a href="?lang=en"><img alt="<spring:message code="label.en" />" src="${pageContext.request.contextPath}/resources/images/en_flag.png" width="20px" height="20px"> </a>
						</span>
						<span>
							<a  href="?lang=ru" ><img alt="<spring:message code="label.ru" />" src="${pageContext.request.contextPath}/resources/images/ru_flag.png" width="20px" height="20px"></a>
						</span>
					</li>	
					<li >
					
					</li>	
					<li>
				
					</li>
				
				</ul>
				
				
		

			</div>
		</div>
	</nav>
</div>


