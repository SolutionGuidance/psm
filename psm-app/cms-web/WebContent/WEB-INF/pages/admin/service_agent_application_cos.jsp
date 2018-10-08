<%--
  Copyright 2013 TopCoder Inc.
  Copyright 2018 The MITRE Corporation
  
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at
  
      http://www.apache.org/licenses/LICENSE-2.0
  
  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
--%>
<%--
  - Description: This is the cos service agent page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="en-US">
  <c:set var="title" value="Category of Service"/>
  <h:handlebars template="includes/html_head" context="${pageContext}" />
  <body>
    <div id="wrapper">
      <h:handlebars template="includes/header" context="${pageContext}"/>

      <div id="mainContent" class="detailPage">
        <div class="contentWidth">
          <div class="mainNav">
            <h:handlebars template="includes/logo" context="${pageContext}"/>
            <h:handlebars template="includes/banner" context="${pageContext}"/>
            <c:set var="activeTabDashboard" value="true"></c:set>
            <h:handlebars template="includes/nav" context="${pageContext}"/>
          </div>
          <div class="breadCrumb">
            <a href="${ctx}/ops/viewDashboard">Dashboard</a>
            <span>Application Category of Service</span>
          </div>
          <div class="head">
            <h1>Category Of Service - ${application.profile.entity.providerType.description} - ${application.profile.entity.name}</h1>
          </div>
          <div class="tabSection">
            <c:set var="actionPath" value="${ctx}/agent/application/addCOS"/>
            <form action="${actionPath}" method="post" id="cosForm">
              <sec:csrfInput />
              <input type="hidden" name="id" value="${application.applicationId}" />
              <div class="detailPanel">
                <c:forEach var="cos" items="${existingServices}" varStatus="loop">
                  <div class="section">
                    <div class="wholeCol">
                      <div class="row">
                        <label>Start Date</label>
                        <span><fmt:formatDate value="${cos.startDate}" pattern="MM/dd/yyyy"/></span>
                      </div>
                      <div class="row">
                        <label>End Date</label>
                        <span id="edt-${cos.id}"><fmt:formatDate value="${cos.endDate}" pattern="MM/dd/yyyy"/></span>
                      </div>
                      <div class="row">
                        <label>COS</label>
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
                        <a href="javascript:;" onclick="deleteCOS(${cos.id}, ${application.applicationId});" class="greyBtn"><span class="text">Delete</span></a>
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
                      <label for="applicationCosStartDate">Start Date</label>
                      <span><input id="applicationCosStartDate" name="startDate" class="shortInput text mdate" value="" /></span>
                    </div>
                    <div class="row">
                      <label for="applicationCosEndDate">End Date</label>
                      <span><input id="applicationCosEndDate" name="endDate" class="shortInput text mdate" value="" /></span>
                    </div>
                    <div class="row">
                      <label for="applicationCosCosSelect">COS</label>
                      <select id="applicationCosCosSelect" name="cos" multiple="multiple" style="width:350px;" class="chzn-select">
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
