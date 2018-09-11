<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp"%>
<div class="tabHead">
  <div class="tabR">
    <div class="tabM">
      <a
        class="tab screeningsAllTab
          <c:if test="${activeTab=='all'}">active</c:if>"
        href="#"
      >
        <span class="aR">
          <span class="aM">
            All
          </span>
        </span>
      </a>
      <a
        class="tab screeningsFailedTab
          <c:if test="${activeTab=='fail'}">active</c:if>"
        href="#"
      >
        <span class="aR">
          <span class="aM">
            Failed
          </span>
        </span>
      </a>
      <a
        class="tab screeningsPassedTab
          <c:if test="${activeTab=='pass'}">active</c:if>"
        href="#"
      >
        <span class="aR">
          <span class="aM">
            Passed
          </span>
        </span>
      </a>
      <a
        class="tab screeningsErrorsTab
          <c:if test="${activeTab=='error'}">active</c:if>"
        href="#" 
      >
        <span class="aR">
          <span class="aM">
            Errors
          </span>
        </span>
      </a>
    </div>
  </div>
</div>
