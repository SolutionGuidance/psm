<%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: This is the approval page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en-US" xml:lang="en-US">
  <c:set var="title" value="Review Enrollment"/>
  <c:set var="adminPage" value="true" />
  <h:handlebars template="includes/html_head" context="${pageContext}" />
  <body>
    <div id="wrapper">
      <h:handlebars template="includes/header" context="${pageContext}"/>
      <div id="mainContent">
        <div class="contentWidth">
          <div class="mainNav">
            <h:handlebars template="includes/logo" context="${pageContext}"/>
            <c:set var="activeTab" value="2"></c:set>
            <h:handlebars template="includes/nav" context="${pageContext}"/>
          </div>
          <!-- /.mainNav -->
          <div class="breadCrumb">
            Review Enrollment
          </div>
          <h1>Review ${model.enrollment.providerInformation.providerType} Enrollment Application</h1>
          <div class="tabSection" id="enrollmentSection">
            <%@include file="/WEB-INF/pages/provider/enrollment/steps/screening_errors.jsp" %>
            <form action="${ctx}/agent/enrollment/approve" method="post" id="approvalForm">
              <sec:csrfInput />

              <div class="newEnrollmentPanel practicePanel">
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
                        <td>NPI LOOKUP</td>
                        <td>${model.enrollment.providerInformation.NPI}</td>
                        <td><a class="autoScreeningResultLink"
                              href="${ctx}/agent/enrollment/autoScreeningResult?type=NPI LOOKUP&id=${id}"
                              target="_blank">
                            <c:choose>
                            <c:when test="${empty verification.NPILookup}">
                              Not performed
                            </c:when>
                            <c:otherwise>
                              View results
                            </c:otherwise>
                            </c:choose>
                          </a></td>
                          <td>
                            <input
                              type="checkbox"
                              title="NPI Lookup Verified"
                              name="npiLookupVerified"
                              value="Y"
                              ${verification.NPILookup eq 'Y' ? 'checked' : ''}
                              />
                          </td>
                      </tr>
                      <tr>
                        <td>SSN DMF VERIFICATION</td>
                        <td>${model.enrollment.providerInformation.applicantInformation.personalInformation.socialSecurityNumber}</td>
                        <td><a class="autoScreeningResultLink"
                              href="${ctx}/agent/enrollment/autoScreeningResult?type=SSN DMF VERIFICATION&id=${id}"
                              target="_blank">
                            <c:choose>
                            <c:when test="${empty verification.socialSecurityNumber}">
                              Not performed
                            </c:when>
                            <c:otherwise>
                              View results
                            </c:otherwise>
                            </c:choose>
                          </a></td>
                          <td>
                            <input
                              type="checkbox"
                              title="SSN Verified"
                              name="ssnVerified"
                              value="Y"
                              ${verification.socialSecurityNumber eq 'Y' ? 'checked' : ''}
                              />
                          </td>
                      </tr>
                      <tr>
                        <td>NPI PECOS VERIFICATION</td>
                        <td>${model.enrollment.providerInformation.NPI}</td>
                        <td><a class="autoScreeningResultLink"
                              href="${ctx}/agent/enrollment/autoScreeningResult?type=NPI PECOS VERIFICATION&id=${id}"
                              target="_blank">
                            <c:choose>
                            <c:when test="${empty verification.NPI}">
                              Not performed
                            </c:when>
                            <c:otherwise>
                              View results
                            </c:otherwise>
                            </c:choose>
                          </a></td>
                          <td>
                            <input
                              type="checkbox"
                              title="NPI Verified"
                              name="npiVerified"
                              value="Y"
                              ${verification.NPI eq 'Y' ? 'checked' : ''}
                              />
                          </td>
                      </tr>
                      <tr>
                        <td>EXCLUDED PROVIDER VERIFICATION IN OIG (checked means not in exclusion list)</td>
                        <td></td>
                        <td><a class="autoScreeningResultLink"
                              href="${ctx}/agent/enrollment/autoScreeningResult?type=EXCLUDED PROVIDERS&id=${id}"
                              target="_blank">
                          <c:choose>
                          <c:when test="${empty verification.nonExclusion}">
                            Not performed
                          </c:when>
                          <c:otherwise>
                            View results
                          </c:otherwise>
                          </c:choose>
                        </a></td>
                        <td>
                          <input
                            type="checkbox"
                            title="Non-exclusion Verified"
                            name="nonExclusionVerified"
                            value="Y"
                            ${verification.nonExclusion eq 'Y' ? 'checked' : ''}
                            />
                        </td>
                      </tr>
                      <tr>
                        <td>EXCLUDED PROVIDER VERIFICATION IN SAM (checked means not in exclusion list)</td>
                        <td></td>
                        <td><a class="autoScreeningResultLink"
                              href="${ctx}/agent/enrollment/autoScreeningResult?type=SAM EXCLUDED PROVIDERS&id=${id}"
                              target="_blank">
                          <c:choose>
                          <c:when test="${empty verification.SAMNonExclusion}">
                            Not performed
                          </c:when>
                          <c:otherwise>
                            View results
                          </c:otherwise>
                          </c:choose>
                        </a></td>
                        <td>
                          <input
                            type="checkbox"
                            title="Non-SAM-Exclusion Verified"
                            name="nonSAMExclusionVerified"
                            value="Y"
                            ${verification.SAMNonExclusion eq 'Y' ? 'checked' : ''}
                            />
                        </td>
                      </tr>
                    </tbody>
                  </table>

                  <c:if test="${not empty model.enrollment.providerInformation.licenseInformation.license}">
                    <div class="tableHeader"><span>License Information</span></div>
                    <div class="clearFixed"></div>
                    <table class="generalTable">
                      <thead>
                        <tr>
                          <th>Type<span class="sep"></span></th>
                          <th>Number<span class="sep"></span></th>
                          <th>Auto Screening<span class="sep"></span></th>
                          <th>Verified</th>
                        </tr>
                      </thead>
                      <tbody>
                        <c:forEach var="license" items="${model.enrollment.providerInformation.licenseInformation.license}">
                          <tr>
                            <td>${license.licenseType}${license.specialtyType}</td>
                            <td>${license.licenseNumber}

                              <c:url var="downloadLink" value="/provider/enrollment/attachment">
                              <c:param name="id" value="${license.attachmentObjectId}"></c:param>
                              </c:url>
                              <a href="${downloadLink}">View</a>

                            </td>
                            <td><a class="autoScreeningResultLink"
                                  href="${ctx}/agent/enrollment/autoScreeningResult?type=LICENSE VERIFICATION&id=${id}&licenseId=${license.objectId}"
                                  target="_blank">
                              <c:choose>
                              <c:when test="${empty license.verified}">
                                Not performed
                              </c:when>
                              <c:otherwise>
                                View results
                              </c:otherwise>
                              </c:choose>
                            </a></td>
                            <td>
                              <input
                                type="checkbox"
                                title="License Number ${license.licenseNumber} Verified"
                                name="verifiedLicenses"
                                value="${license.attachmentObjectId}"
                                ${license.verified eq 'Y' ? 'checked' : ''}
                                />
                            </td>
                          </tr>
                        </c:forEach>
                      </tbody>
                    </table>
                  </c:if>

                  <c:if test="${not empty model.enrollment.providerInformation.facilityCredentials.signedContract}">
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
                        <c:forEach var="contract" items="${model.enrollment.providerInformation.facilityCredentials.signedContract}">
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
                              <c:url var="downloadLink" value="/provider/enrollment/attachment">
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
                <a href="${ctx}/provider/search/pending?statuses=Pending&showFilterPanel=true" class="greyBtn"><span class="text">Cancel</span></a>
                <button class="greyBtn" type="submit">Approve</button>
                <a href="${ctx}/agent/enrollment/rejectTicket?id=${id}" class="greyBtn"><span class="text">Reject</span></a>
                <a href="${ctx}/provider/enrollment/reopen?id=${id}" class="greyBtn"><span class="text">Modify</span></a>
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
