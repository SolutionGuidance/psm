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
    <c:forEach
      var="screening"
      items="${screenings}"
      varStatus="status"
    >
      <tr class="${status.index % 2 == 0 ? 'odd' : 'even'}">
        <td>${screening.date}</td>
        <td>${screening.npi}</td>
        <td>${screening.providerName}</td>
        <td>${screening.providerType}</td>
        <td>${screening.screeningType}</td>
        <td>${screening.reason}</td>
        <td>${screening.result}</td>
        <td class="alignCenter nopad">
          <a
            class="actionLink"
            href="#"
          >
            Auto Screen
          </a>
          <a
            class="actionLink"
            href="#"
          >
            Manual Screen
          </a>
        </td>
      </tr>
    </c:forEach>
  </tbody>
</table>
