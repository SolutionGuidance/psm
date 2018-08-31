<!DOCTYPE html>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="h" tagdir="/WEB-INF/tags" %>
<html lang="en-US">
  <c:set var="title" value="Update Password"/>
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
            <a href="<c:url value="/provider/profile/" />">My Profile</a>
            <span class="text">Update Password</span>
          </div>
          <div class="head">
            <h1>Update Password</h1>
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
                <div id="updateProfile" class="section">
                  <div class="wholeCol">
                    <div class="row">
                      <label for="oldPassword">Old Password</label>

                      <c:set var="errorCls" value=""/>
                      <spring:bind path="oldPassword">
                        <c:if test="${status.error}"><c:set var="errorCls" value="errorInput"/></c:if>
                      </spring:bind>
                      <form:password path="oldPassword" cssClass="passwordNormalInput ${errorCls}"/>
                    </div>
                    <div class="row">
                      <label for="password">New Password</label>

                      <c:set var="errorCls" value=""/>
                      <spring:bind path="password">
                        <c:if test="${status.error}"><c:set var="errorCls" value="errorInput"/></c:if>
                      </spring:bind>
                      <form:password path="password" cssClass="passwordNormalInput ${errorCls}"/>
                    </div>
                    <div class="row">
                      <label for="confirmPassword">Confirm New Password</label>

                      <c:set var="errorCls" value=""/>
                      <spring:bind path="confirmPassword">
                        <c:if test="${status.error}"><c:set var="errorCls" value="errorInput"/></c:if>
                      </spring:bind>
                      <form:password path="confirmPassword" cssClass="passwordNormalInput ${errorCls}"/>
                    </div>
                  </div>
                  <div class="buttonBox">
                    <a href="<c:url value="/provider/profile/" />" class="greyBtn">
                      Cancel
                    </a>
                    <button class="purpleBtn" type="submit">Update</button>
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
