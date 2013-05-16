<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<div id="tabPractice" class="tabContent">
    <div class="tableContainer">
        <div class="tableHeader">
            <span>Private Practice or Primary Office Location Information</span>
        </div>
        <div class="bottomPanel">
            <c:if test="${requestScope['_04_bound'] eq 'Y'}">
    	        <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/common/practice_type.jsp" %>
            </c:if>
	        <c:if test="${requestScope['_05_bound'] eq 'Y'}">
	            <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/common/private_practice.jsp" %>
	        </c:if>
	        <c:if test="${requestScope['_06_bound'] eq 'Y'}">
	            <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/common/primary_practice.jsp" %>
	        </c:if>
        </div>
        <c:if test="${requestScope['_07_bound'] eq 'Y'}">
            <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/common/additional_practice.jsp" %>
        </c:if>
        <div class="bl"></div>
        <div class="br"></div>
    </div>
</div>
<!-- /#tabPractice -->