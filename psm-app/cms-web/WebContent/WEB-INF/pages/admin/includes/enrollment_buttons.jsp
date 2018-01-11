<%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: it is used to build the enrollment search form.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp"%>
<div class="right">
    <c:choose>
        <c:when test="${searchCriteria.showFilterPanel}">
            <a href="javascript:;" class="blueBtn filterBtn hideFilter"><span class="text">Hide Filter</span><span class="arrow"></span></a>
        </c:when>
        <c:otherwise>
            <a href="javascript:;" class="blueBtn filterBtn showFilter"><span class="text">Filter</span><span class="arrow"></span></a>
        </c:otherwise>
    </c:choose>
    <a id="exportEnrollmentsToPDF" href="javascript:;" class="greyBtn iconPdf">Export to PDF</a>
    <a id="printEnrollments" href="javascript:;" class="greyBtn iconPrint">Print</a>
    <c:if test="${active_enrollment_tab=='approved'||active_enrollment_tab=='notes'}">
        <a href="javascript:renewSelections('${ctx}/provider/enrollment/bulkRenewTickets');" class="greyBtn">Renew Selected Enrollments</a>
    </c:if>
</div>
