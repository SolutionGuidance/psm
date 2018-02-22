<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:choose>
    <c:when test="${tabName eq 'Personal Information'}">
        <c:set var="tabCls" value="personal"></c:set>
        <c:set var="tabLabel" value="Personal Info"></c:set>
    </c:when>
    <c:when test="${tabName eq 'Individual PCA Information'}">
        <c:set var="tabCls" value="personal"></c:set>
        <c:set var="tabLabel" value="Individual PCA Info"></c:set>
    </c:when>
    <c:when test="${tabName eq 'License Information'}">
        <c:set var="tabCls" value="license"></c:set>
        <c:set var="tabLabel" value="License Info"></c:set>
    </c:when>
    <c:when test="${tabName eq 'Training Information'}">
        <c:set var="tabCls" value="license"></c:set>
        <c:set var="tabLabel" value="Training"></c:set>
    </c:when>
    <c:when test="${tabName eq 'Practice Information'}">
        <c:set var="tabCls" value="practice"></c:set>
        <c:set var="tabLabel" value="Practice Info"></c:set>
    </c:when>
    <c:when test="${tabName eq 'Individual Agency Information'}">
        <c:set var="tabCls" value="practice"></c:set>
        <c:set var="tabLabel" value="Agency Info"></c:set>
    </c:when>
    <c:when test="${tabName eq 'Summary Information'}">
        <c:set var="tabCls" value="summary"></c:set>
        <c:set var="tabLabel" value="Summary"></c:set>
    </c:when>
    <c:when test="${tabName eq 'Provider Statement'}">
        <c:set var="tabCls" value="provider"></c:set>
        <c:set var="tabLabel" value="Provider Statement"></c:set>
    </c:when>
    <c:when test="${tabName eq 'Organization Information'}">
        <c:set var="tabCls" value="personal"></c:set>
        <c:set var="tabLabel" value="Organization Info"></c:set>
    </c:when>
    <c:when test="${tabName eq 'Provider Setup'}">
        <c:set var="tabCls" value="practice"></c:set>
        <c:set var="tabLabel" value="Provider Setup"></c:set>
    </c:when>
    <c:when test="${tabName eq 'Member Information'}">
        <c:set var="tabCls" value="practice"></c:set>
        <c:set var="tabLabel" value="Individual Member Info"></c:set>
    </c:when>
    <c:when test="${tabName eq 'Facility Credentials'}">
        <c:set var="tabCls" value="license"></c:set>
        <c:set var="tabLabel" value="Facility Credentials"></c:set>
    </c:when>
    <c:when test="${tabName eq 'Qualified Professional'}">
        <c:set var="tabCls" value="practice"></c:set>
        <c:set var="tabLabel" value="Qualified Professional"></c:set>
    </c:when>
    <c:when test="${tabName eq 'Ownership Information'}">
        <c:set var="tabCls" value="ownership"></c:set>
        <c:set var="tabLabel" value="Ownership Info"></c:set>
    </c:when>
    <c:when test="${tabName eq 'Notes'}">
        <c:set var="tabLabel" value="Notes"></c:set>
    </c:when>
    <c:otherwise>
        <c:set var="tabLabel" value="${tabName}"></c:set>
    </c:otherwise>
</c:choose>
