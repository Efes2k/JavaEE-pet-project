<%@page contentType='text/html;charset=UTF-8' language='java'%>
<%@taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@taglib prefix='form' uri='http://www.springframework.org/tags/form'%>
<%@taglib prefix='spring' uri='http://www.springframework.org/tags'%>
<%@taglib prefix='security'	uri='http://www.springframework.org/security/tags'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>

<!DOCTYPE html PUBLIC '-//W3C//DTD HTML 4.01 Transitional//EN' 'http://www.w3.org/TR/html4/loose.dtd'>
<html>
<head>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>

	
	<link rel='stylesheet'	href='${pageContext.request.contextPath}/resources/css/bootstrap.css' />
	<link rel='stylesheet'	href='${pageContext.request.contextPath}/resources/css/style.css' />
	<link rel='stylesheet'	href='${pageContext.request.contextPath}/resources/css/bootstrap-select.css' />
	<link rel='stylesheet'	href='${pageContext.request.contextPath}/resources/js/autocomplete/main.css' />
	<link href='http://fonts.googleapis.com/css?family=Open+Sans'rel='stylesheet' type='text/css'>
	<link rel='stylesheet' href='http://fontawesome.io/assets/font-awesome/css/font-awesome.css'>   
	<link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>  
      
 
<title><spring:message code="label.settings" /></title>
</head>
<body>

    <security:authentication property='principal' var='userOwner'/>

	<div class='containerAll' style='min-height: 1000px;'>
		<c:import url="header.jsp"></c:import>

		<div class='containerRegistration'>
			<div id='successChange'>
				<div class='alert alert-success alert-autocloseable-success'>
					<span class="glyphicon glyphicon-ok" id="fieldChangeSuccess">
					</span> was succesfully changed
				</div>
			</div>
			<fieldset>
				<div class='panel panel-primary'>
					<div class='panel-heading'>
						<h3 class='panel-title'>${userOwner.username}'s <spring:message code="label.settings" /></h3>
					</div>

					<div class='panel-body'>


						<!-- Password -->

