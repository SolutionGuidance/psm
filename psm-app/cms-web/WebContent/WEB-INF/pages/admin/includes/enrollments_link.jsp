<c:choose>
  <c:when test="${isServiceAdministrator}">
    <a href="<c:url value="/provider/enrollments/all?showFilterPanel=true" />">
      Enrollments
    </a>
  </c:when>
  <c:otherwise>
    <a href="<c:url value="/provider/dashboard/" />">
      Enrollments
    </a>
  </c:otherwise>
</c:choose>
