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
<%@ taglib prefix="h" tagdir="/WEB-INF/tags" %>

<c:set var="showCategories" value="${viewModel.tabModels[viewModel.currentTab].formSettings['Facility License Form'].settings['showCategories']}"></c:set>
<input type="hidden" name="formNames" value="<%= ViewStatics.FACILITY_LICENSE_FORM %>">

<c:if test="${showCategories}">
    <div class="newApplicationPanel practicePanel memberInfoPanel">
        <div class="tableHeader topHeader"><span>Please select type of service(s) you provide</span></div>
        <div class="clearFixed"></div>
        <div class="section">
            <div class="">
                <div class="row">
                   <ul>
                        <c:set var="formName" value="_21_categorySize"></c:set>
                        <c:forEach begin="1" end="${requestScope[formName]}" varStatus="status">
                        <li>
                            <c:set var="formName" value="_21_category_${status.index - 1}"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <c:set var="checkedName" value="_21_category_selected_${status.index - 1}"></c:set>
                            <c:set var="checkedValue" value="${requestScope[checkedName]}"></c:set>
                            <label class="checkboxLabel">
                              <input type="checkbox" name="_21_serviceCategory" ${checkedValue eq 'Y' ? 'checked' : ''} value="${formValue}"/>
                              ${formValue}
                            </label>
                        </li>
                        </c:forEach>
                   </ul>
                </div>
                <div class="clearFixed"></div>
            </div>
        </div>
        <!-- /.section -->
        <div class="tl"></div>
        <div class="tr"></div>
        <div class="bl"></div>
        <div class="br"></div>
    </div>
</c:if>

