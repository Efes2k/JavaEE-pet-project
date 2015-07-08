<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="security"	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<link rel="stylesheet"	href="${pageContext.request.contextPath}/resources/css/bootstrap.css" />
<link rel="stylesheet"	href="${pageContext.request.contextPath}/resources/css/style.css" />
<link href='http://fonts.googleapis.com/css?family=Open+Sans'	rel='stylesheet' type='text/css'>
<link rel="stylesheet"	href="http://fontawesome.io/assets/font-awesome/css/font-awesome.css">
<link href="<c:url value="/resources/js/autocomplete/main.css" />"	rel="stylesheet">

<script	src="<c:url value="/resources/js/autocomplete/jquery.1.10.2.min.js" />"></script>
<script	src="<c:url value="/resources/js/autocomplete/jquery.autocomplete.min.js" />"></script>

<title><spring:message code="label.gallery" /></title>
</head>
<body>

	<security:authentication property="principal.username"	var="usernameWho" />
	<c:url value="/list/${usernameWho}/buttonSearch" var="urlSearchFull"></c:url>

	<div class="allContent">
		<c:import url="header.jsp"></c:import>
		<div class="containerAll">
			<div class="container">
				<div class="searchResutlContainer">
					<br /> <br />

					<div class="panel panel-primary" style="margin-top: 50px;">
						<div class="panel-heading">
							<h3 class="panel-title"><spring:message code="label.gallery" /></h3>
						</div>
						<div class="panel-body">
							<div id="main_area">
								<!-- Slider -->
								<div class="row">
									<div class="col-sm-12" id="slider-thumbs">
										<!-- Bottom switcher of slider -->
										<ul style="list-style-type: none;">

											<c:forEach var="i" items="${galleryList}">
												<c:if test="${not empty i.messMedia.media && i.messMedia.type == 'image/jpeg'}">
												
													<c:url	value="/list/${i.owner.username}/imageDisplay/${i.id}?scale=false" var="messAvaUrl"></c:url>
													<c:url	value="/list/${i.owner.username}/imageDisplay/${i.id}?scale=true" var="messAvaScaleUrl"></c:url>
													<c:url value="/list/${i.where.username}" var="whereUrl"></c:url>
													
													<li class="col-sm-3">
													<span><fmt:formatDate	pattern="dd-MMM-yyyy" value="${i.date}" /></span>
													<span><a href="${whereUrl}"> <span class="glyphicon glyphicon-arrow-right" aria-hidden="true"></span></a></span>
													
													<a class="thumbnail"id="carousel-selector-0" data-toggle="modal"
														data-target=".pop-up-${i.id}" href="#"> 
														<img src="${messAvaScaleUrl}" width="150" class="img-responsive img-rounded center-block" />
														
													</a>
													
														<div class="modal fade pop-up-${i.id}" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel-1" aria-hidden="true">
														
															<div class="modal-dialog modal-lg">
															
																<div class="modal-content">
																	<div class="modal-header">
																		<button type="button" class="close"
																			data-dismiss="modal" aria-hidden="true">×
																		</button>
																		<h4 class="modal-title" id="myLargeModalLabel-1">
																				
																				<span><fmt:formatDate	pattern="dd-MMM-yyyy" value="${i.date}" /></span>
																				<span>posted in <a href="${whereUrl}">${i.where.firstName}, ${i.where.lastName}</a> page</span>
																		
																		</h4>
																	</div>
																	<div class="modal-body">
																		<img src="${messAvaUrl}"
																			class="img-responsive img-rounded center-block"	alt="">
																	</div>
																</div>
																<!-- /.modal-content -->
															</div>
															<!-- /.modal-dialog -->
														</div>
														<!-- /.modal mixer image -->
												</li>
												</c:if>
											</c:forEach>
										</ul>
									</div>
									<!--/Slider-->
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<c:url	value="${pageContext.request.contextPath}/list/${usernameWho}/getTags"	var="temp"></c:url>




<script>
	$(document).ready(function() {

		$('#w-input-searchFull').autocomplete({
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

	<script>
	$(document).ready(function() {

		$('#w-input-search').autocomplete({
			serviceUrl: '${pageContext.request.contextPath}/list/${usernameWho}/getTags',
			paramName: "tagName",
			delimiter: ",",
			minLength: 3,
		    transformResult: function(response) {
		        return {    suggestions: $.map($.parseJSON(response), function(item) {
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

	<script	src="${pageContext.request.contextPath}/resources/js/bootstrap.js"></script>
	<script	src="${pageContext.request.contextPath}/resources/js/comment.js"></script>

	<c:import url="footer.jsp"></c:import>

</body>
</html>