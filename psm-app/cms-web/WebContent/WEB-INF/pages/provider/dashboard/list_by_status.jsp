<!DOCTYPE html>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="h" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="en-US">
  <c:set var="title" value="${listType}"/>
  <h:handlebars template="includes/html_head" context="${pageContext}"/>
  <body>
    <div id="wrapper">
      <h:handlebars template="includes/header" context="${pageContext}"/>
      <!-- /#header -->

      <div id="mainContent">
        <div class="contentWidth">
          <div class="mainNav">
            <h:handlebars template="includes/logo" context="${pageContext}"/>
            <c:set var="activeTabEnrollments" value="true"/>
            <h:handlebars template="includes/nav" context="${pageContext}"/>
          </div>
          <!-- /.mainNav -->
          <div class="breadCrumb">
            <%@ include file="/WEB-INF/pages/admin/includes/enrollments_link.jsp" %>
            <span>${listType}</span>
          </div>
          <h1>${listType}</h1>

          <div class="tabSection">
            <c:set var="paginatedResults" value="${results}"/>
            <div class="tabHead">
              <div class="tabR">
                <div class="tabM">
                  <a class="tab draftTab ${statusFilter eq 'Draft' ? 'active' : ''}"
                    href="<c:url value="/provider/dashboard/drafts" />">
                    <span class="aR">
                      <span class="aM">Draft</span>
                    </span>
                  </a>
                  <a class="tab pendingTab ${statusFilter eq 'Pending' ? 'active' : ''}"
                    href="<c:url value="/provider/dashboard/pending" />">
                    <span class="aR">
                      <span class="aM">Pending</span>
                    </span>
                  </a>
                  <a class="tab approvedTab ${statusFilter eq 'Approved' ? 'active' : ''}"
                    href="<c:url value="/provider/dashboard/approved" />">
                    <span class="aR">
                      <span class="aM">Approved</span>
                    </span>
                  </a>
                  <a class="tab deniedTab ${statusFilter eq 'Rejected' ? 'active' : ''}"
                    href="<c:url value="/provider/dashboard/rejected" />">
                    <span class="aR">
                      <span class="aM">Denied</span>
                    </span>
                  </a>
                  <h:create-enrollment-button cssClass="purpleBtn"/>
                </div>
              </div>
            </div>
            <!-- /.tabHead -->
            <div class="tabContent" id="tabDraft">
              <c:url var="exportResultsURL" value="/provider/dashboard/export"/>

              <div class="pagination">
                <div class="left">
                  <h:handlebars template="includes/pagination_details" context="${pageContext}" />
                </div>
                <div class="right">
                  <a href="javascript:;" class="blueBtn filterBtn ${param.filterViewState eq 'visible' ? 'hideFilter' : 'showFilter'}">
                    <span class="text">${param.filterViewState eq 'visible' ? 'Hide Filter' : 'Filter'}</span>
                    <span class="arrow"></span>
                  </a>
                  <a href="javascript:submitFormById('paginationForm','${exportResultsURL}')" class="greyBtn iconPdf">
                    Export to PDF
                  </a>
                </div>
              </div>
              <!-- /.pagination -->
              <%@include file="list_by_status_filter.jsp" %>
              <div class="tableContainer">
                <%@include file="status_results_table.jsp" %>
              </div>
              <!-- /.tableContainer -->
              <div class="tabFoot">
                <div class="tabR">
                  <div class="tabM">
                    <div class="pagination">
                      <div class="left">
                        <h:handlebars template="includes/pagination_details" context="${pageContext}" />
                      </div>
                      <div class="right">
                        <h:handlebars template="includes/pagination_links" context="${pageContext}" />
                      </div>
                    </div>
                    <!-- /.pagination -->
                  </div>
                </div>
              </div>
              <!-- /.tabFoot -->
            </div>
            <!-- /#tabDraft -->
          </div>
          <!-- /.tabSection -->
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

      <div id="printModal" class="outLay">
        <div class="inner">
          <!-- title -->
          <div class="modal-title">
            <a href="javascript:;" class="greyBtn iconX">
              Close
            </a>
            <a href="javascript:;" class="purpleBtn printBtn iconPrintWhite">
              Print
            </a>
            <h3>Print Preview</h3>
          </div>
          <!-- End .modal-title -->
          <!-- content -->
          <div class="modal-content"></div>
          <!-- End .content -->
        </div>
      </div>
      <!-- /#printModal-->

      <c:set var="userHelpModalId" value="user-help-modal"/>
      <h:handlebars template="includes/userhelp/user_help_modal" context="${pageContext}" />

    </div>
  </body>
</html>
