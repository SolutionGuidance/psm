<%--
    JSP Fragment for provider type selection form.

    @author j3_guile
    @version 1.0
 --%>

<%@page import="gov.medicaid.binders.ProviderTypeFormBinder"%>
<%@page import="gov.medicaid.entities.dto.ViewStatics"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>

<div class="stepWidget ${viewModel.individual ? 'stepWidget5Item' : 'stepWidget6Item'}">
    <ul>
        <c:set var="activeIdx" value="1"></c:set>
        <c:set var="isInSubmissionPage" value="${false}"></c:set>
        <c:forEach var="tabName" items="${viewModel.tabNames}" varStatus="status">
            <c:if test="${viewModel.currentTab eq tabName}"><c:set var="activeIdx" value="${status.count}"></c:set></c:if>
        </c:forEach>
        <c:forEach var="tabName" items="${viewModel.tabNames}" varStatus="status">
            <%-- For some reason prototype developer set different classes per tab --%>
            <c:set var="tabCls" value=""></c:set>
            <c:set var="tabLabel" value=""></c:set>
            <c:set var="tabActiveCls" value=""></c:set>
            <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/common/tab_name_mapping.jsp" %>
            <c:choose>
                <c:when test="${status.count == activeIdx}"><c:set var="tabActiveCls" value="active"></c:set></c:when>
                <c:when test="${status.count + 1 == activeIdx}"><c:set var="tabActiveCls" value="activeNear"></c:set></c:when>
                <c:when test="${status.count + 1 < activeIdx}"><c:set var="tabActiveCls" value="activePrev"></c:set></c:when>
            </c:choose>
            <c:if test="${viewModel.currentTab eq tabName}"><c:set var="tabActiveCls" value="active"></c:set></c:if>
            <c:if test="${viewModel.currentTab eq tabName and status.last}"><c:set var="isInSubmissionPage" value="${true}"></c:set></c:if>
            <li class="${status.first ? 'firstSetp' : ''} ${status.last ? 'lastSetp' : ''} ${tabCls} ${tabActiveCls}">
               <span><strong>${status.count}. ${tabLabel}</strong></span>
            </li>
        </c:forEach>
    </ul>
    <div class="clearFixed"></div>
</div>
