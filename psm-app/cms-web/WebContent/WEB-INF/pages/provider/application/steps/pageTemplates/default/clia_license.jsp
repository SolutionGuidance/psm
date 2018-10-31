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

<div class="newApplicationPanel practicePanel">
    <input type="hidden" name="formNames" value="<%= ViewStatics.CLIA_LICENSE_FORM %>">
    <div class="section">
        <div class="tableHeader topHeader"><span>CLIA Certifications</span></div>
        <div class="clearFixed"></div>
        <div class="requiredInfo">
            If the organization is providing laboratory services, identify your CLIA Number(s). You must enclose a copy of current certificate(s).
        </div>

        <div class="addPracticeLocations">
            <table class="generalTable facility" id="tableCLIA">
                <colgroup>
                    <col width="20"/>
                    <col width="150"/>
                    <col width="300"/>
                    <col width="30"/>
                </colgroup>
                <thead>
                <tr>
                    <th class="firstTheader">#<span class="sep"></span></th>
                    <th class="alignCenter"><span class="multi">CLIA Number</span> <span class="required">*</span><span class="sep"></span></th>
                    <th class="alignCenter"><span class="multi">Copy of License/Certification</span><span class="sep"></span></th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
            <c:set var="formName" value="_22_attachmentSize"></c:set>
            <c:forEach begin="1" end="${requestScope[formName]}" varStatus="status">
                <tr>
                    <td class="alignCenter">${status.count}</td>
                    <c:set var="formName" value="_22_licenseNumber_${status.index - 1}"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <td><input type="text" title="CLIA Number" class="longInput" name="${formName}" value="${formValue}" maxlength="45"/></td>
                    <td>
                        <c:set var="formName" value="_22_attachment_${status.index - 1}"></c:set>
                        <input type="file" title="Certification" class="fileUpload" size="10" name="${formName}" />

                        <c:set var="formName" value="_22_filename_${status.index - 1}"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <c:if test="${not empty formValue}">
                            <c:set var="formName" value="_22_attachmentId_${status.index - 1}"></c:set>
                            <c:url var="downloadLink" value="/provider/application/attachment">
                                 <c:param name="id" value="${requestScope[formName]}"></c:param>
                            </c:url>
                            <div><a href="${downloadLink}"><c:out value="${formValue}"></c:out></a></div>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <input type="hidden" name="${formName}" value="${formValue}"/>
                        </c:if>
                    </td>
                    <td class="alignCenter"><a href="javascript:;" class="remove">REMOVE</a></td>
                </tr>
            </c:forEach>
                </tbody>
            </table>
            <div class="clearFixed"></div>
            <div class="tableBottom">
                <a href="javascript:;" id="addCLIALicense">+ Add Another CLIA Certification</a>
            </div>
        </div>
    </div>
    <!-- /.section -->
    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
</div>
<!-- /.newApplicationPanel -->

<!-- /.tableData -->
<div class="hide">
    <table class="hide" id="cliaLicenseTemplate">
        <tbody>
            <tr>
                <td class="alignCenter">1</td>
                <c:set var="formName" value="_22_licenseNumber"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <td><input type="text" title="CLIA Number" class="longInput" name="${formName}" value="${formValue}" maxlength="45"/></td>
                <c:set var="formName" value="_22_attachment"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <td><input type="file" title="Certification" class="fileUpload" size="10" name="${formName}" /></td>
                <td class="alignCenter"><a href="javascript:;" class="remove">REMOVE</a></td>
            </tr>
        </tbody>
    </table>
</div>
