<%--
  - Author: cyberjag
  - Version: 1.0
  - Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
  -
  - Description: This is the cos service agent page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="en-US">
  <c:set var="title" value="Category of Service"/>
  <c:set var="adminPage" value="true" />
  <h:handlebars template="includes/html_head" context="${pageContext}" />
  <body>
    <div id="wrapper">
      <h:handlebars template="includes/header" context="${pageContext}"/>

      <div id="mainContent" class="detailPage">
        <div class="contentWidth">
          <div class="mainNav">
            <h:handlebars template="includes/logo" context="${pageContext}"/>
            <c:set var="activeTabDashboard" value="true"></c:set>
            <h:handlebars template="includes/nav" context="${pageContext}"/>
          </div>
          <div class="breadCrumb">
            <a href="${ctx}/ops/viewDashboard">Dashboard</a>
            <span>Enrollment Category of Service</span>
          </div>
          <div class="head">
            <h1>Category Of Service - ${profile.entity.providerType.description} - ${profile.entity.name}</h1>
          </div>
          <div class="tabSection">
            <c:set var="actionPath" value="${ctx}/agent/enrollment/addCOS"/>
            <form action="${actionPath}" method="post" id="cosForm">
              <sec:csrfInput />
              <input type="hidden" name="id" value="${profile.profileId}" />
              <div class="detailPanel">
                <c:forEach var="cos" items="${existingServices}" varStatus="loop">
                  <div class="section">
                    <div class="wholeCol">
                      <div class="row">
                        <label>Start Date</label>
                        <span class="floatL"><b>:</b></span>
                        <span><fmt:formatDate value="${cos.startDate}" pattern="MM/dd/yyyy"/></span>
                      </div>
                      <div class="row">
                        <label>End Date</label>
                        <span class="floatL"><b>:</b></span>
                        <span id="edt-${cos.id}"><fmt:formatDate value="${cos.endDate}" pattern="MM/dd/yyyy"/></span>
                      </div>
                      <div class="row">
                        <label>COS</label>
                        <span class="floatL"><b>:</b></span>
                        <span id="cats-${cos.id}">
                          <c:forEach var="cat" items="${cos.categories}" varStatus="loop2">
                            ${cat.code}
                            <c:if test="${!loop2.last}">, </c:if>
                          </c:forEach>
                        </span>
                      </div>
                      <div class="buttonBox">
                        <c:if test="${loop.last}">
                          <a href="javascript:;" onclick="copyCOS(${cos.id});" class="greyBtn"><span class="text">Clone</span></a>
                        </c:if>
                        <a href="javascript:;" onclick="deleteCOS(${cos.id}, ${profile.profileId});" class="greyBtn"><span class="text">Delete</span></a>
                      </div>
                    </div>
                  </div>
                  <!-- /.section -->
                  <div class="clearFixed"></div>
                  <div class="bottom-border">&nbsp;</div>
                </c:forEach>
                <div class="section">
                  <input type="hidden" id="prevCosId" name="prevCosId" value="0" />
                  <input type="hidden" id="prevCosEndDate" name="prevCosEndDate" value="" />
                  <div class="wholeCol">
                    <div class="row">
                      <label for="enrollmentCosStartDate">Start Date</label>
                      <span class="floatL"><b>:</b></span>
                      <span><input id="enrollmentCosStartDate" name="startDate" class="shortInput text mdate" value="" /></span>
                    </div>
                    <div class="row">
                      <label for="enrollmentCosEndDate">End Date</label>
                      <span class="floatL"><b>:</b></span>
                      <span><input id="enrollmentCosEndDate" name="endDate" class="shortInput text mdate" value="" /></span>
                    </div>
                    <div class="row">
                      <label for="enrollmentCosCosSelect">COS</label>
                      <span class="floatL"><b>:</b></span>
                      <select id="enrollmentCosCosSelect" name="cos" multiple="multiple" style="width:350px;" class="chzn-select">
                        <c:forEach var="code" items="${codes}">
                          <option value="${code.code}">${code.code}</option>
                        </c:forEach>
                      </select>
                    </div>
                  </div>
                </div>
                <!-- /.section -->
                <div class="tl"></div>
                <div class="tr"></div>
                <div class="bl"></div>
                <div class="br"></div>
              </div>
              <div class="buttonBox">
                <a href="${ctx}/provider/search/approved?statuses=Approved&showFilterPanel=true" class="greyBtn"><span class="text">Cancel</span></a>
                <button class="greyBtn submitCosFormBtn" type="submit">Save</button>
              </div>
            </form>
          </div>
          <!-- /.tabSection -->
        </div>
      </div>
      <!-- /#mainContent -->

      <h:handlebars template="includes/footer" context="${pageContext}"/>
    </div>
    <!-- /#wrapper -->
  </body>
</html>
