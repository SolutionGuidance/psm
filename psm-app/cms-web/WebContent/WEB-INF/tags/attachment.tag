<%@ attribute name="name" required="true"
    description="Set the `name` attribute of the <input> element." %>
<%@ attribute name="title" required="true"
    description="Set the `title` attribute of the <input> element." %>
<%@ attribute name="attachmentId" required="false"
    description="Id of existing attachment; used to generate download link." %>
<%@ attribute name="attachmentIdName" required="false"
    description="Set the `name` attribute for the hidden attachment element." %>
<%@ attribute name="filename" required="false"
    description="Name of previously uploaded file." %>

<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="cms" uri="CMSTags"  %>

<input type="file"
       title="${title}"
       class="fileUpload"
       size="10" name="${name}" />
<c:if test="${not empty attachmentId}">
    <c:url var="downloadLink" value="/provider/enrollment/attachment">
         <c:param name="id" value="${attachmentId}"></c:param>
    </c:url>
    <div><a href="${downloadLink}"><cms:truncate text="${filename}" /></a></div>
    <input type="hidden" name="${attachmentIdName}" value="${attachmentId}"/>
</c:if>
