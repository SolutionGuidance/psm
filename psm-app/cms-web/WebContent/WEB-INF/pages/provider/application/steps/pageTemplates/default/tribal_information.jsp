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
<c:set var="formIdPrefix" value="tribal_information"></c:set>


<div class="radioPanel">
    <input type="hidden" name="formNames" value="<%= ViewStatics.TRIBAL_INFO_FORM %>">
    <div class="section">
        <div id="RadioWrapper" class="row">
            <label>Is applicant a provider at a Public Health Service (PHS) Indian Hospital?</label>
            <div>
                <c:set var="formName" value="_13_worksOnReservation"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label class="span">
                    <input type="radio"
                           onchange="showHideForm('tableLicense3', true);"
                           value="Y"
                           name="${formName}"
                           ${formValue eq 'Y' ? 'checked' : ''}>
                    Yes
                </label>
                <label class="span">
                    <input type="radio"
                           onchange="showHideForm('tableLicense3', false);"
                           value="N"
                           name="${formName}"
                           ${formValue eq 'N' ? 'checked' : ''}>
                    No
                </label>
            </div>
        </div>
        <div class="clearFixed"></div>
    </div>
    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
</div>

<div class="tableData" id="tableLicense3" style="display: ${formValue eq 'Y' ? 'block' : 'none'};">

    <table class="generalTable">
        <thead>
            <tr>
                <th class="reservationTableHeader">Reservation <span class="required-dark-background">*</span><span class="sep"></span></th>
                <th>Upload License/Certification <span class="required-dark-background">*</span><span class="sep"></span></th>
                <th>License/Certification # <span class="required-dark-background">*</span><span class="sep"></span></th>
                <th>Original Issue Date <span class="required-dark-background">*</span><span class="sep"></span></th>
                <th>Renewal End Date <span class="required-dark-background">*</span><span class="sep"></span></th>
                <th>Issuing State/Territory <span class="required-dark-background">*</span><span class="sep"></span></th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>
                    <c:set var="formName" value="_13_tribalCode_0"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <select title="Reservation" class="bigSelect" name="${formName}">
                        <option value="">Please select</option>
                        <c:forEach var="opt" items="${requestScope['_13_tribalCodes']}">
                            <option ${formValue eq opt.description ? 'selected' : ''} value="${opt.description}"><c:out value="${opt.description}" /></option>
                        </c:forEach>
                    </select>
                </td>
                <td>
                    <c:set var="formName" value="_13_attachment_0"></c:set>
                    <input title="Upload License/Certification" type="file" class="fileUpload" size="10" name="${formName}" />

                    <c:set var="formName" value="_13_filename_0"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <c:if test="${not empty formValue}">
                        <c:set var="formName" value="_13_attachmentId_0"></c:set>
                        <c:url var="downloadLink" value="/provider/application/attachment">
                             <c:param name="id" value="${requestScope[formName]}"></c:param>
                        </c:url>
                        <div><a href="${downloadLink}"><cms:truncate text="${formValue}" /></a></div>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                           <input type="hidden" name="${formName}" value="${formValue}"/>
                    </c:if>
                </td>
                <c:set var="formName" value="_13_licenseNumber_0"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <td><input title="License/Certification Number" type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="45"/></td>
                <td class="dateCell">
                    <c:set var="formName" value="_13_originalIssueDate_0"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <span class="dateWrapper">
                        <input title="Original Issue Date" class="date" type="text" name="${formName}" value="${formValue}"/>
                    </span>
                </td>
                <td class="dateCell">
                    <c:set var="formName" value="_13_renewalDate_0"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <span class="dateWrapper">
                        <input title="Renewal End Date" class="date" type="text"  name="${formName}" value="${formValue}"/>
                    </span>
                </td>
                <td>
                    <c:set var="formName" value="_13_issuingState_0"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <select title="Issuing State/Territory" name="${formName}">
                        <option value="">Please select</option>
                           <c:forEach var="opt" items="${requestScope['_13_issuingStates']}">
                               <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                           </c:forEach>
                    </select>
                </td>
            </tr>
        </tbody>
    </table>
    <div class="clearFixed"></div>
    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
</div>
