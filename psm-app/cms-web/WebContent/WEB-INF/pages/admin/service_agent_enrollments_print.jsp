 <%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: This is the enrollments pending page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <c:set var="title" value="Enrollment"/>
  <c:set var="adminPage" value="true" />
  <h:handlebars template="includes/html_head" context="${pageContext}" />
  <body>
    <div id="wrapper">
      <div id="mainContent">
        <div class="contentWidth">
          <h1>Enrollments</h1>
          <div class="tabSection" id="enrollmentSection">
            <c:set var="searchResult" value="${results}"/>
            <div class="tabContent">
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
                    <table cellpadding="0" cellspacing="0" class="generalTable fixedWidthTable">
                      <thead>
                        <tr>
                          <th class="alignCenter">NPI/UMPI</th>
                          <th class="alignCenter">Date Submitted</th>
                          <th class="alignCenter">Provider Type</th>
                          <th class="alignCenter">Provider Name</th>
                          <th class="alignCenter">Request Type</th>
                          <th class="alignCenter">Status</th>
                          <th class="alignCenter">Risk Level</th>
                          <th class="alignCenter">Status Date</th>
                        </tr>
                      </thead>
                      <tbody>
                        <c:forEach var="item" items="${searchResult.items}">
                          <tr>
                            <td style="text-align: center;">${item.npi}
                            </td>
                            <td style="text-align: center;"><fmt:formatDate value="${item.submissionDate}" pattern="MM/dd/yyyy"/></td>
                            <td style="text-align: center;">${item.providerType}</td>
                            <td style="text-align: center;">${item.providerName}</td>
                            <td style="text-align: center;">${item.requestType}</td>
                            <td style="text-align: center;">
                              <c:choose>
                              <c:when test="${fn:toLowerCase(item.status)=='approved'}"><span class="green">Approved</span></c:when>
                              <c:when test="${fn:toLowerCase(item.status)=='rejected'}"><span class="red">Denied</span></c:when>
                              <c:otherwise>${item.status}</c:otherwise>
                              </c:choose>
                            </td>
                            <c:choose>
                            <c:when test="${fn:toLowerCase(item.riskLevel)=='limited'}"><td class="green">Low</td></c:when>
                            <c:when test="${fn:toLowerCase(item.riskLevel)=='high'}"><td class="red">High</td></c:when>
                            <c:otherwise><td style="text-align: center;">${item.riskLevel}</td></c:otherwise>
                            </c:choose>
                            <td style="text-align: center;"><fmt:formatDate value="${item.statusDate}" pattern="MM/dd/yyyy"/></td>
                          </tr>
                        </c:forEach>
                      </tbody>
                    </table>
                  </div>
                  <!-- /.tableContainer -->
                </div>
              </c:otherwise>
              </c:choose>
            </div>
          </div>
          <!-- /.tabSection -->
        </div>
      </div>
      <!-- /#mainContent -->
      <%@ include file="/WEB-INF/pages/includes/footer.jsp" %>
      <!-- #footer -->
    </div>
    <!-- /#wrapper -->
  </body>
</html>
