<%--
 Copyright (C) 2012 TopCoder Inc., All Rights Reserved.

 @author TCSASSEMBLER
 @version 1.0

 The top pagination section for user accounts table.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>

<c:set var="maxPageNumbersCount" value="3"/>
<c:set var="currentPageNumber" value="${results.pageNumber}"/>
<c:set var="totalPageCount" value="${results.totalPages}"/>
<c:set var="total" value="${results.total}"/>

<c:set var="halfMaxPageNumbersCount" value="${(maxPageNumbersCount-1)/2}"/>
<c:set var="startPageNum" value="${currentPageNumber-halfMaxPageNumbersCount>1?currentPageNumber-halfMaxPageNumbersCount:1}"/>
<c:if test="${startPageNum>1&&totalPageCount-currentPageNumber<halfMaxPageNumbersCount}">
    <c:set var="startPageNum" value="${totalPageCount-(maxPageNumbersCount-1)>1?totalPageCount-(maxPageNumbersCount-1):1}"/>
</c:if>

<c:set var="endPageNum" value="${startPageNum+(maxPageNumbersCount-1)>totalPageCount?totalPageCount:startPageNum+(maxPageNumbersCount-1)}"/>

<c:if test="${results.total > 0}">
    <div class="pagination">
        <div class="left">
            Displaying <strong>${(currentPageNumber-1)*results.pageSize+1}</strong> - <strong>
            ${results.pageSize == -1 ? results.total : currentPageNumber*results.pageSize>results.total?results.total:currentPageNumber*results.pageSize}
            </strong> of <strong>${total}</strong> User Accounts | Show:
            <select>
                <option value="10" <c:if test="${results.pageSize eq 10}">selected="selected"</c:if>>10</option>
                <option value="25" <c:if test="${results.pageSize eq 25}">selected="selected"</c:if>>25</option>
                <option value="50" <c:if test="${results.pageSize eq 50}">selected="selected"</c:if>>50</option>
                <option value="-1" <c:if test="${results.pageSize eq -1}">selected="selected"</c:if>>All</option>
            </select>
        </div>
        <div class="right">
            <c:if test="${hasFilterPanel }">
                <c:choose>
                    <c:when test="${criteria.showFilterPanel}">
                        <a href="javascript:;" class="blueBtn filterBtn hideFilter"><span class="text">Hide Filter</span><span class="arrow"></span></a>
                    </c:when>
                    <c:otherwise>
                        <a href="javascript:;" class="blueBtn filterBtn showFilter"><span class="text">Filter</span><span class="arrow"></span></a>
                    </c:otherwise>
                </c:choose>
            </c:if>
            <c:if test="${results.total > 0}">
                <a href="javascript:;" class="greyBtn deleteUserAccountModalBtn"><img src="${ctx}/i/icon-x-red.png" class="delIcon" alt=""/>Delete Selected Accounts</a>
            </c:if>
        </div>
    </div>
    <!-- /.pagination -->
</c:if>
