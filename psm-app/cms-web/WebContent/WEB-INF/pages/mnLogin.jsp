<%--
  Copyright 2018 The MITRE Corporation
  
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at
  
      http://www.apache.org/licenses/LICENSE-2.0
  
  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
--%>
<!DOCTYPE html>
<%@page import="org.springframework.security.web.WebAttributes"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="h" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<html lang="en-US">
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
            <h:handlebars template="includes/banner" context="${pageContext}"/>
          </div>

          <form id="loginForm" action="<c:url value='/login'/>" method="post">
            <sec:csrfInput />
            <div class="loginPanel">
              <p>
                This is a mockup for requests coming from an internal site. Fill up the expected data below and submit.
              </p>
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
                <label for="mnLoginUserNPI" class="label">NPI (user)</label>
                <input id="mnLoginUserNPI" type="text" name="userNPI" class="text"/>
              </div>
              <div class="row">
                <label for="mnLoginProfileNPI" class="label">NPI (profile)</label>
                <input id="mnLoginProfileNPI" type="text" name="profileNPI" class="text"/>
              </div>

              <p>
                The next two tokens should match the configured values EXACTLY
              </p>
              <div class="row">
                <label for="mnLoginToken" class="label">Token</label>
                <input id="mnLoginToken" type="text" name="token" class="text" value="providerapplication"/>
              </div>
              <div class="row">
                <label for="mnLoginReferrer" class="label">Referrer</label>
                <input id="mnLoginReferrer" type="text" name="referrer" class="text" value="localhost"/>
              </div>
              <div class="buttons">
                <button id="btnLogin" class="purpleBtn" type="submit">Login</button>
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
