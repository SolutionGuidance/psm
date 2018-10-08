<%--
  Copyright 2012 TopCoder Inc.
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
  - Description: This is the approval page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="en-US">
  <c:set var="title" value="Review Application"/>
  <h:handlebars template="includes/html_head" context="${pageContext}" />
  <body>
    <div id="wrapper">
      <h:handlebars template="includes/header" context="${pageContext}"/>
      <div id="mainContent">
        <div class="contentWidth">
          <div class="mainNav">
            <h:handlebars template="includes/logo" context="${pageContext}"/>
            <h:handlebars template="includes/banner" context="${pageContext}"/>
            <c:set var="activeTabApplications" value="true"></c:set>
            <h:handlebars template="includes/nav" context="${pageContext}"/>
          </div>
          <!-- /.mainNav -->
          <div class="breadCrumb">
            Review Application
          </div>
          <h1>Review ${model.application.providerInformation.providerType} Application</h1>
          <div class="tabSection" id="applicationSection">
            <%@include file="/WEB-INF/pages/provider/application/steps/screening_errors.jsp" %>
            <form action="${ctx}/agent/application/approve" method="post" id="approvalForm">
              <sec:csrfInput />

              <div class="newApplicationPanel practicePanel">
                <div class="tableHeader topHeader"><span>Provider Information</span></div>
                <div class="clearFixed"></div>
                <div class="section">
                  <input type="hidden" name="id" value="${id}" />
                  <table class="generalTable">
                    <thead>
                      <tr>
                        <th>Field<span class="sep"></span></th>
                        <th>Value<span class="sep"></span></th>
                        <th>Auto Screening<span class="sep"></span></th>
                        <th>Verified</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr>
                        <td>EXCLUDED PROVIDER VERIFICATION IN OIG (checked means not in exclusion list)</td>
                        <td></td>
                        <td>
                          <c:choose>
                            <c:when test="${not empty leieScreeningId}">
                              <a class="autoScreeningResultLink"
                                  href="<c:url value="/agent/automatic-screening/${leieScreeningId}"/>"
                                  target="_blank">
                                ${leieScreeningResult}
                              </a>
                            </c:when>
                            <c:otherwise>
                              ${leieScreeningResult}
                            </c:otherwise>
                          </c:choose>
                        </td>
                        <td>
                          <input
                            type="checkbox"
                            title="Non-exclusion Verified"
                            name="nonExclusionVerified"
                            value="Y"
                            ${leieScreeningPassed ? 'checked' : ''}
                            />
                        </td>
                      </tr>
                      <tr>
                        <td>DEATH MASTER FILE CHECK (checked means not in death master file)</td>
                        <td></td>
                        <td>
                          <c:choose>
                            <c:when test="${not empty dmfScreeningId}">
                              <a class="autoScreeningResultLink"
                                  href="<c:url value="/agent/automatic-screening/${dmfScreeningId}"/>"
                                  target="_blank">
                                ${dmfScreeningResult}
                              </a>
                            </c:when>
                            <c:otherwise>
                              ${dmfScreeningResult}
                            </c:otherwise>
                          </c:choose>
                        </td>
                        <td>
                          <input
                            type="checkbox"
                            title="Not In DMF Verified"
                            name="notInDmfVerified"
                            value="Y"
                            ${dmfScreeningPassed ? 'checked' : ''}
                            />
                        </td>
                      </tr>
                    </tbody>
                  </table>

                  <c:if test="${not empty model.application.providerInformation.licenseInformation.license}">
                    <div class="tableHeader"><span>License Information</span></div>
                    <div class="clearFixed"></div>
                    <table class="generalTable">
                      <thead>
                        <tr>
                          <th>Type<span class="sep"></span></th>
                          <th>Number<span class="sep"></span></th>
                          <th>Original Issue Date<span class="sep"></span></th>
                          <th>Renewal End Date<span class="sep"></span></th>
                          <th>Attachment<span class="sep"></span></th>
                        </tr>
                      </thead>
                      <tbody>
                        <c:forEach var="license" items="${model.application.providerInformation.licenseInformation.license}">
                          <tr>
                            <td>${license.licenseType}${license.specialtyType}</td>
                            <td>${license.licenseNumber}</td>
                            <td>
                              <fmt:formatDate pattern="MM/dd/yyyy"
                                              value="${license.originalIssueDate.time}"/>
                            </td>
                            <td>
                              <fmt:formatDate pattern="MM/dd/yyyy"
                                              value="${license.renewalDate.time}"/>
                            </td>
                            <td>
                              <c:url var="downloadLink" value="/provider/application/attachment">
                                <c:param name="id" value="${license.attachmentObjectId}"></c:param>
                              </c:url>
                              <a href="${downloadLink}">View</a>
                            </td>
                          </tr>
                        </c:forEach>
                      </tbody>
                    </table>
                  </c:if>

                  <c:if test="${not empty model.application.providerInformation.facilityCredentials.signedContract}">
                    <div class="tableHeader"><span>Facility Credentials</span></div>
                    <div class="clearFixed"></div>
                    <table class="generalTable">
                      <thead>
                        <tr>
                          <th>Type<span class="sep"></span></th>
                          <th>Begin<span class="sep"></span></th>
                          <th>End<span class="sep"></span></th>
                          <th>Attachment<span class="sep"></span></th>
                        </tr>
                      </thead>
                      <tbody>
                        <c:forEach var="contract" items="${model.application.providerInformation.facilityCredentials.signedContract}">
                          <tr>
                            <td>${contract.name}</td>
                            <td>
                              <fmt:formatDate pattern="MM/dd/yyyy"
                                              value="${contract.beginDate.time}"/>
                            </td>
                            <td>
                              <fmt:formatDate pattern="MM/dd/yyyy"
                                              value="${contract.endDate.time}"/>
                            </td>
                            <td>
                              <c:url var="downloadLink" value="/provider/application/attachment">
                                <c:param name="id" value="${contract.copyAttachmentId}"></c:param>
                              </c:url>
                              <a href="${downloadLink}">View</a>
                            </td>
                          </tr>
                        </c:forEach>
                      </tbody>
                    </table>
                  </c:if>
                  <div class="row"></div>
                </div>

                <div class="clear"></div>

                <div class="tl"></div>
                <div class="tr"></div>
                <div class="bl"></div>
                <div class="br"></div>

              </div>
              <div class="buttonBox">
                <a
                  href="${ctx}/provider/applications/pending?statuses=Pending&showFilterPanel=true"
                  class="greyBtn"
                >
                  Cancel
                </a>
                <button class="approveBtn greyBtn" type="submit">
                  Approve
                </button>
                <a
                  href="${ctx}/agent/application/rejectApplication?id=${id}"
                  class="rejectBtn greyBtn"
                >
                  Reject
                </a>
                <a
                  href="${ctx}/provider/application/reopen?id=${id}"
                  class="greyBtn"
                >
                  Modify
                </a>
              </div>
            </form>
          </div>
        </div>
      </div>
      <!-- /#mainContent -->
      <h:handlebars template="includes/footer" context="${pageContext}"/>
      <!-- #footer -->
    </div>
    <!-- /#wrapper -->
  </body>
</html>
