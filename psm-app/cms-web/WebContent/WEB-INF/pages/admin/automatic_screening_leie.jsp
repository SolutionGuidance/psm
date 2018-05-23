<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="en-US">
  <c:set var="title" value="LEIE Automatic Screening Details"/>
  <c:set var="adminPage" value="true" />
  <h:handlebars template="includes/html_head" context="${pageContext}" />
  <body>
    <div id="wrapper">
      <h:handlebars template="includes/header" context="${pageContext}"/>
      <div id="mainContent">
        <div class="contentWidth">
          <div class="mainNav">
            <h:handlebars template="includes/logo" context="${pageContext}"/>
            <c:set var="activeTab2" value="true"/>
            <h:handlebars template="includes/nav" context="${pageContext}"/>
          </div>
          <!-- /.mainNav -->
          <div class="breadCrumb">
            <a href="<c:url value="/provider/enrollment/view">
                 <c:param name="id" value="${enrollment_id}"/>
               </c:url>">
               Enrollment
            </a>
            <c:if test="${in_review}">
              <a href="<c:url value="/agent/enrollment/screeningReview">
                  <c:param name="id" value="${enrollment_id}"/>
                </c:url>">
                Review
              </a>
            </c:if>
            <span>LEIE Automatic Screening Log</span>
          </div>
          <h1>Automatic Screening Log</h1>
          <div class="tabSection" id="enrollmentSection">
            <div class="detailPanel">
              <div>
                Screening result:
                <span class="screening-result">${screening_result}</span>
              </div>
              <div>
                Checked at:
                <span class="screening-date">
                  ${screening_date}
                </span>
            </div>
            <div>
              NPI searched:
              <span class="search-term">
                ${search_term}
              </span>
            </div>
            <div class="matched-exclusions">
              <div>There were ${fn:length(exclusions)} matches.</div>
              <c:forEach var="exclusion" items="${exclusions}">
                <hr>
                <h:leie_exclusion exclusion="${exclusion}"/>
              </c:forEach>
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
