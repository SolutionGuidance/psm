<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp"%>
<table
  id="${searchTableId}"
  class="generalTable fixedWidthTable ${active_enrollment_tab eq 'notes' ? 'table-enrollment-notes-sort' : ''}"
>
  <colgroup>
    <c:choose>
      <c:when test="${active_enrollment_tab=='notes'}">
        <col width="32"/>
        <col width="95"/>
        <col width="81"/>
        <col width="97"/>
        <col width="109"/>
        <col width="100"/>
        <col width="81"/>
        <col width="90"/>
        <col width="81"/>
        <col width="183"/>
      </c:when>
      <c:when test="${addStatusColumn=='yes'}">
        <col width="27"/>
        <col width="87"/>
        <col width="112"/>
        <col width="100"/>
        <col width="115"/>
        <col width="100"/>
        <col width="65"/>
        <col width="84"/>
        <col width="90"/>
        <col width="181"/>
      </c:when>
      <c:otherwise>
        <col width="42"/>
        <col width="109"/>
        <col width="118"/>
        <col width="107"/>
        <col width="115"/>
        <col width="106"/>
        <col width="87"/>
        <col width="96"/>
        <col width="181"/>
      </c:otherwise>
    </c:choose>
  </colgroup>

  <thead>
    <tr>
      <th class="alignCenter">
        <input
          type="checkbox"
          title="Select All Enrollments"
          id="enrollmentSelectAll"
          name="enrollmentRowCheckBox"
          class="selectAll"
          />
        <span class="sep"></span>
      </th>
      <c:set var="sortFieldOfEntity" value="2"/>
      <c:set var="sortColumnTitle" value="NPI/UMPI"/>
      <%@ include file="/WEB-INF/pages/admin/includes/sort_column_header.jsp"%>

      <c:choose>
        <c:when test="${active_enrollment_tab=='notes'}">
          <th class="towline">
            <c:choose>
              <c:when test="${searchCriteria.sortColumn == '3'}">
                <a class="sortable_column" rel="3" href="javascript:;">
                  <span>Date<br />Submitted</span>
                  <c:choose>
                    <c:when test="${searchCriteria.ascending}">
                      <span class="sort-up"></span>
                    </c:when>
                    <c:otherwise>
                      <span class="sort-down"></span>
                    </c:otherwise>
                  </c:choose>
                </a>
              </c:when>
              <c:otherwise>
                <a class="sortable_column" rel="3" href="javascript:;">
                  <span>Date<br />Submitted</span>
                </a>
              </c:otherwise>
            </c:choose>
            <span class="sep"></span>
          </th>
        </c:when>
        <c:otherwise>
          <c:set var="sortFieldOfEntity" value="3"/>
          <c:set var="sortColumnTitle" value="Date Submitted"/>
          <%@ include file="/WEB-INF/pages/admin/includes/sort_column_header.jsp"%>
        </c:otherwise>
      </c:choose>
      <c:set var="sortFieldOfEntity" value="8"/>
      <c:set var="sortColumnTitle" value="Provider Type"/>
      <%@ include file="/WEB-INF/pages/admin/includes/sort_column_header.jsp"%>

      <c:set var="sortFieldOfEntity" value="9"/>
      <c:set var="sortColumnTitle" value="Provider Name"/>
      <%@ include file="/WEB-INF/pages/admin/includes/sort_column_header.jsp"%>

      <c:set var="sortFieldOfEntity" value="4"/>
      <c:set var="sortColumnTitle" value="Request Type"/>
      <%@ include file="/WEB-INF/pages/admin/includes/sort_column_header.jsp"%>

      <c:if test="${addStatusColumn=='yes'}">
        <c:set var="sortFieldOfEntity" value="5"/>
        <c:set var="sortColumnTitle" value="Status"/>
        <%@ include file="/WEB-INF/pages/admin/includes/sort_column_header.jsp"%>
      </c:if>

      <c:set var="sortFieldOfEntity" value="7"/>
      <c:set var="sortColumnTitle" value="Risk Level"/>
      <%@ include file="/WEB-INF/pages/admin/includes/sort_column_header.jsp"%>

      <c:set var="sortFieldOfEntity" value="6"/>
      <c:set var="sortColumnTitle" value="Status Date"/>
      <%@ include file="/WEB-INF/pages/admin/includes/sort_column_header.jsp"%>
      <c:if test="${active_enrollment_tab=='notes'}">
        <th class="alignCenter">Notes<span class="sep"></span></th>
      </c:if>
      <th class="alignCenter">Action</th>
    </tr>
  </thead>

  <tbody>
    <c:forEach var="item" items="${searchResult.items}">
      <tr>
        <td class="alignCenter">
          <input
            type="checkbox"
            title="Enrollment ${item.ticketId}"
            class="enrollmentRowCheckBox"
            value="${item.ticketId}"
            />
        </td>
        <td>
          ${item.npi}
        </td>
        <td>
          <fmt:formatDate value="${item.submissionDate}" pattern="MM/dd/yyyy"/>
        </td>
        <td>${item.providerType}</td>
        <td>${item.providerName}</td>
        <td>${item.requestType}</td>
        <c:if test="${addStatusColumn=='yes'}">
          <td>
            <c:choose>
              <c:when test="${fn:toLowerCase(item.status)=='approved'}">
                <span class="green">
                  Approved
                </span>
              </c:when>
              <c:when test="${fn:toLowerCase(item.status)=='rejected'}">
                <span class="red">
                  Denied
                </span>
              </c:when>
              <c:otherwise>
                ${item.status}
              </c:otherwise>
            </c:choose>
          </td>
        </c:if>
        <c:choose>
          <c:when test="${fn:toLowerCase(item.riskLevel)=='limited'}">
            <td class="green">
              Low
            </td>
          </c:when>
          <c:when test="${fn:toLowerCase(item.riskLevel)=='high'}">
            <td class="red">
              High
            </td>
          </c:when>
          <c:otherwise><td>${item.riskLevel}</td></c:otherwise>
        </c:choose>
        <td><fmt:formatDate value="${item.statusDate}" pattern="MM/dd/yyyy"/></td>
        <c:if test="${active_enrollment_tab=='notes'}">
          <td class="alignCenter">
            <a
              href="javascript:;"
              rel="${item.ticketId}"
              class="writeNotes"
              >
              Write
            </a>
            <span class="sep <c:if test="${!(fn:length(item.notes)>0)}">hide</c:if>">|</span>
            <a
              href="javascript:;"
              rel="${item.ticketId}"
              class='viewNotes<c:if test="${!(fn:length(item.notes)>0)}"> hide disabledLink</c:if>'
              >
              View
            </a>
            <div id="notesSection" class="hide">
              <c:forEach var="noteItem" items="${item.notes}" varStatus="noteStatus">
                <span
                  class="note_${item.ticketId}"
                  id="note_${item.ticketId}_${noteStatus.count}"
                  >
                  ${noteItem.text}
                </span>
              </c:forEach>
            </div>
          </td>
        </c:if>
        <td class="alignCenter nopad">
          <c:choose>
            <c:when test="${fn:toLowerCase(item.status)=='pending'}">
              <a class="viewLink" href="${ctx}/provider/enrollment/view?id=${item.ticketId}">
                View
              </a>
              <span class="sep">|</span>
              <a href="${ctx}/provider/enrollment/reopen?id=${item.ticketId}">
                Edit
              </a>
              <span class="sep">|</span>
              <a class="cosLink" href="${ctx}/agent/enrollment/pendingcos?id=${item.ticketId}">
                COS
              </a>
              <span class="sep">|</span>
              <c:forEach var="task" items="${tasks}">
                <c:if test="${task.processInstanceId == item.processInstanceId}">
                    <a class="reviewLink" href="${ctx}/agent/enrollment/screeningReview?id=${item.ticketId}">
                      Review
                    </a>
                    <span class="sep">|</span>
                </c:if>
              </c:forEach>
            </c:when>
            <c:when test="${fn:toLowerCase(item.status)=='draft'}">
              <a href="${ctx}/provider/enrollment/view?id=${item.ticketId}">
                Edit
              </a>
              <span class="sep">|</span>
              <a class="cosLink" href="${ctx}/agent/enrollment/pendingcos?id=${item.ticketId}">
                COS
              </a>
              <span class="sep">|</span>
            </c:when>
            <c:when test="${fn:toLowerCase(item.status)=='approved'}">
              <a class="viewLink" href="${ctx}/provider/enrollment/view?id=${item.ticketId}">
                View
              </a>
              <span class="sep">|</span>
              <a href="${ctx}/provider/profile/edit?profileId=${item.profileReferenceId}">
                Edit
              </a>
              <span class="sep">|</span>
              <a class="cosLink" href="${ctx}/agent/enrollment/cos?id=${item.profileReferenceId}">
                COS
              </a>
              <span class="sep">|</span>
              <a href="${ctx}/provider/profile/renew?profileId=${item.profileReferenceId}">
                Renew
              </a>
              <span class="sep">|</span>
            </c:when>
            <c:otherwise>
              <a class="viewLink" href="${ctx}/provider/enrollment/view?id=${item.ticketId}">
                View
              </a>
              <span class="sep">|</span>
            </c:otherwise>
          </c:choose>
          <a rel="${item.ticketId}" class="printEnrollment" href="javascript:;">
            Print
          </a>
          <span class="sep">|</span>
          <a href="${ctx}/provider/enrollment/exportTicket?id=${item.ticketId}">
            Export
          </a>
        </td>
      </tr>
    </c:forEach>
  </tbody>
</table>
