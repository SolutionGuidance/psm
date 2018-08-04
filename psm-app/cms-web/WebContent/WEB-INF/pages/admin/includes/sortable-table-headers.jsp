<%--
  Copyright 2012 TopCoder Inc.
  Copyright 2018 The MITRE Corporation
  
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at
  
      http://www.apache.org/licenses/LICENSE-2.0
  
  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
--%>
<%--
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
