<%--
    JSP Fragment for common paging links.

    @author j3_guile
    @version 1.0
 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:if test="${paginatedResults.totalPages > 0}">
	<c:set var="minP" value="${(paginatedResults.pageNumber + 4 > paginatedResults.totalPages) ?  paginatedResults.totalPages - 4 : paginatedResults.pageNumber - 2}" />
	<c:if test="${minP < 1}">
	    <c:set var="minP" value="${1}" />
	</c:if>  
	<c:set var="maxP" value="${minP + 4}" />
	<c:if test="${maxP > paginatedResults.totalPages}">
	    <c:set var="maxP" value="${paginatedResults.totalPages}" />
	</c:if>  
	    
	<div class="pagi">
	    <c:if test="${paginatedResults.pageSize > 0 && paginatedResults.pageNumber < paginatedResults.totalPages}">
	        <a href="javascript:changePageNumber(${paginatedResults.pageNumber + 1})">Next &gt;&gt;</a>
	    </c:if>
	    <c:forEach var="idx" begin="${minP}" end="${maxP}" step="1">
	        <c:set var="cPage" value="${minP + (maxP - idx)}"></c:set>
	        <c:if test="${paginatedResults.pageNumber == cPage}">
			    <span class="pageNumber">${cPage}</span>
	        </c:if>
	        <c:if test="${paginatedResults.pageSize > 0 && paginatedResults.pageNumber != cPage}">
			    <a href="javascript:changePageNumber(${cPage})">${cPage}</a>
	        </c:if>
	    </c:forEach>
	    <c:if test="${paginatedResults.pageNumber > 1}">
		    <a href="javascript:changePageNumber(${paginatedResults.pageNumber - 1})">&lt;&lt; Prev</a>
	    </c:if>
	</div>
	<span class="floatR">Pages: </span>
</c:if>