<%--
    JSP Fragment for provider type selection form.

    @author j3_guile
    @version 1.0
 --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:if test="${not empty requestScope['flash_error']}">
    <div class="errorInfo formErrorMarker" style="display: block;">
        <h3>Unable to process request because one or more values could not be recognized:</h3>
        <p class="bindingError"><c:out value="${requestScope['flash_error']}"></c:out></p>
        <div class="tl"></div>
        <div class="tr"></div>
        <div class="bl"></div>
        <div class="br"></div>
    </div>
</c:if>

<c:if test="${empty requestScope['flash_error']}">
	<c:if test="${not empty errors}">
	    <div class="errorInfo formErrorMarker" style="display: block;">
	        <h3>Please correct the following errors:</h3>
	        <c:forEach var="error" items="${errors}">
	            <p class="${error.fieldId}"><c:out value="${error.message}"></c:out></p>
	        </c:forEach>
	        <div class="tl"></div>
	        <div class="tr"></div>
	        <div class="bl"></div>
	        <div class="br"></div>
	    </div>
	</c:if>
</c:if>
