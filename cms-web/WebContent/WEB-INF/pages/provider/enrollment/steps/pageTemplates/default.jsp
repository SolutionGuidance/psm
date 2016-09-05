<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>

<div class="clearFixed"></div>
<%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/common/tabs.jsp" %>

<div class="requiredInfo">
    <span class="required">*</span> Indicates Required Fields
</div>
<!-- /.requiredInfo -->

<form action="" id="enrollmentForm" method="post" enctype="multipart/form-data">

<!-- /.errorInfo -->
<%@include file="/WEB-INF/pages/provider/enrollment/steps/errors.jsp" %>

<c:forEach var="formName" items="${viewModel.currentFormNames}">
    <c:forEach var="entry" items="${viewRegistry}">
        <c:if test="${formName eq entry.key}">
            <jsp:include page="${entry.value}" />
        </c:if>
    </c:forEach>
</c:forEach>

<div class="buttonBox">
    <input type="hidden" name="pageName" value="${pageName}"/>
    <c:url var="saveUrl" value="/provider/enrollment/save" />
    <c:url var="submitUrl" value="/provider/enrollment/submit" />
    <c:url var="nextPageUrl" value="/provider/enrollment/steps/next" />
    <c:url var="prevPageUrl" value="/provider/enrollment/steps/prev" />
    
    <a href="javascript:submitFormById('enrollmentForm', '${prevPageUrl}')" class="greyBtn prevBtn"><span class="btR"><span class="btM"><span class="icon">Previous</span></span></span></a>
    <c:if test="${not isInSubmissionPage}">
        <a id="nextBtn" class="greyBtn" href="javascript:submitFormById('enrollmentForm', '${nextPageUrl}')"><span class="btR"><span class="btM"><span class="icon">Next</span></span></span></a>
    </c:if>
    <c:if test="${isInSubmissionPage}">
        <a href="javascript:submitFormById('enrollmentForm', '${submitUrl}')" class="purpleBtn"><span class="btR"><span class="btM">Submit Enrollment</span></span></a>
    </c:if>
    <a href="javascript:submitFormById('enrollmentForm', '${saveUrl}')" class="greyBtn"><span class="btR"><span class="btM">Save as Draft</span></span></a>
</div>
<!-- /.buttonBox -->
</form>