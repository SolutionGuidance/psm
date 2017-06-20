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
					<!-- /.mainNav -->
                    <form id="loginForm" action="<c:url value='j_spring_security_check'/>" method="post">
						<div class="loginPanel">
                            <%@include file="/WEB-INF/pages/includes/flash.jsp" %>
                            
                            <c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION.message}">
								<div class="errorInfo" style="display: block;">
									<h3>${SPRING_SECURITY_LAST_EXCEPTION.message}</h3>
									<div class="tl"></div>
									<div class="tr"></div>
									<div class="bl"></div>
									<div class="br"></div>
								</div>
								<% session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION); %>
                            </c:if>
						
							<div class="row">
								<label class="label">Username:</label>
								<input type="text" name="j_username" class="text" id="username" value="${SPRING_SECURITY_LAST_USERNAME}" maxlength="50"/>
							</div>
							<div class="row">
								<label class="label">Password:</label>
								<input type="password" name="j_password" id="password" />
							</div>
                            <div class="row">
                                <label class="label">Domain:</label>
                                <select name="domain" onchange="disableElement('remember', this.value != 'CMS_ONLINE')">
                                    <option value="CMS_ONLINE" selected="selected">Online Portal</option>
                                    <option value="MN_ITS">MN-ITS</option>
                                </select>
                            </div>
							<div class="row">
	                            <label class="label">&nbsp;</label>
	                            <input type="checkbox" id="remember" name="keepUserSignedIn" />
	                            <label for="remember">Remember Me</label>
								<a href="<c:url value="/forgotpassword" />">Forgot Password?</a>
							</div>
							<div class="buttons">
								<a href="javascript:;" id="btnLogin" class="purpleBtn"><span class="btR"><span class="btM">Login</span></span></a>
                                <a href="<c:url value="/accounts/new" />" class="">Register New Account</a>
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
