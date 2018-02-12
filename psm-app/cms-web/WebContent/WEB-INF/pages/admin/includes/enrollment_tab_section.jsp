<%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: it is used to render the enrollment tab section.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp"%>
<div class="tabHead">
    <div class="tabR">
        <div class="tabM">
            <a class="tab <c:if test="${active_enrollment_tab=='draft'}">active</c:if>" href="${ctx}/provider/search/draft?statuses=Draft&showFilterPanel=true"><span class="aR"><span class="aM">Draft</span></span></a>
            <a class="tab <c:if test="${active_enrollment_tab=='pending'}">active</c:if>" href="${ctx}/provider/search/pending?statuses=Pending&showFilterPanel=true"><span class="aR"><span class="aM">Pending</span></span></a>
            <a class="tab <c:if test="${active_enrollment_tab=='approved'}">active</c:if>" href="${ctx}/provider/search/approved?statuses=Approved&showFilterPanel=true"><span class="aR"><span class="aM">Approved</span></span></a>
            <a class="tab <c:if test="${active_enrollment_tab=='rejected'}">active</c:if>" href="${ctx}/provider/search/rejected?statuses=Rejected&showFilterPanel=true"><span class="aR"><span class="aM">Denied</span></span></a>
            <a class="tab <c:if test="${active_enrollment_tab=='notes'}">active</c:if>" href="${ctx}/provider/search/notes?statuses=&showFilterPanel=true"><span class="aR"><span class="aM">Notes</span></span></a>
            <a href="${ctx}/provider/enrollment/start" class="purpleBtn">New Enrollment/Renewal</a>
        </div>
    </div>
</div>
