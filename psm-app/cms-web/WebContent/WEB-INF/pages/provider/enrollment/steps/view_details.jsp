<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="h" tagdir="/WEB-INF/tags" %>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en-US" xml:lang="en-US">
  <c:set var="title" value="${pageTitle}"/>
  <h:handlebars template="includes/html_head" context="${pageContext}"/>
  <c:set var="selectedMarkup" value='selected="selected"'/>
  <body>
    <div id="wrapper">
      <h:handlebars template="includes/header" context="${pageContext}"/>
      <!-- /#header -->

      <div id="mainContent" class="detailPage providerReadOnly">
        <div class="contentWidth">
          <div class="mainNav">
            <h:handlebars template="includes/logo" context="${pageContext}"/>
            <c:set var="activeTab" value="2"></c:set>
            <h:handlebars template="includes/nav" context="${pageContext}"/>
          </div>
          <!-- /.mainNav -->
          <div class="breadCrumb">
            <a href="<c:url value="/provider/dashboard/list" />">Enrollments</a>
            <span>View Enrollment Details</span>
          </div>

          <div class="head">
            <h1>View Enrollment Details</h1>
            <a class="greyBtn" href="<c:url value="/provider/enrollment/export" />">
              <img alt="" src="<c:url value="/i/icon-pdf.png" />"/>Export to PDF
            </a>
            <a class="greyBtn printModalBtn" href="javascript:printThis();">
              <img alt="" src="<c:url value="/i/icon-print.png" />"/>Print
            </a>
            <c:if test="${showReviewLink}">
              <a class="greyBtn" href="<c:url value="/agent/enrollment/screeningReview?id=${enrollment.objectId}" />">
                Review
              </a>
            </c:if>
          </div>
          <c:if test="${requestScope['_99_legacyInd'] eq 'Y'}">
            <div class="legacyInfo">If you enrolled with DHS prior to November 1st 2013, the data fields below may not be correct. Please review your information and make the necessary corrections before you submit it.</div>
          </c:if>

          <div class="tabSection">
            <div class="detailPanel" style="width: 940px;">
              <div class="section">
                <div class="col1">
                  <div class="row">
                    <label>Request Type</label>
                    <span class="floatL">
                      <b>:</b>
                    </span>
                    <span>${requestScope['_99_requestType']}</span>
                  </div>
                  <div class="row">
                    <label>Status</label>
                    <span class="floatL">
                      <b>:</b>
                    </span>
                    <span>${requestScope['_99_requestStatus'] eq 'Rejected' ? 'Denied' : requestScope['_99_requestStatus']}</span>
                  </div>
                </div>
                <div class="col2">
                  <div class="row">
                    <label>Submitted On</label>
                    <span class="floatL">
                      <b>:</b>
                    </span>
                    <span>${requestScope['_99_submittedOn']}</span>
                  </div>
                  <div class="row">
                    <label>Status Date</label>
                    <span class="floatL">
                      <b>:</b>
                    </span>
                    <span>${requestScope['_99_statusDate']}</span>
                  </div>
                </div>
                <div class="col3">
                  <div class="row">
                    <label>Risk Level &nbsp;&nbsp;&nbsp;&nbsp;:</label>
                    <span>${requestScope['_99_riskLevel']}</span>
                  </div>
                </div>
              </div>
              <!-- /.section -->
              <div class="tl"></div>
              <div class="tr"></div>
              <div class="bl"></div>
              <div class="br"></div>
            </div>

            <!-- /.detailPanel -->
            <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/common/readonly_profile.jsp" %>

          </div>
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
      <%@include file="/WEB-INF/pages/provider/enrollment/steps/modal/print_modal.jsp" %>
      <%@include file="/WEB-INF/pages/provider/enrollment/steps/modal/stale_ticket.jsp" %>
      <%@include file="/WEB-INF/pages/provider/enrollment/steps/modal/superseded_ticket.jsp" %>
      <%@include file="/WEB-INF/pages/provider/enrollment/steps/modal/submit_enrollment.jsp" %>
      <!-- /#saveAsDraftModal-->
    </div>
    <c:if test="${not empty requestScope['flash_popup']}">
      <input type="hidden" id="flashPopUp" value="${requestScope['flash_popup']}"/>
    </c:if>
  </body>
</html>
