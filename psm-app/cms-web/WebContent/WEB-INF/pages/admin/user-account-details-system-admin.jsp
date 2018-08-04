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
 The user account details page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<c:set value="false" var="isUpdateUser"></c:set>
<c:set value="true" var="hasArrow"></c:set>

<!DOCTYPE html>
<html lang="en-US">
  <c:set value="User Account Details (System Admin)" var="title"></c:set>
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

          <div class="breadCrumb">
            <a href="<c:url value='/system/user/list' />">User Accounts</a>
            <span>User Account Details</span>
          </div>
          <div class="head">
            <h1 class="text">User Account Details</h1>
            <a href="javascript:;" class="greyBtn deleteUserAccountModalBtnSingle iconXRed" rel="${user.userId}">Delete User Account</a>
            <a href="<c:url value='/system/user/edit?role=${role}&userId=${user.userId}' />" class="purpleBtn">Edit User Account</a>
          </div>
          <div class="tabSection" id="myProfile">
            <div class="detailPanel">
              <div class="section">
                <div class="wholeCol">
                  <div class="row">
                    <label>Username</label>
                    <span>${user.username}</span>
                  </div>
                  <div class="row">
                    <label>Password</label>
                    <span>********</span>
                  </div>
                  <div class="row">
                    <label>First Name</label>
                    <span>${user.firstName}</span>
                  </div>
                  <div class="row">
                    <label>Middle Name</label>
                    <span>${user.middleName}</span>
                  </div>
                  <div class="row">
                    <label>Last Name</label>
                    <span>${user.lastName}</span>
                  </div>
                  <div class="row">
                    <label>Email</label>
                    <span>${user.email}</span>
                  </div>
                  <div class="row">
                    <label>API Read Access</label>
                    <span>${user.apiRead ? "Yes" : "No"}</span>
                  </div>
                  <div class="row">
                    <label>API Write Access</label>
                    <span>${user.apiWrite ? "Yes" : "No"}</span>
                  </div>
                  <div class="row">
                    <label>User Role</label>
                    <span>${user.role.description}</span>
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
    <input type="hidden" value="<c:url value='/system/user/delete' />" id="deleteAccountsURL" />
  </body>
</html>
