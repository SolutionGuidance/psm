<!DOCTYPE html>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="h" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="en-US">
  <c:set var="title" value="Dashboard"/>
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
            Enrollment
          </div>
          <h1>Dashboard</h1>

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
              <c:url var="filterResultsURL" value="/provider/dashboard/filter"/>
              <form:form action="${filterResultsURL}" id="paginationForm" method="get" commandName="criteria">
                <div class="filterPanel" style="display: ${param.filterViewState eq 'visible' ? 'block' : 'none'};">
                  <div class="floatW">
                    <input type="hidden" id="filterViewStateId" name="filterViewState" value="${param.filterViewState eq 'visible' ? 'visible' : 'hidden'}"/>
                    <form:hidden path="pageSize"/>
                    <form:hidden path="pageNumber"/>
                    <form:hidden path="sortColumn"/>
                    <form:hidden path="ascending"/>
                    <input type="hidden" name="status" value="${statusFilter}"/>

                    <div class="leftCol">
                      <div class="row">
                        <label for="listByStatusNpi">NPI/UMPI</label>
                        <form:input id="listByStatusNpi" path="npi" cssClass="normalInput"/>
                      </div>
                      <div class="row">
                        <label>Date Created</label>
                        <span class="dateWrapper floatL">
                          <form:input title="Create Start" path="createDateStart" cssClass="date" readonly=""/>
                        </span>
                        <span class="floatL">
                          -
                        </span>
                        <span class="dateWrapper floatL">
                          <form:input title="Create End" path="createDateEnd" cssClass="date" readonly=""/>
                        </span>
                      </div>
                    </div>
                    <div class="rightCol">
                      <div class="row">
                        <label for="listByStatusRequestTypes">Request Type</label>
                        <form:select id="listByStatusRequestTypes" path="requestTypes" cssClass="longSelect" multiple="false">
                          <form:option value="">All</form:option>
                          <form:option value="Enrollment">Enrollment</form:option>
                          <form:option value="Renewal">Renewal</form:option>
                          <form:option value="Update">Update</form:option>
                          <form:option value="Import Profile">Import Profile</form:option>
                        </form:select>
                      </div>
                      <div class="row">
                        <label>Status Date</label>
                        <span class="dateWrapper floatL">
                          <form:input title="Status Start" path="statusDateStart" cssClass="date" readonly=""/>
                        </span>
                        <span class="floatL">
                          -
                        </span>
                        <span class="dateWrapper floatL">
                          <form:input title="Status End" path="statusDateEnd" cssClass="date" readonly=""/>
                        </span>
                      </div>
                    </div>
                  </div>
                  <button class="purpleBtn" type="submit">Filter</button>
                </div>
              </form:form>
              <!-- /.filterPanel -->
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
