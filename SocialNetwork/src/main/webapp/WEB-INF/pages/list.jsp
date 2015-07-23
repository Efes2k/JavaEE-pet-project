<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="security"	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<head>
<meta http-equiv="Content-type" content="text/html;charset=utf-8" />

<script	src="<c:url value="/resources/js/autocomplete/jquery.1.10.2.min.js" />"></script>
<script	src="<c:url value="/resources/js/autocomplete/jquery.autocomplete.min.js" />"></script>
<script	src="${pageContext.request.contextPath}/resources/js/bootstrap.js"></script>
<script type="text/javascript"	src="${pageContext.request.contextPath}/resources/js/bootstrap-filestyle.min.js"> </script>

<link href="<c:url value="/resources/js/autocomplete/main.css" />" rel="stylesheet">
<link rel="stylesheet"	href="${pageContext.request.contextPath}/resources/css/bootstrap.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" />
<link href='http://fonts.googleapis.com/css?family=Open+Sans'	rel='stylesheet' type='text/css'>
<link rel="stylesheet"	href="http://fontawesome.io/assets/font-awesome/css/font-awesome.css">


<title><spring:message code="label.home" /></title>
</head>
<body>
		<security:authentication property="principal.username"	var="userOwner" />
		<security:authentication property="principal"	var="userOwnerObj" />
