<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>

<div class="tableHeader ${status.first ? '' : 'otherTableHeader'}">
    <c:url var="editLink" value="/provider/enrollment/jump">
      <c:param name="page" value="${tabName}"></c:param>
    </c:url>
    <span>${tabName}</span>
    <a href="${editLink}" class="edit">Edit</a>
</div>
<div class="clearFixed"></div>
