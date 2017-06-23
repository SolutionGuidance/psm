<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@page import="org.springframework.security.web.WebAttributes"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="/WEB-INF/pages/includes/html_head.jsp" %>
		<title>Login</title>
	</head>
	<body>
		<div id="wrapper">
			<div id="header">
				<div class="contentWidth">
				</div>
				<!-- /.contentWidth -->
			</div>
			<!-- /#header -->

			<div id="mainContent">
				<div class="contentWidth">
					<div class="mainNav">
						<%@include file="/WEB-INF/pages/includes/logo.jsp" %>
					</div>
					
                    <form id="loginForm" action="<c:url value='j_spring_security_check'/>" method="post">
						<div class="loginPanel">
							<p>
								This is a mockup for requests coming from an internal site. 
								Fill up the expected data below and submit.
							</p>
                            <%@include file="/WEB-INF/pages/includes/flash.jsp" %>
                            
                            <c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION.message}">
								<div class="errorInfo" style="display: block;">
									<h3>Invalid username/password.</h3>
									<div class="tl"></div>
									<div class="tr"></div>
									<div class="bl"></div>
									<div class="br"></div>
								</div>
								<% session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION); %>
                            </c:if>
						
							<div class="row">
								<label class="label">NPI (user)</label>
								<input type="text" name="userNPI" class="text" id="userNPI" />
							</div>
							<div class="row">
								<label class="label">NPI (profile)</label>
								<input type="text" name="profileNPI" class="text" id="profileNPI" />
							</div>
							
							<p>
								The next two tokens should match the configured values EXACTLY
							</p>
							<div class="row">
								<label class="label">Token</label>
								<input type="text" name="token" class="text" id="token" value="providerenrollment" />
							</div>
							<div class="row">
								<label class="label">Referrer</label>
								<input type="text" name="referrer" class="text" id="referrer" value="localhost"/>
							</div>
							<div class="buttons">
								<a href="javascript:;" id="btnLogin" class="purpleBtn"><span class="btR"><span class="btM">Login</span></span></a>
							</div>
							<div class="tl"></div>
							<div class="tr"></div>
							<div class="bl"></div>
							<div class="br"></div>
						</div>
                    </form>					
				</div>
			</div>
			<!-- /#mainContent -->

            <%@include file="/WEB-INF/pages/includes/footer.jsp" %>
		</div>
		<!-- /#wrapper -->
	</body>
</html>


                	<!-- login form -->
