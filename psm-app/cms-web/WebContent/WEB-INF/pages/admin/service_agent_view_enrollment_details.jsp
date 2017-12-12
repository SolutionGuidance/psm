 <%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: This is the enrollment service agent details page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<!-- <c:out value="${pageScope['javax.servlet.jsp.jspPage']}"></c:out> -->
<html xmlns="http://www.w3.org/1999/xhtml" lang="en-US" xml:lang="en-US">
  <c:set var="title" value="View Enrollment - ${profile.status.description}"/>
  <c:set var="adminPage" value="true" />
  <h:handlebars template="includes/html_head" context="${pageContext}" />
  <body>
    <div id="wrapper">
      <c:if test="${param.print != 'yes' }">
        <h:handlebars template="includes/header" context="${pageContext}"/>
      </c:if>
      <div id="mainContent" class="detailPage providerReadOnly">
        <div class="contentWidth">
          <div class="head">
            <h1>View Enrollment Details</h1>
            <a class="greyBtn" href="<c:url value="/provider/enrollment/export" />"><span class="btR"><span class="btM"><img alt="" src="<c:url value="/i/icon-pdf.png" />" />Export to PDF</span></span></a>
            <a class="greyBtn" href="javascript:window.print();"><span class="btR"><span class="btM"><img alt="" src="<c:url value="/i/icon-print.png" />" />Print</span></span></a>
          </div>
          <div id="printModal" class="tabSection">

            <div class="detailPanel" style="width: 940px;">
              <div class="section">
                <div class="col1">
                  <div class="row">
                    <label>Request Type</label>
                    <span class="floatL"><b>:</b></span>
                    <span>${requestScope['_99_requestType']}</span>
                  </div>
                  <div class="row">
                    <label>Status</label>
                    <span class="floatL"><b>:</b></span>
                    <span>${requestScope['_99_requestStatus'] eq 'Rejected' ? 'Denied' : requestScope['_99_requestStatus']}</span>
                  </div>
                </div>
                <div class="col2">
                  <div class="row">
                    <label>Submitted On</label>
                    <span class="floatL"><b>:</b></span>
                    <span>${requestScope['_99_submittedOn']}</span>
                  </div>
                  <div class="row">
                    <label>Status Date</label>
                    <span class="floatL"><b>:</b></span>
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

            <%@include file="/WEB-INF/pages/provider/enrollment/print_modal.jsp" %>
          </div>
          <!-- /.tabSection -->
        </div>
      </div>
      <!-- /#mainContent -->

      <h:handlebars template="includes/footer" context="${pageContext}"/>
      <!-- #footer -->
    </div>
    <!-- /#wrapper -->
  </body>
</html>
