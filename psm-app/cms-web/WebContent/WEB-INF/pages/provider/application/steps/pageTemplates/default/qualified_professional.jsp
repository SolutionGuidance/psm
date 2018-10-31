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
<%@page import="gov.medicaid.entities.dto.ViewStatics"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@taglib prefix="cms" uri="CMSTags"  %>
<c:set var="formIdPrefix" value="qualified_professional"></c:set>

<input type="hidden" name="formNames" value="<%= ViewStatics.QUALIFIED_PROFESSIONAL_FORM %>">
<c:set var="selectedMarkup" value='selected="selected"' />

<div id="qpsTable">
<c:set var="formName" value="_29_qpSize"></c:set>

<c:forEach begin="1" end="${requestScope[formName]}" varStatus="status">
<div class="newApplicationPanel practicePanel memberInfoPanel">
    <div class="section">
        <div class="leftCol">
            <div class="row requireField">
                <c:set var="formName" value="_29_qpType_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">QP Type <span class="required">*</span></label>
                <select id="${formIdPrefix}_${formName}" name="${formName}">
                    <option value="">Please select</option>
                    <c:forEach var="opt" items="${requestScope['_29_qpTypes']}">
                       <option ${formValue == opt.description ? selectedMarkup : ''} value="${opt.description}"><c:out value="${opt.description}" /></option>
                    </c:forEach>
                </select>
            </div>
            <div class="row requireField">
                <c:set var="formName" value="_29_name_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Name <span class="required">*</span></label>
                <input id="${formIdPrefix}_${formName}" type="text" class="nameInput normalInput" name="${formName}" value="${formValue}" maxlength="100"/>
            </div>
            <div class="row requireField">
                <c:set var="formName" value="_29_npi_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">NPI</label>
                <input id="${formIdPrefix}_${formName}" type="text" class="npiMasked normalInput" name="${formName}" value="${formValue}" maxlength="10"/>
            </div>
            <div class="row requireField">
                <c:set var="formName" value="_29_startDate_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Date of Employment <span class="required">*</span>
                    <span class="label">(MM/DD/YYYY)</span>
                </label>
                <span class="dateWrapper floatL">
                    <input id="${formIdPrefix}_${formName}" class="date" type="text" name="${formName}" value="${formValue}"/>
                </span>
            </div>
            <div class="clearFixed"></div>
        </div>
        <div class="rightCol">
            <c:set var="qpType" value="_29_qpType_${status.index - 1}"></c:set>
            <c:set var="qpTypeValue" value="${requestScope[qpType]}"></c:set>
            <c:choose>
                <c:when test="${qpTypeValue == 'Mental Health Professional'}">
                    <div class="row mhpType">
                </c:when>
                <c:otherwise>
                    <div class="row mhpType hide">
                </c:otherwise>
            </c:choose>
                <c:set var="formName" value="_29_qpSubType_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">MHP Type</label>
                <span class="floatL">
                    <input id="${formIdPrefix}_${formName}" type="text" class="normalInput" name="${formName}" value="${formValue}"/>
                </span>
            </div>
            <div class="row requireField">
                <c:set var="formName" value="_29_dob_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Date of Birth <span class="required">*</span>
                    <span class="label">(MM/DD/YYYY)</span>
                </label>
                <span class="dateWrapper floatL">
                    <input id="${formIdPrefix}_${formName}" class="date" type="text" name="${formName}" value="${formValue}"/>
                </span>
            </div>
            <div class="row requireField">
                <c:set var="formName" value="_29_ssn_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Social Security Number <span class="required">*</span></label>
                <input id="${formIdPrefix}_${formName}" type="text" class="ssnMasked normalInput" name="${formName}" value="${formValue}" maxlength="9"/>
            </div>
            <div class="row requireField">
                <label>
                    <c:set var="formName" value="_29_ended_${status.index - 1}"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input type="checkbox" ${formValue eq 'Y' ? 'checked' : ''} name="${formName}" value="Y"/>
                    The affiliation has ended
                </label>

                <c:set var="formName" value="_29_endDate_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">End Date (MM/DD/YYYY)</label>
                <span class="dateWrapper floatL">
                    <input id="${formIdPrefix}_${formName}" class="date" type="text" name="${formName}" value="${formValue}"/>
                </span>
            </div>
            <div class="clearFixed"></div>
        </div>
        <div class="clear"></div>

        <div>
            <div class="row addressline1">
                <c:set var="formName" value="_29_addressLine1_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Residence Address</label>
                <input id="${formIdPrefix}_${formName}" type="text" title="Residence Address, Line 1" class="normalInput addressInputFor" name="${formName}" value="${formValue}" maxlength="28"/>
            </div>

            <div class="row inlineBox addressline2">
                <c:set var="formName" value="_29_addressLine2_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <span class="label">&nbsp;</span>
                <input type="text" title="Residence Address, Line 2" class="normalInput addressInputFor" name="${formName}" value="${formValue}" maxlength="28"/>
            </div>

            <div class="row inlineBox">
                <span class="label">&nbsp;</span>
                <c:set var="formName" value="_29_city_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}" class="cityLabel">City <span class="required">*</span></label>
                <input id="${formIdPrefix}_${formName}" type="text" class="cityInputFor" name="${formName}" value="${formValue}" maxlength="18"/>

                <c:set var="formName" value="_29_state_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">State/Territory <span class="required">*</span></label>
                <select id="${formIdPrefix}_${formName}" class="stateSelectFor" name="${formName}">
                    <option value="">Please select</option>
                    <c:forEach var="opt" items="${requestScope['_99_states']}">
                        <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                    </c:forEach>
                </select>

                <c:set var="formName" value="_29_zip_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">ZIP Code <span class="required">*</span></label>
                <input id="${formIdPrefix}_${formName}" type="text" class="zipInputFor" name="${formName}" value="${formValue}" maxlength="10"/>

                <c:set var="formName" value="_29_county_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">County</label>
                <select id="${formIdPrefix}_${formName}" class="countySelectFor" name="${formName}">
                    <option value="">Please select</option>
                    <c:forEach var="opt" items="${requestScope['_99_counties']}">
                        <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="leftCol">
            <div class="row requireField">
                <c:set var="formName" value="_29_bgsNumber_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">BGS ID NUMBER <span class="required">*</span></label>
                <input id="${formIdPrefix}_${formName}" type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="45"/>
            </div>
            <div class="clearFixed"></div>
        </div>

        <div class="rightCol">
            <div class="row requireField">
                <c:set var="formName" value="_29_bgsClearanceDate_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">BGS Clearance Date <span class="required">*</span>
                    <span class="label">(MM/DD/YYYY)</span>
                </label>
                <span class="dateWrapper floatL">
                    <input id="${formIdPrefix}_${formName}" class="date" type="text" name="${formName}" value="${formValue}"/>
                </span>
            </div>
            <div class="clearFixed"></div>
        </div>
        <div class="clearFixed"></div>
    </div>

    <div class="tableData">
    <table class="generalTable fixedWidthTable">
        <colgroup>
            <col width="30">
            <col width="183">
            <col width="183">
            <col width="147">
            <col width="126">
            <col width="124">
            <col width="132">
        </colgroup>
        <thead>
            <tr>
                <th class="alignCenter">#<span class="sep"></span></th>
                <th>Type of License/Certification <span class="required-dark-background">*</span><span class="sep"></span></th>
                <th>Upload License/Certification <span class="required-dark-background">*</span><span class="sep"></span></th>
                <th>License/Certification Number <span class="required-dark-background">*</span><span class="sep"></span></th>
                <th>Original Issue Date <span class="required-dark-background">*</span><span class="sep"></span></th>
                <th>Renewal End Date <span class="required-dark-background">*</span><span class="sep"></span></th>
                <th>Issuing State/Territory <span class="required-dark-background">*</span><span class="sep"></span></th>
            </tr>
        </thead>
        <tbody>
            <c:set var="formName" value="_29_licenseSize_${status.index - 1}"></c:set>
            <c:forEach begin="1" end="${requestScope[formName]}" varStatus="licenseRow">
            <tr>
                <c:set var="totalLiceses" value="${licenseRow.count}" />
                <td class="alignCenter">${licenseRow.count}</td>
                <td class="licenseTypeInput">
                    <c:set var="formName" value="_29_licenseType_${status.index - 1}_${licenseRow.index - 1}"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <c:if test="${formValue eq 'PCA 1 or 3 day Steps for Success Training'}">
                        <span>PCA 1 or 3 day Steps for Success Training</span>
                        <input type="hidden" name="${formName}" value="PCA 1 or 3 day Steps for Success Training"/>
                    </c:if>
                    <c:if test="${formValue ne 'PCA 1 or 3 day Steps for Success Training'}">
                        <select class="bigSelect" title="Type of License/Certification" name="${formName}">
                            <option value="">Please select</option>
                            <c:forEach var="opt" items="${requestScope['_29_licenseTypes']}">
                                <option ${formValue eq opt.description ? 'selected' : ''} value="${opt.description}"><c:out value="${opt.description}" /></option>
                            </c:forEach>
                        </select>
                    </c:if>
                </td>
                <td class="licenseCopyInput">
                    <c:set var="formName" value="_29_attachment_${status.index - 1}_${licenseRow.index - 1}"></c:set>
                    <input type="file" title="Upload License/Certification" class="fileUpload" size="10" name="${formName}" />

                    <c:set var="formName" value="_29_filename_${status.index - 1}_${licenseRow.index - 1}"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <c:if test="${not empty formValue}">
                        <c:set var="formName" value="_29_attachmentId_${status.index - 1}_${licenseRow.index - 1}"></c:set>
                        <c:url var="downloadLink" value="/provider/application/attachment">
                             <c:param name="id" value="${requestScope[formName]}"></c:param>
                        </c:url>
                        <div><a href="${downloadLink}"><cms:truncate text="${formValue}" /></a></div>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="hidden" name="${formName}" value="${formValue}"/>
                    </c:if>
                </td>
                <c:set var="formName" value="_29_licenseNumber_${status.index - 1}_${licenseRow.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <td class="licenseNoInput"><input type="text" title="License/Certification Number" class="normalInput" name="${formName}" value="${formValue}" maxlength="45"/></td>
                <td class="dateCell licenseDateInput">
                    <span class="dateWrapper">
                        <c:set var="formName" value="_29_originalIssueDate_${status.index - 1}_${licenseRow.index - 1}"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" title="Original Issue Date" class="date" name="${formName}" value="${formValue}"/>
                    </span>
                </td>
                <td class="dateCell licenseRenewalInput">
                    <span class="dateWrapper">
                        <c:set var="formName" value="_29_renewalDate_${status.index - 1}_${licenseRow.index - 1}"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" title="Renewal End Date" class="date" name="${formName}" value="${formValue}"/>
                    </span>
                </td>
                <td class="licenseStateInput">
                    <c:set var="formName" value="_29_issuingState_${status.index - 1}_${licenseRow.index - 1}"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <select title="Issuing State/Territory" name="${formName}">
                        <option value="">Please select</option>
                        <c:forEach var="opt" items="${requestScope['_99_states']}">
                            <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            </c:forEach>
            <tr>
                  <td colspan="7">Enter the Steps for Success Training information when you have completed the training.</td>
            </tr>
            <c:if test="${totalLiceses == 1}">
                <tr>
                    <td class="alignCenter">2</td>
                    <td class="licenseTypeInput">
                        <c:set var="formName" value="_29_licenseType_${status.index - 1}_1"></c:set>
                        <span>PCA 1 or 3 day Steps for Success Training</span>
                        <input type="hidden" name="${formName}" value="PCA 1 or 3 day Steps for Success Training"/>
                    </td>
                    <td class="licenseCopyInput">
                        <c:set var="formName" value="_29_attachment_${status.index - 1}_1"></c:set>
                        <input type="file" title="Upload License/Certification" class="fileUpload" size="10" name="${formName}" />

                        <c:set var="formName" value="_29_filename_${status.index - 1}_1"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <c:if test="${not empty formValue}">
                            <c:set var="formName" value="_29_attachmentId_${status.index - 1}_1"></c:set>
                            <c:url var="downloadLink" value="/provider/application/attachment">
                                 <c:param name="id" value="${requestScope[formName]}"></c:param>
                            </c:url>
                            <div><a href="${downloadLink}"><c:out value="${formValue}"></c:out></a></div>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <input type="hidden" name="${formName}" value="${formValue}"/>
                        </c:if>
                    </td>
                    <c:set var="formName" value="_29_licenseNumber_${status.index - 1}_1"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <td class="licenseNoInput"><input type="text" title="License Number" class="normalInput" name="${formName}" value="${formValue}" maxlength="45"/></td>
                    <td class="dateCell licenseDateInput">
                        <span class="dateWrapper">
                            <c:set var="formName" value="_29_originalIssueDate_${status.index - 1}_1"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <input title="Original Issue Date" class="date" type="text" name="${formName}" value="${formValue}"/>
                        </span>
                    </td>
                    <td class="dateCell licenseRenewalInput">
                        <span class="dateWrapper">
                            <c:set var="formName" value="_29_renewalDate_${status.index - 1}_1"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <input title="Renewal Date" class="date" type="text"  name="${formName}" value="${formValue}"/>
                        </span>
                    </td>
                    <td class="licenseStateInput">
                        <c:set var="formName" value="_29_issuingState_${status.index - 1}_1"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <select title="Issuing State/Territory" name="${formName}">
                            <option value="">Please select</option>
                            <c:forEach var="opt" items="${requestScope['_29_licenseStates']}">
                                <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
            </c:if>
        </tbody>
        </table>
        </div>
    <div class="clearFixed"></div>

    <!-- /.section -->
    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
    <button class="closeSection" title="Close" aria-label="Close" type="button"></button>
