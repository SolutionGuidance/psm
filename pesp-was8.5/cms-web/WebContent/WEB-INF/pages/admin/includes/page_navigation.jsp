<%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: it is used to render the page navigation.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<div class="pagination">
    <%@ include file="page_left_navigation.jsp" %>
    <c:if test="${searchResult.pageSize > 0}">
        <div class="right">
            <div class="pagi">
                <c:choose>
                    <c:when test="${searchResult.pageNumber < searchResult.totalPages}">
                        <a href="javascript:;" rel="${searchResult.pageNumber + 1}" class="pagination-page-number-clickable">Next &gt;&gt;</a>
                    </c:when>
                    <c:otherwise>
                        <%-- <a href="javascript:;" class="pagination-page-number-disabled">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>  --%>
                    </c:otherwise>
                </c:choose>
                <c:set var="tempPageNum" value="${endPageNum}"/>
                <c:forEach var="item" begin="${startPageNum}" end="${endPageNum}" step="1">
                    <c:choose>
                        <c:when test="${tempPageNum==searchResult.pageNumber}">
                            <span class="pageNumber">${searchResult.pageNumber}</span>
                        </c:when>
                        <c:otherwise>
                            <a href="javascript:;" rel="${tempPageNum}" class="pagination-page-number-clickable"><fmt:formatNumber value="${tempPageNum}"  maxFractionDigits="0" /></a>
                        </c:otherwise>
                    </c:choose>
                    <c:set var="tempPageNum" value="${tempPageNum - 1}"/>
                </c:forEach>
                <c:choose>
                    <c:when test="${searchResult.pageNumber > 1}">
                        <a href="javascript:;" rel="${searchResult.pageNumber - 1}" class="pagination-page-number-clickable">&lt;&lt; Prev</a>
                    </c:when>
                    <c:otherwise>
                        <%--  <a href="javascript:;" class="pagination-page-number-disabled">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a> --%>
                    </c:otherwise>
                </c:choose>
            </div>
            <span class="floatR">Pages:</span>
        </div>
    </c:if>
</div>
