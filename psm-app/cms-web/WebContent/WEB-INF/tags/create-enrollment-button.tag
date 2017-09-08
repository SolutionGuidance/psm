<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ attribute name="cssClass" required="true" %>
<a
    href="<c:url value="/provider/enrollment/start" />"
    class="${cssClass}"
    id="createNewEnrollment"
    >
  <span class="btR"><span class="btM">Create New Enrollment</span></span>
</a>
