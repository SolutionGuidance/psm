<%--
  The filter panel for: admin user login > Screenings > All/Passed/Failed/etc.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp"%>
<div
  id="screeningsTabFilterPanel"
  <c:choose>
    <c:when test="${searchCriteria.showFilterPanel}">
      style="display: block"
    </c:when>
    <c:otherwise>
      style="display: none"
    </c:otherwise>
  </c:choose>
  class="filterPanel screeningsTabFilterPanel"
>

  <div class="floatW">
    <div class="leftCol">
      <div class="row">
        <input id="recentScreeningsFilterInput" type="checkbox" value="" />
        <label style="width:90%">
          Most recent screenings (per provider and screening type)
        </label>
      </div>
    </div>
    <div class="rightCol">
      <div class="row">
        <input id="rescreeningsFilterInput" type="checkbox" value="" />
        <label style="width:90%">
          Re-screenings
        </label>
      </div>
    </div>
  </div>

  <a
    id="screeningsTabFilterBtn"
    href="javascript:;"
    class="purpleBtn showResultBtn"
  >
    Filter
  </a>

</div>
<div class="clearFixed"></div>
<!-- /.filterPanel -->
