 <%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: This is the quick search result page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <c:set var="title" value="Search Results"/>
    <%@ include file="/WEB-INF/pages/admin/includes/html_head.jsp" %>
    <body>
        <div id="wrapper">
            <%@ include file="/WEB-INF/pages/includes/header.jsp" %>

            <div id="mainContent">
                <div class="contentWidth">
                    <div class="mainNav">
                        <%@include file="/WEB-INF/pages/includes/logo.jsp" %>
                        <%@include file="/WEB-INF/pages/includes/nav.jsp" %>
                    </div>
                    <div class="breadCrumb">
                        <span class="text">Search Results</span>
                    </div>
                    <h1>Search Results</h1>
                    <div class="tabSection" id="searchResultsSection">
                        <c:set var="enrollmentSearchFormAction" value="${ctx}/provider/search/quick"/>
                        <c:set var="searchResult" value="${results}"/>
                        <c:set var="itemsName" value="Enrollment${searchResult.total>1?'s':''} Found"/>
                        <%@ include file="/WEB-INF/pages/admin/includes/enrollment_search_form.jsp" %>
                        <div class="sectionHeader">
                            <h2>Search Results</h2>
                            <div class="tl"></div>
                            <div class="tr"></div>
                        </div>
                        <div class="tabContent">
                            <div class="pagination">
                                <%@ include file="/WEB-INF/pages/admin/includes/page_left_navigation.jsp" %>
                                <%@ include file="/WEB-INF/pages/admin/includes/enrollment_buttons.jsp" %>
                            </div>
                            <div <c:choose><c:when test="${searchCriteria.showFilterPanel}">style="display: block"</c:when><c:otherwise>style="display: none"</c:otherwise></c:choose> id="quickEnrollmentFilterPanel" class="filterPanel">
                                <div class="floatW">
                                    <div class="leftCol">
                                        <div class="row">
                                            <label>NPI/UMPI</label>
                                            <span class="floatL"><b>:</b></span>
                                            <input id="npiInput" type="text" class="normalInput" value="${searchCriteria.npi}"/>
                                        </div>
                                        <div class="row">
                                            <label>Date Submitted</label>
                                            <span class="floatL"><b>:</b></span>
                                            <span class="dateWrapper floatL">
                                                <input id="submissionDateStartInput" value='<fmt:formatDate value="${searchCriteria.submissionDateStart}" pattern="MM/dd/yyyy"/>' class="date" type="text" readonly="readonly"/>
                                            </span>
                                            <span class="floatL"> - </span>
                                            <span class="dateWrapper floatL">
                                                <input id="submissionDateEndInput"  value='<fmt:formatDate value="${searchCriteria.submissionDateEnd}" pattern="MM/dd/yyyy"/>' class="date" type="text" readonly="readonly"/>
                                            </span>
                                        </div>
                                        <div class="row">
                                            <label>Provider Type</label>
                                            <span class="floatL"><b>:</b></span>
                                            <select id="providerTypeInput" class="longSelect">
                                                <option value="">All</option>
                                                <c:forEach var="item" items="${providerTypesLookup}">
                                                    <option <c:if test="${item.description == searchCriteria.providerType}">selected="selected"</c:if> value="${item.description}">${item.description}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="row">
                                            <label>Provider Name</label>
                                            <span class="floatL"><b>:</b></span>
                                            <input id="providerNameInput" value="${searchCriteria.providerName}" type="text" class="normalInput"/>
                                        </div>
                                    </div>
                                    <div class="rightCol">
                                        <div class="row">
                                            <label>Request Type</label>
                                            <span class="floatL"><b>:</b></span>
                                            <select id="requestTypeInput" class="longSelect">
                                                <option value="">All</option>
                                                <c:forEach var="item" items="${requestTypesLookup}">
                                                    <option <c:forEach var="selectedItem" items="${searchCriteria.requestTypes}"><c:if test="${item.description == selectedItem}">selected="selected"</c:if></c:forEach> value="${item.description}">${item.description}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="row">
                                            <label>Status</label>
                                            <span class="floatL"><b>:</b></span>
                                            <select id="enrollmentStatusesInput" class="longSelect">
                                                <option value="">All</option>
                                                <c:forEach var="item" items="${enrollmentStatusesLookup}">
                                                    <option <c:forEach var="selectedItem" items="${searchCriteria.statuses}"><c:if test="${item.description == selectedItem}">selected="selected"</c:if></c:forEach> value="${item.description}">${item.description}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="row">
                                            <label>Risk Level</label>
                                            <span class="floatL"><b>:</b></span>
                                            <select id="riskLevelInput" class="longSelect">
                                                <option value="">All</option>
                                                <c:forEach var="item" items="${riskLevelsLookup}">
                                                    <option <c:forEach var="selectedItem" items="${searchCriteria.riskLevels}"><c:if test="${item.description == selectedItem}">selected="selected"</c:if></c:forEach> value="${item.description}">${item.description}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <a id="showSearchEnrollmentsResultBtn" href="javascript:;" class="purpleBtn showResultBtn"><span class="btR"><span class="btM">Filter</span></span></a>
                            </div>
                            <!-- /.filterPanel -->
                            <c:choose>
                                <c:when test="${searchResult.total == 0}">
                                    <div class="tableWrapper">
                                        <div class="tableContainer"></div>                                    
                                        <div class="tabFoot">
                                            <div class="tabR">
                                                <div class="tabM red">
                                                    No matched data found.
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="tableWrapper">
                                        <div class="tableContainer">
                                            <c:set var="addStatusColumn" value="yes"/>
                                            <c:set var="searchTableId" value="resultsTable"/>
                                            <%@ include file="/WEB-INF/pages/admin/includes/enrollment_search_result_table.jsp" %>
                                        </div>
                                        <!-- /.tableContainer -->
                                        <div class="tabFoot">
                                            <div class="tabR">
                                                <div class="tabM">
                                                    <%@ include file="/WEB-INF/pages/admin/includes/page_navigation.jsp" %>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- /.tabFoot -->
                                    </div>
                                </c:otherwise>
                            </c:choose>
                            <%@ include file="/WEB-INF/pages/admin/includes/high_risk_level_means.jsp" %>
                        </div>
                    </div>
                    <!-- /.tabSection -->
                </div>
            </div>
            <!-- /#mainContent -->
            <%@ include file="/WEB-INF/pages/includes/footer.jsp" %>
            <!-- #footer -->
        </div>
        <!-- /#wrapper -->
    </body>
</html>