</div>
</c:forEach>
</div>

<div class="tableBottom">
    <a href="javascript:;" id="addQP">+ Add Another Qualified Professional</a>
</div>
<div class="clearFixed"></div>

<div class="hide">
<div class="newApplicationPanel practicePanel memberInfoPanel" id="qpTemplate">
    <div class="section">
        <div class="leftCol">
            <div class="row requireField">
                <c:set var="formName" value="_29_qpType"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">QP Type <span class="required">*</span></label>
                <select id="${formIdPrefix}_${formName}" name="${formName}" class="qpTypeSelect">
                    <option value="">Please select</option>
                    <c:forEach var="opt" items="${requestScope['_29_qpTypes']}">
                       <option ${formValue == opt.description ? selectedMarkup : ''} value="${opt.description}"><c:out value="${opt.description}" /></option>
                    </c:forEach>
                </select>
            </div>
            <div class="row requireField">
                <c:set var="formName" value="_29_name"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Name <span class="required">*</span></label>
                <input id="${formIdPrefix}_${formName}" type="text" class="nameInput normalInput" name="${formName}" value="${formValue}" maxlength="100"/>
            </div>
            <div class="row requireField">
                <c:set var="formName" value="_29_npi"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">NPI</label>
                <input id="${formIdPrefix}_${formName}" type="text" class="npiMasked normalInput" name="${formName}" value="${formValue}" maxlength="10"/>
            </div>
            <div class="row requireField">
                <c:set var="formName" value="_29_startDate"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Date of Employment <span class="required">*</span>
                    <span class="label">(MM/DD/YYYY)</span>
                </label>
                <span class="dateWrapper floatL">
                    <input id="${formIdPrefix}_${formName}" class="date" type="text" name="${formName}" value="${formValue}"/>
                </span>
            </div>
            <div class="clearFixed"></div>
        </div>
        <div class="rightCol">
            <div class="row mhpType hide">
                <c:set var="formName" value="_29_qpSubType"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">MHP Type</label>
                <span class="floatL">
                    <input id="${formIdPrefix}_${formName}" type="text" class="normalInput" name="${formName}" value="${formValue}"/>
                </span>
            </div>
            <div class="row requireField">
                <c:set var="formName" value="_29_dob"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Date of Birth <span class="required">*</span>
                    <span class="label">(MM/DD/YYYY)</span>
                </label>
                <span class="dateWrapper floatL">
                    <input id="${formIdPrefix}_${formName}" class="date" type="text" name="${formName}" value="${formValue}"/>
                </span>
            </div>
            <div class="row requireField">
                <c:set var="formName" value="_29_ssn"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Social Security Number <span class="required">*</span></label>
                <input id="${formIdPrefix}_${formName}" type="text" class="ssnMasked normalInput" name="${formName}" value="${formValue}" maxlength="11"/>
            </div>
            <div class="row requireField">
                <label>
                    <c:set var="formName" value="_29_ended"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input type="checkbox" ${formValue eq 'Y' ? 'checked' : ''} name="${formName}" value="Y"/>
                    The affiliation has ended
                </label>
                <c:set var="formName" value="_29_endDate"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}" class="label">Date Ended (MM/DD/YYYY)</label>
                <span class="dateWrapper floatL">
                    <input id="${formIdPrefix}_${formName}" class="date" type="text" name="${formName}" value="${formValue}"/>
                </span>
            </div>
            <div class="clearFixed"></div>
        </div>
        <div class="clear"></div>

        <div>
            <div class="row addressline1">
                <c:set var="formName" value="_29_addressLine1"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Residence Address</label>
                <input id="${formIdPrefix}_${formName}" title="Residence Address, Line 1" type="text" class="normalInput addressInputFor" name="${formName}" value="${formValue}" maxlength="28"/>
            </div>

            <div class="row inlineBox addressline2">
                <c:set var="formName" value="_29_addressLine2"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <span class="label">&nbsp;</span>
                <input title="Residence Address, Line 2" type="text" class="normalInput addressInputFor" name="${formName}" value="${formValue}" maxlength="28"/>
            </div>

            <div class="row inlineBox">
                <span class="label">&nbsp;</span>
                <c:set var="formName" value="_29_city"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}" class="cityLabel">City <span class="required">*</span></label>
                <input id="${formIdPrefix}_${formName}" type="text" class="cityInputFor" name="${formName}" value="${formValue}" maxlength="20"/>

                <c:set var="formName" value="_29_state"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">State/Territory <span class="required">*</span></label>
                <select id="${formIdPrefix}_${formName}" class="stateSelectFor" name="${formName}">
                    <option value="">Please select</option>
                    <c:forEach var="opt" items="${requestScope['_99_states']}">
                        <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                    </c:forEach>
                </select>

                <c:set var="formName" value="_29_zip"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">ZIP Code <span class="required">*</span></label>
                <input id="${formIdPrefix}_${formName}" type="text" class="zipInputFor" name="${formName}" value="${formValue}" maxlength="10"/>

                <c:set var="formName" value="_29_county"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">County</label>
                <select id="${formIdPrefix}_${formName}" class="countySelectFor" name="${formName}">
                    <option value="">Please select</option>
                    <c:forEach var="opt" items="${requestScope['_99_counties']}">
                        <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="leftCol">
            <div class="row requireField">
                <c:set var="formName" value="_29_bgsNumber"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">BGS ID NUMBER <span class="required">*</span></label>
                <input id="${formIdPrefix}_${formName}" type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="45"/>
            </div>
            <div class="clearFixed"></div>
        </div>

        <div class="rightCol">
            <div class="row requireField">
                <c:set var="formName" value="_29_bgsClearanceDate"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">BGS Clearance Date <span class="required">*</span>
                    <span class="label">(MM/DD/YYYY)</span>
                </label>
                <span class="dateWrapper floatL">
                    <input id="${formIdPrefix}_${formName}" class="date" type="text" name="${formName}" value="${formValue}"/>
                </span>
            </div>
            <div class="clearFixed"></div>
        </div>
        <div class="clearFixed"></div>
    </div>

    <div class="tableData">
    <table class="generalTable">
        <thead>
            <tr>
                <th class="alignCenter">#<span class="sep"></span></th>
                <th>Type of License/Certification <span class="required-dark-background">*</span><span class="sep"></span></th>
                <th>Upload License/Certification <span class="required-dark-background">*</span><span class="sep"></span></th>
                <th>License/Certification Number <span class="required-dark-background">*</span><span class="sep"></span></th>
                <th>Original Issue Date <span class="required-dark-background">*</span><span class="sep"></span></th>
                <th>Renewal End Date <span class="required-dark-background">*</span><span class="sep"></span></th>
                <th>Issuing State/Territory <span class="required-dark-background">*</span><span class="sep"></span></th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td class="alignCenter">1</td>
                <td class="licenseTypeInput">
                    <c:set var="formName" value="_29_licenseType"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <select title="Type of License/Certification" class="bigSelect" name="${formName}">
                        <option value="">Please select</option>
                        <c:forEach var="opt" items="${requestScope['_29_licenseTypes']}">
                            <option ${formValue eq opt.description ? 'selected' : ''} value="${opt.description}"><c:out value="${opt.description}" /></option>
                        </c:forEach>
                    </select>
                </td>
                <td class="licenseCopyInput">
                    <c:set var="formName" value="_29_attachment"></c:set>
                    <input title="Upload License/Certification" type="file" class="fileUpload" size="10" name="${formName}" />

                    <c:set var="formName" value="_29_filename"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <c:if test="${not empty formValue}">
                        <c:set var="formName" value="_29_attachmentId"></c:set>
                        <c:url var="downloadLink" value="/provider/application/attachment">
                             <c:param name="id" value="${requestScope[formName]}"></c:param>
                        </c:url>
                        <div><a href="${downloadLink}"><c:out value="${formValue}"></c:out></a></div>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="hidden" name="${formName}" value="${formValue}"/>
                    </c:if>
                </td>
                <c:set var="formName" value="_29_licenseNumber"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <td class="licenseNoInput"><input title="License/Certification Number" type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="45"/></td>
                <td class="dateCell licenseDateInput">
                    <c:set var="formName" value="_29_originalIssueDate"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <span class="dateWrapper">
                        <input title="Original Issue Date" class="date" type="text" name="${formName}" value="${formValue}"/>
                    </span>
                </td>
                <td class="dateCell licenseRenewalInput">
                    <c:set var="formName" value="_29_renewalDate"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <span class="dateWrapper">
                        <input title="Renewal End Date" class="date" type="text" name="${formName}" value="${formValue}"/>
                    </span>
                </td>
                <td class="licenseStateInput">
                    <c:set var="formName" value="_29_issuingState"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <select title="Issuing State/Territory" name="${formName}">
                        <option value="">Please select</option>
                        <c:forEach var="opt" items="${requestScope['_29_licenseStates']}">
                            <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <td class="alignCenter">2</td>
                <td class="licenseTypeInput">
                    <c:set var="formName" value="_29_licenseType"></c:set>
                    <span>PCA 1 or 3 day Steps for Success Training</span>
                    <input type="hidden" name="${formName}" value="PCA 1 or 3 day Steps for Success Training"/>
                </td>
                <td class="licenseCopyInput">
                    <c:set var="formName" value="_29_attachment"></c:set>
                    <input title="Upload License/Certification" type="file" class="fileUpload" size="10" name="${formName}" />

                    <c:set var="formName" value="_29_filename"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <c:if test="${not empty formValue}">
                        <c:set var="formName" value="_29_attachmentId"></c:set>
                        <c:url var="downloadLink" value="/provider/application/attachment">
                             <c:param name="id" value="${requestScope[formName]}"></c:param>
                        </c:url>
                        <div><a href="${downloadLink}"><c:out value="${formValue}"></c:out></a></div>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="hidden" name="${formName}" value="${formValue}"/>
                    </c:if>
                </td>
                <c:set var="formName" value="_29_licenseNumber"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <td class="licenseNoInput"><input title="License/Certification Number" type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="45"/></td>
                <td class="dateCell licenseDateInput">
                    <c:set var="formName" value="_29_originalIssueDate"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <span class="dateWrapper">
                        <input title="Original Issue Date" class="date" type="text" name="${formName}" value="${formValue}"/>
                    </span>
                </td>
                <td class="dateCell licenseRenewalInput">
                    <span class="dateWrapper">
                        <c:set var="formName" value="_29_renewalDate"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input title="Renewal End Date" class="date" type="text"  name="${formName}" value="${formValue}"/>
                    </span>
                </td>
                <td class="licenseStateInput">
                    <c:set var="formName" value="_29_issuingState"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <select title="Issuing State/Territory" name="${formName}">
                        <option value="">Please select</option>
                        <c:forEach var="opt" items="${requestScope['_29_licenseStates']}">
                            <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                  <td colspan="7">Enter the Steps for Success Training information when you have completed the training.</td>
            </tr>
        </tbody>
        </table>
        </div>
    <div class="clearFixed"></div>

    <!-- /.section -->
    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
    <button class="closeSection" title="Close" aria-label="Close" type="button"></button>
</div>
</div>

<script>
$(document).ready(function() {
     if ($('.memberInfoPanel').length == 1) {
        createQPs();
    }
});
</script>
