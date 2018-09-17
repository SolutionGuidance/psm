<%-- Used for Personal Care Assistant application --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:if test="${requestScope['_11_bound'] eq 'Y'}">
    <div class="practiceSection">
        <div class="wholeCol">
           <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/common/ind_agency_rows.jsp" %>
        </div>
        <div class="clearFixed"></div>
    </div>
</c:if>
