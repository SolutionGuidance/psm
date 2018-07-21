<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="en-US">
  <c:choose>
    <c:when test="${tabName == 'all'}">
      <c:set var="listType" value="All Enrollments"/>
    </c:when>
    <c:when test="${tabName == 'approved'}">
      <c:set var="listType" value="Approved Enrollments"/>
    </c:when>
    <c:when test="${tabName == 'rejected'}">
      <c:set var="listType" value="Denied Enrollments"/>
    </c:when>
    <c:when test="${tabName == 'pending'}">
      <c:set var="listType" value="Pending Enrollments"/>
    </c:when>
    <c:when test="${tabName == 'draft'}">
      <c:set var="listType" value="Draft Enrollments"/>
    </c:when>
  </c:choose>
  <c:set var="title" value="${listType}"/>
  <c:set var="adminPage" value="true" />
  <h:handlebars template="includes/html_head" context="${pageContext}" />
  <body>
    <div id="wrapper">
      <h:handlebars template="includes/header" context="${pageContext}"/>
      <div id="mainContent">
        <div class="contentWidth">
          <div class="mainNav">
            <h:handlebars template="includes/logo" context="${pageContext}"/>
            <c:set var="activeTabEnrollments" value="true"></c:set>
            <h:handlebars template="includes/nav" context="${pageContext}"/>
          </div>
          <!-- /.mainNav -->
          <div class="breadCrumb">
            <a href="<c:url value='/provider/dashboard/drafts' />">Enrollments</a>
            <span>${listType}</span>
          </div>
          <h1>${listType}</h1>
          <div class="tabSection" id="enrollmentSection">
            <c:set var="active_enrollment_tab" value="${tabName}"/>
            <c:set var="enrollmentSearchFormAction" value="${ctx}/provider/enrollments/${tabName}?statuses=${Status}"/>
            <c:set var="searchResult" value="${results}"/>
            <%@ include file="/WEB-INF/pages/admin/includes/enrollment_tab_section.jsp" %>
            <%@ include file="/WEB-INF/pages/admin/includes/enrollment_search_form.jsp" %>
            <!-- /.tabHead -->
            <div class="tabContent">
              <div class="pagination">
                <%@ include file="/WEB-INF/pages/admin/includes/page_left_navigation.jsp" %>
                <%@ include file="/WEB-INF/pages/admin/includes/enrollment_buttons.jsp" %>
              </div>
              <%@ include file="/WEB-INF/pages/admin/includes/enrollment_search_filter_panel.jsp" %>
              <c:choose>
              <c:when test="${searchResult.total == 0}">
                <div class="tableWrapper">
                  <div class="tableContainer"></div>
                  <div class="tabFoot">
                    <div class="tabR">
                      <div class="tabM red">
                        No matched data found.
                      </div>
                    </div>
                  </div>
                </div>
              </c:when>
              <c:otherwise>
                <div class="tableWrapper">
                  <div class="tableContainer">
                    <c:if test="${active_enrollment_tab == 'all'}">
                      <c:set var="addStatusColumn" value="yes"/>
                    </c:if>
                    <%@ include file="/WEB-INF/pages/admin/includes/enrollment_search_result_table.jsp" %>
                  </div>
                  <!-- /.tableContainer -->
                  <div class="tabFoot">
                    <div class="tabR">
                      <div class="tabM">
                        <%@ include file="/WEB-INF/pages/admin/includes/page_navigation.jsp" %>
                      </div>
                    </div>
                  </div>
                  <!-- /.tabFoot -->
                </div>
              </c:otherwise>
              </c:choose>
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
