<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ attribute name="cssClass" required="true" %>
<a
    href="<c:url value="/provider/application/start" />"
    class="${cssClass}"
    id="createNewApplication"
    >
  Create New Application
</a>
