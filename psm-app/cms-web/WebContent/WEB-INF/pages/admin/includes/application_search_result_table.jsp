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
  id="${searchTableId}"
  class="generalTable linedTable"
>
  <colgroup>
    <c:if test="${active_application_tab=='approved'}">
      <col width="27"/>
    </c:if>
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
    <col width="*"/>
  </colgroup>

  <thead>
    <tr>
      <c:if test="${active_application_tab=='approved'}">
        <th class="alignCenter">
          <input
            type="checkbox"
            title="Select All Applications"
            id="applicationSelectAll"
            name="applicationRowCheckBox"
            class="selectAll"
            />
          <span class="sep"></span>
        </th>
      </c:if>
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
    <c:forEach
      var="item"
      items="${searchResult.items}"
      varStatus="status"
    >
      <tr class="${status.index % 2 == 0 ? 'odd' : 'even'}">
        <c:if test="${active_application_tab=='approved'}">
          <td class="alignCenter tdCheckbox">
            <input
              type="checkbox"
              title="Application ${item.applicationId}"
              class="applicationRowCheckBox"
              value="${item.applicationId}"
              />
          </td>
        </c:if>
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
              Limited
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
        <td class="alignCenter">
          <c:choose>
            <c:when test="${fn:toLowerCase(item.status)=='pending'}">
              <a
                class="actionLink viewLink"
                href="${ctx}/provider/application/view?id=${item.applicationId}"
              >
                View
              </a>
              <c:if test="${item.active}">
                <a
                  class="actionLink"
                  href="${ctx}/provider/application/reopen?id=${item.applicationId}"
                >
                  Edit
                </a>
                <c:forEach var="task" items="${tasks}">
                  <c:if test="${task.processInstanceId == item.processInstanceId}">
                      <a
                        class="actionLink reviewLink"
                        href="${ctx}/agent/application/screeningReview?id=${item.applicationId}"
                      >
                        Review
                      </a>
                  </c:if>
                </c:forEach>
              </c:if>
            </c:when>
            <c:when test="${fn:toLowerCase(item.status)=='draft'}">
              <a
                class="actionLink"
                href="${ctx}/provider/application/view?id=${item.applicationId}"
              >
                Edit
              </a>
            </c:when>
            <c:when test="${fn:toLowerCase(item.status)=='approved'}">
              <a
                class="actionLink viewLink"
                href="${ctx}/provider/application/view?id=${item.applicationId}"
              >
                View
              </a>
              <c:if test="${item.active}">
                <a
                  class="actionLink"
                  href="${ctx}/provider/profile/edit?profileId=${item.profileReferenceId}"
                >
                  Edit
                </a>
                <a
                  class="actionLink
                  href="${ctx}/provider/profile/renew?profileId=${item.profileReferenceId}"
                >
                  Renew
                </a>
              </c:if>
            </c:when>
            <c:otherwise>
              <a
                class="actionLink viewLink"
                href="${ctx}/provider/application/view?id=${item.applicationId}"
              >
                View
              </a>
            </c:otherwise>
          </c:choose>

          <c:if test="${isServiceAdministrator}">
            <a
              href="javascript:;"
              rel="${item.applicationId}"
              class="actionLink writeNotes"
            >
              Add Note
            </a>
            <a
              href="javascript:;"
              rel="${item.applicationId}"
              class='actionLink viewNotes <c:if test="${!(fn:length(item.notes)>0)}">hide disabledLink</c:if>'
            >
              View Notes
            </a>
          </c:if>

          <a
            class="actionLink"
            href="${ctx}/provider/application/exportApplication?id=${item.applicationId}"
          >
            Export
          </a>
        </td>
      </tr>
    </c:forEach>
  </tbody>
</table>
<%@ include file="/WEB-INF/pages/admin/includes/application_notes_dialog.jsp" %>

<c:if test="${isServiceAdministrator}">
  <%-- This is how the view notes modal accesses and stores notes. --%>
  <div id="notesSection" class="hide">
    <c:forEach var="item" items="${searchResult.items}">
      <c:forEach var="noteItem" items="${item.notes}" varStatus="noteStatus">
        <%-- There needs to be no extra whitespace inside this span. --%>
        <span
          class="note_${item.applicationId}"
          id="note_${item.applicationId}_${noteStatus.count}"
        >${noteItem.text}</span>
      </c:forEach>
    </c:forEach>
  </div>
</c:if>