<%-- 		<security:authentication property="principal.username"	var="usernameWho" /> --%>

	<div class="allContent">
		<c:import url="header.jsp"></c:import>

		<div class="containerAll">
			<div class="container">
																																	<!-- Avatar Image -->
				<div class="fb-profile">
					<c:url value="/list/${userInfo.username}/imageDisplay?scale=true&w=200&h=200" var="avaUrl"></c:url>
					<c:url	value="../resources/images/anonymous.jpg" var="avaUrlErr"></c:url>
					<c:url value="../resources/images/screen.jpg" var="screenAva"></c:url>
					<img align="left" class="fb-image-lg"	src="${screenAva}" alt="Profile image example" /> 

					<c:choose>
						<c:when test="${not empty userInfo.avatar}">
								<img align="left" class="fb-image-profile thumbnail" 
							src="${avaUrl}" onerror="${avaUrlErr}"
								 alt="Profile image example" />
						</c:when>

						<c:otherwise>
									<img align="left" class="fb-image-profile thumbnail"
									 style="height: 250px;"src="${avaUrlErr}" onerror="${avaUrlErr}" 
									 alt="Profile image example" />
						</c:otherwise>
					</c:choose>
					<div class="fb-profile-text">
						<h1>${userInfo.firstName}    ${userInfo.lastName} </h1>
					</div>
				</div>
			</div>
			
			<div class="container">
				<div class="row">
					<div class=col-md-4>
					<div class=col-md-1>
					</div>
					<div class=col-md-9>
					<c:if test="${userOwner != userInfo.username}">

							<div id="subscribeOn">
								<button  class="subscribeIs btn btn-success btn-block" id="subscribeOn">Subscribe </button>	
							</div >
							<div id = "subscribeOff">
								<button class="subscribeIs btn btn-default btn-block" id="subscribeOff">Already your friend</button>		
							</div>
							<div id="subscribeIs">
					
							<c:choose>
								<c:when test="${subOk == 'false'}">
									<button  class="subscribeIs btn btn-success btn-block" id="subscribeOn">Subscribe </button>		
								</c:when>
								<c:otherwise>
									<button  class="subscribeIs btn btn-default btn-block" id="subscribeOff">Already your friend</button>		
								</c:otherwise>
							</c:choose>
							</div>
								<security:authorize access="hasRole('ADMIN')">
											<c:url value="/list/credentials/${userInfo.username}" var="contUrl"></c:url>
											<a href="${contUrl}" class="btn btn-primary btn-setting" ><span class="glyphicon glyphicon-cog" aria-hidden="true" ></span></a>
							    </security:authorize>
					</c:if>
					</div>
					</div>

																																					<!-- Post new message-->
					<div class="col-md-8 " style="margin-top: -100px;">

						<div class="container">
							<div class="col-md-6 " style="margin: 20px">
								<div class="widget-area no-padding blank ">
									<div class="status-upload contentTwits-dark">

										<c:url value="/list/${userInfo.username}/addMessage" var="messUrl"></c:url>

										<form:form method="post" action="${messUrl}"	
												enctype="multipart/form-data" commandName="message"	
												cssClass="form-horizontal" id = "contact-form">
											<form:textarea path="text" placeholder="What are you doing right now ? "></form:textarea>
											<ul>
												<li>												</li>
												<li>
													<div class="control-group">
													<input id="uploadFile" name="imageMess" type="file" value="Change"
														class="filestyle" data-filename-placement="inside">
													</div>
												</li>
											</ul>
											<button type="submit" class="btn btn-success green">
												<i class="fa fa-share"></i> <spring:message code="label.message.share" />
											</button>
										</form:form>
									</div>
								</div>
							</div>
						</div>
						<hr />
					</div>
				</div>

																																		<!-- Information table-->
				<div class="row">
					<div class="sidebar" style="width: 310px; float: left;">
						<div>
							<div class=col-md-12>
								<div class="panel panel-primary">
									<div class="panel-heading"><spring:message code="label.information" /></div>
									<div class="panel-body">
										<address>
											<strong><spring:message code="label.location" /></strong><br /> ${userInfo.city.cityName},
											${userInfo.city.countryIn.countryName}<br />
											<hr class='registrationForm'>
											<strong><spring:message code="label.dateOfBirth" /></strong><br />
											<fmt:formatDate pattern="dd-MMM-yyyy"
												value="${userInfo.dateOfBirth}" />
											<br />
											<hr class='registrationForm'>
											<strong><spring:message code="label.phoneNumber" /></strong><br /> <abbr title="Phone">P:</abbr>
											${userInfo.phoneNumber}
										</address>
										<hr class='registrationForm'>
										<address>
											<strong><spring:message code="label.email" /></strong><br> <a href="mailto:#">${userInfo.email }</a>
										</address>
									</div>


								</div>
							</div>


																																			<!-- My friends table-->

							<div class=col-md-12>
								<div class="panel panel-primary">
									<div class="panel-heading"><spring:message code="label.friends" /></div>
									<div class="panel-body">
										<div style="height: 200px; overflow-y: scroll;">
											<c:forEach var="i" items="${userInfo.myFriends }">
												<c:url value="/list/${i.myFriend.username}/imageDisplay?scale=true&w=50&h=50"
													var="iImg"></c:url>
												<c:url value="/list/${i.myFriend.username}" var="iContUrl"></c:url>
												<img class="img-rounded " src="${iImg}" alt="avaOwner"
													width="35px" height="35px" />
												<a href="${iContUrl}">${i.myFriend.firstName},${i.myFriend.lastName}<br /></a>
											</c:forEach>
										</div>
									</div>
								</div>
							</div>
							
						</div>
					</div>

																																				<!--Messages-->
					<div class="main" >	
						<c:forEach items="${messList}" var="i" varStatus="status">
							<div class="containerTwits" id="${userInfo.username}">
								<div class="row">
									<div class="[ col-md-10 ] ">
										<div class="[ panel panel-default ] panel-google-plus contentTwits-dark">
										
											<div class="panel-heading">
													<c:if test="${userInfo.username eq userOwner ||  i.owner.username eq userOwner}" >   
															<c:url value="/list/${userInfo.username}/removeMessage/${i.id}" var="messRemoveUrl"></c:url>  
															<a href="${messRemoveUrl}" class="btn" style="float:right;">
																		<i class="glyphicon glyphicon-remove" ></i> 
																		<strong></strong>
															</a>
													</c:if>
												
												<c:url value="/list/${i.owner.username}/imageDisplay?scale=true&w=80&h=80"	var="messAvaUrl"></c:url>
												<img class="[ img-rounded pull-left ]" src="${messAvaUrl}"	alt="avaOwner" width="60px" height="60px" />
												<c:url value="/list/${i.owner.username}" var="contUrl"></c:url>
												<h3>
													<a href="${contUrl}">${i.owner.firstName} ${i.owner.lastName}</a>
												</h3>
												<h3 hidden="true" id="message-id">${i.id}</h3>
												<h5>
													<span><spring:message code="label.message.shared" /></span> - <span>
													<fmt:formatDate	pattern="dd-MMM-yyyy hh:mm" value="${i.date}" /></span>
												</h5>
											</div>
											<div class="panel-body"  >
											
																																					<!-- Messsage Image-->
												<c:if test="${not empty i.messMedia.media}">
													<c:if test="${i.messMedia.type == 'image/jpeg' || i.messMedia.type == 'image/gif'}">
													 <hr class='registrationForm'>
														<c:url	value="/list/${i.owner.username}/imageDisplay/${i.id}?scale=false"	var="messAvaUrl"></c:url>
														<img  class="img-thumbnail" style="max-width: 100%; max-height: 500px" src="${messAvaUrl}"	alt="image" />
														 <hr class='registrationForm'>
													 </c:if>
													 <c:if test="${i.messMedia.type == 'audio/mpeg' || i.messMedia.type == 'audio/mp3'}">
														 <hr class='registrationForm'>
														 <c:url	value="/list/${i.owner.username}/imageDisplay/${i.id}?scale=false"	var="messAvaUrl"></c:url>
														 <audio src="${messAvaUrl}" controls loop> 
	    												 </audio>
	    												 <br/><strong> ${i.messMedia.fileName}</strong>
														 <hr class='registrationForm'>
													 </c:if>
												</c:if>
												<br />
												<div style="padding-left: 100px;">
													<p>${i.text}</p>
												</div>
											</div>
											<div>
												<hr>
											</div>
																	
																																					<!-- Comments -->
											<c:forEach items="${i.comments}" var="j" varStatus="status">
												<div class="comments-list" id = "comments-list${j.id}">
													<c:if test="${userInfo.username eq userOwner ||  j.author.username eq userOwner}" >   
															<a href="" class="remove-comment-icon btn" style="float:right;"  id = "${j.id}" >
																		<i class="glyphicon glyphicon-remove" ></i> 
															</a>
													</c:if>
												
													<div class="media">
														<p class="pull-right">
															<small><fmt:formatDate pattern="dd-MMM-yyyy hh:mm" value="${j.date}" /></small>
														</p>
														<c:url value="/list/${j.author.username}/imageDisplay?scale=true&w=80&h=80"	var="avaCommentUrl"></c:url>
														<div class="media-left">
															<img src="${avaCommentUrl}" width="40px" height="40px">
														</div>
														<div class="media-body">

															<h4 class="media-heading user_name">${j.author.firstName}
																${j.author.lastName}
															</h4>
															${j.text }
														</div>
													</div>
												</div>


											</c:forEach>
											<div class="appendComment${i.id}"></div>
																																				<!--Add new comment bar-->

											<div class="panel-footer">
												<div class="input-placeholder">Add a comment...</div>
											</div>
											<c:url value="/list/${userInfo.username}/addComment/${i.id}" var="commentUrl"></c:url>
											<form action="" class="panel-google-plus-comment"
												id="${i.id}">
												<img class="img-circle"	src="https://lh3.googleusercontent.com/uFp_tsTJboUY7kue5XAsGA=s46"	alt="User Image" />
												<div class="panel-google-plus-textarea">
													<textarea rows="4" id="comment${i.id}"	name="comment-textarea"></textarea>
													<button type="submit" class="[ btn btn-success disabled]"><spring:message code="label.comment.add" /></button>
													<button type="reset" class="[ btn btn-default ]"><spring:message code="label.comment.cancel" /></button>
												</div>
											</form>
											<div class="clearfix"></div>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</div>

	<c:import url="footer.jsp"></c:import>

	<c:url	value="${pageContext.request.contextPath}/list/${userOwner}/getTags"	var="temp"></c:url>
	
		
																													<!-- Autocomplete in search field -->
