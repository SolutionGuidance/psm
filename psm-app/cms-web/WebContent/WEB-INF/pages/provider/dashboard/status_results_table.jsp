<%--
    Provider status list results table (Draft, Pending, etc.).
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:choose>
  <c:when test="${statusFilter == 'All'}">
    <table class="generalTable linedTable dashboardTable fixedWidthTable">
  </c:when>
  <c:when test="${statusFilter != 'Draft'}">
    <table class="generalTable linedTable table-sort">
  </c:when>
  <c:otherwise>
    <table class="generalTable linedTable" id="draftTable">
  </c:otherwise>
</c:choose>

  <colgroup>
    <col width="27"/>
    <col width="90"/>
    <col width="85"/>
    <col width="90"/>
    <col width="120"/>
    <col width="85"/>
    <c:if test="${statusFilter == 'All'}">
      <col width="70"/>
    </c:if>
    <col width="80"/>
    <col width="85"/>
    <col width="*"/>
  </colgroup>

  <thead>
    <c:set
      var="sortDirCls"
      value="${criteria.ascending ? 'tablesorter-headerSortDown' : 'tablesorter-headerSortUp' }"
    />
    <tr class="tablesorter-header">
      <th class="alignCenter">
        <div class="tablesorter-header-inner">
          <input
            type="checkbox"
            title="Select All"
            class="selectAll"
            name="providerIds"
          >
          <span class="sep"></span>
        </div>
      </th>
      <th class="tablesorter-header ${sortDirCls}">
        <div class="tablesorter-header-inner">
          <a href="javascript:changeSort(2);">
            NPI/UMPI
            <span class="${criteria.sortColumn == '2' ? 'sort' : 'nosort'}"></span>
          </a>
          <span class="sep"></span>
        </div>
      </th>
      <th class="tablesorter-header twoline ${sortDirCls}">
        <div class="tablesorter-header-inner">
          <a href="javascript:changeSort(10);">
            Date<br />Created
            <span class="${criteria.sortColumn == '10' ? 'sort' : 'nosort'}"></span>
          </a>
          <span class="sep"></span>
        </div>
      </th>
      <th class="tablesorter-header twoline ${sortDirCls}">
        <div class="tablesorter-header-inner">
          <a href="javascript:changeSort(3);">
            Date<br />Submitted
            <span class="${criteria.sortColumn == '3' ? 'sort' : 'nosort'}"></span>
          </a>
          <span class="sep"></span>
        </div>
      </th>
      <th class="tablesorter-header twoline ${sortDirCls}">
        <div class="tablesorter-header-inner">
          <a href="javascript:changeSort(8);">
            Provider<br />Type
            <span class="${criteria.sortColumn == '8' ? 'sort' : 'nosort'}"></span>
          </a>
          <span class="sep"></span>
        </div>
      </th>
      <th class="tablesorter-header twoline ${sortDirCls}">
        <div class="tablesorter-header-inner">
          <a href="javascript:changeSort(4);">
            Request<br />Type
            <span class="${criteria.sortColumn == '4' ? 'sort' : 'nosort'}"></span>
          </a>
          <span class="sep"></span>
        </div>
      </th>

      <c:if test="${statusFilter == 'All'}">
        <th class="tablesorter-header ${sortDirCls}">
          <div class="tablesorter-header-inner">
            <a href="javascript:changeSort(5);">
              Status
              <span class="${criteria.sortColumn == '5' ? 'sort' : 'nosort'}"></span>
            </a>
            <span class="sep"></span>
          </div>
        </th>
      </c:if>

      <th class="tablesorter-header twoline ${sortDirCls}">
        <div class="tablesorter-header-inner">
          <a href="javascript:changeSort(11);">
            Risk<br />Level
            <span class="${criteria.sortColumn == '11' ? 'sort' : 'nosort'}"></span>
          </a>
          <span class="sep"></span>
        </div>
      </th>
      <th class="tablesorter-header twoline ${sortDirCls}">
        <div class="tablesorter-header-inner">
          <a href="javascript:changeSort(6);">
            Status<br />Date
            <span class="${criteria.sortColumn == '6' ? 'sort' : 'nosort'}"></span>
          </a>
          <span class="sep"></span>
        </div>
      </th>
      <th class="alignCenter" >
        <div class="tablesorter-header-inner">
          Action
          <a href="javascript:" class="userHelpLink actionColumnHelpLink">?</a>
        </div>
      </th>
    </tr>
  </thead>

  <tbody>
    <c:forEach var="item" items="${results.items}" varStatus="status">
      <c:url var="viewTicketLink" value="/provider/enrollment/view">
        <c:param name="id" value="${item.enrollmentId}" />
      </c:url>
      <c:url var="exportTicketLink" value="/provider/enrollment/exportTicket">
        <c:param name="id" value="${item.enrollmentId}" />
      </c:url>
      <c:set
        var="statusCls"
        value="${item.status == 'Rejected' ? 'red' : item.status == 'Approved' ? 'green' : ''}"
      />
      <c:set
        var="riskCls"
        value="${item.riskLevel == 'High' ? 'red' : item.riskLevel == 'Limited' ? 'green' : ''}"
      />

      <tr class="${status.index % 2 == 0 ? 'even' : 'odd'}">
        <td class="alignCenter tdCheckbox">
          <input
            type="checkbox"
            title="Provider ${item.enrollmentId}"
            name="providerIds"
            value="${item.enrollmentId}"
          />
        </td>
        <td>${item.npi}</td>
        <td>
          <fmt:formatDate value="${item.createDate}" pattern="MM/dd/yyyy" />
        </td>
        <td>
          <fmt:formatDate value="${item.submissionDate}" pattern="MM/dd/yyyy" />
        </td>
        <td>${item.providerType}</td>
        <td>${item.requestType}</td>

        <c:if test="${statusFilter == 'All'}">
          <td class="${statusCls}">
            ${item.status == 'Rejected' ? 'Denied' : item.status}
          </td>
        </c:if>

        <td class="${riskCls}">${item.riskLevel}</td>
        <td>
          <fmt:formatDate value="${item.statusDate}" pattern="MM/dd/yyyy" />
        </td>
        <td class="alignCenter">
          <c:choose>
            <c:when test="${item.status == 'Draft'}">
              <a
                class="actionLink"
                href="${viewTicketLink}"
              >
                Edit
              </a>
            </c:when>
            <c:otherwise>
              <a
                class="actionLink"
                href="${viewTicketLink}"
              >
                View
              </a>
            </c:otherwise>
          </c:choose>
          <a
            class="actionLink"
            href="${exportTicketLink}"
          >
            Export to PDF
          </a>
        </td>
      </tr>
    </c:forEach>
  </tbody>
</table>