<!-- 						<div class='row'> -->
<%-- 							<form action='' class='contact-form' id='password'> --%>
<!-- 								<div class=col-md-4> -->
<%-- 									<label><spring:message code="label.current.password" /></label>  --%>
<%-- 									<input class='input-xlarge'	id='password' name='password' disabled='disabled'	value='${userOwner.password }' /> --%>
<!-- 								</div> -->
<!-- 								<div class='control-group'> -->
<!-- 									<div class='col-md-5 '> -->
<%-- 										<label><spring:message code="label.new.password" /></label> --%>
<!-- 										 <input	class='input-xlarge field-password' id='password'	name='password' /> -->
<!-- 									</div> -->
<!-- 									<div class=col-md-3> -->
<!-- 										<div style='margin-top: 25%'> -->
<%-- 											<input type='submit' class='btn btn-success' value='<spring:message code="label.save" />'id='password' /> --%>
<!-- 										</div> -->
<!-- 									</div> -->
<!-- 								</div> -->
<%-- 							</form> --%>
<!-- 						</div> -->

						<hr class='registrationForm'>


						<!-- First name -->

						<div class='row'>
							<form action='' class='contact-form' id='firstName'>
								<div class=col-md-4>
									<label><spring:message code="label.current.fName" /></label>
									 <input class='input-xlarge 'id='firstName' disabled='disabled'
										value='${userOwner.firstName }' />
								</div>
								<div class='control-group'>
									<div class='col-md-5 '>
										<label><spring:message code="label.new.fName" /></label>
										 <input	class='input-xlarge field-firstName' id='firstName'
											name='firstName' />
									</div>
									<div class=col-md-3>
										<div style='margin-top: 25%'>
											<input type='submit' class='btn btn-success' value='<spring:message code="label.save" />'
												id='firstName' />
										</div>
									</div>
								</div>

							</form>

						</div>
						<hr class='registrationForm'>
						<!-- Last name -->

						<div class='row'>
							<form action='' class='contact-form' id='lastName'>
								<div class=col-md-4>
									<label><spring:message code="label.current.fName" /></label>
									 <input class='input-xlarge' id='lastName' disabled='disabled'
										value='${userOwner.lastName }' />
								</div>
								<div class='control-group'>
									<div class='col-md-5 '>
										<label><spring:message code="label.new.fName" /></label>
										 <input	class='input-xlarge field-lastName' id='lastName'
											name='lastName' />
									</div>
									<div class=col-md-3>
										<div style='margin-top: 25%'>
											<input type='submit' class='btn btn-success' value='<spring:message code="label.save" />'
												id='lastName' name='lastName' />
										</div>
									</div>
								</div>

							</form>

						</div>
						<hr class='registrationForm'>

						<!-- E-mail -->

						<div class='row'>
							<form action='' class='contact-form' id='email'>
								<div class=col-md-4>
									<label><spring:message code="label.current.email" /></label> 
									<input class='input-xlarge'	id='email' disabled='disabled' value='${userOwner.email}' />
								</div>
								<div class='control-group'>
									<div class='col-md-5 '>
										<label><spring:message code="label.new.email" /></label> 
										<input	class='input-xlarge field-email' id='email' name='email' />
									</div>
									<div class=col-md-3>
										<div style='margin-top: 25%'>
											<input type='submit' class='btn btn-success' value='<spring:message code="label.save" />'
												id='email' name='email' />
										</div>
									</div>
								</div>

							</form>

						</div>
						<hr class='registrationForm'>

						<!-- Phone -->

						<div class='row'>
							<form action='' class='contact-form' id='phoneNumber'>
								<div class=col-md-4>
									<label><spring:message code="label.current.phone" /></label> <input
										class='input-xlarge' id='phoneNumber' disabled='disabled'
										value='${userOwner.phoneNumber}' />
								</div>
								<div class='control-group'>
									<div class='col-md-5 '>
										<label><spring:message code="label.new.phone" /></label>
										 <input	class='input-xlarge field-phoneNumber' id='phoneNumber' name='phoneNumber' />
									</div>
									<div class=col-md-3>
										<div style='margin-top: 25%'>
											<input type='submit' class='btn btn-success' value='<spring:message code="label.save" />'
												id='phoneNumber' name='phoneNumber' />
										</div>
									</div>
								</div>

							</form>

						</div>
						<hr class='registrationForm'>

																											<!-- Avatar -->
						<c:url value="/list/${userOwner.username}/addAvatar" var="url"></c:url>
						<div class='row'>
							<form:form method="POST" action="${url}"	enctype="multipart/form-data">
								<div class=col-md-4>
									<label><spring:message code="label.current.avatar" /></label>

									<c:url value="/list/${userOwner.username}/imageDisplay?scale=true&h=150&w=150" var="avaUrl"></c:url>
									<c:url value="../resources/images/anonymous.jpg"	var="avaUrlErr"></c:url>
									<c:choose>
										<c:when test="${not empty userOwner.avatar}">
											<img class="thumbnail" style="height: 150px; width: 160px"
												src="${avaUrl}" alt="Profile image example" />
										</c:when>

										<c:otherwise>
											<img align="left" class="fb-image-profile thumbnail"
												style="height: 150px; width: 150px;" src="${avaUrlErr}"
												alt="Profile image example" />
										</c:otherwise>
									</c:choose>
								</div>
								<div class='control-group'>
									<div class='col-md-5 '>
										<label><spring:message code="label.new.avatar" /></label> 
										<input type="file"	class='input-xlarge field-avatar' id='avatar' name='image' />
									</div>
									<div class=col-md-3>
										<div style='margin-top: 25%'>
											<input type='submit' class='btn btn-success' value='<spring:message code="label.save" />'
												id='avatar' name='avatar' />
										</div>
									</div>
								</div>
							</form:form>
						</div>

						<hr class='registrationForm'>

					</div>

					<!-- Button -->
					<div class='panel-footer clearfix'>
						<div class='pull-center'>
							<c:url value="/list/${userOwner.username}" var="backUrl"></c:url>
							<a href='${backUrl}' class='btn btn-danger btn-block'><spring:message code="label.back" /></a>
						</div>
					</div>

				</div>
			</fieldset>
		</div>
	</div>


	<c:import url='footer.jsp'></c:import>



	<script	src="<c:url value="/resources/js/autocomplete/jquery.1.10.2.min.js" />"></script>
	<script	src="<c:url value="/resources/js/autocomplete/jquery.autocomplete.min.js" />"></script>
    <script src='${pageContext.request.contextPath}/resources/js/bootstrap.js'></script>
    <script src='${pageContext.request.contextPath}/resources/js/comment.js'></script>
    <script src='${pageContext.request.contextPath}/resources/js/jquery.validate.js'></script>





  <!-- Validate forw with jQuery -->
