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
            <c:set var="activeTabDashboard" value="true"/>
            <h:handlebars template="includes/nav" context="${pageContext}"/>
          </div>
          <!-- /.mainNav -->
          <div class="breadCrumb">
            Dashboard
          </div>
          <h1>Dashboard</h1>
          <div class="tabContent contentT">
            <c:set var="paginatedResults" value="${results}"/>
            <div class="tableHeader tableHeader2">
              <h:create-enrollment-button cssClass="purpleBtn purpleBtnR"/>
              <span>Latest Activities</span>
            </div>
            <div class="tl"></div>
            <div class="tr"></div>

            <div class="pagination">
              <div class="left">
                <h:handlebars template="includes/pagination_details" context="${pageContext}" />
              </div>
              <div class="right">
                <a href="javascript:;" class="blueBtn filterBtn ${param.filterViewState eq 'visible' ? 'hideFilter' : 'showFilter'}">
                  <span class="text">${param.filterViewState eq 'visible' ? 'Hide Filter' : 'Filter'}</span>
                  <span class="arrow"></span>
                </a>
              </div>
            </div>
            <!-- /.pagination -->

            <%@include file="dashboard_filter.jsp" %>
            <!-- /.filterPanel -->

            <div class="tableContainer">
              <%@include file="dashboard_table.jsp" %>
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
          <!-- /#tabApproved -->

          <%--
                             Commenting this alert out for now, as per
                             github.com/SolutionGuidance/psm/issues/53.
                             We can put it back when a) we know how to
                             conditionalize it on the presence of some
                             actual "high"-risk provider in the pagination
                             group currently being displayed, and b) we
                             know what our risk levels are and what we
                             want to say about one(s) considered "high".

                             TODO: Also, there's a code duplication
                             between this block and the snippet in
                             ../../admin/includes/high_risk_level_means.jsp.
                             And why isn't the code here doing
                             <%@ include file="/WEB-INF/pages/admin/includes/high_risk_level_means.jsp" %>
                             the way various other places in the
                             PSM tree do?
                        --%>
          <!--
                        <div class="row infoRow">
                            <div class="row red">
                                <b>* High risk level means:</b>
                            </div>
                            <p>TBD: Say something about what it means
                               that some of the providers shown on
                               this page are "high"-risk.</p>
                        </div>
                        -->
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

      <c:set var="userHelpModalId" value="user-help-modal"/>
      <h:handlebars template="includes/userhelp/user_help_modal" context="${pageContext}" />

    </div>
  </body>
</html>
