<%--
    JSP Fragment for provider status list results table.
 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:choose>
  <c:when test="${statusFilter != 'Draft'}">
    <table class="generalTable table-sort">
  </c:when>
  <c:otherwise>
    <table class="generalTable" id="draftTable">
  </c:otherwise>
</c:choose>

  <colgroup>
    <col width="30"/>
    <col width="120"/>
    <col width="120"/>
    <col width="130"/>
    <col width="120"/>
    <col width="120"/>
    <c:if test="${statusFilter != 'Draft'}">
      <col width="120"/>
    </c:if>
    <col width="*"/>
  </colgroup>

  <thead>
    <c:set var="sortDirCls" value="${criteria.ascending ? 'tablesorter-headerSortDown' : 'tablesorter-headerSortUp' }" />
    <tr class="tablesorter-header">
      <th class="alignCenter">
        <div class="tablesorter-header-inner">
          <input type="checkbox" title="Select All" class="selectAll" name="providerIds">
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
      <th class="tablesorter-header ${sortDirCls}">
        <div class="tablesorter-header-inner">
          <a href="javascript:changeSort(10);">
            Date Created
            <span class="${criteria.sortColumn == '10' ? 'sort' : 'nosort'}"></span>
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

      <c:if test="${statusFilter != 'Draft'}">
        <th class="tablesorter-header ${sortDirCls}">
          <div class="tablesorter-header-inner">
            <a href="javascript:changeSort(11);">
              Risk Level
              <span class="${criteria.sortColumn == '11' ? 'sort' : 'nosort'}"></span>
            </a>
            <span class="sep"></span>
          </div>
        </th>
      </c:if>

      <th class="tablesorter-header ${sortDirCls}">
        <div class="tablesorter-header-inner">
          <a href="javascript:changeSort(6);">
            Status Date
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
        <c:param name="id" value="${item.ticketId}" />
      </c:url>
      <c:url var="previewTicketLink" value="/provider/enrollment/preview">
        <c:param name="id" value="${item.ticketId}" />
      </c:url>
      <c:url var="exportTicketLink" value="/provider/enrollment/exportTicket">
        <c:param name="id" value="${item.ticketId}" />
      </c:url>
      <c:set var="statusCls" value="${item.status == 'Rejected' ? 'red' : item.status == 'Approved' ? 'green' : ''}" />
      <c:set var="riskCls" value="${item.riskLevel == 'High' ? 'red' : item.riskLevel == 'Limited' ? 'green' : ''}" />

      <tr class="${status.index % 2 == 0 ? 'even' : 'odd'}">
        <td class="alignCenter">
          <input type="checkbox" title="Provider ${item.ticketId}" name="providerIds" value="${item.ticketId}" />
        </td>
        <td>
          <c:out value="${item.npi}" />
        </td>
        <td>
          <fmt:formatDate value="${item.createDate}" pattern="MM/dd/yyyy" />
        </td>
        <td>${item.providerType}</td>
        <td>
          <c:out value="${item.requestType}" />
        </td>

        <c:if test="${statusFilter != 'Draft'}">
          <td class="${riskCls}">
            <c:out value="${item.riskLevel}" />
          </td>
        </c:if>

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
