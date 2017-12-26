<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@page import="org.springframework.security.web.WebAttributes"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="h" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en-US" xml:lang="en-US">
  <c:set var="title" value="Login"/>
  <h:handlebars template="includes/html_head" context="${pageContext}"/>
  <body>
    <div id="wrapper">
      <div id="header">
        <div class="contentWidth"></div>
        <!-- /.contentWidth -->
      </div>
      <!-- /#header -->

      <div id="mainContent">
        <div class="contentWidth">
          <div class="mainNav">
            <h:handlebars template="includes/logo" context="${pageContext}"/>
          </div>
          <!-- /.mainNav -->
          <form id="loginForm" action="<c:url value='/login'/>" method="post">
            <sec:csrfInput />
            <div class="loginPanel">
              <h:handlebars template="includes/flash" context="${pageContext}"/>

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
                <label for="username" class="label">Username:</label>
                <input id="username" name="username" type="text" class="text" value="${LAST_USERNAME}" maxlength="50"/>
              </div>
              <div class="row">
                <label for="password" class="label">Password:</label>
                <input id="password" type="password" name="password" />
              </div>
              <div class="row">
                <label for="domain" class="label">Domain:</label>
                <select id="domain" name="domain" onchange="disableElement('remember', this.value != 'CMS_ONLINE')">
                  <option value="CMS_ONLINE" selected="selected">Online Portal</option>
                  <option value="MN_ITS">MN-ITS</option>
                </select>
              </div>
              <div class="row">
                <label class="label">&nbsp;</label>
                <input id="remember" type="checkbox" name="keepUserSignedIn"/>
                <label for="remember">Remember Me</label>
                <a href="<c:url value="/forgotpassword" />">Forgot Password?</a>
              </div>
              <div class="buttons">
                <button id="btnLogin" class="purpleBtn" type="submit">Login</button>
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

      <h:handlebars template="includes/footer" context="${pageContext}"/>
    </div>
    <!-- /#wrapper -->
  </body>
</html>

<!-- login form -->
