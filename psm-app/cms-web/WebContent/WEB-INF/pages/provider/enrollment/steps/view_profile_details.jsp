<!DOCTYPE html>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="h" tagdir="/WEB-INF/tags" %>
<html lang="en-US">
  <c:set var="title" value="${pageTitle}"/>
  <h:handlebars template="includes/html_head" context="${pageContext}"/>
  <c:set var="selectedMarkup" value='selected="selected"'/>
  <body>
    <div id="wrapper">
      <h:handlebars template="includes/header" context="${pageContext}"/>
      <!-- /#header -->

      <div id="mainContent" class="detailPage">
        <div class="contentWidth">
          <div class="mainNav">
            <h:handlebars template="includes/logo" context="${pageContext}"/>
            <c:set var="activeTabProfile" value="true"></c:set>
            <h:handlebars template="includes/nav" context="${pageContext}"/>
          </div>
          <!-- /.mainNav -->
          <div class="breadCrumb">
            <a href="<c:url value="/provider/profile/" />">My Profile</a>
            <span>View Profile Details</span>
          </div>
          <div class="head">
            <h1>View Profile Details</h1>
            <a class="greyBtn iconPdf" href="<c:url value="/provider/enrollment/export" />">
              Export to PDF
            </a>
            <a class="greyBtn printModalBtn iconPrint" href="javascript:printThis();">
              Print
            </a>
          </div>

          <div class="tabSection">
            <div class="detailPanel firstRegistrant" style="width: 940px;">
              <div class="section">
                <div class="wholeCol">
                  <label>Provider Type</label>
                  <span class="floatL">
                    <b>:</b>
                  </span>
                  <span>${requestScope['_01_providerType']}</span>
                </div>
              </div>

              <!-- /.section -->
              <div class="tl"></div>
              <div class="tr"></div>
              <div class="bl"></div>
              <div class="br"></div>
            </div>
            <!-- /.detailPanel -->

            <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/common/readonly_profile.jsp" %>

          </div>
        </div>
      </div>
      <!-- /#mainContent -->

      <h:handlebars template="includes/footer" context="${pageContext}"/>
      <!-- #footer -->
      <div class="clear"></div>
    </div>
    <!-- /#wrapper -->

    <!-- /#modalBackground-->
    <div id="modalBackground"></div>
    <div id="new-modal">
      <%@include file="/WEB-INF/pages/provider/enrollment/steps/modal/print_modal.jsp" %>
      <%@include file="/WEB-INF/pages/provider/enrollment/steps/modal/stale_ticket.jsp" %>
      <%@include file="/WEB-INF/pages/provider/enrollment/steps/modal/superseded_ticket.jsp" %>
      <%@include file="/WEB-INF/pages/provider/enrollment/steps/modal/submit_enrollment.jsp" %>
      <!-- /#saveAsDraftModal-->
    </div>
    <c:if test="${not empty requestScope['flash_popup']}">
      <input type="hidden" id="flashPopUp" value="${requestScope['flash_popup']}"/>
    </c:if>
  </body>
</html>
