<%--
 Copyright (C) 2012 TopCoder Inc., All Rights Reserved.

 @author TCSASSEMBLER
 @version 1.0

 The advanced search results page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<%@ include file="/WEB-INF/pages/admin/includes/advanced-search-section.jsp" %>

<c:set var="hasFilterPanel" value="false" />
<%@ include file="/WEB-INF/pages/admin/includes/search-result-section.jsp" %>

        <!-- /.tabSection -->
      </div>
    </div>
    <!-- /#mainContent -->
    <h:handlebars template="includes/footer" context="${pageContext}"/>
    <!-- #footer -->
    <div class="clear"></div>
    </div>
    <!-- /#wrapper -->
    <%@ include file="/WEB-INF/pages/admin/includes/modal.jsp" %>
    <input type="hidden" value="<c:url value='/admin/user/list' />" id="userAccountsURL" />
    <input type="hidden" value="<c:url value='/system/search/delete' />" id="deleteAccountsURL" />
  </body>
</html>
