<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="en-US">
  <c:set var="title" value="Provider Types"/>
  <c:set var="reportPage" value="true" />
  <c:set var="includeD3" value="true" />
  <c:set var="pageScripts" value="${[ctx.concat('/js/admin/providerTypesReport.js')]}" />
  <h:handlebars template="includes/html_head" context="${pageContext}" />

  <body>
    <div id="wrapper">
      <h:handlebars template="includes/header" context="${pageContext}"/>
      <div id="mainContent">
        <div class="contentWidth">
          <div class="mainNav">
            <h:handlebars template="includes/logo" context="${pageContext}"/>
            <c:set var="activeTabReports" value="true" />
            <h:handlebars template="includes/nav" context="${pageContext}"/>
          </div>
          <div class="breadCrumb">
            <a href="<c:url value='/admin/reports' />">Reports</a>
            <span>Provider Types</span>
          </div>
          <div class="head">
            <h1 class="text">Provider Types</h1>
            <a
              class="downloadProviderTypes"
              href="${ctx}/admin/reports/providertypes.csv?${providerTypeCodesQueryString}"
              >Download this report</a>
          </div>
          <div class="tabSection">
            <div class="detailPanel">
              <form action="${ctx}/admin/reports/provider-types" :method "get">
                <label for="providerType" class="label">Provider Types:</label>
                <select id="providerType" name="providerType" multiple="multiple">
                  <c:forEach var="providerType" items="${providerTypes}">
                    <option
                      value="${providerType.code}"
                      <c:if test="${enteredProviderTypeCodes.contains(providerType.code)}">
                        selected="selected"
                      </c:if>
                    >${providerType.description}</option>
                  </c:forEach>
                </select>
                <div class="row">
                  <input
                    type="submit"
                    value="Filter"
                    class="purpleBtn viewProviderTypesButton"
                  />
                </div>
              </form>
            </div>
          </div>

          <div id="providerTypesLineGraph" class="lineGraphContainer">
            <em>Loading...</em>
          </div>

          <div class="reportTable dashboardPanel">
            <c:forEach var="month" items="${months}">
              <div class="tableData">
                <div class="tableTitle">
                  <h2>${month.month}</h2>
                </div>
                <c:choose>
                  <c:when test="${month.providerTypes.size() > 0}">
                    <table class="generalTable">
                      <thead>
                        <tr>
                          <th>Provider Type</th>
                          <th class="providerTypesNum">Applications Reviewed</th>
                        </tr>
                      </thead>
                      <c:forEach
                        var="providerType"
                        items="${month.providerTypes}"
                      >
                        <tr class="reportRow">
                          <td
                            class="reportDatum"
                            reportField="providerType"
                            reportValue="${providerType.description}"
                          >
                            ${providerType.description}
                          </td>
                          <td
                            class="reportDatum"
                            reportField="applicationsReviewed"
                            reportValue="${month.getEnrollments(providerType).size()}"
                          >
                            ${month.getEnrollments(providerType).size()}
                          </td>
                        </tr>
                      </c:forEach>
                    </table>
                  </c:when>
                  <c:otherwise>
                    <h2 class="noResults">No results found</h2>
                  </c:otherwise>
                </c:choose>
              </div>
            </c:forEach>
          </div>

        </div>
      </div>
      <!-- /#mainContent -->

      <h:handlebars template="includes/footer" context="${pageContext}"/>
    </div>
    <!-- /#wrapper -->
  </body>
</html>
