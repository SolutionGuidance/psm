<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<div class="row">
    <label>Do you maintain your own private practice?</label>
    <span class="floatL"><b>:</b></span>
    <span><c:choose>
        <c:when test="${requestScope['_04_maintainsOwnPrivatePractice'] eq 'Y'}">Yes</c:when>
        <c:when test="${requestScope['_04_maintainsOwnPrivatePractice'] eq 'N'}">No</c:when>
    </c:choose></span>            
    
</div>
<div class="row">
    <label>Are you employed and/or independently contracted by a group practice?</label>
    <span class="floatL"><b>:</b></span>
    <span><c:choose>
        <c:when test="${requestScope['_04_employedOrContractedByGroup'] eq 'Y'}">Yes</c:when>
        <c:when test="${requestScope['_04_employedOrContractedByGroup'] eq 'N'}">No</c:when>
    </c:choose></span>            
</div>