<%--
 Copyright (C) 2012 TopCoder Inc., All Rights Reserved.

 @author TCSASSEMBLER
 @version 1.0

 The common header for all the jsps of the application.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>

  <body>
    <div id="wrapper">
      <div id="header">
        <div class="contentWidth">
          <div class="userSection">
            Welcome,
            <strong><c:out value="${principalUser.username}" /></strong>
            | <a href="<c:url value='/system/help-system-admin' />">Help</a>
            | <c:url var="logoutUrl" value="/logout"/>
              <form action="${logoutUrl}" method="post" class="logoutForm">
                <input type="submit" class="logoutButton" value="Logout"/>
                <input type="hidden"
                       name="${_csrf.parameterName}"
                       value="${_csrf.token}"/>
              </form>
          </div>
          <!-- /.userSection -->
          <div class="mastHead">
            Last login: <c:out value="${loginDate}" />
          </div>
          <!-- /.mastHead -->
        </div>
      </div>
      <!-- /#header -->

      <div id="mainContent" <c:if test='${isUpdateUser}'>class="detailPage"</c:if>>
        <div class="contentWidth">
          <div class="mainNav">
            <h:handlebars template="includes/logo" context="${pageContext}"/>
            <div class="nav">
              <div class="navR">
                <div class="navM">
                  <ul>
                    <li class="active">
                      <a href="<c:url value='/system/user/list' />">USER ACCOUNTS</a>
                      <c:if test="${hasArrow}"><span class="arrow"></span></c:if>

                    </li>
                  </ul>
                  <div class="searchWidget">
                    <a href="<c:url value='/system/advanced-search-system-admin' />">Advanced Search</a>
                    <form id="searchBoxForm" class="inputContainer" action="<c:url value='/system/user/search?role=Provider' />"  method="post">
                      <sec:csrfInput />
                      <a href="javascript:;" class="search searchBox"></a>
                      <input type="text" class="hint" value="Search Keyword" title="Search Keyword" name="firstName" id="searchBoxFirstName"/>
                      <input type="hidden" name="lastName" id="searchBoxLastName" />
                      <input type="hidden" name="and" value="false" />
                      <input type="hidden" name="searchBox" value="true" />
                      <input type="hidden" name="initSearchBox" value="true" />
                      <input type="hidden" name="roles" value="Provider"/>
                      <input type="hidden" name="roles" value="Service Agent"/>
                      <input type="hidden" name="roles" value="Service Administrator"/>
                      <input type="hidden" name="roles" value="System Administrator"/>
                    </form>
                  </div>
                  <!-- /.searchWidget -->
                </div>
              </div>
            </div>
          </div>
          <!-- /.mainNav -->
