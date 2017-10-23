<%--
    JSP Fragment for flash messages.

    @author j3_guile
    @version 1.0
 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>

<c:if test="${not empty requestScope['flash_info']}">
    <div class="info"><c:out value="${requestScope['flash_info']}"></c:out></div>
</c:if>

<c:if test="${not empty requestScope['flash_error']}">
    <div class="error"><c:out value="${requestScope['flash_error']}"></c:out></div>
</c:if>
