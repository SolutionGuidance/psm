<%-- The system admin user accounts table. --%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<c:set var="hasFilterPanel" value="true" />
<c:if test="${results.total > 0}">
  <div class="pagination">
    <%@ include file="/WEB-INF/pages/includes/pagination_details_wrapper.jsp" %>
    <%@ include file="/WEB-INF/pages/admin/includes/system_admin_buttons.jsp" %>
  </div>
</c:if>
<%@ include file="/WEB-INF/pages/admin/includes/filter-panel.jsp" %>
<c:choose>
  <c:when test="${results.total == 0}">
    <%@ include file="/WEB-INF/pages/admin/includes/no-result-section.jsp" %>
  </c:when>
  <c:otherwise>
    <div class="tableContainer">
      <table class="generalTable linedTable">
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
          <c:forEach
            var="item"
            items="${results.items}"
            varStatus="status"
          >
            <c:choose>
              <c:when test="${item.status == 'DISABLED'}">
                <c:set var="userStatusClass" value="disabledUser" />
              </c:when>
              <c:when test="${item.status == 'ACTIVE'}">
                <c:set var="userStatusClass" value="enabledUser" />
              </c:when>
              <c:otherwise>
                <c:set var="userStatusClass" value="" />
              </c:otherwise>
            </c:choose>
            <tr class="${userStatusClass} ${status.index % 2 == 0 ? 'odd' : 'even'}">
              <td class="alignCenter">
                <input
                  type="checkbox"
                  title="User ${item.userId}"
                  value="${item.userId}"
                  name="providers"
                />
              </td>
              <td>${item.username}</td>
              <td>${item.lastName}</td>
              <td>${item.firstName}</td>
              <td>${item.email}</td>
              <td class="alignCenter">
                <a
                  class="actionLink"
                  href="<c:url value='/system/user/details?role=${role}&userId=${item.userId}' />"
                >
                  View
                </a>
                <a
                  class="actionLink"
                  href="<c:url value='/system/user/edit?role=${role}&userId=${item.userId}' />"
                >
                  Edit
                </a>
                <a
                  href="<c:url value='/system/user/reinstate?userId=${item.userId}' />"
                  class="actionLink reinstateLink"
                >
                  Reinstate
                </a>
                <a
                  href="<c:url value='/system/user/suspend?userId=${item.userId}' />"
                  class="actionLink suspendLink"
                >
                  Suspend
                </a>
                <a
                  href="javascript:;"
                  class="actionLink deleteLink"
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
<c:if test="${results.total > 0}">
  <div class="tabFoot">
    <div class="tabR">
      <div class="tabM">
        <%@ include file="/WEB-INF/pages/includes/pagination_details_and_links.jsp" %>
      </div>
    </div>
  </div>
</c:if>