<script>
	$(document).ready(function() {
		$('#w-input-search').autocomplete({
			serviceUrl: '${pageContext.request.contextPath}/list/${userOwner}/getTags',
			paramName: "tagName",
			delimiter: ",",
			minLength: 3,
		    transformResult: function(response) {
		    	
		        return { suggestions: $.map($.parseJSON(response), function(item) {
		                return { 
		                	value: item.firstName + "  " + item.lastName, 
		                	data:item.firstName + " " +item.lastName };
		            })
		            
		        };
		    }
		});
	});
</script>
	
	
																											<!-- Remove comment to message -->	
<script type="text/javascript">
	$(document).ready(function(){
	
		 $(document).on('click', '.remove-comment-icon' ,function(event) { 
			 event.preventDefault();
			 var commentId = this.id; 
			$.ajax({
				url: "${pageContext.request.contextPath}/list/${userInfo.username}/removeComment/"+commentId ,
				data:{				},
				type: 'POST',
				
				success: function(data){
					var respContent = "";
					$('#comments-list' + commentId).html(respContent)
				},
				error: function(xhr, status, errorThrown){
					alert('failed with status' + status + ". " + errorThrown);
				}
			});
		});
	});
	
</script>
	
	

																											<!-- Add comment to message -->	
<script type="text/javascript">
	$('.containerTwits').ready(function(){
	
		 $("form.panel-google-plus-comment").submit(function(event) { 
			 event.preventDefault();
				var messageId = this.id;
				var commentText= $('#comment'+messageId).val();

			$.ajax({
			
				url: "${pageContext.request.contextPath}/list/${userOwner}/addComment",
				data:{commentText : commentText,
					  messageId : messageId	
					},
				type: 'POST',
				
				success: function(data){
					  var monthNames = [
					                    "Jan", "Feb", "Mar",
					                    "Apl", "May", "June", "July",
					                    "Aug", "Sept", "Oct",
					                    "Nov", "Dec"
					                ];
					
					 var text = data.text;
					 var date = data.dateOfBirth;
					 var username = data.author.username;
					 var firstName = data.author.firstName;
					 var lastName = data.author.lastName; 
					 var time = new Date().getTime();
					 var d = new Date(time);
					 var respContent = "";
					 
				 	 respContent += "<div class='comments-list' 	id = 'comments-list" + data.id + "'> ";
					 respContent += "<a href='' class='remove-comment-icon btn' style='float:right;'  id = '" + data.id + "' >";
					 respContent += "<i class='glyphicon glyphicon-remove' ></i> <strong></strong> 	</a> ";
					 respContent +="<div class='media'> <p class='pull-right'>";
					 respContent +="<small>"+d.getDate()+"-"+ monthNames[d.getMonth()] + "-" + d.getFullYear()+ " "+ d.getHours()+":" +d.getMinutes()+"</small> </p>"
					 respContent +="<c:url value='/list/" + username  + "/imageDisplay?scale=true&w=80&h=80' var='avaCommentUrl'></c:url>";
					 respContent +="<div class='media-left'  >  <img src='${avaCommentUrl}' width='40px' height='40px'> </div> 	<div class='media-body'> ";
					 respContent +="<h4 class='media-heading user_name'>" +firstName + " "+ lastName + "</h4>";
					 respContent += text + " </div> </div> </div>";
					
					document.getElementById('comment'+messageId).value='';
					
					$(".appendComment"+messageId).append(respContent);    
				},
				error: function(xhr, status, errorThrown){
					alert('failed with status' + status + ". " + errorThrown);
				}
			});
		});
	});
	
