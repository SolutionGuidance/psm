<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<div class="tabHead" style="width: 958px;">
    <div class="tabR">
        <div class="tabM">
            <c:forEach var="tabName" items="${viewModel.tabNames}" varStatus="status">
                <c:if test="${tabName ne 'Summary Information'}">
                    <c:set var="tabLabel" value=""></c:set>
                    <c:set var="tabCls" value=""></c:set>
                    <c:set var="tabActiveCls" value=""></c:set>
                    <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/common/tab_name_mapping.jsp" %>
                    <c:if test="${viewModel.currentTab eq tabName}"><c:set var="tabActiveCls" value="active"></c:set></c:if>
                    <c:url var="tabLink" value="/provider/enrollment/jump"><c:param name="page" value="${tabName}"></c:param></c:url>
                    <a href="${tabLink}" class="tab ${tabCls} ${tabActiveCls}">
                      <span class="aR">
                        <span class="aM">${tabLabel}</span>
                      </span>
                    </a>
                </c:if>
            </c:forEach>
        </div>
    </div>
</div>

<c:choose>
    <c:when test="${pageName eq 'Personal Information'}">
        <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/view_personal_info.jsp" %>
    </c:when>
    <c:when test="${pageName eq 'Practice Information'}">
        <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/view_practice_info.jsp" %>
    </c:when>
    <c:when test="${pageName eq 'Provider Statement'}">
        <c:if test="${viewModel.individual}">
            <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/view_individual_disclosure.jsp" %>
        </c:if>
        <c:if test="${not viewModel.individual}">
            <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/view_organization_disclosure.jsp" %>
        </c:if>

    </c:when>
    <c:otherwise>
        <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/view_default.jsp" %>
    </c:otherwise>
</c:choose>
