<%--
    JSP Fragment for common footer.
 --%>

<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>

<div id="footer">
    <strong>This module is open source (non-included version of footer).</strong>  <a href="https://github.com/OpenTechStrategies/psm">Contributions welcome</a>.
     <br />
     This version of the PSM is up to date as of
    <c:if test="${empty date}">
          <span><c:out value="string"/></span>
    </c:if>
    <c:if test="${not empty date}">
          <span><c:out value="${date}"/></span>
    </c:if>

    .
</div>
