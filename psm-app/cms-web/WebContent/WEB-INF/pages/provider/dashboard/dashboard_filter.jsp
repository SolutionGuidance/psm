<%--
    JSP Fragment for provider dashboard filter.

    @author j3_guile
    @version 1.0
 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:url var="filterResultsURL" value="/provider/dashboard/list/filter" />
<form:form action="${filterResultsURL}" id="paginationForm" method="get" commandName="criteria">
<div class="filterPanel" style="display: ${param.filterViewState eq 'visible' ? 'block' : 'none'};">
    <div class="floatW">
        <input type="hidden" id="filterViewStateId" name="filterViewState" value="${param.filterViewState eq 'visible' ? 'visible' : 'hidden'}" />
        <form:hidden path="pageSize" />
        <form:hidden path="pageNumber" />
        <form:hidden path="sortColumn" />
        <form:hidden path="ascending" />

        <div class="leftCol">
            <div class="row">
                <label>NPI/UMPI</label>
                <span class="floatL"><b>:</b></span>
                <form:input path="npi" cssClass="normalInput"/>
            </div>
            <div class="row">
                <label>Request Type</label>
                <span class="floatL"><b>:</b></span>
                <form:select path="requestTypes" cssClass="longSelect" multiple="false">
                    <form:option value="">All</form:option>
                    <form:option value="Enrollment">Enrollment</form:option>
                    <form:option value="Renewal">Renewal</form:option>
                    <form:option value="Update">Update</form:option>
                    <form:option value="Import Profile">Import Profile</form:option>
                </form:select>
            </div>
            <div class="row">
                <label>Date Submitted</label>
                <span class="floatL"><b>:</b></span>
                <span class="dateWrapper floatL">
                    <form:input path="submissionDateStart" cssClass="date" readonly=""/>
                </span>
                <span class="floatL"> - </span>
                <span class="dateWrapper floatL">
                    <form:input path="submissionDateEnd" cssClass="date" readonly=""/>
                </span>
            </div>
        </div>
        <div class="rightCol">
            <div class="row">
                <label>Status</label>
                <span class="floatL"><b>:</b></span>
                <form:select path="statuses" cssClass="longSelect" multiple="false">
                    <form:option value="">All</form:option>
                    <form:option value="Draft">Draft</form:option>
                    <form:option value="Pending">Pending</form:option>
                    <form:option value="Approved">Approved</form:option>
                    <form:option value="Rejected">Denied</form:option>
                </form:select>
            </div>
            <div class="row">
                <label>Risk Level</label>
                <span class="floatL"><b>:</b></span>
                <form:select path="riskLevel" cssClass="longSelect">
                    <form:option value="">All</form:option>
                    <form:option value="NULL">Not screened yet</form:option>
                    <form:option value="Low">Low</form:option>
                    <form:option value="Moderate">Moderate</form:option>
                    <form:option value="High">High</form:option>
                </form:select>
            </div>
            <div class="row">
                <label>Status Date</label>
                <span class="floatL"><b>:</b></span>
                <span class="dateWrapper floatL">
                    <form:input title="Status Start" path="statusDateStart" cssClass="date" readonly=""/>
                </span>
                <span class="floatL"> - </span>
                <span class="dateWrapper floatL">
                    <form:input title="Status End" path="statusDateEnd" cssClass="date" readonly=""/>
                </span>
            </div>
        </div>
    </div>
    <button class="purpleBtn" type="submit">Filter</button>
</div>
</form:form>
