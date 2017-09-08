<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ attribute name="name" required="true" %>
<%@ attribute name="streetAddress" required="true" %>
<%@ attribute name="extendedAddress" required="false" %>
<%@ attribute name="city" required="true" %>
<%@ attribute name="state" required="true" %>
<%@ attribute name="postalCode" required="true" %>
<%@ attribute name="county" required="false" %>
<span class="h-adr ${name}">
    <div class="p-street-address"><c:out value="${streetAddress}" /></div>
    <div class="p-extended-address"><c:out value="${extendedAddress}" /></div>
    <span class="p-locality"><c:out value="${city}" /></span>,
    <span class="p-region state"><c:out value="${state}" /></span>
    <span class="p-postal-code"><c:out value="${postalCode}" /></span><
        c:if test="${not empty county}">,</c:if>
    <span class="p-region county"><c:out value="${county}" /></span>
</span>
