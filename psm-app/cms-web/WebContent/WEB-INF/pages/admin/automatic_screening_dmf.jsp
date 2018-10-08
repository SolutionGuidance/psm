<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="en-US">
  <c:set var="title" value="DMF Automatic Screening Details"/>
  <c:set var="adminPage" value="true" />
  <h:handlebars template="includes/html_head" context="${pageContext}" />
  <body>
    <div id="wrapper">
      <h:handlebars template="includes/header" context="${pageContext}"/>
      <div id="mainContent">
        <div class="contentWidth">
          <div class="mainNav">
            <h:handlebars template="includes/logo" context="${pageContext}"/>
            <h:handlebars template="includes/banner" context="${pageContext}"/>
            <c:set var="activeTabApplications" value="true"/>
            <h:handlebars template="includes/nav" context="${pageContext}"/>
          </div>
          <!-- /.mainNav -->
          <div class="breadCrumb">
            <a href="<c:url value="/provider/application/view">
                 <c:param name="id" value="${application_id}"/>
               </c:url>">
               Application
            </a>
            <c:if test="${in_review}">
              <a href="<c:url value="/agent/application/screeningReview">
                  <c:param name="id" value="${application_id}"/>
                </c:url>">
                Review
              </a>
            </c:if>
            <span>Results from Automatic DMF Screening</span>
          </div>
          <h1>Results from Automatic DMF Screening</h1>
          <div class="tabSection" id="applicationSection">
            <div class="detailPanel">

              <c:choose>
                <c:when test="${screening_result == 'ERROR'}">
                  <div class="row screeningResult">
                    A connection error occurred.
                  </div>
                  <div class="row">
                    <strong>
                      <a
                        href="javascript:alert('Retrying the DMF screening has not been implemented yet.');">
                        Retry the automatic DMF screening</a>
                    </strong>
                  </div>
                </c:when>
                <c:when test="${screening_result == 'PASS'}">
                  <div class="row screeningResultPass">
                    This application contains no matches found in the DMF
                    and may be approved.
                  </div>
                </c:when>
                <c:otherwise>
                  <div class="row screeningResultFail">
                    This appliaction contains matches in the DMF and should
                    be rejected.
                  </div>
                </c:otherwise>
              </c:choose>

              <div class="row">
                Screening result:
                <span class="screening-result">${screening_result}</span>
              </div>
              <div class="row">
                Checked at:
                <span class="screening-date">
                  ${screening_date}
                </span>
              </div>
              <div class="row matched-exclusions">
                <c:set var="count" value="${fn:length(results)}" />
                <c:choose>
                  <c:when test="${count == 1}">
                    <div>There was ${count} query.</div>
                  </c:when>
                  <c:otherwise>
                    <div>There were ${count} queries.</div>
                  </c:otherwise>
                </c:choose>
                <c:forEach var="result" items="${results}">
                  <hr>
                  <div class="dmf-result">
                    <c:if test="${not empty result.name}">
                      <div>Name: ${result.name}</div>
                    </c:if>
                    <c:if test="${not empty result.ssn}">
                      <div>Social Security Number: ${result.ssn}</div>
                    </c:if>
                    <div>Found: ${result.result}</div>
                  </div>
                </c:forEach>
              </div>
            </div>
          </div>
        </div>
      </div>
      <!-- /#mainContent -->
      <h:handlebars template="includes/footer" context="${pageContext}"/>
      <!-- #footer -->
    </div>
    <!-- /#wrapper -->
  </body>
</html>
