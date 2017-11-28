 <%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: This is the approval page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en-US" xml:lang="en-US">
  <c:set var="title" value="Enrollment"/>
  <c:set var="adminPage" value="true" />
  <h:handlebars template="includes/html_head" context="${pageContext}" />
  <body>
    <div id="wrapper">
      <h:handlebars template="includes/header" context="${pageContext}"/>
      <div id="mainContent" class="detailPage">
        <div class="contentWidth">
          <div class="mainNav">
            <h:handlebars template="includes/logo" context="${pageContext}"/>
            <c:set var="activeTab" value="2"></c:set>
            <h:handlebars template="includes/nav" context="${pageContext}"/>
          </div>
          <!-- /.mainNav -->
          <div class="breadCrumb">
            Screening Log
          </div>
          <h1>External Source Screening Log</h1>
          <div class="tabSection" id="enrollmentSection">
            <div class="detailPanel">
              <div class="section">
                <div class="wholeCol">
                  <c:if test="${empty output}">
                    No external screening was performed.
                  </c:if>
                  <c:if test="${not empty output}">
                    <div class="row">
                      <label>Status</label>
                      <span class="floatL"><b>:</b></span>
                      <span>SUCCESS</span>
                    </div>

                    <c:set var="recordsMatched"
                           value="${fn:length(output.searchResultItem)}"/>
                    <div class="row">
                      <c:choose>
                      <c:when test="${recordsMatched == 0}">
                        No records were matched.
                      </c:when>
                      <c:when test="${recordsMatched == 1}">
                        1 record matched.
                      </c:when>
                      <c:otherwise>
                        ${recordsMatched} records matched.
                      </c:otherwise>
                      </c:choose>
                    </div>

                    <c:forEach var="record" items="${output.searchResultItem}">
                      <hr />
                      <c:forEach var="coldata" items="${record.columnData.nameValuePair}">
                        <div class="row">
                          <label>${coldata.name}</label>
                          <span class="floatL"><b>:</b></span>
                          <span><c:out value="${coldata.value}"></c:out> </span>
                        </div>
                      </c:forEach>
                    </c:forEach>
                  </c:if>
                </div>
              </div>
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
