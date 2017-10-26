<%--
    JSP Fragment for common header.

    @author j3_guile
    @version 1.0
 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div id="header">
  <div class="contentWidth">
    <div class="userSection">
      Welcome, <strong><sec:authentication property="principal.username" /></strong>
      | <a href="javascript:;">Help</a>
      | <a href="<spring:url value="/j_spring_security_logout" />">Logout</a>
    </div>
    <!-- /.userSection -->
    <div class="mastHead">
      Last login: <c:out value="${loginDate}" />
    </div>
    <!-- /.mastHead -->
  </div>
  <!-- /.contentWidth -->

  <sec:authentication property="principal.authenticatedBySystem"
                      var="authenticatedBySystem"/>
  <sec:authentication property="principal"
                      var="requestPrincipal"/>
  <spring:eval expression="authenticatedBySystem == T(gov.medicaid.entities.SystemId).CMS_ONLINE"
               var="isInternalUser" />
</div>
