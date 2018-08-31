<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<div class="right">
  <c:if test="${hasFilterPanel}">
    <c:choose>
      <c:when test="${criteria.showFilterPanel}">
        <a
          href="javascript:;"
          class="blueBtn filterBtn hideFilter"
        >
          <span class="text">
            Hide Filter
          </span>
          <span class="arrow"></span>
        </a>
      </c:when>
      <c:otherwise>
        <a
          href="javascript:;"
          class="blueBtn filterBtn showFilter"
        >
          <span class="text">
            Filter
          </span>
          <span class="arrow"></span>
        </a>
      </c:otherwise>
    </c:choose>
  </c:if>
  <c:if test="${results.total > 0}">
    <a
      href="javascript:;"
      class="greyBtn deleteUserAccountModalBtn iconXRed"
    >
      Delete Selected Accounts
    </a>
  </c:if>
</div>
