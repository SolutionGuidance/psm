<%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: This page renders the functions service navigation.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<div class="tabHead">
    <div class="tabR">
        <div class="tabM">
            <a class="tab first<c:if test="${functions_service_active_menu=='providerTypes'}"> active</c:if>" href="${ctx}/admin/viewProviderTypes"><span class="aR"><span class="aM">Provider Types</span></span></a>
            <a class="tab<c:if test="${functions_service_active_menu=='screeningSchedules'}"> active</c:if>" href="${ctx}/admin/getScreeningSchedule"><span class="aR"><span class="aM">Screening Schedules</span></span></a>
            <a class="tab<c:if test="${functions_service_active_menu=='helpTopics'}"> active</c:if>" href="${ctx}/admin/searchHelp"><span class="aR"><span class="aM">Help Topics</span></span></a>
            <a class="tab<c:if test="${functions_service_active_menu=='agreement'}"> active</c:if>" href="${ctx}/admin/viewAgreementDocuments"><span class="aR"><span class="aM">Agreements &amp; Addendums</span></span></a>
            <a class="tab<c:if test="${functions_service_active_menu=='serviceAgents'}"> active</c:if>" href="${ctx}/admin/viewAgents"><span class="aR"><span class="aM">Service Agents</span></span></a>
            <c:if test="${functions_service_active_menu=='providerTypes'}"><a href="${ctx}/admin/beginCreateProviderType" class="purpleBtn addProviderBtn"><span class="btR"><span class="btM">Add Provider Type</span></span></a></c:if>
            
        </div>
    </div>
</div>
