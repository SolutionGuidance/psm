<%--
    Provider dashboard table.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<table class="generalTable dashboardTable fixedWidthTable">

  <colgroup>
    <col width="105"/>
    <col width="120"/>
    <col width="135"/>
    <col width="110"/>
    <col width="85"/>
    <col width="90"/>
    <col width="110"/>
    <col width="*"/>
  </colgroup>

  <thead>
    <c:set
      var="sortDirCls"
      value="${criteria.ascending ? 'tablesorter-headerSortDown' : 'tablesorter-headerSortUp' }"
    />
    <tr class="tablesorter-header">
      <th class="tablesorter-header ${sortDirCls}">
        <div class="tablesorter-header-inner">
          <a href="javascript:changeSort(2);">
            NPI/UMPI
            <span class="${criteria.sortColumn == '2' ? 'sort' : 'nosort'}"></span>
          </a>
          <span class="sep"></span>
        </div>
      </th>
      <th class="tablesorter-header ${sortDirCls}">
        <div class="tablesorter-header-inner">
          <a href="javascript:changeSort(3);">
            Date Submitted
            <span class="${criteria.sortColumn == '3' ? 'sort' : 'nosort'}"></span>
          </a>
          <span class="sep"></span>
        </div>
      </th>
      <th class="tablesorter-header ${sortDirCls}">
        <div class="tablesorter-header-inner">
          <a href="javascript:changeSort(8);">
            Provider Type
            <span class="${criteria.sortColumn == '8' ? 'sort' : 'nosort'}"></span>
          </a>
          <span class="sep"></span>
        </div>
      </th>
      <th class="tablesorter-header ${sortDirCls}">
        <div class="tablesorter-header-inner">
          <a href="javascript:changeSort(4);">
            Request Type
            <span class="${criteria.sortColumn == '4' ? 'sort' : 'nosort'}"></span>
          </a>
          <span class="sep"></span>
        </div>
      </th>
      <th class="tablesorter-header ${sortDirCls}">
        <div class="tablesorter-header-inner">
          <a href="javascript:changeSort(5);">
            Status
            <span class="${criteria.sortColumn == '5' ? 'sort' : 'nosort'}"></span>
          </a>
          <span class="sep"></span>
        </div>
      </th>
      <th class="tablesorter-header ${sortDirCls}">
        <div class="tablesorter-header-inner">
          <a href="javascript:changeSort(11);">
            Risk Level
            <span class="${criteria.sortColumn == '11' ? 'sort' : 'nosort'}"></span>
          </a>
          <span class="sep"></span>
        </div>
      </th>
      <th class="tablesorter-header ${sortDirCls}">
        <div class="tablesorter-header-inner">
          <a href="javascript:changeSort(6);">
            Status Date
            <span class="${criteria.sortColumn == '6' ? 'sort' : 'nosort'}"></span>
          </a><span class="sep"></span>
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
      <c:url var="previewTicketLink" value="/provider/enrollment/preview">
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

      <tr>
        <td class="primary">${item.npi}</td>
        <td>
          <fmt:formatDate value="${item.submissionDate}" pattern="MM/dd/yyyy" />
        </td>
        <td>${item.providerType}</td>
        <td>${item.requestType}</td>
        <td class="${statusCls}">
          ${item.status == 'Rejected' ? 'Denied' : item.status}
        </td>
        <td class="${riskCls}">${item.riskLevel}</td>
        <td>
          <fmt:formatDate value="${item.statusDate}" pattern="MM/dd/yyyy" />
        </td>
        <td class="alignCenter">
          <c:choose>
            <c:when test="${item.status == 'Draft'}">
              <a href="${viewTicketLink}">
                Edit
              </a>
            </c:when>
            <c:otherwise>
              <a href="${viewTicketLink}">
                View
              </a>
            </c:otherwise>
          </c:choose>
          <span class="sep">|</span>
          <a href="${previewTicketLink}" class="printModalBtn printMe">
            Print
          </a>
          <span class="sep">|</span>
          <a href="${exportTicketLink}">
            Export to PDF
          </a>
        </td>
      </tr>
    </c:forEach>
  </tbody>
</table>
