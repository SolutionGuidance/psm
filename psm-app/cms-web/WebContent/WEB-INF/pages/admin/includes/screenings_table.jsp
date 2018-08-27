<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp"%>
<table
  id="screeningsTable"
  class="generalTable"
>
  <thead>
    <tr>
      <th>
        Date
        <span class="sep"></span>
      </th>
      <th>
        NPI
        <span class="sep"></span>
      </th>
      <th>
        Provider
        <span class="sep"></span>
      </th>
      <th>
        Provider Type
        <span class="sep"></span>
      </th>
      <th>
        Screening Type
        <span class="sep"></span>
      </th>
      <th>
        Reason
        <span class="sep"></span>
      </th>
      <th>
        Result
        <span class="sep"></span>
      </th>
      <th class="alignCenter">
        Action
      </th>
    </tr>
  </thead>

  <tbody>
    <c:forEach var="screening" items="${screenings}">
      <tr>
        <td><fmt:formatDate value="${screening.date}" pattern="MM/dd/yyyy"/></td>
        <td>${screening.npi}</td>
        <td>${screening.providerName}</td>
        <td>${screening.providerType}</td>
        <td>${screening.screeningType}</td>
        <td>${screening.reason}</td>
        <td>${screening.result}</td>
        <td class="alignCenter nopad">
          <a href="${ctx}/provider/enrollment/view?id=${screening.ticketId}">View</a>
          <span class="sep">|</span>        
          <a href="${ctx}/agent/automatic-screening/${screening.screeningId}">Auto Screen</a>
          <span class="sep">|</span>
          <a href="${ctx}/agent/enrollment/screeningReview?id=${screening.ticketId}">Manual Screen</a>
        </td>
      </tr>
    </c:forEach>
  </tbody>
</table>
