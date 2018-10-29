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
            <h:handlebars template="includes/banner" context="${pageContext}"/>
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
