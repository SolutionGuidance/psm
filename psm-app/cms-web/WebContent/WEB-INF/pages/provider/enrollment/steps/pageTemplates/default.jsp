<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<div class="clearFixed"></div>
<%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/common/tabs.jsp" %>

<form action="<c:url value="/provider/enrollment/page" />"
      id="enrollmentForm"
      method="post"
      enctype="multipart/form-data">
  <sec:csrfInput />

  <input type="hidden" name="pageName" value="${pageName}"/>
  <c:set var="showExportNavigation" value="${false}" />
  <c:set var="isTopNavigation" value="${true}" />
  <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/common/steps_navigation_buttons.jsp" %>

  <div class="requiredInfo">
    <span class="required">*</span> Indicates Required Fields
  </div>

  <%@include file="/WEB-INF/pages/provider/enrollment/steps/errors.jsp" %>

  <c:forEach var="formName" items="${viewModel.currentFormNames}">
    <c:forEach var="entry" items="${viewRegistry}">
      <c:if test="${formName eq entry.key}">
        <jsp:include page="${entry.value}" />
      </c:if>
    </c:forEach>
  </c:forEach>

  <c:set var="isTopNavigation" value="${false}" />
  <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/common/steps_navigation_buttons.jsp" %>

</form>
