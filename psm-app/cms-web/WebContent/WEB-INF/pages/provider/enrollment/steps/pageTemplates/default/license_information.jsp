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
<%@ page import="gov.medicaid.binders.ProviderTypeFormBinder"%>
<%@ page import="gov.medicaid.entities.dto.ViewStatics"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="h" tagdir="/WEB-INF/tags" %>

<c:set var="formIdPrefix" value="license_information"></c:set>

<c:set var="hideRenewalDate" value="${viewModel.tabModels['Personal Information'].formSettings['Personal Information Form'].settings['hideRenewalDate']}"></c:set>
<c:set var="hideLicenseNumber" value="${viewModel.tabModels['Personal Information'].formSettings['Personal Information Form'].settings['hideLicenseNumber']}"></c:set>
<c:set var="requireRenewalDate" value="${viewModel.tabModels['Training Information'].formSettings['License Information Form'].settings['requireRenewalDate']}"></c:set>

<div class="tableData" id="tableLicense">
    <input type="hidden" name="formNames" value="<%= ViewStatics.LICENSE_INFO_FORM %>">

    <table class="generalTable licenseInformationTable">
        <thead>
            <tr>
                <th class="alignCenter">#<span class="sep"></span></th>
                <th>Type of License/Certification <span class="required-dark-background">*</span><span class="sep"></span></th>
                <th>Upload License/Certification <span class="required-dark-background">*</span><span class="sep"></span></th>
                <c:choose>
                    <c:when test="${hideLicenseNumber}">
                        <th width="0"> </th>
                    </c:when>
                    <c:otherwise>
                        <th>License/Certification # <span class="required-dark-background">*</span><span class="sep"></span></th>
                    </c:otherwise>
                </c:choose>

                <th>Original Issue Date <span class="required-dark-background">*</span><span class="sep"></span></th>
                <c:choose>
                     <c:when test="${hideRenewalDate}">
                        <th width="0"> </th>
                        </c:when>
                        <c:otherwise>
                            <c:choose>
                                <c:when test="${requireRenewalDate == false}">
                                    <th>Renewal End Date<span class="sep"></span></th>
                                </c:when>
                                <c:otherwise>
                                    <th>Renewal End Date <span class="required-dark-background">*</span><span class="sep"></span></th>
                                </c:otherwise>
                            </c:choose>
                        </c:otherwise>
                </c:choose>
                <th>Issuing State/Territory <span class="required-dark-background">*</span><span class="sep"></span></th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            <c:set var="formName" value="_03_attachmentSize"></c:set>
            <c:forEach begin="1" end="${requestScope[formName]}" varStatus="status">
                <c:set var="disableRenewalDate" value="${false}"></c:set>
                <tr>
                    <td class="alignCenter">${status.index}</td>
                    <td>
                        <c:set var="formName" value="_03_licenseType_${status.index - 1}"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <select title="Type of License (License ${status.index})" class="bigSelect" name="${formName}">
                            <option value="">Please select</option>
                            <c:forEach var="opt" items="${requestScope['_03_licenseTypes']}">
                                <option ${formValue eq opt.description ? 'selected' : ''} value="${opt.description}"><c:out value="${opt.description}" /></option>
                            </c:forEach>
                        </select>
                    </td>
                    <td>
                        <c:set var="formName" value="_03_attachment_${status.index - 1}" />
                        <c:set var="filenameKey" value="_03_filename_${status.index - 1}" />
                        <c:set var="attachmentIdName" value="_03_attachmentId_${status.index - 1}" />
                        <h:attachment
                            name="${formName}"
                            title="Upload License/Certification (License ${status.index})"
                            attachmentId="${requestScope[attachmentIdName]}"
                            attachmentIdName="${attachmentIdName}"
                            filename="${requestScope[filenameKey]}" />
                    </td>
                    <c:choose>
                        <c:when test="${hideLicenseNumber}">
                            <td width="0"></td>
                        </c:when>
                        <c:otherwise>
                            <c:set var="formName" value="_03_licenseNumber_${status.index - 1}"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <td><input type="text" title="License/Certification Number (License ${status.index})" class="normalInput" name="${formName}" value="${formValue}" maxlength="45"/></td>
                        </c:otherwise>
                    </c:choose>

                    <td class="dateCell">
                        <span class="dateWrapper">
                            <c:set var="formName" value="_03_originalIssueDate_${status.index - 1}"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <input type="text" title="Original Issue Date (License ${status.index})" class="date" name="${formName}" value="${formValue}"/>
                        </span>
                    </td>
                    <c:choose>
                         <c:when test="${hideRenewalDate}">
                             <td width="0"></td>
                        </c:when>
                        <c:otherwise>
                            <td class="dateCell">
                                <span class="dateWrapper">
                                    <c:set var="formName" value="_03_renewalDate_${status.index - 1}"></c:set>
                                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                                    <input type="text" title="Renewal End Date (License ${status.index})" class="date" name="${formName}" value="${formValue}"/>
                                </span>
                            </td>
                         </c:otherwise>
                      </c:choose>
                    <td>
                        <c:set var="formName" value="_03_issuingState_${status.index - 1}"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <select title="Issuing State/Territory (License ${status.index})" name="${formName}">
                            <option value="">Please select</option>
                            <c:forEach var="opt" items="${requestScope['_03_licenseStates']}">
                                <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                            </c:forEach>
                        </select>
                    </td>
                    <td class="alignCenter"><a href="javascript:;" class="remove">REMOVE</a></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <div class="clearFixed"></div>
    <div class="tableBottom">
        <a href="javascript:;" id="addLicense">+ Add A License/Certification</a>
    </div>
    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
