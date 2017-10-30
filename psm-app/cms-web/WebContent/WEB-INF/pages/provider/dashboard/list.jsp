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
            <c:set var="activeTab" value="1"/>
            <%@include file="/WEB-INF/pages/includes/nav.jsp" %>
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
                  <span class="btR">
                    <span class="btM">
                      <span class="text">${param.filterViewState eq 'visible' ? 'Hide Filter' : 'Filter'}</span>
                      <span class="arrow"></span>
                    </span>
                  </span>
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
                      <%@include file="/WEB-INF/pages/includes/pagination_links.jsp" %>
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
                             github.com/OpenTechStrategies/psm/issues/53.
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

      <%@include file="/WEB-INF/pages/includes/footer.jsp" %>
      <!-- #footer -->
      <div class="clear"></div>
    </div>
    <!-- /#wrapper -->
    <!-- /#modalBackground-->
    <div id="modalBackground"></div>
    <div id="new-modal">

      <%@include file="/WEB-INF/pages/provider/enrollment/steps/modal/print_modal.jsp" %>

    </div>
  </body>
</html>
