<%--
  Copyright 2012 TopCoder Inc.
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
<%--
 The edit user account page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<c:set value="true" var="isUpdateUser"></c:set>
<c:set value="true" var="hasArrow"></c:set>

<!DOCTYPE html>
<html lang="en-US">
  <c:choose>
    <c:when test="${not empty user.userId}">
      <c:set value="Edit User Account (System Admin)" var="title"></c:set>
    </c:when>
    <c:otherwise>
      <c:set value="Create New User Account (System Admin)" var="title"></c:set>
    </c:otherwise>
  </c:choose>
  <h:handlebars template="includes/html_head" context="${pageContext}" />
  <body>
    <div id="wrapper">
      <h:handlebars template="includes/header" context="${pageContext}" />
      <div id="mainContent" <c:if test='${isUpdateUser}'>class="detailPage"</c:if>>
        <div class="contentWidth">
          <div class="mainNav">
            <h:handlebars template="includes/logo" context="${pageContext}"/>
            <h:handlebars template="includes/banner" context="${pageContext}"/>
            <h:handlebars template="includes/nav" context="${pageContext}"/>
          </div>

          <c:choose>
            <c:when test="${not empty user.userId}">
              <div class="breadCrumb">
                <a href="<c:url value='/system/user/list' />">User Accounts</a>
                <a href="<c:url value='/system/user/details?role=${role }&userId=${user.userId}' />">User Account Details</a>
                <span>Edit User Account</span>
              </div>
            </c:when>
            <c:otherwise>
              <div class="breadCrumb">
                <a href="<c:url value='/system/user/list' />">User Accounts</a>
                <span>Create New User Account</span>
              </div>
            </c:otherwise>
          </c:choose>

          <div class="head">
            <c:choose>
              <c:when test="${not empty user.userId}">
                <h1 class="text">Edit User Account</h1>
              </c:when>
              <c:otherwise>
                <h1 class="text">Create New User Account</h1>
              </c:otherwise>
            </c:choose>
          </div>

          <c:choose>
            <c:when test='${not empty user.userId}'><c:url value='/system/user/edit?roleName=${role }' var='updateURL' /></c:when>
            <c:otherwise><c:url value='/system/user/new?roleName=${role }' var='updateURL' /></c:otherwise>
          </c:choose>
          <div class="tabSection">
            <form:form commandName="user" action="${updateURL}" modelAttribute="user">
              <spring:hasBindErrors name="user">
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
                  <input type="hidden" name="status" value="ACTIVE" />
                  <form:hidden path="userId"/>
                  <div class="wholeCol">
                    <div class="row">
                      <label for="newUsername">Username</label>
                      <form:input id="newUsername" cssClass="normalInput" path="username" />
                    </div>
                    <div class="row">
                      <label for="newPassword">Password</label>
                      <input type="password" id="newPassword" class="passwordNormalInput" value="" name="password" />
                    </div>
                    <div class="row">
                      <label for="newConfirmPassword">Confirm Password</label>
                      <input type="password" id="newConfirmPassword" class="passwordNormalInput" value="" name="password2"/>
                    </div>
                    <div class="row">
                      <label for="firstName">First Name</label>
                      <form:input id="firstName" cssClass="normalInput" path="firstName" />
                    </div>
                    <div class="row">
                      <label for="middleName">Middle Name</label>
                      <form:input id="middleName" cssClass="normalInput" path="middleName" />
                    </div>
                    <div class="row">
                      <label for="lastName">Last Name</label>
                      <form:input id="lastName" cssClass="normalInput" path="lastName" />
                    </div>
                    <div class="row">
                      <label for="email">Email</label>
                      <form:input id="email" cssClass="normalInput" path="email" />
                    </div>
                    <div class="row">
                      <label for="apiRead">API Read Access</label>
                      <form:checkbox id="apiRead" path="apiRead" />
                    </div>
                    <div class="row">
                      <label for="apiWrite">API Write Access</label>
                      <form:checkbox id="apiWrite" path="apiWrite" />
                    </div>
                    <div class="row">
                      <label for="userRole">User Role</label>
                      <form:select id="userRole" cssClass="userRoleSelect" path="role.description">
                        <form:option value="" >Please Select</form:option>
                        <c:forEach items="${availableRoles }" var="r">
                          <form:option value="${r.description}" >${r.description}</form:option>
                        </c:forEach>
                      </form:select>
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
                <a href="<c:url value='/system/user/list' />" class="greyBtn">Cancel</a>
                <button class="purpleBtn" type="submit">Save</button>
              </div>
              <!-- /.buttonBox -->
            </form:form>
          </div>
          <!-- /.tabSection -->
        </div>
      </div>
      <!-- /#mainContent -->
      <h:handlebars template="includes/footer" context="${pageContext}"/>
      <!-- #footer -->
      <div class="clear"></div>
    </div>
    <!-- /#wrapper -->
    <%@ include file="/WEB-INF/pages/admin/includes/modal.jsp" %>
    <input type="hidden" value="<c:url value='/admin/user/list' />" id="userAccountsURL" />
  </body>
</html>
