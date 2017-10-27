<%--
    JSP Fragment for common navigation.

    @author j3_guile
    @version 1.0
 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<div class="nav">
    <div class="navR">
        <div class="navM">
            <ul>
                <li class="${activeTab == 1 ? 'active' : ''}">
                    <a href="<c:url value="/landing" />">DASHBOARD</a>
                    <c:if test="${activeTab == 1}"><span class="arrow"></span></c:if>
                </li>
                <li class="${activeTab == 2 ? 'active' : ''}">
                    <a href="<c:url value="/provider/dashboard/drafts" />">ENROLLMENTS</a>
                    <c:if test="${activeTab == 2}"><span class="arrow"></span></c:if>
                </li>
                <c:if test="${isServiceAdministrator}">
                <li class="${activeTab == 4 ? 'active' : ''}">
                    <a href="<c:url value="/admin/viewProviderTypes" />">FUNCTIONS</a>
                    <c:if test="${activeTab == 4}"><span class="arrow"></span></c:if>
                </li>
                </c:if>
                <li class="last ${activeTab == 3 ? 'active' : ''}">
                    <a href="<c:url value="/myprofile" />">MY PROFILE</a>
                    <c:if test="${activeTab == 3}"><span class="arrow"></span></c:if>
                </li>
            </ul>

                <div class="searchWidget">
                    <a href="${ctx}/provider/search/advanced">Advanced Search</a>
                    <div class="inputContainer">
                        <c:choose>
                            <c:when test="${param.npi!=null&&param.npi!=''}">
                                <c:set var="quickSearchNPI" value="${param.npi}"/>
                            </c:when>
                            <c:otherwise>
                                <c:set var="quickSearchNPI" value="Search Keyword"/>
                            </c:otherwise>
                        </c:choose>
                        <a id="enrollmentQuickSearch" href="${ctx}/provider/search/quick" class="search"></a> <input id="quickSearchInput" type="text" class="hint"
                            value="${quickSearchNPI}" title="Search Keyword" />
                    </div>
                </div>
        </div>
    </div>
</div>
