 <%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: This is the advanced search page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <c:set var="title" value="Advanced Search"/>
    <%@ include file="/WEB-INF/pages/admin/includes/html_head.jsp" %>
    <body>
        <div id="wrapper">
            <%@ include file="/WEB-INF/pages/includes/header.jsp" %>
            <!-- /#header -->

            <div id="mainContent">
                <div class="contentWidth">
                    <div class="mainNav">
                        <%@include file="/WEB-INF/pages/includes/logo.jsp" %>
                        <%@include file="/WEB-INF/pages/includes/nav.jsp" %>
                    </div>
                    <!-- /.mainNav -->
                    <div class="breadCrumb">
                        <span class="text">Advanced Search</span>
                    </div>
                    <h1>Advanced Search</h1>
                    <div class="tabSection" id="advancedSearch">
                        <c:set var="enrollmentSearchFormAction" value="${ctx}/provider/search/advanced"/>
                        <c:set var="searchResult" value="${results}"/>
                        <c:set var="itemsName" value="Enrollment${searchResult.total>1?'s':''} Found"/>
                        <%@ include file="/WEB-INF/pages/admin/includes/enrollment_search_form.jsp" %>
                        <div class="detailPanel" id="advancedFilterPanel">
                            <div class="section">
                                <div class="leftCol">
                                    <div class="row">
                                        <label>Enrollment #</label>
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
                                <!-- /.leftCol -->
                                <div class="rightCol">
                                    <div class="row checkRow">
                                        <label>Request Type</label>
                                        <span class="floatL"><b>:</b></span>
                                        <div class="checkWrapper">
                                            <input type="checkbox" name="requestType" class="checkAll" />
                                            <span class="label">All</span>
                                            <c:forEach var="item" items="${requestTypesLookup}">
                                                <input type="checkbox" name="requestType" class="requestType" value="${item.description}" <c:forEach var="selectedItem" items="${searchCriteria.requestTypes}"><c:if test="${item.description == selectedItem}">checked="checked"</c:if></c:forEach>/>
                                                <span class="label">${item.description}</span>
                                            </c:forEach>
                                        </div>
                                    </div>
                                    <div class="row checkRow">
                                        <label>Status</label>
                                        <span class="floatL"><b>:</b></span>
                                        <div class="checkWrapper">
                                            <input type="checkbox" name="enrollmentStatus" class="checkAll" />
                                            <span class="label">All</span>
                                            <c:forEach var="item" items="${enrollmentStatusesLookup}">
                                                <input type="checkbox" name="enrollmentStatus" class="enrollmentStatus" value="${item.description}" <c:forEach var="selectedItem" items="${searchCriteria.statuses}"><c:if test="${item.description == selectedItem}">checked="checked"</c:if></c:forEach>/>
                                                <span class="label">${item.description eq 'Rejected' ? 'Denied' : item.description}</span>
                                            </c:forEach>
                                        </div>
                                    </div>
                                    <div class="row checkRow">
                                        <label>Risk Level</label>
                                        <span class="floatL"><b>:</b></span>
                                        <div class="checkWrapper">
                                            <input type="checkbox" name="riskLevel" class="checkAll" />
                                            <span class="label">All</span>
                                            <c:forEach var="item" items="${riskLevelsLookup}">
                                                <input type="checkbox" name="riskLevel" class="riskLevel" value="${item.description}" <c:forEach var="selectedItem" items="${searchCriteria.riskLevels}"><c:if test="${item.description == selectedItem}">checked="checked"</c:if></c:forEach>/>
                                                <span class="label">${item.description}</span>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                                <!-- /.rightCol -->
                                <div class="clearFixed"></div>
                            </div>
                            <!-- /.section -->
                            <div class="tl"></div>
                            <div class="tr"></div>
                        </div>
                        <div class="clearFixed"></div>
                        <div class="buttons">
                            <a id="showSearchEnrollmentsResultBtn" href="javascript:;" class="purpleBtn advancedSearchBtn"><span class="btR"><span class="btM"><span class="icon">Search</span><span class="arrow"></span></span></span></a>
                        </div>
                    </div>
                    <!-- /.tabSection -->
                    <div class="tabSection" id="searchResultsSection">
                        <div class="sectionHeader">
                            <h2>Search Results</h2>
                            <div class="tl"></div>
                            <div class="tr"></div>
                        </div>
                        <c:choose>
                            <c:when test="${searchResult.total == 0}">
                                <div class="tabContent">
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
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="tabContent">
                                    <div class="pagination">
                                        <%@ include file="/WEB-INF/pages/admin/includes/page_left_navigation.jsp" %>
                                        <div class="right">
                                            <a id="exportEnrollmentsToPDF" href="javascript:;" class="greyBtn"><span class="btR"><span class="btM"><img src="${ctx}/i/icon-pdf.png" alt=""/>Export to PDF</span></span></a>
                                            <a id="printEnrollments" href="javascript:;" class="greyBtn"><span class="btR"><span class="btM"><img src="${ctx}/i/icon-print.png" alt=""/>Print</span></span></a>
                                        </div>
                                    </div>
                                    <!-- /.pagination -->
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
                                    <%@ include file="/WEB-INF/pages/admin/includes/high_risk_level_means.jsp" %>
                                </div>
                            </c:otherwise>
                        </c:choose>

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