<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp"%>
<table
  id="screeningsTable"
  class="generalTable linedTable"
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
      <%--
        Just using 'style' below for now since this will be reworked when we add
        sortable columns to this table, and these spans will probably go away.
      --%>
      <th class="twoline">
        <span style="display: inline-block;">
          Provider<br>Type
        </span>
        <span class="sep"></span>
      </th>
      <th class="twoline">
        <span style="display: inline-block;">
          Screening<br>Type
        </span>
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
    <c:forEach
      var="screening"
      items="${screenings}"
      varStatus="status"
    >
      <tr class="${status.index % 2 == 0 ? 'odd' : 'even'}">
        <td>
          <fmt:formatDate
            value="${screening.date}"
            pattern="MM/dd/yyyy"
          />
        </td>
        <td>${screening.npi}</td>
        <td>${screening.providerName}</td>
        <td>${screening.providerType}</td>
        <td>${screening.screeningType}</td>
        <td>${screening.reason}</td>
        <td>${screening.result}</td>
        <td class="alignCenter">
          <a
            class="actionLink"
            href="${ctx}/provider/enrollment/view?id=${screening.enrollmentId}"
          >
            View
          </a>
          <a
            class="actionLink"
            href="javascript:alert('Manually re-running a screening is not currently supported.');"
            <%--
              The href for this link:
              href="${ctx}/agent/automatic-screening/${screening.screeningId}"
            --%>
          >
            Run Again
          </a>
          <a
            class="actionLink"
            href="${ctx}/agent/enrollment/screeningReview?id=${screening.enrollmentId}"
          >
            Review
          </a>
        </td>
      </tr>
    </c:forEach>
  </tbody>
</table>
