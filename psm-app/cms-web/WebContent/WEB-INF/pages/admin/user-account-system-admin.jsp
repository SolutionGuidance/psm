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
 The user accounts page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<c:set value="false" var="isUpdateUser"></c:set>
<c:set value="true" var="hasArrow"></c:set>

<!DOCTYPE html>
<html lang="en-US">
  <c:set value="User Account (System Admin)" var="title"></c:set>
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
            User Accounts
          </div>
          <h1>User Accounts</h1>
          <div class="tabSection" id="userAccountsTab">
            <div class="tabHead">
              <div class="tabR">
                <div class="tabM">
                  <a class="tabLink <c:choose>
                  <c:when test='${role eq "Provider" }'>active"</c:when>
                  <c:otherwise>" href="<c:url value='/system/user/search?role=Provider' />"</c:otherwise>
                  </c:choose>
                  ><span class="aR"><span class="aM">Providers</span></span></a>
                  <a class="tabLink <c:choose>
                  <c:when test='${role eq "Service Agent" }'>active"</c:when>
                  <c:otherwise>" href="<c:url value='/system/user/search?role=Service Agent' />"</c:otherwise>
                  </c:choose>
                  ><span class="aR"><span class="aM">Service Agents</span></span></a>
                  <a class="tabLink <c:choose>
                  <c:when test='${role eq "Service Administrator" }'>active"</c:when>
                  <c:otherwise>" href="<c:url value='/system/user/search?role=Service Administrator' />"</c:otherwise>
                  </c:choose>
                  ><span class="aR"><span class="aM">Service Administrators</span></span></a>
                  <a class="tabLink <c:choose>
                  <c:when test='${role eq "System Administrator" }'>active"</c:when>
                  <c:otherwise>" href="<c:url value='/system/user/search?role=System Administrator' />"</c:otherwise>
                  </c:choose>
                  ><span class="aR"><span class="aM">System Administrators</span></span></a>
                  <a class="purpleBtn" href="<c:url value='/system/user/new?role=${role}' />">Create New User Account</a>
                </div>
              </div>
            </div>
            <!-- /.tabHead -->
            <c:if test='${role eq "Provider" }'>
              <div class="tabContent" id="tabProviders">
                <%@ include file="/WEB-INF/pages/admin/includes/user_accounts_table.jsp" %>
              </div>
            </c:if>
            <!-- /#tabProviders -->
            <c:if test='${role eq "Service Agent" }'>
              <div class="tabContent " id="tabServiceAgents">
                <%@ include file="/WEB-INF/pages/admin/includes/user_accounts_table.jsp" %>
              </div>
            </c:if>
            <!-- /#tabServiceAgents -->
            <c:if test='${role eq "Service Administrator" }'>
              <div class="tabContent " id="tabServiceAdministrators">
                <%@ include file="/WEB-INF/pages/admin/includes/user_accounts_table.jsp" %>
              </div>
            </c:if>
            <!-- /#tabServiceAdministrators -->
            <c:if test='${role eq "System Administrator" }'>
              <div class="tabContent " id="tabSystemAdministrators">
                <%@ include file="/WEB-INF/pages/admin/includes/user_accounts_table.jsp" %>
              </div>
            </c:if>
            <!-- /#tabSystemAdministrators -->
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