</script>

																																<!-- Validate subscribe button-->
<script type="text/javascript">
	$(document).ready(function(){
		var bv;
		$('div#subscribeOff').hide();
		$('div#subscribeOn').hide();
			
		 $("button.subscribeIs").click(function(event) { 
			var username = "${userInfo.username}";
			$('div#subscribeIs').hide();
			var urlname = '';
			var val = this.id;
			var respContent = "";
			if(val == 'subscribeOn') {
				urlname = '${pageContext.request.contextPath}/list/${userInfo.username}/addFriend';
				$('div#subscribeOn').hide();
				$('div#subscribeOff').show();
			}
			
			if(val == 'subscribeOff') {
				urlname = '${pageContext.request.contextPath}/list/${userInfo.username}/removeFriend';
				$('div#subscribeOn').show();
				$('div#subscribeOff').hide();
			}
		
			$.ajax({
				url: urlname,
				
				data:{username : username	},
				type: 'GET',
				success: function(){
				},
				error: function(xhr, status, errorThrown){
					alert('failed with status' + status + ". " + errorThrown);
				}
			});
		});
	});
	
</script>

<script type="text/javascript">
$('#uploadFile').bind('change', function() {

	  //this.files[0].size gets the size of your file.
	  if(this.files[0].size > 50*1024*1024){
	  	alert('file cant bet more 50MB');
	  	document.getElementById("uploadFile").value = "";
	  }
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

	<script	src="${pageContext.request.contextPath}/resources/js/jquery.validate.js"></script>
	<script	src="${pageContext.request.contextPath}/resources/js/bootstrap.js"></script>
	<script	src="${pageContext.request.contextPath}/resources/js/comment.js"></script>

</body>
</html>