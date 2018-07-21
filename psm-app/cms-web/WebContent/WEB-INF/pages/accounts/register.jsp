<!DOCTYPE html>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="h" tagdir="/WEB-INF/tags" %>
<html lang="en-US">
  <c:set var="title" value="Register"/>
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
          </div>
          <!-- /.mainNav -->
          <div class="head">
            <h1 class="text">Register</h1>
          </div>
          <div class="tabSection">
            <form:form commandName="registrant" id="registrationform">
              <spring:hasBindErrors name="registrant">
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
                      <label for="registerUsername">Username <span class="required">*</span></label>
                      <c:set var="errorCls" value=""/>
                      <spring:bind path="username">
                        <c:if test="${status.error}"><c:set var="errorCls" value="errorInput"/></c:if>
                      </spring:bind>
                      <form:input id="registerUsername" path="username" cssClass="normalInput ${errorCls}"/>
                    </div>

                    <div class="row">
                      <label for="registerFirstName">First Name <span class="required">*</span></label>
                      <c:set var="errorCls" value=""/>
                      <spring:bind path="firstName">
                        <c:if test="${status.error}"><c:set var="errorCls" value="errorInput"/></c:if>
                      </spring:bind>
                      <form:input id="registerFirstName" path="firstName" cssClass="normalInput ${errorCls}"/>
                    </div>
                    <div class="row">
                      <label for="registerMiddleName">Middle Name</label>
                      <c:set var="errorCls" value=""/>
                      <spring:bind path="middleName">
                        <c:if test="${status.error}"><c:set var="errorCls" value="errorInput"/></c:if>
                      </spring:bind>
                      <form:input id="registerMiddleName" path="middleName" cssClass="normalInput ${errorCls}"/>
                    </div>

                    <div class="row">
                      <label for="registerLastName">Last Name <span class="required">*</span></label>
                      <c:set var="errorCls" value=""/>
                      <spring:bind path="lastName">
                        <c:if test="${status.error}"><c:set var="errorCls" value="errorInput"/></c:if>
                      </spring:bind>
                      <form:input id="registerLastName" path="lastName" cssClass="normalInput ${errorCls}"/>
                    </div>
                    <div class="row">
                      <label for="registerEmail">Email <span class="required">*</span></label>
                      <c:set var="errorCls" value=""/>
                      <spring:bind path="email">
                        <c:if test="${status.error}"><c:set var="errorCls" value="errorInput"/></c:if>
                      </spring:bind>
                      <form:input id="registerEmail" path="email" cssClass="normalInput ${errorCls}"/>
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
                <button class="purpleBtn" type="submit">Register</button>
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
