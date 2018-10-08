<%--
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
<!DOCTYPE html>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
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
            <h:handlebars template="includes/banner" context="${pageContext}"/>
            <c:set var="activeTabApplications" value="true"></c:set>
            <h:handlebars template="includes/nav" context="${pageContext}"/>
          </div>
          <!-- /.mainNav -->
          <div class="breadCrumb">
            <%@ include file="/WEB-INF/pages/admin/includes/applications_link.jsp" %>
            <span>Edit Application</span>
          </div>
          <div class="head">
            <h1>Edit Application</h1>
          </div>

          <div class="tabSection">

            <form action="<c:url value="/provider/application/steps/rebind" />"
                id="changeProviderTypeForm"
                method="post"
                enctype="multipart/form-data">
              <sec:csrfInput />
              <c:if test="${isReopened}">
                <div class="detailPanel" style="width: 940px;">
                  <div class="section">
                    <div class="col1">
                      <div class="row">
                        <label>Request Type</label>
                        <span>${requestScope['_99_requestType']}</span>
                      </div>
                      <div class="row">
                        <label>Status</label>
                        <span>${requestScope['_99_requestStatus'] eq 'Rejected' ? 'Denied' : requestScope['_99_requestStatus']}</span>
                      </div>
                    </div>
                    <div class="col2">
                      <div class="row">
                        <label>Submitted On</label>
                        <span>${requestScope['_99_submittedOn']}</span>
                      </div>
                      <div class="row">
                        <label>Status Date</label>
                        <span>${requestScope['_99_statusDate']}</span>
                      </div>
                    </div>
                    <div class="col3">
                      <div class="row">
                        <label>Risk Level</label>
                        <span>${requestScope['_99_riskLevel']}</span>
                      </div>
                    </div>
                  </div>
                  <!-- /.section -->
                  <div class="tl"></div>
                  <div class="tr"></div>
                  <div class="bl"></div>
                  <div class="br"></div>
                </div>

              </c:if>

              <div class="detailPanel firstRegistrant" style="width: 940px;">

                <%@include file="/WEB-INF/pages/provider/application/steps/pageTemplates/default/provider_type.jsp" %>
                <!-- /.section -->
                <div class="tl"></div>
                <div class="tr"></div>
                <div class="bl"></div>
                <div class="br"></div>
              </div>
            </form>

            <!-- /.errorInfo -->
            <div class="clear"></div>
            <%@include file="/WEB-INF/pages/provider/application/steps/errors.jsp" %>

            <!-- /.detailPanel -->
            <form action="<c:url value="/provider/application/page" />"
                  id="applicationForm"
                  method="post"
                  enctype="multipart/form-data">
              <sec:csrfInput />
              <input type="hidden" name="pageName" value="${pageName}"/>

            <div class="tabHead" style="width: 958px;">
              <div class="tabR">
                <div class="tabM">
                  <c:forEach var="tabName" items="${viewModel.tabNames}" varStatus="status">
                    <c:if test="${tabName ne 'Summary Information'}">
                      <c:set var="tabLabel" value=""></c:set>
                      <c:set var="tabCls" value=""></c:set>
                      <c:set var="tabActiveCls" value=""></c:set>
                      <%@include file="/WEB-INF/pages/provider/application/steps/pageTemplates/common/tab_name_mapping.jsp" %>
                      <c:if test="${viewModel.currentTab eq tabName}">
                        <c:set var="tabActiveCls" value="active"></c:set>
                      </c:if>
                      <c:url var="tabLink" value="/provider/application/jump">
                        <c:param name="page" value="${tabName}"></c:param>
                      </c:url>
                      <a href="javascript:submitFormById('applicationForm', '${tabLink}')"
                        class="tab ${tabCls} ${tabActiveCls}">
                        <span class="aR">
                          <span class="aM">${tabLabel}</span>
                        </span>
                      </a>
                    </c:if>
                  </c:forEach>
                  <%-- always show notes tab on edit --%>
                  <c:if test="${viewModel.currentTab eq 'Notes'}">
                    <c:set var="tabActiveCls" value="active"></c:set>
                  </c:if>
                  <c:url var="tabLink" value="/provider/application/jump">
                    <c:param name="page" value="Notes"></c:param>
                  </c:url>
                  <a href="javascript:submitFormById('applicationForm', '${tabLink}')"
                    class="tab notesTab ${tabActiveCls}">
                    <span class="aR">
                      <span class="aM">Notes</span>
                    </span>
                  </a>
                </div>
              </div>
            </div>

            <div id="tabPersonal" class="tabContent">
              <div class="requiredInfo">
                <span class="required">*</span>
                Indicates Required Fields
              </div>
              <!-- /.requiredInfo -->

              <div class="editTabWrapper">

                  <c:choose>
                    <c:when test="${viewModel.currentTab eq 'Notes'}">
                      <%@include file="/WEB-INF/pages/provider/notes.jsp" %>
                    </c:when>
                    <c:otherwise>
                      <c:forEach var="formName" items="${viewModel.currentFormNames}">
                        <c:forEach var="entry" items="${viewRegistry}">
                          <c:if test="${formName eq entry.key}">
                            <jsp:include page="${entry.value}"/>
                          </c:if>
                        </c:forEach>
                      </c:forEach>
                    </c:otherwise>
                  </c:choose>
                <div class="br"></div>
                <div class="bl"></div>
              </div>

              <c:choose>
                <c:when test="${viewModel.currentTab eq 'Notes'}">
                  <div class="buttonBox">
                    <c:url var="cancelUrl" value="/provider/applications/pending?statuses=Pending&showFilterPanel=true"/>
                    <a class="greyBtn" href="${cancelUrl}">
                      Cancel
                    </a>
                    <button class="purpleBtn" type="submit" name="saveNote">
                      Save Note
                    </button>
                  </div>
                </c:when>
                <c:when test="${isReopened}">
                  <div class="buttonBox">
                    <c:url var="cancelUrl" value="/provider/applications/pending?statuses=Pending&showFilterPanel=true"/>
                    <a class="greyBtn" href="${cancelUrl}">
                      Cancel
                    </a>
                    <button class="purpleBtn" type="submit" name="resubmitWithChanges" />
                      Re-Submit Application
                    </button>
                  </div>
                </c:when>
                <c:otherwise>
                  <div class="buttonBox">
                    <input type="hidden" name="pageName" value="${pageName}"/>
                    <c:choose>
                      <c:when test="${isServiceAdministrator}">
                        <c:url var="cancelUrl" value="/provider/applications/all"/>
                      </c:when>
                      <c:otherwise>
                        <c:url var="cancelUrl" value="/provider/dashboard/drafts"/>
                      </c:otherwise>
                    </c:choose>
                    <a class="greyBtn" href="${cancelUrl}">
                      Cancel
                    </a>
                    <button class="purpleBtn" type="submit" name="submitApplication">
                      Submit Application
                    </button>
                    <button class="greyBtn" type="submit" name="save">
                      Save as Draft
                    </button>
                  </div>
                </c:otherwise>
              </c:choose>

              <!-- /.buttonBox -->
            </form>
          </div>
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
    <%@include file="/WEB-INF/pages/provider/application/steps/modal/save_as_draft.jsp" %>
    <%@include file="/WEB-INF/pages/provider/application/steps/modal/practice_lookup.jsp" %>
    <%@include file="/WEB-INF/pages/provider/application/steps/modal/stale_application.jsp" %>
    <%@include file="/WEB-INF/pages/provider/application/steps/modal/superseded_application.jsp" %>
    <%@include file="/WEB-INF/pages/provider/application/steps/modal/submit_application.jsp" %>
    <!-- /#saveAsDraftModal-->
  </div>
  <c:if test="${not empty requestScope['flash_popup']}">
    <input type="hidden" id="flashPopUp" value="${requestScope['flash_popup']}"/>
  </c:if>
</body>
</html>
