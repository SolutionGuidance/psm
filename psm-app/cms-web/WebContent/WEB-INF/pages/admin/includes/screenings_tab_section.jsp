<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp"%>
<div class="tabHead">
  <div class="tabR">
    <div class="tabM">
      <a
        class="tab allTab
          <c:if test="${active_screenings_tab=='all'}">active</c:if>"
        href="#"
      >
        <span class="aR">
          <span class="aM">All</span>
        </span>
      </a>
      <a
        class="tab failedTab
          <c:if test="${active_screenings_tab=='failed'}">active</c:if>"
        href="#"
      >
        <span class="aR">
          <span class="aM">Failed</span>
        </span>
      </a>
      <a
        class="tab passedTab
          <c:if test="${active_screenings_tab=='passed'}">active</c:if>"
        href="#"
      >
        <span class="aR">
          <span class="aM">Passed</span>
        </span>
      </a>
      <a
        class="tab errorsTab
          <c:if test="${active_screenings_tab=='errors'}">active</c:if>"
        href="#"
      >
        <span class="aR">
          <span class="aM">Errors</span>
        </span>
      </a>
    </div>
  </div>
</div>
