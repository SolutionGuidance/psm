<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:if test="${requestScope['_14_bound'] eq 'Y'}">

<c:set var="specialtyTrigger" value="${viewModel.tabModels[viewModel.currentTab].formSettings['Highest Degree Form'].settings['specialtyTrigger']}"></c:set>
<c:set var="isActivated" value="${true}"></c:set>
<c:if test="${not empty specialtyTrigger}">
    <c:set var="isActivated" value="${false}"></c:set>
    <c:set var="formName" value="_09_attachmentSize"></c:set>
    <c:forEach begin="1" end="${requestScope[formName]}" varStatus="status">
        <c:set var="formName" value="_09_specialtyType_${status.index - 1}"></c:set>
        <c:if test="${requestScope[formName] eq specialtyTrigger}">
            <c:set var="isActivated" value="${true}"></c:set>
        </c:if>
    </c:forEach>
</c:if>

<c:if test="${isActivated}">
<div class="practiceSection">
    <div class="wholeCol">
        <div class="row">
            <label>Highest Degree Earned</label>
            <span class="floatL"><b>:</b></span>
            <span>${requestScope['_14_highestDegreeEarned']}</span>
        </div>
        <div class="row">
            <label>Degree Award Date</label>
            <span class="floatL"><b>:</b></span>
            <span>${requestScope['_14_degreeAwardDate']}</span>
        </div>
    </div>
    <div class="clearFixed"></div>
</div>
</c:if>

<!-- /.section -->
<div class="clearFixed"></div>

</c:if>
