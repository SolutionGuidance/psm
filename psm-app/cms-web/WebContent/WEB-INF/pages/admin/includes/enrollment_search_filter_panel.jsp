<%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: it is used to render the enrollment search filter panel section.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp"%>
<div id="enrollmentFilterPanel" <c:choose><c:when test="${searchCriteria.showFilterPanel}">style="display: block"</c:when><c:otherwise>style="display: none"</c:otherwise></c:choose> class="filterPanel">
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
                    <input id="submissionDateStartInput" title="Submission Date Start" value='<fmt:formatDate value="${searchCriteria.submissionDateStart}" pattern="MM/dd/yyyy"/>' class="date" type="text" readonly="readonly"/>
                </span>
                <span class="floatL"> - </span>
                <span class="dateWrapper floatL">
                    <input id="submissionDateEndInput" title="Submission Date End" value='<fmt:formatDate value="${searchCriteria.submissionDateEnd}" pattern="MM/dd/yyyy"/>' class="date" type="text" readonly="readonly"/>
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
        </div>
        <div class="rightCol">
            <div class="row">
                <label>Provider Name</label>
                <span class="floatL"><b>:</b></span>
                <input id="providerNameInput" value="${searchCriteria.providerName}" type="text" class="normalInput"/>
            </div>
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
    <a id="showSearchEnrollmentsResultBtn" href="javascript:;" class="purpleBtn showResultBtn">Filter</a>
</div>
<div class="clearFixed"></div>
<div class="tabCorner hide">
    <div class="tabCornerR">
        <div class="tabCornerM"></div>
    </div>
</div>
<!-- /.filterPanel -->
