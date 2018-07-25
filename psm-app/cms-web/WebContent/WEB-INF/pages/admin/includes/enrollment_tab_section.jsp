<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp"%>
<div class="tabHead">
  <div class="tabR">
    <div class="tabM">
      <a
        class="tab allTab <c:if test="${active_enrollment_tab == 'all'}">active</c:if>"
        href="${ctx}/provider/enrollments/all?showFilterPanel=true"
      >
        <span class="aR">
          <span class="aM">All</span>
        </span>
      </a>
      <a
        class="tab draftTab <c:if test="${active_enrollment_tab=='draft'}">active</c:if>"
        href="${ctx}/provider/enrollments/draft?statuses=Draft&showFilterPanel=true"
      >
        <span class="aR">
          <span class="aM">Draft</span>
        </span>
      </a>
      <a
        class="tab pendingTab <c:if test="${active_enrollment_tab=='pending'}">active</c:if>"
        href="${ctx}/provider/enrollments/pending?statuses=Pending&showFilterPanel=true"
      >
        <span class="aR">
          <span class="aM">Pending</span>
        </span>
      </a>
      <a
        class="tab approvedTab <c:if test="${active_enrollment_tab=='approved'}">active</c:if>"
        href="${ctx}/provider/enrollments/approved?statuses=Approved&showFilterPanel=true"
      >
        <span class="aR">
          <span class="aM">Approved</span>
        </span>
      </a>
      <a
        class="tab deniedTab <c:if test="${active_enrollment_tab=='rejected'}">active</c:if>"
        href="${ctx}/provider/enrollments/rejected?statuses=Rejected&showFilterPanel=true"
      >
        <span class="aR">
          <span class="aM">Denied</span>
        </span>
      </a>
      <a href="${ctx}/provider/enrollment/start" class="purpleBtn">
        New Enrollment/Renewal
      </a>
    </div>
  </div>
</div>
