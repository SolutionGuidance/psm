<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<div class="pagination">
  <%@ include file="/WEB-INF/pages/includes/pagination_details_wrapper.jsp" %>
  <div class="right">
    <h:handlebars
      template="includes/pagination_links"
      context="${pageContext}"
    />
  </div>
</div>
