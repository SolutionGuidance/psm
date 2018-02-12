<%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: it is used to render the sort column header.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp"%>
<th>
    <c:choose>
        <c:when test="${searchCriteria.sortColumn == sortFieldOfEntity}">
            <a class="sortable_column" rel="${sortFieldOfEntity}" href="javascript:;"><span>${sortColumnTitle}</span>
                <c:choose>
                    <c:when test="${searchCriteria.ascending}">
                        <span class="sort-up"></span>
                    </c:when>
                    <c:otherwise>
                        <span class="sort-down"></span>
                    </c:otherwise>
                </c:choose>
            </a>
        </c:when>
        <c:otherwise>
            <a class="sortable_column" rel="${sortFieldOfEntity}" href="javascript:;"><span>${sortColumnTitle}</span></a>
        </c:otherwise>
    </c:choose>
    <span class="sep"></span>
</th>
