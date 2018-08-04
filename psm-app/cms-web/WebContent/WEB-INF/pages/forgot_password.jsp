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
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="h" tagdir="/WEB-INF/tags" %>
<html lang="en-US">
  <c:set var="title" value="Forgot Password"/>
  <h:handlebars template="includes/html_head" context="${pageContext}"/>
  <body>
    <div id="wrapper">
      <div id="header">
        <div class="contentWidth"></div>
        <!-- /.contentWidth -->
      </div>
      <!-- /#header -->

      <div id="mainContent" class="detailPage">
        <div class="contentWidth">
          <div class="mainNav">
            <h:handlebars template="includes/logo" context="${pageContext}"/>
            <h:handlebars template="includes/banner" context="${pageContext}"/>
          </div>
          <!-- /.mainNav -->
          <div class="head">
            <h1 class="text">Forgot Password</h1>
          </div>
          <h:handlebars template="includes/flash" context="${pageContext}"/>

          <div class="tabSection">
            <form:form commandName="passwordForm" id="passwordForm">
              <spring:hasBindErrors name="passwordForm">
                <div class="errorInfo" style="display: block;">
                  <h3>Please correct the following errors:</h3>
                  <form:errors path="*"></form:errors>
                  <div class="tl"></div>
                  <div class="tr"></div>
                  <div class="bl"></div>
                  <div class="br"></div>
                </div>
              </spring:hasBindErrors>
              <div class="detailPanel">
                <div class="section" id="updateProfile">
                  <div class="wholeCol">
                    <div class="row">
                      <label for="forgotPasswordUsername">Username <span class="required">*</span></label>
                      <c:set var="errorCls" value=""/>
                      <spring:bind path="username">
                        <c:if test="${status.error}"><c:set var="errorCls" value="errorInput"/></c:if>
                      </spring:bind>
                      <form:input id="forgotPasswordUsername" path="username" cssClass="normalInput ${errorCls}"/>
                    </div>
                    <div class="row">
                      <label for="forgotPasswordEmail">Email <span class="required">*</span></label>
                      <c:set var="errorCls" value=""/>
                      <spring:bind path="email">
                        <c:if test="${status.error}"><c:set var="errorCls" value="errorInput"/></c:if>
                      </spring:bind>
                      <form:input id="forgotPasswordEmail" path="email" cssClass="normalInput ${errorCls}"/>
                    </div>
                  </div>
                </div>
                <!-- /.section -->
                <div class="tl"></div>
                <div class="tr"></div>
                <div class="bl"></div>
                <div class="br"></div>
              </div>
              <div class="buttonBox">
                <a href="<c:url value="/login" />" class="greyBtn">
                  Cancel
                </a>
                <button class="purpleBtn" type="submit">Reset Password</button>
              </div>
              <!-- /.buttonBox -->
            </form:form>
          </div>
          <!-- /.tabSection -->
        </div>
      </div>
      <!-- /#mainContent -->

      <h:handlebars template="includes/footer" context="${pageContext}"/>
    </div>
    <!-- /#wrapper -->
  </body>
</html>