<div class="newApplicationPanel practicePanel">
    <div class="section">
        <c:if test="${showCategories}">
            <div class="tableHeader topHeader"><span>Required Licenses/Certifications based on your service selection</span></div>
            <div class="clearFixed"></div>
        </c:if>
        <c:if test="${not showCategories}">
            <div class="tableHeader topHeader"><span>Facility Licenses/Certifications</span></div>
            <div class="clearFixed"></div>
        </c:if>

        <div class="addPracticeLocations">
            <table class="generalTable facility" id="tableFacilityLicense">
                <colgroup>
                    <col width="20"/>
                    <col width="130"/>
                    <col width="100"/>
                    <col width="100"/>
                    <col width="100"/>
                    <col width="100"/>
                    <col width="100"/>
                    <col width="30"/>
                </colgroup>
                <thead>
                <tr>
                    <th class="firstTheader">#<span class="sep"></span></th>
                    <th class="alignCenter"><span class="multi">Type of License<br/>/Certification</span> <span class="required-dark-background">*</span><span class="sep"></span></th>
                    <th class="alignCenter"><span class="multi">License/Certification<br/> Number</span> <span class="required-dark-background">*</span><span class="sep"></span></th>
                    <th class="alignCenter"><span class="multi">Original Issue Date<br/> (MM/DD/YYYY)</span> <span class="required-dark-background">*</span><span class="sep"></span></th>
                    <th class="alignCenter"><span class="multi">Renewal End Date<br/> (MM/DD/YYYY)</span> <span class="required-dark-background">*</span><span class="sep"></span></th>
                    <th class="alignCenter"><span class="multi">Issuing State<br/>/Territory</span> <span class="required-dark-background">*</span><span class="sep"></span></th>
                    <th class="alignCenter"><span class="multi">Copy of License<br/>/Certification</span> <span class="sep"></span></th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
            <c:set var="formName" value="_21_attachmentSize"></c:set>
            <c:forEach begin="1" end="${requestScope[formName]}" varStatus="status">
                <tr>
                    <td class="alignCenter">${status.index}</td>
                    <td>
                        <c:set var="formName" value="_21_licenseType_${status.index - 1}"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <select title="Type of License (License ${status.index})" class="bigSelect medicareCheck" name="${formName}">
                            <option value="">Please select</option>
                            <c:forEach var="opt" items="${requestScope['_21_licenseTypes']}">
                                <option ${formValue eq opt.description ? 'selected' : ''} value="${opt.description}"><c:out value="${opt.description}" /></option>
                            </c:forEach>
                        </select>
                    </td>
                    <c:set var="formName" value="_21_licenseNumber_${status.index - 1}"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <td><input type="text" title="License/Certification Number (License ${status.index})" class="longInput" name="${formName}" value="${formValue}" maxlength="45"/></td>
                    <td class="dateCell">
                        <span class="dateWrapper">
                            <c:set var="formName" value="_21_originalIssueDate_${status.index - 1}"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <input class="date" type="text" title="Original Issue Date (License ${status.index})" name="${formName}" value="${formValue}"/>
                        </span>
                    </td>
                    <td class="dateCell">
                        <span class="dateWrapper">
                            <c:set var="formName" value="_21_renewalDate_${status.index - 1}"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <input class="date" title="Renewal End Date (License ${status.index})" type="text"  name="${formName}" value="${formValue}"/>
                        </span>
                    </td>
                    <td>
                        <c:set var="formName" value="_21_issuingState_${status.index - 1}"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <select title="Issuing State/Territory (License ${status.index})" name="${formName}" class="licenseStates">
                            <option value="">Please select</option>
                            <c:choose>
                                <c:when test="${formValue == 'MEDICARE'}">
                                    <option value="MEDICARE" selected="selected">Medicare</option>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="opt" items="${requestScope['_99_states']}">
                                        <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </select>
                    </td>
                    <td>
                        <c:set var="formName" value="_21_attachment_${status.index - 1}" />
                        <c:set var="filenameKey" value="_21_filename_${status.index - 1}" />
                        <c:set var="attachmentIdName" value="_21_attachmentId_${status.index - 1}" />
                        <h:attachment
                            name="${formName}"
                            title="Copy of License (License ${status.index})"
                            attachmentId="${requestScope[attachmentIdName]}"
                            attachmentIdName="${attachmentIdName}"
                            filename="${requestScope[filenameKey]}" />
                    </td>
                    <td class="alignCenter"><a href="javascript:;" class="remove">REMOVE</a></td>
                </tr>
            </c:forEach>
                </tbody>
            </table>
            <div class="clearFixed"></div>
            <div class="tableBottom">
                <a href="javascript:;" id="addFacilityLicense">+ Add Another License</a>
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
    <table class="hide" id="tableLicenseTemplate">
        <tbody>
            <tr>
                <td class="alignCenter">1</td>
                <td>
                    <c:set var="formName" value="_21_licenseType"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <select title="Type of License" class="bigSelect medicareCheck" name="${formName}">
                        <option value="">Please select</option>
                        <c:forEach var="opt" items="${requestScope['_21_licenseTypes']}">
                            <option value="${opt.description}"><c:out value="${opt.description}" /></option>
                        </c:forEach>
                    </select>
                </td>
                <c:set var="formName" value="_21_licenseNumber"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <td><input type="text" title="License/Certification Number" class="longInput" name="${formName}" value="${formValue}" maxlength="45"/></td>
                <td class="dateCell">
                    <span class="dateWrapper">
                        <c:set var="formName" value="_21_originalIssueDate"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input class="date" title="Original Issue Date" type="text" name="${formName}" value="${formValue}"/>
                    </span>
                </td>
                <td class="dateCell">
                    <span class="dateWrapper">
                        <c:set var="formName" value="_21_renewalDate"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" title="Renewal End Date" class="date" name="${formName}" value="${formValue}"/>
                    </span>
                </td>
                <td>
                    <c:set var="formName" value="_21_issuingState"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <select title="Issuing State/Territory" name="${formName}" class="licenseStates">
                        <option value="">Please select</option>
                        <c:forEach var="opt" items="${requestScope['_99_states']}">
                            <option value="${opt.code}"><c:out value="${opt.description}" /></option>
                        </c:forEach>
                    </select>
                </td>
                <c:set var="formName" value="_21_attachment"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <td>
                    <h:attachment
                        name="_21_attachment"
                        title="Copy of License" />
                </td>
                <td class="alignCenter"><a href="javascript:;" class="remove">REMOVE</a></td>
            </tr>
        </tbody>
    </table>
</div>
