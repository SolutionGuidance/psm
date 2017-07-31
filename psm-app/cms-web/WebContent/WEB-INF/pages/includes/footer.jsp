<%--
    JSP Fragment for common footer.
 --%>

<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>

<div id="footer">
    <strong>This module is open source.</strong>  <a href="https://github.com/OpenTechStrategies/psm">Contributions welcome</a>.
     <br />
     This version of the PSM is up to date as of
<c:if test="${not empty date}">
      <c:out value="${date}"/>
</c:if>
.
</div>
