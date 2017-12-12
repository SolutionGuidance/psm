<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<div class="clearFixed"></div>
<%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/common/tabs.jsp" %>
<form action="<c:url value="/provider/enrollment/page" />"
    id="enrollmentForm"
    method="post"
    enctype="multipart/form-data">
  <sec:csrfInput />
  <div class="buttonBox topButtonBox">
    <button class="greyBtn prevBtn" type="submit" name="previous">
      <span class="icon">Previous</span>
    </button>
    <button class="nextBtn greyBtn" type="submit" name="next">
      <span class="icon">Next</span>
    </button>
    <button class="greyBtn" type="submit" name="save">
      Save as Draft
    </button>
    <a href="javascript:printThis();" class="greyBtn printModalBtn"><span class="btR"><span class="btM"><img src="<c:url value="/i/icon-print.png" />" alt=""/>Print</span></span></a>
  </div>

  <!-- /.buttonBox -->
  <div class="personalPanel summaryPageWrapper">
    <c:set var="afterSummary" value="${false}"></c:set>
    <c:forEach var="tabName" items="${viewModel.tabNames}" varStatus="status">
      <c:if test="${tabName ne pageName and not afterSummary}">
        <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/summary/header.jsp" %>
      </c:if>
      <c:choose>
      <c:when test="${tabName eq 'Personal Information'}">
        <jsp:include page="pageTemplates/summary/personal_info.jsp" />
      </c:when>
      <c:when test="${tabName eq 'Practice Information'}">
        <jsp:include page="pageTemplates/summary/practice_info.jsp" />
      </c:when>
      <c:otherwise>
        <c:forEach var="formName" items="${viewModel.tabModels[tabName].formNames}">
          <c:forEach var="entry" items="${summaryViewRegistry}">
            <c:if test="${formName eq entry.key}">
              <jsp:include page="${entry.value}" />
            </c:if>
          </c:forEach>
        </c:forEach>
      </c:otherwise>
      </c:choose>
      <c:if test="${tabName eq pageName}"><c:set var="afterSummary" value="${true}"></c:set></c:if>
    </c:forEach>
    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
  </div>

  <div class="buttonBox topButtonBox">
    <input type="hidden" name="pageName" value="${pageName}"/>
    <button class="greyBtn prevBtn" type="submit" name="previous">
      <span class="icon">Previous</span>
    </button>
    <button class="nextBtn greyBtn" type="submit" name="next">
      <span class="icon">Next</span>
    </button>
    <button class="greyBtn" type="submit" name="save">
      Save as Draft
    </button>
    <a href="javascript:printThis();" class="greyBtn printModalBtn"><span class="btR"><span class="btM"><img src="<c:url value="/i/icon-print.png" />" alt=""/>Print</span></span></a>
  </div>
  <!-- /.buttonBox -->
</form>
