<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp"%>
<c:set var="active_screenings_tab" value="${tabName}"/>

<div class="tabHead">
  <div class="tabR">
    <div class="tabM">
      <a
        class="tab allTab
          <c:if test="${active_screenings_tab=='all'}">active</c:if>"
        href="#"
      >
        <span class="aR">
          <span class="aM" onclick="$('#status').val('all');$('#screening_form').submit()">All</span>
        </span>
      </a>
      <a
        class="tab failedTab
          <c:if test="${active_screenings_tab=='fail'}">active</c:if>"
        href="#"
      >
        <span class="aR">
          <span class="aM" onclick="$('#status').val('fail');$('#screening_form').submit()">Failed</span>
        </span>
      </a>
      <a
        class="tab passedTab
          <c:if test="${active_screenings_tab=='pass'}">active</c:if>"
        href="#"
      >
        <span class="aR">
          <span class="aM" onclick="$('#status').val('pass');$('#screening_form').submit()">Passed</span>
        </span>
      </a>
      <a
        class="tab errorsTab
          <c:if test="${active_screenings_tab=='errors'}">active</c:if>"
        href="#" 
      >
        <span class="aR">
          <span class="aM" onclick="$('#status').val('errors');$('#screening_form').submit()">Errors</span>
        </span>
      </a>
    </div>
  </div>
</div>
