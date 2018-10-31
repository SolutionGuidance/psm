<%--
  Copyright 2018 The MITRE Corporation
  
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at
  
      http://www.apache.org/licenses/LICENSE-2.0
  
  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="en-US">
  <c:set var="title" value="LEIE Automatic Screening Details"/>
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
            <span>Results from Automatic LEIE Screening</span>
          </div>
          <h1>Results from Automatic LEIE Screening</h1>
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
                        href="javascript:alert('Retrying the LEIE screening has not been implemented yet.');">
                        Retry the automatic LEIE screening</a>
                      or
                      <a href="https://exclusions.oig.hhs.gov/">
                        search the LEIE manually</a>.
                    </strong>
                  </div>
                </c:when>
                <c:when test="${screening_result == 'PASS'}">
                  <div class="row screeningResultPass">
                    This provider does not appear in the LEIE and may be
                    approved.
                  </div>
                </c:when>
                <c:otherwise>
                  <div class="row screeningResultFail">
                    This provider appears in the LEIE and should be rejected.
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
              <div class="row">
                NPI searched:
                <span class="search-term">
                  ${search_term}
                </span>
              </div>
              <div class="row matched-exclusions">
                <c:set var="count" value="${fn:length(exclusions)}" />
                <c:choose>
                  <c:when test="${count == 1}">
                    <div>There was ${count} match.</div>
                  </c:when>
                  <c:otherwise>
                    <div>There were ${count} matches.</div>
                  </c:otherwise>
                </c:choose>
                <c:forEach var="exclusion" items="${exclusions}">
                  <hr>
                  <h:leie_exclusion exclusion="${exclusion}"/>
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
