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
<%-- Used in County Contracted Mental Health Rehab applications --%>
<%@page import="gov.medicaid.binders.ProviderTypeFormBinder"%>
<%@page import="gov.medicaid.entities.dto.ViewStatics"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>

<input type="hidden" name="formNames" value="<%= ViewStatics.FACILITY_CONTRACTS_FORM %>">
<div class="newApplicationPanel practicePanel memberInfoPanel">
    <div class="tableHeader topHeader"><span>Mental Health Rehab Services Certification and Contracts</span></div>
    <div class="clearFixed"></div>

    <div class="section">
        <div class="">
            <div class="row requireField">
                <c:set var="formName" value="_34_certificateInd_0"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input id="adultRehabilitativeMentalHealthServices_${formName}" type="checkbox" ${formValue eq 'Y' ? 'checked' : ''} class="checkbox showHidePanelSection" name="${formName}" value="Y"/>
                <label for="adultRehabilitativeMentalHealthServices_${formName}" class="mediumLbl">Adult Rehabilitative Mental Health Services</label>
                <input type="hidden" name="_34_contractType_0" value="Adult Rehabilitative Mental Health Services"/>
            </div>
        </div>
        <div class="hiddenSection" style="display: ${formValue eq 'Y' ? 'block' : 'none'}">
            <div class="leftCol">
                <div class="row requireField">
                    <label for="beginDate_adultRehabilitativeMentalHealthServices_${formName}">Begin Date <span class="required">*</span>
                        <span class="label">(MM/DD/YYYY)</span>
                    </label>
                                <span class="dateWrapper floatL">
                        <c:set var="formName" value="_34_beginDate_0"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input id="beginDate_adultRehabilitativeMentalHealthServices_${formName}" class="date" type="text" name="${formName}" value="${formValue}"/>
                                        </span>
                </div>
                <div class="clearFixed"></div>
            </div>
            <div class="rightCol">
                <div class="row requireField">
                    <label for="endDate_adultRehabilitativeMentalHealthServices_${formName}">End Date <span class="required">*</span>
                        <span class="label">(MM/DD/YYYY)</span>
                    </label>
                                <span class="dateWrapper floatL">
                        <c:set var="formName" value="_34_endDate_0"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input id="endDate_adultRehabilitativeMentalHealthServices_${formName}" class="date" type="text" name="${formName}" value="${formValue}"/>
                                        </span>
                </div>
                <div class="clearFixed"></div>
            </div>
            <div class="clear"></div>
            <div class="row requireField">
                <label for="certification_adultRehabilitativeMentalHealthServices_${formName}">Certification <span class="required">*</span></label>
                <c:set var="formName" value="_34_attachment_0"></c:set>
                <input id="certification_adultRehabilitativeMentalHealthServices_${formName}" type="file" class="fileUpload" name="${formName}" />
                <c:set var="formName" value="_34_filename_0"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <c:if test="${not empty formValue}">
                    <c:set var="formName" value="_34_attachmentId_0"></c:set>
                    <c:url var="downloadLink" value="/provider/application/attachment">
                         <c:param name="id" value="${requestScope[formName]}"></c:param>
                    </c:url>
                    <div><a href="${downloadLink}"><c:out value="${formValue}"></c:out></a></div>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input type="hidden" name="${formName}" value="${formValue}"/>
                </c:if>
            </div>
        </div>
        <div class="clearFixed"></div>
    </div>

    <div class="section line">
        <div class="">
            <div class="row requireField">
                <c:set var="formName" value="_34_certificateInd_1"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input id="ctss_${formName}" type="checkbox" ${formValue eq 'Y' ? 'checked' : ''} class="checkbox showHidePanelSection" name="${formName}" value="Y"/>
                <label for="ctss_${formName}" class="mediumLbl">Children's Therapeutic Services and Supports (CTSS)</label>
                <input type="hidden" name="_34_contractType_1" value="Children's Therapeutic Services and Supports (CTSS)"/>
            </div>
        </div>
        <div class="hiddenSection" style="display: ${formValue eq 'Y' ? 'block' : 'none'}">
            <div class="leftCol">
                <div class="row requireField">
                    <label for="ctss_beginDate_${formName}">Begin Date <span class="required">*</span>
                        <span class="label">(MM/DD/YYYY)</span>
                    </label>
                                <span class="dateWrapper floatL">
                        <c:set var="formName" value="_34_beginDate_1"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input id="ctss_beginDate_${formName}" class="date" type="text" name="${formName}" value="${formValue}"/>
                                        </span>
                </div>
                <div class="clearFixed"></div>
            </div>
            <div class="rightCol">
                <div class="row requireField">
                    <label for="ctss_endDate_${formName}">End Date <span class="required">*</span>
                        <span class="label">(MM/DD/YYYY)</span>
                    </label>
                                <span class="dateWrapper floatL">
                        <c:set var="formName" value="_34_endDate_1"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input id="ctss_endDate_${formName}" class="date" type="text" name="${formName}" value="${formValue}"/>
                                        </span>
                </div>
                <div class="clearFixed"></div>
            </div>
            <div class="clear"></div>
            <div class="row requireField">
                <label for="ctss_certification_${formName}">Certification <span class="required">*</span></label>
                <c:set var="formName" value="_34_attachment_1"></c:set>
                <input id="ctss_certification_${formName}" type="file" class="fileUpload" name="${formName}" />
                <c:set var="formName" value="_34_filename_1"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <c:if test="${not empty formValue}">
                    <c:set var="formName" value="_34_attachmentId_1"></c:set>
                    <c:url var="downloadLink" value="/provider/application/attachment">
                         <c:param name="id" value="${requestScope[formName]}"></c:param>
                    </c:url>
                    <div><a href="${downloadLink}"><c:out value="${formValue}"></c:out></a></div>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input type="hidden" name="${formName}" value="${formValue}"/>
                </c:if>
            </div>
        </div>
        <div class="clearFixed"></div>
    </div>

    <div class="section line">
        <div class="">
            <div class="row requireField">
                <c:set var="formName" value="_34_certificateInd_2"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input id="adultCrisisAssessment_${formName}" type="checkbox" ${formValue eq 'Y' ? 'checked' : ''} class="checkbox showHidePanelSection" name="${formName}" value="Y"/>
                <label for="adultCrisisAssessment_${formName}" class="mediumLbl">Adult Crisis Response Services - Crisis Assessment &amp; Crisis Intervention</label>
                <input type="hidden" name="_34_contractType_2" value="Adult Crisis Response Services - Crisis Assessment & Crisis Intervention"/>
            </div>
        </div>
        <div class="hiddenSection" style="display: ${formValue eq 'Y' ? 'block' : 'none'}">
            <div class="leftCol">
                <div class="row requireField">
                    <label for="adultCrisisAssessment_beginDate_${formName}">Begin Date <span class="required">*</span>
                        <span class="label">(MM/DD/YYYY)</span>
                    </label>
                                <span class="dateWrapper floatL">
                        <c:set var="formName" value="_34_beginDate_2"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input id="adultCrisisAssessment_beginDate_${formName}" class="date" type="text" name="${formName}" value="${formValue}"/>
                                        </span>
                </div>
                <div class="clearFixed"></div>
            </div>
            <div class="rightCol">
                <div class="row requireField">
                    <label for="adultCrisisAssessment_endDate_${formName}">End Date <span class="required">*</span>
                        <span class="label">(MM/DD/YYYY)</span>
                    </label>
                                <span class="dateWrapper floatL">
                        <c:set var="formName" value="_34_endDate_2"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input id="adultCrisisAssessment_endDate_${formName}" class="date" type="text" name="${formName}" value="${formValue}"/>
                                        </span>
                </div>
                <div class="clearFixed"></div>
            </div>
            <div class="clear"></div>
            <div class="row requireField">
                <label for="adultCrisisAssessment_contract_${formName}">County Contract <span class="required">*</span></label>
                <c:set var="formName" value="_34_attachment_2"></c:set>
                <input id="adultCrisisAssessment_contract_${formName}" type="file" class="fileUpload" name="${formName}" />
                <c:set var="formName" value="_34_filename_2"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <c:if test="${not empty formValue}">
                    <c:set var="formName" value="_34_attachmentId_2"></c:set>
                    <c:url var="downloadLink" value="/provider/application/attachment">
                         <c:param name="id" value="${requestScope[formName]}"></c:param>
                    </c:url>
                    <div><a href="${downloadLink}"><c:out value="${formValue}"></c:out></a></div>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input type="hidden" name="${formName}" value="${formValue}"/>
                </c:if>
            </div>
        </div>
        <div class="clearFixed"></div>
    </div>

    <div class="section line">
        <div class="">
            <div class="row requireField">
                <c:set var="formName" value="_34_certificateInd_3"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input id="adultCrisisStabilization_${formName}" type="checkbox" ${formValue eq 'Y' ? 'checked' : ''} class="checkbox showHidePanelSection" name="${formName}" value="Y"/>
                <label for="adultCrisisStabilization_${formName}" class="mediumLbl">Adult Crisis Response Services - Crisis Stabilization</label>
                <input type="hidden" name="_34_contractType_3" value="Adult Crisis Response Services - Crisis Stabilization"/>
            </div>
        </div>
        <div class="hiddenSection" style="display: ${formValue eq 'Y' ? 'block' : 'none'}">
            <div class="leftCol">
                <div class="row requireField">
                    <label for="adultCrisisStabilization_beginDate_${formName}">Begin Date <span class="required">*</span>
                        <span class="label">(MM/DD/YYYY)</span>
                    </label>
                                <span class="dateWrapper floatL">
                        <c:set var="formName" value="_34_beginDate_3"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input id="adultCrisisStabilization_beginDate_${formName}" class="date" type="text" name="${formName}" value="${formValue}"/>
                                        </span>
                </div>
                <div class="clearFixed"></div>
            </div>
            <div class="rightCol">
                <div class="row requireField">
                    <label for="adultCrisisStabilization_endDate_${formName}">End Date <span class="required">*</span>
                        <span class="label">(MM/DD/YYYY)</span>
                    </label>
                                <span class="dateWrapper floatL">
                        <c:set var="formName" value="_34_endDate_3"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input id="adultCrisisStabilization_endDate_${formName}" class="date" type="text" name="${formName}" value="${formValue}"/>
                                        </span>
                </div>
                <div class="clearFixed"></div>
            </div>
            <div class="clear"></div>
            <div class="row requireField">
                <label for="adultCrisisStabilization_contract_${formName}">County Contract <span class="required">*</span></label>
                <c:set var="formName" value="_34_attachment_3"></c:set>
                <input id="adultCrisisStabilization_contract_${formName}" type="file" class="fileUpload" name="${formName}" />
                <c:set var="formName" value="_34_filename_3"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <c:if test="${not empty formValue}">
                    <c:set var="formName" value="_34_attachmentId_3"></c:set>
                    <c:url var="downloadLink" value="/provider/application/attachment">
                         <c:param name="id" value="${requestScope[formName]}"></c:param>
                    </c:url>
                    <div><a href="${downloadLink}"><c:out value="${formValue}"></c:out></a></div>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input type="hidden" name="${formName}" value="${formValue}"/>
                </c:if>
            </div>
        </div>
        <div class="clearFixed"></div>
    </div>

    <div class="section line">
        <div class="">
            <div class="row requireField">
                <c:set var="formName" value="_34_certificateInd_4"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input id="adultCrisisShortTermResidential_${formName}" type="checkbox" ${formValue eq 'Y' ? 'checked' : ''} class="checkbox showHidePanelSection" name="${formName}" value="Y"/>
                <label for="adultCrisisShortTermResidential_${formName}" class="mediumLbl">Adult Crisis Response Services - Short-Term Residential</label>
                <input type="hidden" name="_34_contractType_4" value="Adult Crisis Response Services - Short-Term Residential"/>
            </div>
        </div>
        <div class="hiddenSection" style="display: ${formValue eq 'Y' ? 'block' : 'none'}">
            <div class="leftCol">
                <div class="row requireField">
                    <label for="adultCrisisShortTermResidential_beginDate_${formName}">Begin Date <span class="required">*</span>
                        <span class="label">(MM/DD/YYYY)</span>
                    </label>
                                <span class="dateWrapper floatL">
                        <c:set var="formName" value="_34_beginDate_4"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input id="adultCrisisShortTermResidential_beginDate_${formName}" class="date" type="text" name="${formName}" value="${formValue}"/>
                                        </span>
                </div>
                <div class="clearFixed"></div>
            </div>
            <div class="rightCol">
                <div class="row requireField">
                    <label for="adultCrisisShortTermResidential_endDate_${formName}">End Date <span class="required">*</span>
                        <span class="label">(MM/DD/YYYY)</span>
                    </label>
                                <span class="dateWrapper floatL">
                        <c:set var="formName" value="_34_endDate_4"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input id="adultCrisisShortTermResidential_endDate_${formName}" class="date" type="text" name="${formName}" value="${formValue}"/>
                                        </span>
                </div>
                <div class="clearFixed"></div>
            </div>
            <div class="clear"></div>
            <div class="row requireField">
                <label for="adultCrisisShortTermResidential_contract_${formName}">County Contract <span class="required">*</span></label>
                <c:set var="formName" value="_34_attachment_4"></c:set>
                <input id="adultCrisisShortTermResidential_contract_${formName}" type="file" class="fileUpload" name="${formName}" />
                <c:set var="formName" value="_34_filename_4"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <c:if test="${not empty formValue}">
                    <c:set var="formName" value="_34_attachmentId_4"></c:set>
                    <c:url var="downloadLink" value="/provider/application/attachment">
                         <c:param name="id" value="${requestScope[formName]}"></c:param>
                    </c:url>
                    <div><a href="${downloadLink}"><c:out value="${formValue}"></c:out></a></div>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input type="hidden" name="${formName}" value="${formValue}"/>
                </c:if>
            </div>
        </div>
        <div class="clearFixed"></div>
    </div>
    <!-- /.section -->
    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
</div>
