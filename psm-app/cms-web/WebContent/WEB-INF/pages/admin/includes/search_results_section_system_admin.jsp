<%-- The system admin search result section. --%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>

<div class="tabSection" id="searchResultsSection">
  <div class="sectionHeader">
    <h2>Search Results</h2>
    <div class="tl"></div>
    <div class="tr"></div>
  </div>
  <div class="tabContent">
    <c:if test="${results.total > 0}">
      <div class="pagination">
        <%@ include file="/WEB-INF/pages/includes/pagination_details_wrapper.jsp" %>
        <%@ include file="/WEB-INF/pages/admin/includes/system_admin_buttons.jsp" %>
      </div>
    </c:if>
    <c:if test="${hasFilterPanel}">
      <%@ include file="/WEB-INF/pages/admin/includes/filter-panel.jsp" %>
    </c:if>
    <c:choose>
      <c:when test="${results.total == 0}">
        <%@ include file="/WEB-INF/pages/admin/includes/no-result-section.jsp" %>
      </c:when>
      <c:otherwise>
        <div class="tableContainer">
          <div class="tableMain">
            <table
              class="generalTable linedTable"
              id="userAccountResultsTable"
            >
              <colgroup>
                <col width="35"/>
                <col width="125"/>
                <col width="115"/>
                <col width="135"/>
                <col width="120"/>
                <col width="120"/>
                <col width="135"/>
              </colgroup>
              <thead>
                <tr>
                  <th class="alignCenter">
                    <input
                      type="checkbox"
                      title="Select All"
                      name="search"
                      class="selectAll"
                    />
                    <span class="sep"></span>
                  </th>
                  <%@ include file="/WEB-INF/pages/admin/includes/sortable-table-headers.jsp" %>
                  <th>
                    Email
                    <span class="sep"></span>
                  </th>
                  <th>
                    Role
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
                  <tr class="${status.index % 2 == 0 ? 'odd' : 'even'}">
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
                    <td>${item.role.description}</td>
                    <td class="alignCenter">
                      <a
                        class="actionLink"
                        href="<c:url value='/admin/user/details?role=${item.role.description}&userId=${item.userId}' />"
                      >
                        View
                      </a>
                      <a
                        class="actionLink"
                        href="<c:url value='/admin/user/edit?role=${item.role.description}&userId=${item.userId}' />"
                      >
                        Edit
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
        </div>
        <!-- /.tableContainer -->
      </c:otherwise>
    </c:choose>
    <c:if test="${results.total > 0}">
      <div class="tabFoot">
        <div class="tabR">
          <div class="tabM">
            <%@ include file="/WEB-INF/pages/includes/pagination_details_and_links.jsp" %>
          </div>
        </div>
      </div>
    </c:if>
  </div>
</div>
<!-- /.tabSection -->
