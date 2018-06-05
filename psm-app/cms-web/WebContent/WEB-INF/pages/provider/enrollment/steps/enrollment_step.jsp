<!DOCTYPE html>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="h" tagdir="/WEB-INF/tags" %>
<html lang="en-US">
  <c:set var="title" value="${pageTitle}"/>
  <h:handlebars template="includes/html_head" context="${pageContext}"/>
  <c:set var="selectedMarkup" value='selected="selected"'/>
  <body>
    <div id="wrapper" class="${viewModel.individual ? '' : 'homeHealthAgency'}">
      <h:handlebars template="includes/header" context="${pageContext}"/>
      <!-- /#header -->

      <div id="mainContent" class="detailPage">
        <div class="contentWidth">
          <div class="mainNav">
            <h:handlebars template="includes/logo" context="${pageContext}"/>
            <c:set var="activeTabEnrollments" value="true"></c:set>
            <h:handlebars template="includes/nav" context="${pageContext}"/>
          </div>
          <!-- /.mainNav -->

          <c:choose>
            <c:when test="${isRenewalEnrollment}">
              <div class="breadCrumb">
                <a href="<c:url value="/provider/dashboard/drafts" />">Enrollments</a>
                <span>Enrollment Renewal</span>
              </div>
              <div class="head">
                <h1>Enrollment Renewal</h1>
              </div>
              <c:if test="${requestScope['_99_legacyInd'] eq 'Y'}">
                <div class="legacyInfo">If you enrolled with DHS prior to November 1st 2013, the data fields below may not be correct. Please review your information and make the necessary corrections before you submit it.</div>
              </c:if>
            </c:when>
            <c:otherwise>
              <div class="breadCrumb">
                <a href="<c:url value="/provider/dashboard/drafts" />">Enrollments</a>
                <span>Register New Enrollment</span>
              </div>
              <div class="head">
                <c:choose>
                  <c:when test="${pageName eq 'Provider Type Page'}">
                    <h1>Select Provider Type</h1>
                  </c:when>
                  <c:otherwise>
                    <h1><c:out value="${requestScope['_01_providerType']}"/>
                      Enrollment Application</h1>
                  </c:otherwise>
                </c:choose>
              </div>
            </c:otherwise>
          </c:choose>

          <c:if test="${not empty requestScope['flash_info']}">
            <div class="info">
              <c:out value="${requestScope['flash_info']}"></c:out>
            </div>
          </c:if>

          <c:choose>
            <c:when test="${pageName eq 'Provider Type Page'}">
              <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/select_type.jsp" %>
            </c:when>
            <c:when test="${pageName eq 'Summary Information'}">
              <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/summary.jsp" %>
            </c:when>
            <c:otherwise>
              <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/default.jsp" %>
            </c:otherwise>
          </c:choose>
        </div>
      </div>
      <!-- /#mainContent -->

      <h:handlebars template="includes/footer" context="${pageContext}"/>
      <!-- #footer -->
      <div class="clear"></div>
    </div>
    <!-- /#wrapper -->

    <!-- /#modalBackground-->
    <div id="modalBackground"></div>
    <div id="new-modal">
      <%@include file="/WEB-INF/pages/provider/enrollment/steps/modal/save_as_draft.jsp" %>
      <%@include file="/WEB-INF/pages/provider/enrollment/steps/modal/practice_lookup.jsp" %>
      <%@include file="/WEB-INF/pages/provider/enrollment/steps/modal/stale_ticket.jsp" %>
      <%@include file="/WEB-INF/pages/provider/enrollment/steps/modal/superseded_ticket.jsp" %>
      <%@include file="/WEB-INF/pages/provider/enrollment/steps/modal/submit_enrollment.jsp" %>
      <%@include file="/WEB-INF/pages/provider/enrollment/steps/modal/print_modal.jsp" %>

      <c:set var="userHelpModalId" value="user-help-modal"/>
      <h:handlebars template="includes/userhelp/user_help_modal" context="${pageContext}" />

    </div>
    <c:if test="${not empty requestScope['flash_popup']}">
      <input type="hidden" id="flashPopUp" value="${requestScope['flash_popup']}"/>
    </c:if>
  </body>
</html>
