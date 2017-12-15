<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<div class="clearFixed"></div>
<%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/common/tabs.jsp" %>

<div class="requiredInfo">
  <span class="required">*</span> Indicates Required Fields
</div>
<!-- /.requiredInfo -->

<form action="<c:url value="/provider/enrollment/page" />"
      id="enrollmentForm"
      method="post"
      enctype="multipart/form-data">
  <sec:csrfInput />
  <!-- /.errorInfo -->
  <%@include file="/WEB-INF/pages/provider/enrollment/steps/errors.jsp" %>

  <c:forEach var="formName" items="${viewModel.currentFormNames}">
    <c:forEach var="entry" items="${viewRegistry}">
      <c:if test="${formName eq entry.key}">
        <jsp:include page="${entry.value}" />
      </c:if>
    </c:forEach>
  </c:forEach>

  <div class="buttonBox">
    <input type="hidden" name="pageName" value="${pageName}"/>

    <button type="submit" class="greyBtn prevBtn" name="previous">
      <span class="icon">Previous</span>
    </button>
    <c:if test="${not isInSubmissionPage}">
      <button type="submit" class="nextBtn greyBtn" name="next">
        <span class="icon">Next</span>
      </button>
    </c:if>
    <c:if test="${isInSubmissionPage}">
      <button type="submit" class="purpleBtn" name="submit">
        Submit Enrollment
      </button>
    </c:if>
    <button type="submit" class="greyBtn" name="save">
      Save as Draft
    </button>
  </div>
  <!-- /.buttonBox -->
</form>
