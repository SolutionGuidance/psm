<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="h" tagdir="/WEB-INF/tags" %>
<html lang="en-US">
  <c:set var="title" value="Import Profiles"/>
  <h:handlebars template="includes/html_head" context="${pageContext}"/>
  <body>
    <div id="wrapper">
      <h:handlebars template="includes/header" context="${pageContext}"/>
      <!-- /#header -->

      <div id="mainContent" class="detailPage">
        <div class="contentWidth">
          <div class="mainNav">
            <h:handlebars template="includes/logo" context="${pageContext}"/>
            <c:set var="activeTabProfile" value="true"/>
            <h:handlebars template="includes/nav" context="${pageContext}"/>
          </div>
          <!-- /.mainNav -->
          <div class="breadCrumb">
            <span class="text">My Profile</span>
          </div>
          <div class="head">
            <h1>My Profile</h1>
          </div>
          <div class="clearFixed"></div>
          <h:handlebars template="includes/flash" context="${pageContext}"/>

          <div class="dashboardPanel">
            <div class="tableData">
              <div class="tableTitle">
                <h2>Profiles</h2>
              </div>
              <table class="generalTable">
                <thead>
                  <tr>
                    <th>NPI / UMPI<span class="sep"></span></th>
                    <th>Provider Type<span class="sep"></span></th>
                    <th>Last Modified On<span class="sep"></span></th>
                    <th class="alignCenter">Action<span class="sep"></span></th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="profile" items="${profiles}">
                    <c:url var="viewProfileLink" value="/provider/enrollment/profile">
                      <c:param name="id" value="${profile.profileId}"/>
                    </c:url>
                    <c:url var="editProfileLink" value="/provider/profile/edit">
                      <c:param name="profileId" value="${profile.profileId}"/>
                    </c:url>
                    <c:url var="renewProfileLink" value="/provider/profile/renew">
                      <c:param name="profileId" value="${profile.profileId}"/>
                    </c:url>
                    <tr>
                      <td><c:out value="${profile.npi}"/></td>
                      <td><c:out value="${profile.providerType}"/></td>
                      <td><fmt:formatDate value="${profile.lastModifiedDate}" pattern="MM/dd/yyyy"/></td>
                      <td class="alignCenter">
                        <a href="${viewProfileLink}">View</a><span class="sep">|</span>
                        <a href="${editProfileLink}">Edit</a><span class="sep">|</span>
                        <a href="${renewProfileLink}">Renew</a>
                      </td>
                    </tr>
                  </c:forEach>
                  <c:if test="${empty profiles}">
                    <tr>
                      <td colspan="4">No profiles found.</td>
                    </tr>
                  </c:if>
                </tbody>
              </table>
              <div class="clearFixed"></div>
              <div class="tl"></div>
              <div class="tr"></div>
            </div>
            <!-- /.tableData -->
            <div class="sideBar">
              <div class="notificationsPanel panel">
                <div class="panelHeader">
                  <h2>Account Maintenance</h2>
                </div>
                <div class="panelSection">
                  <ul>
                    <li>
                      <p>
                        <a class="accountSetupLink" href="<c:url value="/provider/dashboard/setup" />">Account Setup</a>
                        <br/>
                        Create new or import existing profiles
                      </p>
                    </li>
                    <c:if test="${isInternalUser}">
                      <li>
                        <p>
                          <a href="<c:url value="/provider/profile/reset" />" id="change_password_link">Change Password</a>
                          <br/>
                          Set a new password for your online account
                        </p>
                      </li>
                    </c:if>
                  </ul>
                </div>
                <div class="tl"></div>
                <div class="tr"></div>
              </div>
            </div>
            <!-- /.sideBar -->
          </div>
          <!-- /.dashboardPanel -->
        </div>
      </div>
      <!-- /#mainContent -->

      <h:handlebars template="includes/footer" context="${pageContext}"/>
      <!-- #footer -->
    </div>
    <!-- /#wrapper -->
  </body>
</html>
