<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp"%>

<div class="buttonBox ${isTopNavigation ? 'topButtonBox' : ''}">

  <button
    type="submit"
    class="prevBtn greyBtn"
    name="previous"
  >
    <span class="icon">
      Previous
    </span>
  </button>

  <c:if test="${not isSubmissionPage}">
    <button
      type="submit"
      class="nextBtn greyBtn"
      name="next"
    >
      <span class="icon">
        Next
      </span>
    </button>
  </c:if>

  <c:if test="${isSubmissionPage && not isTopNavigation}">
    <button
      type="submit"
      class="purpleBtn"
      name="submit"
    >
      Submit Application
    </button>
  </c:if>

  <c:if test="${not isSubmissionPage || (isSubmissionPage && not isTopNavigation)}">
    <button
      type="submit"
      class="greyBtn"
      name="save"
    >
      Save as Draft
    </button>
  </c:if>

  <c:if test="${showExportNavigation}">
    <a
      class="greyBtn iconPdf"
      href="<c:url value="/provider/application/export" />"
    >
      Export to PDF
    </a>
  </c:if>

</div>