<script type='text/javascript'>
$(document).ready(function(){
	$('.alert-autocloseable-success').hide();
	  $('form').each(function() { 
	 $(this).validate(
	 {
	  rules: {
	    username: {
	      minlength: 3,
	      maxlength:15,
	      required: true
	    },
	    password: {
		      minlength: 3,
		      maxlength:15,
		      required: true
		    },
	    email: {
	      required: true,
	      email: true
	    },
	    firstName: {
	      minlength: 3,
	      maxlength:15,
	      required: true
	    },
	    phoneNumber: {
		      minlength: 7,
		      maxlength:15,
		      number:true,
		      required: true
		    },
	    lastName: {
	      minlength: 3,
	      maxlength:15,
	      required: true
	    }
	    
	  },
	  highlight: function(element) {
	    $(element).closest('.control-group').removeClass('success').addClass('error').
	    find(":input[type='submit']").attr('disabled',true);
	    
	  },
	  success: function(element) {
	    element
	    .text('OK!').addClass('valid')
	    .closest('.control-group').removeClass('error').addClass('success').
	     find(":input[type='submit']").attr('disabled',false)	    ;
	  }
	 });
	}); 
});
</script>



 																											<!-- Changing one field -->
 
<script type='text/javascript'>
	$(document).ready(function(){
		 $('form.contact-form').submit(function(event) {
			 event.preventDefault();
				var fieldId = this.id;
				var changes = $('.field-' + fieldId).val();
				if (changes.length == 0){
					return;
					}
			$.ajax({
				url: '${pageContext.request.contextPath}/list/${userOwner}/settings/fieldChange',
				
				data:{fieldId : fieldId,
					  changes : changes
					},
				type: 'POST',
				success: function(data){
					var respContent = '';
					showSuccess(fieldId);
					
				},
				error: function(xhr, status, errorThrown){
					alert('failed with status' + status + '. ' + errorThrown);
										
				}
			});
		});
		 
		 
	});
	
</script>
		
																											<!-- Autocomplete in search field -->
	
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

																																		<!-- Autocomplete in header -->
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
						respContent +="<img src='${avaUrl}' alt='avatar'	class='img-rounded img-responsive' /> </th>";
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
$('#avatar').bind('change', function() {

	  //this.files[0].size gets the size of your file.
	  if(this.files[0].size > 5*1024*1024){
	 	 	alert('file cant bet more 5MB');
	  		document.getElementById("avatar").value = "";
	  }
	});

</script>

 <!-- Alert message -->
 <script type="text/javascript">
function showSuccess(message) {
	
	$('#fieldChangeSuccess').html(message);
     	$('.alert-autocloseable-success').hide();
			$('.alert-autocloseable-success').show();
			$('.alert-autocloseable-success').delay(5000).fadeOut( "slow", function() {
				// Animation complete.
			
			});
		
};
</script>


</body>
</html>