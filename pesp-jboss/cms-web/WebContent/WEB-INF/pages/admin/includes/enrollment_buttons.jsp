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
            <a href="javascript:;" class="blueBtn filterBtn hideFilter"><span class="btR"><span class="btM"><span class="text">Hide Filter</span><span class="arrow"></span></span></span></a>
        </c:when>
        <c:otherwise>
            <a href="javascript:;" class="blueBtn filterBtn showFilter"><span class="btR"><span class="btM"><span class="text">Filter</span><span class="arrow"></span></span></span></a>
        </c:otherwise>
    </c:choose>
    <a id="exportEnrollmentsToPDF" href="javascript:;" class="greyBtn"><span class="btR"><span class="btM"><img src="${ctx}/i/icon-pdf.png" alt=""/>Export to PDF</span></span></a>
    <a id="printEnrollments" href="javascript:;" class="greyBtn"><span class="btR"><span class="btM"><img src="${ctx}/i/icon-print.png" alt=""/>Print</span></span></a>
    <c:if test="${active_enrollment_tab=='approved'||active_enrollment_tab=='notes'}">
        <a href="javascript:renewSelections('${ctx}/provider/enrollment/bulkRenewTickets');" class="greyBtn"><span class="btR"><span class="btM">Renew Selected Enrollments</span></span></a>
    </c:if>
</div>