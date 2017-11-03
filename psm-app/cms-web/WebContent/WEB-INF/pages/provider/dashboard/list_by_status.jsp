<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="h" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html xmlns="http://www.w3.org/1999/xhtml">
  <c:set var="title" value="Dashboard"/>
  <h:handlebars template="includes/html_head" context="${pageContext}"/>
  <body>
    <div id="wrapper">
      <%@include file="/WEB-INF/pages/includes/header.jsp" %>
      <!-- /#header -->

      <div id="mainContent">
        <div class="contentWidth">
          <div class="mainNav">
            <%@include file="/WEB-INF/pages/includes/logo.jsp" %>
            <c:set var="activeTab" value="2"/>
            <%@include file="/WEB-INF/pages/includes/nav.jsp" %>
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
                  <a class="tab ${statusFilter eq 'Draft' ? 'active' : ''}" href="<c:url value="/provider/dashboard/drafts" />">
                    <span class="aR">
                      <span class="aM">Draft</span>
                    </span>
                  </a>
                  <a class="tab ${statusFilter eq 'Pending' ? 'active' : ''}" href="<c:url value="/provider/dashboard/pending" />">
                    <span class="aR">
                      <span class="aM">Pending</span>
                    </span>
                  </a>
                  <a class="tab ${statusFilter eq 'Approved' ? 'active' : ''}" href="<c:url value="/provider/dashboard/approved" />">
                    <span class="aR">
                      <span class="aM">Approved</span>
                    </span>
                  </a>
                  <a class="tab ${statusFilter eq 'Rejected' ? 'active' : ''}" href="<c:url value="/provider/dashboard/rejected" />">
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
                    <span class="btR">
                      <span class="btM">
                        <span class="text">${param.filterViewState eq 'visible' ? 'Hide Filter' : 'Filter'}</span>
                        <span class="arrow"></span>
                      </span>
                    </span>
                  </a>
                  <a href="javascript:submitFormById('paginationForm','${exportResultsURL}')" class="greyBtn">
                    <span class="btR">
                      <span class="btM"><img src="<c:url value="/i/icon-pdf.png" />" alt=""/>Export to PDF</span>
                    </span>
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
                        <label>NPI/UMPI</label>
                        <span class="floatL">
                          <b>:</b>
                        </span>
                        <form:input path="npi" cssClass="normalInput"/>
                      </div>
                      <div class="row">
                        <label>Date Created</label>
                        <span class="floatL">
                          <b>:</b>
                        </span>
                        <span class="dateWrapper floatL">
                          <form:input path="createDateStart" cssClass="date" readonly=""/>
                        </span>
                        <span class="floatL">
                          -
                        </span>
                        <span class="dateWrapper floatL">
                          <form:input path="createDateEnd" cssClass="date" readonly=""/>
                        </span>
                      </div>
                    </div>
                    <div class="rightCol">
                      <div class="row">
                        <label>Request Type</label>
                        <span class="floatL">
                          <b>:</b>
                        </span>
                        <form:select path="requestTypes" cssClass="longSelect" multiple="false">
                          <form:option value="">All</form:option>
                          <form:option value="Enrollment">Enrollment</form:option>
                          <form:option value="Renewal">Renewal</form:option>
                          <form:option value="Update">Update</form:option>
                          <form:option value="Import Profile">Import Profile</form:option>
                        </form:select>
                      </div>
                      <div class="row">
                        <label>Status Date</label>
                        <span class="floatL">
                          <b>:</b>
                        </span>
                        <span class="dateWrapper floatL">
                          <form:input path="statusDateStart" cssClass="date" readonly=""/>
                        </span>
                        <span class="floatL">
                          -
                        </span>
                        <span class="dateWrapper floatL">
                          <form:input path="statusDateEnd" cssClass="date" readonly=""/>
                        </span>
                      </div>
                    </div>
                  </div>
                  <a href="javascript:submitFormById('paginationForm');" class="purpleBtn">
                    <span class="btR">
                      <span class="btM">Filter</span>
                    </span>
                  </a>
                </div>
              </form:form>
              <!-- /.filterPanel -->
              <div class="tableContainer">
                <c:choose>
                  <c:when test="${statusFilter eq 'Draft'}"><%@include file="drafts_table.jsp" %></c:when>
                  <c:otherwise><%@include file="status_results_table.jsp" %></c:otherwise>
                </c:choose>
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
                        <%@include file="/WEB-INF/pages/includes/pagination_links.jsp" %>
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

      <%@include file="/WEB-INF/pages/includes/footer.jsp" %>
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
            <a href="javascript:;" class="greyBtn">
              <span class="btR">
                <span class="btM"><img src="<c:url value="/i/icon-x.png" />" alt=""/>Close</span>
              </span>
            </a>
            <a href="javascript:;" class="purpleBtn printBtn">
              <span class="btR">
                <span class="btM"><img src="<c:url value="/i/icon-print2.png" />" alt=""/>Print</span>
              </span>
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
    </div>
  </body>
</html>
