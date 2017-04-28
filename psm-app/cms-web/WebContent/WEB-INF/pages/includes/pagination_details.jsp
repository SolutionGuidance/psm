<%--
    JSP Fragment for common pagination details.

    @author j3_guile
    @version 1.0
 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>

<c:set var="pageStartItem" value="${((paginatedResults.pageNumber - 1) * paginatedResults.pageSize) + 1}" />
<c:set var="pageEndItem" value="${((paginatedResults.pageNumber - 1) * paginatedResults.pageSize) + paginatedResults.totalItems}" />
 Displaying <strong>${paginatedResults.totalItems == 0 ? 0 : pageStartItem}</strong> - <strong>${pageEndItem}</strong> of <strong>${paginatedResults.total}</strong> Enrollment | Show:
 <select onchange="changePageSize(this.value);">
     <option value="10" ${paginatedResults.pageSize == 10 ? 'selected' : ''}>10</option>
     <option value="25" ${paginatedResults.pageSize == 25 ? 'selected' : ''}>25</option>
     <option value="50" ${paginatedResults.pageSize == 50 ? 'selected' : ''}>50</option>
     <option value="0" ${paginatedResults.pageSize == 0 ? 'selected' : ''}>All</option>
 </select>
