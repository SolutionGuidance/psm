 <%--
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: This is the enrollment service agent details page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="en-US">
  <c:set var="title" value="View Enrollment - ${profile.status.description}"/>
  <h:handlebars template="includes/html_head" context="${pageContext}" />
  <body>
    <div id="wrapper">
      <h:handlebars template="includes/header" context="${pageContext}"/>
      <div id="mainContent" class="detailPage providerReadOnly">
        <div class="contentWidth">
          <div class="head">
            <h1>View Enrollment Details</h1>
            <a class="greyBtn iconPdf" href="<c:url value="/provider/enrollment/export" />">Export to PDF</a>
          </div>
          <div class="tabSection">

            <div class="detailPanel" style="width: 940px;">
              <div class="section">
                <div class="col1">
                  <div class="row">
                    <label>Request Type</label>
                    <span>${requestScope['_99_requestType']}</span>
                  </div>
                  <div class="row">
                    <label>Status</label>
                    <span class="enrollmentStatus">
                      ${requestScope['_99_requestStatus'] == 'Rejected' ? 'Denied' : requestScope['_99_requestStatus']}
                    </span>
                  </div>
                </div>
                <div class="col2">
                  <div class="row">
                    <label>Submitted On</label>
                    <span>${requestScope['_99_submittedOn']}</span>
                  </div>
                  <div class="row">
                    <label>Status Date</label>
                    <span>${requestScope['_99_statusDate']}</span>
                  </div>
                </div>
                <div class="col3">
                  <div class="row">
                    <label>Risk Level</label>
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
