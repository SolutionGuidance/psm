<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp"%>
<table
  id="${searchTableId}"
  class="generalTable fixedWidthTable"
>
  <colgroup>
    <col width="27"/>
    <col width="90"/>
    <col width="85"/>
    <col width="100"/>
    <col width="110"/>
    <col width="100"/>
    <c:if test="${addStatusColumn=='yes'}">
      <col width="70"/>
    </c:if>
    <col width="80"/>
    <col width="85"/>
    <c:choose>
      <c:when test="${addStatusColumn=='yes'}">
        <col width="214"/>
      </c:when>
      <c:otherwise>
        <col width="284"/>
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

      <c:set var="sortFieldOfEntity" value="3"/>
      <c:set var="sortColumnTitle" value="Date<br />Submitted"/>
      <c:set var="thClass" value="twoline"/>
      <%@ include file="/WEB-INF/pages/admin/includes/sort_column_header.jsp"%>
      <c:set var="thClass" value=""/>

      <c:set var="sortFieldOfEntity" value="8"/>
      <c:set var="sortColumnTitle" value="Provider Type"/>
      <%@ include file="/WEB-INF/pages/admin/includes/sort_column_header.jsp"%>

      <c:set var="sortFieldOfEntity" value="9"/>
      <c:set var="sortColumnTitle" value="Provider Name"/>
      <%@ include file="/WEB-INF/pages/admin/includes/sort_column_header.jsp"%>

      <c:set var="sortFieldOfEntity" value="4"/>
      <c:set var="sortColumnTitle" value="Request Type"/>
      <%@ include file="/WEB-INF/pages/admin/includes/sort_column_header.jsp"%>

      <c:if test="${addStatusColumn == 'yes'}">
        <c:set var="sortFieldOfEntity" value="5"/>
        <c:set var="sortColumnTitle" value="Status"/>
        <%@ include file="/WEB-INF/pages/admin/includes/sort_column_header.jsp"%>
      </c:if>

      <c:set var="sortFieldOfEntity" value="7"/>
      <c:set var="sortColumnTitle" value="Risk Level"/>
      <%@ include file="/WEB-INF/pages/admin/includes/sort_column_header.jsp"%>

      <c:set var="sortFieldOfEntity" value="6"/>
      <c:set var="sortColumnTitle" value="Status<br />Date"/>
      <c:set var="thClass" value="twoline"/>
      <%@ include file="/WEB-INF/pages/admin/includes/sort_column_header.jsp"%>
      <c:set var="thClass" value=""/>

      <th class="alignCenter">Action</th>
    </tr>
  </thead>

  <tbody>
    <c:forEach var="item" items="${searchResult.items}">
      <tr>
        <td class="alignCenter tdCheckbox">
          <input
            type="checkbox"
            title="Enrollment ${item.enrollmentId}"
            class="enrollmentRowCheckBox"
            value="${item.enrollmentId}"
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
        <td class="alignCenter nopad">
          <c:choose>
            <c:when test="${fn:toLowerCase(item.status)=='pending'}">
              <a class="viewLink" href="${ctx}/provider/enrollment/view?id=${item.enrollmentId}">
                View
              </a>
              <span class="sep">|</span>
              <a href="${ctx}/provider/enrollment/reopen?id=${item.enrollmentId}">
                Edit
              </a>
              <span class="sep">|</span>
              <c:if test="${isServiceAdministrator}">
                <a class="cosLink" href="${ctx}/agent/enrollment/pendingcos?id=${item.enrollmentId}">
                  COS
                </a>
                <span class="sep">|</span>
              </c:if>
              <c:forEach var="task" items="${tasks}">
                <c:if test="${task.processInstanceId == item.processInstanceId}">
                    <a class="reviewLink" href="${ctx}/agent/enrollment/screeningReview?id=${item.enrollmentId}">
                      Review
                    </a>
                    <span class="sep">|</span>
                </c:if>
              </c:forEach>
            </c:when>
            <c:when test="${fn:toLowerCase(item.status)=='draft'}">
              <a href="${ctx}/provider/enrollment/view?id=${item.enrollmentId}">
                Edit
              </a>
              <span class="sep">|</span>
              <c:if test="${isServiceAdministrator}">
                <a class="cosLink" href="${ctx}/agent/enrollment/pendingcos?id=${item.enrollmentId}">
                  COS
                </a>
                <span class="sep">|</span>
              </c:if>
            </c:when>
            <c:when test="${fn:toLowerCase(item.status)=='approved'}">
              <a class="viewLink" href="${ctx}/provider/enrollment/view?id=${item.enrollmentId}">
                View
              </a>
              <span class="sep">|</span>
              <a href="${ctx}/provider/profile/edit?profileId=${item.profileReferenceId}">
                Edit
              </a>
              <span class="sep">|</span>
              <c:if test="${isServiceAdministrator}">
                <a class="cosLink" href="${ctx}/agent/enrollment/cos?id=${item.profileReferenceId}">
                  COS
                </a>
                <span class="sep">|</span>
              </c:if>
              <a href="${ctx}/provider/profile/renew?profileId=${item.profileReferenceId}">
                Renew
              </a>
              <span class="sep">|</span>
            </c:when>
            <c:otherwise>
              <a class="viewLink" href="${ctx}/provider/enrollment/view?id=${item.enrollmentId}">
                View
              </a>
              <span class="sep">|</span>
            </c:otherwise>
          </c:choose>

          <c:if test="${isServiceAdministrator}">
            <a
              href="javascript:;"
              rel="${item.enrollmentId}"
              class="writeNotes"
            >
              Add Note
            </a>
            <span class="sep">|</span>
            <a
              href="javascript:;"
              rel="${item.enrollmentId}"
              class='viewNotes<c:if test="${!(fn:length(item.notes)>0)}"> hide disabledLink</c:if>'
            >
              View Notes
            </a>
            <span class="sep <c:if test="${!(fn:length(item.notes)>0)}">hide</c:if>">|</span>
          </c:if>

          <a rel="${item.enrollmentId}" class="printEnrollment" href="javascript:;">
            Print
          </a>
          <span class="sep">|</span>
          <a href="${ctx}/provider/enrollment/exportTicket?id=${item.enrollmentId}">
            Export
          </a>
        </td>
      </tr>
    </c:forEach>
  </tbody>
</table>
<%@ include file="/WEB-INF/pages/admin/includes/enrollment_notes_dialog.jsp" %>

<c:if test="${isServiceAdministrator}">
  <%-- This is how the view notes modal accesses and stores notes. --%>
  <div id="notesSection" class="hide">
    <c:forEach var="item" items="${searchResult.items}">
      <c:forEach var="noteItem" items="${item.notes}" varStatus="noteStatus">
        <%-- There needs to be no extra whitespace inside this span. --%>
        <span
          class="note_${item.enrollmentId}"
          id="note_${item.enrollmentId}_${noteStatus.count}"
        >${noteItem.text}</span>
      </c:forEach>
    </c:forEach>
  </div>
</c:if>
