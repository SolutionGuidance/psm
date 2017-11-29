<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="h" tagdir="/WEB-INF/tags" %>
<c:choose>
  <c:when test="${principalUser ne null}">
    <html xmlns="http://www.w3.org/1999/xhtml" lang="en-US" xml:lang="en-US">
      <c:set var="title" value="Server Error"/>
      <h:handlebars template="includes/html_head" context="${pageContext}"/>
      <body>
        <div id="wrapper">
          <h:handlebars template="includes/header" context="${pageContext}"/>
          <!-- /#header -->

          <div id="mainContent">
            <div class="contentWidth">
              <div class="mainNav">
                <h:handlebars template="includes/logo" context="${pageContext}"/>
                <c:set var="activeTab" value="1"/>
                <h:handlebars template="includes/nav" context="${pageContext}"/>
              </div>
              <!-- /.mainNav -->
              <div class="breadCrumb">&nbsp;</div>
              <h1>Error</h1>
              <div class="tabSection">
                <div class="detailPanel">
                  <div class="section" id="updateProfile">
                    <div class="wholeCol">
                      <div class="row">
                        <h3>Server Error</h3>
                        <p style="color: #c00;">
                          An error has been occurred while processing your request, please contact 1-800-1010-2010 for any concerns.
                        </p>
                      </div>
                    </div>
                  </div>
                  <!-- /.section -->
                  <div class="tl"></div>
                  <div class="tr"></div>
                  <div class="bl"></div>
                  <div class="br"></div>
                </div>
              </div>
            </div>
          </div>
          <!-- /#mainContent -->

          <h:handlebars template="includes/footer" context="${pageContext}"/>
          <!-- #footer -->
          <div class="clear"></div>
        </div>
        <!-- /#wrapper -->
        <!-- /#modalBackground-->
        <div id="modalBackground"></div>
        <div id="new-modal">

          <%@include file="/WEB-INF/pages/provider/enrollment/steps/modal/print_modal.jsp" %>

        </div>
      </body>
    </html>
  </c:when>
  <c:otherwise>
    <%@page import="org.springframework.security.web.WebAttributes"%>
    <html xmlns="http://www.w3.org/1999/xhtml" lang="en-US" xml:lang="en-US">
      <c:set var="title" value="Login"/>
      <c:set var="ctx" value="${pageContext.request.contextPath}"/>
      <h:handlebars template="includes/html_head" context="${pageContext}"/>
      <body>
        <div id="wrapper">
          <div id="header">
            <div class="contentWidth"></div>
            <!-- /.contentWidth -->
          </div>
          <!-- /#header -->
          <!-- start of error message -->
          <div id="errorbar">
            <div class="contentWidth">
              An error has been occurred while processing your request, please contact 1-800-1010-2010 for any concerns.
            </div>
          </div>
          <!-- end of error message -->

          <div id="mainContent">
            <div class="contentWidth">
              <div class="mainNav">
                <h:handlebars template="includes/logo" context="${pageContext}"/>
              </div>
              <!-- /.mainNav -->
              <form id="loginForm" action="<c:url value='login'/>" method="post">
                <sec:csrfInput />
                <div class="loginPanel">
                  <h:handlebars template="includes/flash" context="${pageContext}"/>

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
                    <label class="label">Username:</label>
                    <input type="text" name="username" class="text" id="username" value="${LAST_USERNAME}" maxlength="50"/>
                  </div>
                  <div class="row">
                    <label class="label">Password:</label>
                    <input type="password" name="password" id="password"/>
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
                    <input type="checkbox" id="remember" name="keepUserSignedIn"/>
                    <label for="remember">Remember Me</label>
                    <a href="<c:url value="/forgotpassword" />">Forgot Password?</a>
                  </div>
                  <div class="buttons">
                    <a href="javascript:;" id="btnLogin" class="purpleBtn">
                      <span class="btR">
                        <span class="btM">Login</span>
                      </span>
                    </a>
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
  </c:otherwise>
</c:choose>
