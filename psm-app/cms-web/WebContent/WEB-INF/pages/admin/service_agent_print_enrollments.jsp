 <%--
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: This is the enrollments pending page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="en-US">
  <c:set var="title" value="Enrollment"/>
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
                    <table class="generalTable fixedWidthTable">
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
                            <td class="alignCenter">${item.npi}</td>
                            <td class="alignCenter">
                              <fmt:formatDate
                                value="${item.submissionDate}"
                                pattern="MM/dd/yyyy"
                              />
                            </td>
                            <td class="alignCenter">${item.providerType}</td>
                            <td class="alignCenter">${item.providerName}</td>
                            <td class="alignCenter">${item.requestType}</td>
                            <c:choose>
                              <c:when test="${fn:toLowerCase(item.status)=='approved'}">
                                <td class="green alignCenter">Approved</td>
                              </c:when>
                              <c:when test="${fn:toLowerCase(item.status)=='rejected'}">
                                <td class="red alignCenter">Denied</td>
                              </c:when>
                              <c:otherwise>
                                <td class="alignCenter">${item.status}</td>
                              </c:otherwise>
                            </c:choose>
                            <c:choose>
                              <c:when test="${fn:toLowerCase(item.riskLevel)=='limited'}">
                                <td class="green alignCenter">Limited</td>
                              </c:when>
                              <c:when test="${fn:toLowerCase(item.riskLevel)=='high'}">
                                <td class="red alignCenter">High</td>
                              </c:when>
                              <c:otherwise>
                                <td class="alignCenter">${item.riskLevel}</td>
                              </c:otherwise>
                            </c:choose>
                            <td class="alignCenter">
                              <fmt:formatDate
                                value="${item.statusDate}"
                                pattern="MM/dd/yyyy"
                              />
                            </td>
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
      <h:handlebars template="includes/footer" context="${pageContext}"/>
      <!-- #footer -->
    </div>
    <!-- /#wrapper -->
  </body>
</html>
