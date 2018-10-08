<%--
  Copyright 2018 The MITRE Corporation
  
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at
  
      http://www.apache.org/licenses/LICENSE-2.0
  
  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
--%>
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
            href="${ctx}/provider/application/view?id=${screening.applicationId}"
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
            href="${ctx}/agent/application/screeningReview?id=${screening.applicationId}"
          >
            Review
          </a>
        </td>
      </tr>
    </c:forEach>
  </tbody>
</table>
