<%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: it is used to render the page navigation.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<c:set var="maxPageNumbersCount" value="3"/>
<c:set var="currentPageNumber" value="${searchResult.pageNumber}"/>
<c:set var="totalPageCount" value="${searchResult.totalPages}"/>

<c:set var="halfMaxPageNumbersCount" value="${(maxPageNumbersCount-1)/2}"/>
<c:set var="startPageNum" value="${currentPageNumber-halfMaxPageNumbersCount>1?currentPageNumber-halfMaxPageNumbersCount:1}"/>
<c:if test="${startPageNum>1&&totalPageCount-currentPageNumber<halfMaxPageNumbersCount}">
    <c:set var="startPageNum" value="${totalPageCount-(maxPageNumbersCount-1)>1?totalPageCount-(maxPageNumbersCount-1):1}"/>
</c:if>

<c:set var="endPageNum" value="${startPageNum+(maxPageNumbersCount-1)>totalPageCount?totalPageCount:startPageNum+(maxPageNumbersCount-1)}"/>
<c:if test="${searchResult.total > 0}">
    <div class="left topPagination">
        Displaying <strong>${(currentPageNumber-1)*searchResult.pageSize+1}</strong> - <strong>${searchResult.pageSize == -1 ? searchResult.total : currentPageNumber*searchResult.pageSize>searchResult.total?searchResult.total:currentPageNumber*searchResult.pageSize}</strong> of <strong>${searchResult.total}</strong> ${itemsName} | Show:
        <select class="pageSizeSelect" title="items per page">
            <option value="10" <c:if test="${searchResult.pageSize==10}" >selected="selected"</c:if>>
                10
            </option>
            <option value="25" <c:if test="${searchResult.pageSize==25}" >selected="selected"</c:if>>
                25
            </option>
            <option value="50" <c:if test="${searchResult.pageSize==50}" >selected="selected"</c:if>>
                50
            </option>
            <option value="-1" <c:if test="${searchResult.pageSize==-1}" >selected="selected"</c:if>>
                All
            </option>
        </select>
    </div>
</c:if>
