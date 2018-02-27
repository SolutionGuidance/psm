<%--
    JSP Fragment for provider status list results table.
 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:choose>
  <c:when test="${statusFilter ne 'Draft'}">
    <table cellpadding="0" cellspacing="0" class="generalTable table-sort">
  </c:when>
  <c:otherwise>
    <table cellpadding="0" cellspacing="0" class="generalTable" id="draftTable">
  </c:otherwise>
</c:choose>

    <colgroup>
        <col width="30"/>
        <col width="140"/>
        <col width="140"/>
        <col width="150"/>
        <col width="145"/>
        <c:if test="${statusFilter != 'Draft'}">
          <col width="145"/>
        </c:if>
        <col width="210"/>
    </colgroup>
    <thead>
        <c:set var="sortDirCls" value="${criteria.ascending ? 'tablesorter-headerSortDown' : 'tablesorter-headerSortUp' }"></c:set>
        <tr class="tablesorter-header">
            <th class="alignCenter"><div class="tablesorter-header-inner"><input type="checkbox" title="Select All" class="selectAll" name="providerIds"><span class="sep"></span></div></th>
            <th class="tablesorter-header ${sortDirCls}"><div class="tablesorter-header-inner"><a href="javascript:changeSort(2);"><span>NPI/UMPI</span><span class="${criteria.sortColumn eq '2' ? 'sort' : 'nosort'}"></span></a><span class="sep"></span></div></th>
            <th class="tablesorter-header ${sortDirCls}"><div class="tablesorter-header-inner"><a href="javascript:changeSort(10);"><span>Date Created</span><span class="${criteria.sortColumn eq '10' ? 'sort' : 'nosort'}"></span></a><span class="sep"></span></div></th>
            <th class="tablesorter-header ${sortDirCls}"><div class="tablesorter-header-inner"><a href="javascript:changeSort(4);"><span>Request Type</span><span class="${criteria.sortColumn eq '4' ? 'sort' : 'nosort'}"></span></a><span class="sep"></span></div></th>

            <c:if test="${statusFilter != 'Draft'}">
              <th class="tablesorter-header ${sortDirCls}"><div class="tablesorter-header-inner"><a href="javascript:changeSort(11);"><span>Risk Level</span><span class="${criteria.sortColumn eq '11' ? 'sort' : 'nosort'}"></span></a><span class="sep"></span></div></th>
            </c:if>

            <th class="tablesorter-header ${sortDirCls}"><div class="tablesorter-header-inner"><a href="javascript:changeSort(6);"><span>Status Date</span><span class="${criteria.sortColumn eq '6' ? 'sort' : 'nosort'}"></span></a><span class="sep"></span></div></th>
            <th class="alignCenter" ><div class="tablesorter-header-inner">Action</div></th>
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
            <c:set var="statusCls" value="${item.status eq 'Rejected' ? 'red' : item.status eq 'Approved' ? 'green' : ''}"></c:set>
            <c:set var="riskCls" value="${item.riskLevel eq 'High' ? 'red' : item.riskLevel eq 'Limited' ? 'green' : ''}"></c:set>

            <tr class="${status.index % 2 == 0 ? 'even' : 'odd'}">
	            <td class="alignCenter">
	                <input type="checkbox" title="Provider ${item.ticketId}" name="providerIds" value="${item.ticketId}"/>
	            </td>
                <td>
                  <c:out value="${item.npi}" />
                </td>
                <td><fmt:formatDate value="${item.createDate}" pattern="MM/dd/yyyy"/></td>
                <td><c:out value="${item.requestType}" /></td>

                <c:if test="${statusFilter != 'Draft'}">
                  <td class="${riskCls}"><c:out value="${item.riskLevel}" /></td>
                </c:if>

                <td><fmt:formatDate value="${item.statusDate}" pattern="MM/dd/yyyy"/></td>
                <td class="alignCenter">
                  <c:choose>
                    <c:when test="${item.status eq 'Draft'}">
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
