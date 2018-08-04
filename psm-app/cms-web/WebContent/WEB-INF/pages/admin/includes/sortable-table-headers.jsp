<%--
 Copyright (C) 2012 TopCoder Inc., All Rights Reserved.


 The sort-able user accounts table header section.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>

<th>
    <c:choose>
        <c:when test="${criteria.sortColumn == 'username'}">
            <a
                class="sortable_column"
                rel="username"
                href="javascript:;"><span>Username</span>
                <c:choose>
                    <c:when test="${criteria.ascending}">
                        <span class="sort-up"></span>
                    </c:when>
                    <c:otherwise>
                        <span class="sort-down"></span>
                    </c:otherwise>
                </c:choose>
            </a>
        </c:when>
        <c:otherwise>
            <a
                class="sortable_column"
                rel="username"
                href="javascript:;"><span>Username</span></a>
        </c:otherwise>
    </c:choose>
    <span class="sep"></span>
</th>
<th>
    <c:choose>
        <c:when test="${criteria.sortColumn == 'lastName'}">
            <a class="sortable_column" rel="lastName" href="javascript:;"><span>Last Name</span>
                <c:choose>
                    <c:when test="${criteria.ascending}">
                        <span class="sort-up"></span>
                    </c:when>
                    <c:otherwise>
                        <span class="sort-down"></span>
                    </c:otherwise>
                </c:choose>
            </a>
        </c:when>
        <c:otherwise>
            <a class="sortable_column" rel="lastName" href="javascript:;"><span>Last Name</span></a>
        </c:otherwise>
    </c:choose>
    <span class="sep"></span>
</th>
<th>
    <c:choose>
        <c:when test="${criteria.sortColumn == 'firstName'}">
            <a class="sortable_column" rel="firstName" href="javascript:;"><span>First Name</span>
                <c:choose>
                    <c:when test="${criteria.ascending}">
                        <span class="sort-up"></span>
                    </c:when>
                    <c:otherwise>
                        <span class="sort-down"></span>
                    </c:otherwise>
                </c:choose>
            </a>
        </c:when>
        <c:otherwise>
            <a class="sortable_column" rel="firstName" href="javascript:;"><span>First Name</span></a>
        </c:otherwise>
    </c:choose>
    <span class="sep"></span>
</th>
