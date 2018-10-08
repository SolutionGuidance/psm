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
<%@page import="gov.medicaid.binders.ProviderTypeFormBinder"%>
<%@page import="gov.medicaid.entities.dto.ViewStatics"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@taglib prefix="cms" uri="CMSTags"  %>
<c:set var="formIdPrefix" value="specialty_information"></c:set>

<div class="tableData" id="tableLicense2">
    <input type="hidden" name="formNames" value="<%= ViewStatics.SPECIALTY_INFO_FORM %>">

    <table class="generalTable">
        <thead>
            <tr>
                <th class="alignCenter">#<span class="sep"></span></th>
                <th>Specialty <span class="required-dark-background">*</span><span class="sep"></span></th>
                <th>Upload License/Certification <span class="required-dark-background">*</span><span class="sep"></span></th>
                <th>License/Certification # <span class="required-dark-background">*</span><span class="sep"></span></th>
                <th>Original Issue Date <span class="required-dark-background">*</span><span class="sep"></span></th>
                <th>Renewal End Date <span class="required-dark-background">*</span><span class="sep"></span></th>
                <th>Board <span class="required-dark-background">*</span><span class="sep"></span></th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            <c:set var="formName" value="_09_attachmentSize"></c:set>
            <c:forEach begin="1" end="${requestScope[formName]}" varStatus="status">
                <tr>
                    <td class="alignCenter">${status.count}</td>
                    <td>
                        <c:set var="formName" value="_09_specialtyType_${status.index - 1}"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <select title="Specialty" class="bigSelect" name="${formName}" onchange="updateSpecialties()">
                            <option value="">Please select</option>
                            <c:forEach var="opt" items="${requestScope['_09_specialtyTypes']}">
                                <option ${formValue eq opt.description ? 'selected' : ''} value="${opt.description}"><c:out value="${opt.description}" /></option>
                            </c:forEach>
                        </select>
                    </td>
                    <td>
                        <c:set var="formName" value="_09_attachment_${status.index - 1}"></c:set>
                        <input title="Upload License/Certification" type="file" class="fileUpload" size="10" name="${formName}" />

                        <c:set var="formName" value="_09_filename_${status.index - 1}"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <c:if test="${not empty formValue}">
                            <c:set var="formName" value="_09_attachmentId_${status.index - 1}"></c:set>
                            <c:url var="downloadLink" value="/provider/application/attachment">
                                 <c:param name="id" value="${requestScope[formName]}"></c:param>
                            </c:url>
                            <div><a href="${downloadLink}"><cms:truncate text="${formValue}" /></a></div>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <input type="hidden" name="${formName}" value="${formValue}"/>
                        </c:if>
                    </td>
                    <c:set var="formName" value="_09_licenseNumber_${status.index - 1}"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <td><input title="License/Certification Number" type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="45"/></td>
                    <td class="dateCell">
                        <c:set var="formName" value="_09_originalIssueDate_${status.index - 1}"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <span class="dateWrapper">
                            <input title="Original Issue Date" class="date" type="text" name="${formName}" value="${formValue}"/>
                        </span>
                    </td>
                    <td class="dateCell">
                        <c:set var="formName" value="_09_renewalDate_${status.index - 1}"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <span class="dateWrapper">
                            <input title="Renewal End Date" class="date" type="text" name="${formName}" value="${formValue}"/>
                        </span>
                    </td>
                    <td>
                        <c:set var="formName" value="_09_issuingBoard_${status.index - 1}"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <select title="Issuing Board" name="${formName}">
                            <option value="">Please select</option>
                            <c:forEach var="opt" items="${requestScope['_09_specialtyBoards']}">
                                <option ${formValue eq opt.description ? 'selected' : ''} value="${opt.description}"><c:out value="${opt.description}" /></option>
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
        <a href="javascript:;" id="addLicense2">+ Add Another Specialty</a>
    </div>
    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
</div>
<!-- /.tableData -->
<div class="hide">
    <table class="hide" id="tableLicenseTemplate2">
        <tbody>
            <tr>
                <td class="alignCenter"><span>1</span></td>
                <td>
                    <c:set var="formName" value="_09_specialtyType"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <select title="Specialty" class="bigSelect" name="${formName}" onchange="updateSpecialties()">
                        <option value="">Please select</option>
                        <c:forEach var="opt" items="${requestScope['_09_specialtyTypes']}">
                            <option value="${opt.description}"><c:out value="${opt.description}" /></option>
                        </c:forEach>
                    </select>
                </td>
                <c:set var="formName" value="_09_attachment"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <td><input title="Upload License/Certification" type="file" class="fileUpload" size="10" name="${formName}" /></td>
                <c:set var="formName" value="_09_licenseNumber"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <td><input title="License/Certification Number" type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="45"/></td>
                <td class="dateCell">
                    <c:set var="formName" value="_09_originalIssueDate"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <span class="dateWrapper">
                        <input title="Original Issue Date" class="date" type="text" name="${formName}" value="${formValue}"/>
                    </span>
                </td>
                <td class="dateCell">
                    <c:set var="formName" value="_09_renewalDate"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <span class="dateWrapper">
                        <input title="Renewal End Date" class="date" type="text" name="${formName}" value="${formValue}"/>
                    </span>
                </td>
                <td>
                    <c:set var="formName" value="_09_issuingBoard"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <select title="Issuing Board" name="${formName}">
                        <option value="">Please select</option>
                        <c:forEach var="opt" items="${requestScope['_09_specialtyBoards']}">
                            <option value="${opt.description}"><c:out value="${opt.description}" /></option>
                        </c:forEach>
                    </select>
                </td>
                <td class="alignCenter"><a href="javascript:;" class="remove">REMOVE</a></td>
            </tr>
        </tbody>
    </table>
</div>