</div>
<!-- /.tableData -->
<div class="hide">
    <table class="hide" id="tableLicenseTemplate">
        <tbody>
            <tr>
                <td class="alignCenter">1</td>
                <td>
                    <c:set var="formName" value="_03_licenseType"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <select title="Type of License" class="bigSelect" name="${formName}">
                        <option value="">Please select</option>
                        <c:forEach var="opt" items="${requestScope['_03_licenseTypes']}">
                            <option value="${opt.description}"><c:out value="${opt.description}" /></option>
                        </c:forEach>
                    </select>
                </td>
                <c:set var="formName" value="_03_attachment"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <td>
                  <h:attachment
                      name="_03_attachment"
                      title="Upload License/Certification" />
                </td>
                <c:choose>
                        <c:when test="${hideLicenseNumber}">
                            <td width="0"></td>
                        </c:when>
                        <c:otherwise>
                            <c:set var="formName" value="_03_licenseNumber"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <td><input type="text" title="License/Certification Number" class="normalInput" name="${formName}" value="${formValue}" maxlength="45"/></td>
                        </c:otherwise>
                </c:choose>
                <td class="dateCell">
                    <span class="dateWrapper">
                        <c:set var="formName" value="_03_originalIssueDate"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" title="Original Issue Date" class="date" name="${formName}" value="${formValue}"/>
                    </span>
                </td>
                <c:choose>
                         <c:when test="${hideRenewalDate}">
                             <td width="0"></td>
                        </c:when>
                        <c:otherwise>
                            <td class="dateCell">
                                <span class="dateWrapper">
                                    <c:set var="formName" value="_03_renewalDate"></c:set>
                                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                                    <input type="text" title="Renewal End Date" class="date" name="${formName}" value="${formValue}"/>
                                </span>
                            </td>
                        </c:otherwise>
                </c:choose>
                <td>
                    <c:set var="formName" value="_03_issuingState"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <select title="Issuing State/Territory" name="${formName}">
                        <option value="">Please select</option>
                        <c:forEach var="opt" items="${requestScope['_03_licenseStates']}">
                            <option value="${opt.code}"><c:out value="${opt.description}" /></option>
                        </c:forEach>
                    </select>
                </td>
                <td class="alignCenter"><a href="javascript:;" class="remove">REMOVE</a></td>
            </tr>
        </tbody>
    </table>
</div>
