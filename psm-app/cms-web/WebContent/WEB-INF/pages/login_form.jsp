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
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp"%>
<form id="loginForm" action="<c:url value='/login'/>" method="post">
  <sec:csrfInput />
  <div class="loginPanel">
    <h:handlebars template="includes/flash" context="${pageContext}"/>

    <c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION.message}">
      <div class="errorInfo" style="display: block;">
        <h3>
          Invalid username and/or password.
          <br>
          ${SPRING_SECURITY_LAST_EXCEPTION.message}
        </h3>
        <div class="tl"></div>
        <div class="tr"></div>
        <div class="bl"></div>
        <div class="br"></div>
      </div>
      <% session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION); %>
    </c:if>

    <div class="row">
      <label for="username" class="label">Username</label>
      <input id="username"
             name="username"
             type="text"
             class="text"
             value="${LAST_USERNAME}"
             maxlength="50"
             autofocus />
    </div>
    <div class="row">
      <label for="password" class="label">Password</label>
      <input id="password" type="password" name="password" />
    </div>
    <div class="row">
      <label class="label">&nbsp;</label>
      <input id="remember" type="checkbox" name="keepUserSignedIn"/>
      <label for="remember">Remember Me</label>
      <a class="forgotPasswordLink" href="<c:url value="/forgotpassword" />">Forgot Password?</a>
    </div>
    <div class="buttons">
      <button id="btnLogin" class="purpleBtn" type="submit">Login</button>
      <a class="registerNewAccountLink" href="<c:url value="/accounts/new" />">Register New Account</a>
    </div>

    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
  </div>
</form>