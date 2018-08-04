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
 The advanced search results page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<c:set value="false" var="isUpdateUser"></c:set>
<c:set value="false" var="hasArrow"></c:set>
<c:set var="formIdPrefix" value="advanced_search_system_admin"></c:set>

<!DOCTYPE html>
<html lang="en-US">
  <c:set value="Advanced Search (System Admin)" var="title"></c:set>
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
            <span class="text">Advanced Search</span>
          </div>
          <h1>Advanced Search</h1>
          <div class="systemAdminFrom">
            <form cssClass="tabSection" id="advancedSearch" action="${ctx}/system/search/list" method="post">
              <sec:csrfInput />
              <div class="detailPanel">
                <div class="section">
                  <div class="leftCol">
                    <div class="row">
                      <label for="${formIdPrefix}_username">Username</label>
                      <input id="${formIdPrefix}_username" type="text" class="normalInput" name="username"/>
                    </div>
                    <div class="row">
                      <label for="${formIdPrefix}_last_name">Last Name</label>
                      <input id="${formIdPrefix}_last_name" type="text" class="normalInput" name="lastName"/>
                    </div>
                    <div class="row">
                      <label for="${formIdPrefix}">First Name</label>
                      <input id="${formIdPrefix}_first_name" type="text" class="normalInput" name="firstName"/>
                    </div>
                  </div>
                  <!-- /.leftCol -->
                  <div class="rightCol">
                    <div class="row checkRow">
                      <label for="${formIdPrefix}_email">Email</label>
                      <div class="checkWrapper">
                        <input id="${formIdPrefix}_email" type="text" class="normalInput" name="email"/>
                      </div>
                    </div>
                    <div class="row checkRow">
                      <label>Role</label>
                      <div class="checkMain">
                        <div class="checkWrapper">
                          <input id="${formIdPrefix}_role_all" type="checkbox" id="requestType" class="checkAll" />
                          <label for="${formIdPrefix}_role_all" class="minWidth">All</label>
                          <input id="${formIdPrefix}_role_service_agent" type="checkbox" name="roles" value="Service Agent" />
                          <label for="${formIdPrefix}_role_service_agent" class="label">Service Agent</label>
                          <input id="${formIdPrefix}_role_system_administrator" type="checkbox" name="roles" value="System Administrator" />
                          <label for="${formIdPrefix}_role_system_administrator" class="label">System Administrator</label>
                          <div class="clearFixed"></div>
                          <input id="${formIdPrefix}_role_provider" type="checkbox" name="roles" value="Provider" />
                          <label for="${formIdPrefix}_role_provider" class="minWidth">Provider</label>
                          <input id="${formIdPrefix}_service_administrator" type="checkbox" name="roles" value="Service Administrator" />
                          <label for="${formIdPrefix}_service_administrator" class="label">Service Administrator</label>
                        </div>
                      </div>
                    </div>
                  </div>
                  <input type="hidden" id="and" name="and" value="true" />
                  <input type="hidden" id="pageSize" name="pageSize" value="10" />
                  <input type="hidden" id="pageNumber" name="pageNumber" value="1" />
                  <input type="hidden" id="sortColumn" name="sortColumn" value="" />
                  <input type="hidden" id="ascending" name="ascending" value="true" />
                  <input type="hidden" id="showFilterPanel" name="showFilterPanel" value="false" />
                  <!-- /.rightCol -->
                  <div class="clearFixed"></div>
                </div>
                <!-- /.section -->
                <div class="tl"></div>
                <div class="tr"></div>
              </div>
              <div class="clearFixed"></div>
              <div class="buttons">
                <button class="purpleBtn" type="submit"><span class="icon">Search</span><span class="arrow"></span></button>
              </div>
            </form>
            <!-- /.tabSection -->
          </div>
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
