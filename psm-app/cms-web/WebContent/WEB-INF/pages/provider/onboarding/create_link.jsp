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
  <c:set var="title" value="${pageTitle}"/>
  <h:handlebars template="includes/html_head" context="${pageContext}"/>
  <body>
    <div id="wrapper">
      <h:handlebars template="includes/header" context="${pageContext}"/>
      <!-- /#header -->

      <div id="mainContent" class="detailPage">
        <div class="contentWidth">
          <div class="mainNav">
            <h:handlebars template="includes/logo" context="${pageContext}"/>
            <h:handlebars template="includes/banner" context="${pageContext}"/>
            <h:handlebars template="includes/nav" context="${pageContext}"/>
          </div>
          <!-- /.mainNav -->
          <div class="breadCrumb">
            <a class="accountSetupLink" href="<c:url value="/provider/dashboard/setup" />">Account Setup</a>
            <span class="text">Account Details</span>
          </div>
          <div class="head">
            <h1>Enter Account Details</h1>
          </div>

          <div class="tabSection">
            <form:form commandName="accountLink" id="accountLinkForm">
              <spring:hasBindErrors name="accountLink">
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
                <div id="updateProfile" class="section">
                  <div class="wholeCol">
                    <div class="row">
                      <label>System</label>

                      <c:set var="errorCls" value=""/>
                      <spring:bind path="systemId">
                        <c:if test="${status.error}"><c:set var="errorCls" value="errorInput"/></c:if>
                      </spring:bind>
                      <form:select path="systemId" cssClass="longSelect ${errorCls}">
                        <form:option value="MN_ITS">MN-ITS</form:option>
                      </form:select>
                    </div>
                    <div class="row">
                      <label for="createLinkAccountId">Account Id</label>

                      <c:set var="errorCls" value=""/>
                      <spring:bind path="accountId">
                        <c:if test="${status.error}"><c:set var="errorCls" value="errorInput"/></c:if>
                      </spring:bind>
                      <form:input id="createLinkAccountId" path="accountId" cssClass="normalInput ${errorCls}"/>
                    </div>
                    <div class="row">
                      <label for="createLinkPassword">Password</label>

                      <c:set var="errorCls" value=""/>
                      <spring:bind path="password">
                        <c:if test="${status.error}"><c:set var="errorCls" value="errorInput"/></c:if>
                      </spring:bind>
                      <form:password id="createLinkPassword" path="password" cssClass="passwordNormalInput ${errorCls}"/>
                    </div>
                  </div>
                  <div class="buttonBox">
                    <a href="<c:url value="/provider/dashboard/setup" />" class="greyBtn">
                      Cancel
                    </a>
                    <button class="purpleBtn" type="submit">Get Profiles</button>
                  </div>
                </div>
                <!-- /.section -->
                <div class="tl"></div>
                <div class="tr"></div>
                <div class="bl"></div>
                <div class="br"></div>
              </div>
            </form:form>
          </div>
        </div>
      </div>
      <!-- /#mainContent -->

      <h:handlebars template="includes/footer" context="${pageContext}"/>
      <!-- #footer -->
    </div>
    <!-- /#wrapper -->
  </body>
</html>
