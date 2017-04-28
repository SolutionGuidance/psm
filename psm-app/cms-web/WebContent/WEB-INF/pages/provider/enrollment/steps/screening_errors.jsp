<%--
    JSP Fragment for provider type selection form.

    @author j3_guile
    @version 1.0
 --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:if test="${not empty errors}">
    <div class="errorInfo formErrorMarker" style="display: block;">
        <h3>The following problems were identified for this enrollment during screening:</h3>
        <h3>You may perform manual verification for licenses and fields, but incomplete enrollments cannot be approved.</h3>
        <c:forEach var="error" items="${errors}">
            <p class="${error.fieldId}"><c:out value="${error.message}"></c:out></p>
        </c:forEach>
        <div class="tl"></div>
        <div class="tr"></div>
        <div class="bl"></div>
        <div class="br"></div>
    </div>
</c:if>
