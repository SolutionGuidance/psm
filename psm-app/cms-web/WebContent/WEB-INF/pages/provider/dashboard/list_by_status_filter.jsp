<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>

<c:url var="filterResultsURL" value="/provider/dashboard/filter"/>
<form:form
  action="${filterResultsURL}"
  id="filterForm"
  cssClass="paginationForm"
  method="get"
  commandName="criteria"
>
  <div class="filterPanel" style="display: ${param.filterViewState eq 'visible' ? 'block' : 'none'};">
    <div class="floatW">
      <input type="hidden" id="filterViewStateId" name="filterViewState" value="${param.filterViewState eq 'visible' ? 'visible' : 'hidden'}"/>
      <form:hidden path="pageSize"/>
      <form:hidden path="pageNumber"/>
      <form:hidden path="sortColumn"/>
      <form:hidden path="ascending"/>
      <input type="hidden" name="status" value="${statusFilter}"/>

      <div class="leftCol">
        <div class="row">
          <label for="listByStatusNpi">NPI/UMPI</label>
          <form:input id="listByStatusNpi" path="npi" cssClass="normalInput"/>
        </div>
        <div class="row">
          <label>Date Created</label>
          <span class="dateWrapper floatL">
            <form:input title="Create Start" path="createDateStart" cssClass="date" readonly=""/>
          </span>
          <span class="floatL">
            -
          </span>
          <span class="dateWrapper floatL">
            <form:input title="Create End" path="createDateEnd" cssClass="date" readonly=""/>
          </span>
        </div>
      </div>
      <div class="rightCol">
        <div class="row">
          <label for="listByStatusRequestTypes">Request Type</label>
          <form:select id="listByStatusRequestTypes" path="requestTypes" cssClass="longSelect" multiple="false">
            <form:option value="">All</form:option>
            <form:option value="Application">Application</form:option>
            <form:option value="Renewal">Renewal</form:option>
            <form:option value="Update">Update</form:option>
            <form:option value="Import Profile">Import Profile</form:option>
          </form:select>
        </div>
        <div class="row">
          <label>Status Date</label>
          <span class="dateWrapper floatL">
            <form:input title="Status Start" path="statusDateStart" cssClass="date" readonly=""/>
          </span>
          <span class="floatL">
            -
          </span>
          <span class="dateWrapper floatL">
            <form:input title="Status End" path="statusDateEnd" cssClass="date" readonly=""/>
          </span>
        </div>
      </div>
    </div>
    <button class="purpleBtn" type="submit">Filter</button>
  </div>
</form:form>
