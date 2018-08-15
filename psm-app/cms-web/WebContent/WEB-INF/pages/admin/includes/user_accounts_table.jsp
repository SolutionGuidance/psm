<%-- The system admin user accounts table. --%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<c:set var="hasFilterPanel" value="true" />
<%@ include file="/WEB-INF/pages/admin/includes/top-pagination-section.jsp" %>
<%@ include file="/WEB-INF/pages/admin/includes/filter-panel.jsp" %>
<c:choose>
  <c:when test="${results.total == 0}">
    <%@ include file="/WEB-INF/pages/admin/includes/no-result-section.jsp" %>
  </c:when>
  <c:otherwise>
    <div class="tableContainer">
      <table class="generalTable">
        <colgroup>
          <col width="30"/>
          <col width="145"/>
          <col width="145"/>
          <col width="155"/>
          <col width="150"/>
          <col width="185"/>
        </colgroup>
        <thead>
          <tr>
            <th class="alignCenter">
              <input
                type="checkbox"
                title="Select All"
                name="providers"
                class="selectAll"
              />
              <span class="sep"></span>
            </th>
            <%@ include file="/WEB-INF/pages/admin/includes/sortable-table-headers.jsp" %>
            <th>
              Email
              <span class="sep"></span>
            </th>
            <th class="alignCenter">
              Action
            </th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="item" items="${results.items}">
            <tr
              <c:choose>
                <c:when test="${item.status == 'DISABLED'}">
                  class="disabledUser"
                </c:when>
                <c:when test="${item.status == 'ACTIVE'}">
                  class="enabledUser"
                </c:when>
              </c:choose>
            >
              <td class="alignCenter">
                <input
                  type="checkbox"
                  title="User ${item.userId}"
                  value="${item.userId}"
                  name="providers"
                />
              </td>
              <td>
                <a href="<c:url value='/system/user/details?role=${role}&userId=${item.userId}' />">
                  ${item.username}
                </a>
              </td>
              <td>${item.lastName}</td>
              <td>${item.firstName}</td>
              <td>${item.email}</td>
              <td class="alignCenter">
                <a href="<c:url value='/system/user/edit?role=${role}&userId=${item.userId}' />">
                  Edit
                </a>
                <span class="sep">|</span>
                <a
                  href="<c:url value='/system/user/reinstate?userId=${item.userId}' />"
                  class="reinstateLink"
                >
                  Reinstate
                </a>
                <a
                  href="<c:url value='/system/user/suspend?userId=${item.userId}' />"
                  class="suspendLink"
                >
                  Suspend
                </a>
                <span class="sep">|</span>
                <a
                  href="javascript:;"
                  class="deleteLink"
                >
                  Delete
                </a>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
  </c:otherwise>
</c:choose>
<!-- /.tableContainer -->
<%@ include file="/WEB-INF/pages/admin/includes/bottom-pagination-section.jsp" %>
