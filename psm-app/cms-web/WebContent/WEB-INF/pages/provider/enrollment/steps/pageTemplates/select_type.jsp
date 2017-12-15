<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<div class="tabSection">
  <form action="<c:url value="/provider/enrollment/steps/next" />"
        id="enrollmentForm"
        method="post">
    <sec:csrfInput />
    <%@include file="/WEB-INF/pages/provider/enrollment/steps/errors.jsp" %>

    <div class="detailPanel firstRegistrant" style="width: 940px;">

      <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/default/provider_type.jsp" %>

      <!-- /.section -->
      <div class="tl"></div>
      <div class="tr"></div>
      <div class="bl"></div>
      <div class="br"></div>
    </div>

    <div class="buttonBox">
      <input type="hidden" name="pageName" value="${pageName}"/>
      <button type="submit" class="nextBtn greyBtn"><span class="icon">Next</span></button>
    </div>
  </form>
</div>
