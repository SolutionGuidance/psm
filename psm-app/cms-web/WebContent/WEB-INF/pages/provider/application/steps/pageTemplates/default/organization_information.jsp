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
<c:set var="formIdPrefix" value="organization_information"></c:set>

<c:set var="askEffectiveDate" value="${viewModel.tabModels[viewModel.currentTab].formSettings['Organization Information Form'].settings['askEffectiveDate']}"></c:set>
<c:set var="askFiscalYear" value="${viewModel.tabModels[viewModel.currentTab].formSettings['Organization Information Form'].settings['askFiscalYear']}"></c:set>
<c:set var="askTaxPayerName" value="${viewModel.tabModels[viewModel.currentTab].formSettings['Organization Information Form'].settings['askTaxPayerName']}"></c:set>
<c:set var="askDBAName" value="${viewModel.tabModels[viewModel.currentTab].formSettings['Organization Information Form'].settings['askDBAName']}"></c:set>
<c:set var="requireNPI" value="${viewModel.tabModels[viewModel.currentTab].formSettings['Organization Information Form'].settings['requireNPI']}"></c:set>
<c:set var="useEDILayout" value="${viewModel.tabModels[viewModel.currentTab].formSettings['Organization Information Form'].settings['useEDILayout']}"></c:set>
<c:set var="useEducationPlanLayout" value="${viewModel.tabModels[viewModel.currentTab].formSettings['Organization Information Form'].settings['useEducationPlanLayout']}"></c:set>
<c:set var="useNursingFacilityLayout" value="${viewModel.tabModels[viewModel.currentTab].formSettings['Organization Information Form'].settings['useNursingFacilityLayout']}"></c:set>
<c:set var="askUMPI" value="${viewModel.tabModels[viewModel.currentTab].formSettings['Organization Information Form'].settings['askUMPI']}"></c:set>
<c:set var="askUMPIorNPI" value="${viewModel.tabModels[viewModel.currentTab].formSettings['Organization Information Form'].settings['askUMPIorNPI']}"></c:set>
<c:set var="showInitialChoices" value="${viewModel.tabModels[viewModel.currentTab].formSettings['Organization Information Form'].settings['showInitialChoices']}"></c:set>
<c:set var="clearingHouseLayout" value="${viewModel.tabModels[viewModel.currentTab].formSettings['Organization Information Form'].settings['clearingHouseLayout']}"></c:set>

<div class="newApplicationPanel practicePanel">
    <div class="section">
    <input type="hidden" name="formNames" value="<%= ViewStatics.ORG_INFO_FORM %>">
        <div class="wholeCol organizationInfo">
          <c:choose>
              <c:when test="${useNursingFacilityLayout}">
                    <div class="row requireField">
                        <c:set var="formName" value="_15_name"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <label for="${formIdPrefix}_${formName}">Name of Facility <span class="required">*</span></label>
                        <input id="${formIdPrefix}_${formName}" type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="100"/>
                    </div>

                    <div class="row requireField">
                        <c:set var="formName" value="_15_npi"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <label for="${formIdPrefix}_${formName}">
                          <abbr title="National Provider Identifier">NPI</abbr>
                          <span class="required">*</span>
                          <a href="javascript:" class="userHelpLink NPIdefinition">?</a>
                        </label>
                        <input id="{formIdPrefix}_${formName}" type="text" class="npiMasked normalInput" name="${formName}" value="${formValue}" maxlength="10"/>
                    </div>

                    <div class="row addressline1">
                        <c:set var="formName" value="_15_addressLine1"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <label for="{formIdPrefix}_${formName}">Street Address <span class="required">*</span></label>
                        <input id="{formIdPrefix}_${formName}" type="text" title="Street Address, Line 1" class="normalInput addressInputFor" name="${formName}" value="${formValue}" maxlength="28"/>
                    </div>
                    <div class="row inlineBox addressline2">
                        <c:set var="formName" value="_15_addressLine2"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <span class="label">(Practice location cannot be a<br />PO Box)</span>
                        <input type="text" title="Street Address, Line 2" class="normalInput addressInputFor" name="${formName}" value="${formValue}" maxlength="28"/>
                    </div>

                    <div class="row inlineBox">
                        <span class="label">&nbsp;</span>

                        <c:set var="formName" value="_15_city"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <label for="{formIdPrefix}_${formName}" class="cityLabel">City <span class="required">*</span></label>
                        <input id="{formIdPrefix}_${formName}" type="text"  class="cityInputFor" name="${formName}" value="${formValue}" maxlength="18"/>

                        <c:set var="formName" value="_15_state"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <label for="{formIdPrefix}_${formName}">State/Territory <span class="required">*</span></label>
                        <select id="{formIdPrefix}_${formName}" class="stateSelectFor" name="${formName}">
                            <option value="">Please select</option>
                            <c:forEach var="opt" items="${requestScope['_99_states']}">
                                <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                            </c:forEach>
                        </select>

                        <c:set var="formName" value="_15_zip"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <label for="{formIdPrefix}_${formName}">ZIP Code <span class="required">*</span></label>
                        <input id="{formIdPrefix}_${formName}" type="text" class="zipInputFor" name="${formName}" value="${formValue}" maxlength="10"/>

                        <c:set var="formName" value="_15_orgCountyName"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <label for="{formIdPrefix}_${formName}">County <span class="required">*</span></label>
                        <select id="{formIdPrefix}_${formName}" class="countySelectFor" name="${formName}">
                            <option value="">Please select</option>
                            <c:forEach var="opt" items="${requestScope['_99_counties']}">
                                <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="row requireField">
                        <c:set var="formName" value="_15_fein"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <label for="{formIdPrefix}_${formName}">Federal Employer ID <span class="required">*</span></label>
                        <input id="{formIdPrefix}_${formName}" type="text" class="normalInput feinMasked" id="fein" name="${formName}" value="${formValue}" maxlength="10"/>
                    </div>

                    <div class="row requireField">
                        <c:set var="formName" value="_15_legalName"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <label for="{formIdPrefix}_${formName}">TaxPayer Name <span class="required">*</span></label>
                        <input id="{formIdPrefix}_${formName}" type="text" class="normalInput" id="legalName" name="${formName}" value="${formValue}" maxlength="100"/>
                    </div>

                    <div class="row">
                        <c:set var="formName" value="_15_stateTaxId"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <label for="{formIdPrefix}_${formName}">State Tax ID</label>
                        <input id="{formIdPrefix}_${formName}" type="text" class="normalInput taxIdMasked" id="stateTaxId" name="${formName}" value="${formValue}" maxlength="10"/>
                    </div>

                    <div class="row requiredField">
                        <label>Fiscal Year End <span class="required">*</span></label>
                        <c:set var="formName" value="_15_fye1"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" title="Fiscal Year End Month" class="fiscalMonthInput smallInput" name="${formName}" value="${formValue}" maxlength="2"/>
                        <span class="sep">/</span>
                        <c:set var="formName" value="_15_fye2"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" title="Fiscal Year End Day" class="fiscalYearInput smallInput" name="${formName}" value="${formValue}" maxlength="2"/>
                        <span class="shrtFldInfo">MM/DD</span>
                    </div>

                    <div class="row">
                        <label>Office Phone Number <span class="required">*</span></label>
                        <c:set var="formName" value="_15_phone1"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" title="Office Phone Area Code" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                        <span class="sep">-</span>
                        <c:set var="formName" value="_15_phone2"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" title="Office Phone Prefix" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                        <span class="sep">-</span>
                        <c:set var="formName" value="_15_phone3"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" title="Office Phone Line Number" class="autotab smallInputP" name="${formName}" value="${formValue}" maxlength="4"/>
                        <span class="sep"><strong>ext.</strong></span>
                        <c:set var="formName" value="_15_phone4"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" title="Office Phone Extension" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                    </div>

                    <div class="row">
                        <label>Office Fax Number</label>
                        <c:set var="formName" value="_15_fax1"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" title="Office Fax Area Code" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                        <span class="sep">-</span>
                        <c:set var="formName" value="_15_fax2"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" title="Office Fax Prefix" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                        <span class="sep">-</span>
                        <c:set var="formName" value="_15_fax3"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" title="Office Fax Line Number" class="autotab smallInputP" name="${formName}" value="${formValue}" maxlength="4"/>
                    </div>
              </c:when>
              <c:when test="${useEducationPlanLayout}">
                    <div class="row requireField">
                        <c:set var="formName" value="_15_name"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <label for="{formIdPrefix}_${formName}">Complete Provider Name <span class="required">*</span></label>
                        <input id="{formIdPrefix}_${formName}" type="text" class="normalInput" id="legalName" name="${formName}" value="${formValue}" maxlength="100"/>
                        <span class="fldInfo">(number of the independent school district or complete name of regional cooperative or charter school)</span>
                    </div>

                    <div class="row requireField">
                        <c:set var="formName" value="_15_npi"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <label for="{formIdPrefix}_${formName}">
                          <abbr title="National Provider Identifier">NPI</abbr>
                          <span class="required">*</span>
                          <a href="javascript:" class="userHelpLink NPIdefinition">?</a>
                        </label>
                        <input id="{formIdPrefix}_${formName}" type="text" class="npiMasked normalInput" name="${formName}" value="${formValue}" maxlength="10"/>
                    </div>

                    <div class="row addressline1">
                        <c:set var="formName" value="_15_addressLine1"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <label for="{formIdPrefix}_${formName}">Actual Street Address <span class="required">*</span></label>
                        <input id="{formIdPrefix}_${formName}" type="text" title="Actual Street Address, Line 1" class="normalInput addressInputFor" name="${formName}" value="${formValue}" maxlength="28"/>
                    </div>
                    <div class="row inlineBox addressline2">
                        <span class="label">(Practice location cannot be a<br />PO Box)</span>
                        <c:set var="formName" value="_15_addressLine2"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" title="Actual Street Address, Line 2" class="normalInput addressInputFor" name="${formName}" value="${formValue}" maxlength="28"/>
                    </div>

                    <div class="row inlineBox">
                        <span class="label">&nbsp;</span>

                        <c:set var="formName" value="_15_city"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <label for="{formIdPrefix}_${formName}" class="cityLabel">City <span class="required">*</span></label>
                        <input id="{formIdPrefix}_${formName}" type="text"  class="cityInputFor" name="${formName}" value="${formValue}" maxlength="18"/>

                        <c:set var="formName" value="_15_state"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <label for="{formIdPrefix}_${formName}">State/Territory <span class="required">*</span></label>
                        <select id="{formIdPrefix}_${formName}" class="stateSelectFor" name="${formName}">
                            <option value="">Please select</option>
                            <c:forEach var="opt" items="${requestScope['_99_states']}">
                                <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                            </c:forEach>
                        </select>

                        <c:set var="formName" value="_15_zip"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <label for="{formIdPrefix}_${formName}">ZIP <span class="required">*</span> Code : </label>
                        <input id="{formIdPrefix}_${formName}" type="text" class="zipInputFor" name="${formName}" value="${formValue}" maxlength="10"/>
                    </div>

                    <div class="row requireField">
                        <c:set var="formName" value="_15_orgCountyName"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <label for="{formIdPrefix}_${formName}">County <span class="required">*</span></label>
                        <select id="{formIdPrefix}_${formName}" class="countySelectFor" name="${formName}">
                            <option value="">Please select</option>
                            <c:forEach var="opt" items="${requestScope['_99_counties']}">
                                <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                            </c:forEach>
                        </select>
                        <span class="fldInfo">(name of the county where the ISD, regional cooperative or charter school is located)</span>
                    </div>

                    <div class="row requireField">
                        <c:set var="formName" value="_15_fein"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <label for="{formIdPrefix}_${formName}">Federal Employer ID <span class="required">*</span></label>
                        <input id="{formIdPrefix}_${formName}" type="text" class="normalInput feinMasked" id="fein" name="${formName}" value="${formValue}" maxlength="10"/>
                    </div>

                    <div class="row requireField">
                        <c:set var="formName" value="_15_legalName"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <label for="{formIdPrefix}_${formName}">Legal Name According to the IRS <span class="required">*</span></label>
                        <input id="{formIdPrefix}_${formName}" type="text" class="normalInput" id="legalName" name="${formName}" value="${formValue}" maxlength="100"/>
                    </div>

                    <div class="row">
                        <c:set var="formName" value="_15_stateTaxId"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <label for="{formIdPrefix}_${formName}">State Tax ID</label>
                        <input id="{formIdPrefix}_${formName}" type="text" class="normalInput taxIdMasked" id="stateTaxId" name="${formName}" value="${formValue}" maxlength="10"/>
                    </div>

                    <div class="row requiredField">
                        <label>Fiscal Year End <span class="required">*</span></label>
                        <c:set var="formName" value="_15_fye1"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" title="Fiscal Year End Month" class="fiscalMonthInput smallInput" name="${formName}" value="${formValue}" maxlength="2"/>
                        <span class="sep">/</span>
                        <c:set var="formName" value="_15_fye2"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" title="Fiscal Year End Day" class="fiscalYearInput smallInput" name="${formName}" value="${formValue}" maxlength="2"/>
                        <span class="shrtFldInfo">MM/DD</span>
                    </div>

                    <div class="row">
                        <label>Office Phone Number <span class="required">*</span></label>
                        <c:set var="formName" value="_15_phone1"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" title="Office Phone Area Code" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                        <span class="sep">-</span>
                        <c:set var="formName" value="_15_phone2"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" title="Office Phone Prefix" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                        <span class="sep">-</span>
                        <c:set var="formName" value="_15_phone3"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" title="Office Phone Line Number" class="autotab smallInputP" name="${formName}" value="${formValue}" maxlength="4"/>
                        <span class="sep"><strong>ext.</strong></span>
                        <c:set var="formName" value="_15_phone4"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" title="Office Phone Extension" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                    </div>

                    <div class="row">
                        <label>Office Fax Number</label>
                        <c:set var="formName" value="_15_fax1"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" title="Office Fax Area Code" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                        <span class="sep">-</span>
                        <c:set var="formName" value="_15_fax2"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" title="Office Fax Prefix" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                        <span class="sep">-</span>
                        <c:set var="formName" value="_15_fax3"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" title="Office Fax Line Number" class="autotab smallInputP" name="${formName}" value="${formValue}" maxlength="4"/>
                    </div>

                    <div class="row requireField">
                        <c:set var="formName" value="_15_effectiveDate"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <label for="{formIdPrefix}_${formName}">Requested Application Date <span class="required">*</span></label>
                        <span class="dateWrapper floatL">
                            <input id="{formIdPrefix}_${formName}" class="date" type="text" name="${formName}" value="${formValue}"/>
                        </span>
                    </div>

              </c:when>
              <c:when test="${useEDILayout}">
                      <c:if test="${showInitialChoices}">
                    <div class="row requireField">
                        <label>Please Select <span class="required">*</span></label>
                        <c:set var="formName" value="_15_subType"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <label class="radioLabel">
                          <input type="radio" ${formValue eq 'Billing Agent' ? 'checked' : ''} value="Billing Agent" name="${formName}"/>
                          Billing Agent
                        </label>
                        <label class="radioLabel">
                          <input type="radio" ${formValue eq 'Eligibility Verification Vendor' ? 'checked' : ''} value="Eligibility Verification Vendor" name="${formName}"/>
                          Eligibility Verification Vendor
                        </label>
                        <label class="radioLabel">
                          <input type="radio" ${formValue eq 'Consolidated Billing Agent' ? 'checked' : ''} value="Consolidated Billing Agent" name="${formName}"/>
                          Consolidated Billing Agent
                        </label>
                        <label class="radioLabel">
                          <input type="radio" ${formValue eq 'Health Care Data Trading Partner' ? 'checked' : ''} value="Health Care Data Trading Partner" name="${formName}"/>
                          Health Care Data Trading Partner
                        </label>
                    </div>
                    <div class="row requireField">
                        <label>&nbsp;</label>
                        <label class="radioLabel">
                          <input type="radio" ${formValue eq 'Medicare Carrier' ? 'checked' : ''} value="Medicare Carrier" name="${formName}"/>
                          Medicare Carrier
                        </label>
                        <label class="radioLabel">
                          <input type="radio" ${formValue eq 'Mental Health Information System Grantee' ? 'checked' : ''} value="Mental Health Information System Grantee" name="${formName}"/>
                          Mental Health Information System Grantee
                        </label>
                        <label class="radioLabel">
                          <input type="radio" ${formValue eq 'MN Health Insurance Exchange Carrier' ? 'checked' : ''} value="MN Health Insurance Exchange Carrier" name="${formName}"/>
                          MN Health Insurance Exchange Carrier
                        </label>
                    </div>
                    </c:if>
                    <div class="row requireField">
                        <c:set var="formName" value="_15_name"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <label for="legalName">Organization Name <span class="required">*</span></label>
                        <input type="text" class="normalInput" id="legalName" name="${formName}" value="${formValue}" maxlength="100"/>
                    </div>
                    <div class="row requireField">
                        <c:set var="formName" value="_15_effectiveDate"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <label for="{formIdPrefix}_${formName}">Effective Date <span class="required">*</span></label>
                        <span class="dateWrapper floatL">
                            <input id="{formIdPrefix}_${formName}" class="date" type="text" name="${formName}" value="${formValue}"/>
                        </span>
                    </div>

                    <div class="row requireField">
                        <c:set var="formName" value="_15_fein"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <label for="fein">Federal Employer ID <span class="required">*</span></label>
                        <input type="text" class="normalInput feinMasked" id="fein" name="${formName}" value="${formValue}" maxlength="10"/>
                    </div>

                    <div class="row">
                        <c:set var="formName" value="_15_stateTaxId"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <label for="stateTaxId">State Tax ID</label>
                        <input type="text" class="normalInput taxIdMasked" id="stateTaxId" name="${formName}" value="${formValue}" maxlength="10"/>
                    </div>

                    <div class="row requireField">
                        <c:set var="formName" value="_15_legalName"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <label for="legalName">Legal Name <span class="required">*</span></label>
                        <input type="text" class="longNormalInput" id="legalName" name="${formName}" value="${formValue}" maxlength="1024"/>
                    </div>

                    <div class="row addressline1">
                        <c:set var="formName" value="_15_addressLine1"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <label for="{formIdPrefix}_${formName}">Address <span class="required">*</span></label>
                        <input id="{formIdPrefix}_${formName}" type="text" title="Address, Line 1" class="normalInput addressInputFor" name="${formName}" value="${formValue}" maxlength="28"/>
                    </div>
                    <div class="row inlineBox addressline2">
                        <c:set var="formName" value="_15_addressLine2"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <span class="label">(Practice location cannot be a<br />PO Box)</span>
                        <input type="text" title="Address, Line 2" class="normalInput addressInputFor" name="${formName}" value="${formValue}" maxlength="28"/>
                    </div>

                    <div class="row inlineBox">
                        <span class="label">&nbsp;</span>

                        <c:set var="formName" value="_15_city"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <label for="{formIdPrefix}_${formName}" class="cityLabel">City <span class="required">*</span></label>
                        <input id="{formIdPrefix}_${formName}" type="text" class="cityInputFor" name="${formName}" value="${formValue}" maxlength="18"/>

                        <c:set var="formName" value="_15_state"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <label for="{formIdPrefix}_${formName}">State/Territory <span class="required">*</span></label>
                        <select id="{formIdPrefix}_${formName}" class="stateSelectFor" name="${formName}">
                            <option value="">Please select</option>
                            <c:forEach var="opt" items="${requestScope['_99_states']}">
                                <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                            </c:forEach>
                        </select>

                        <c:set var="formName" value="_15_zip"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <label for="{formIdPrefix}_${formName}">ZIP Code <span class="required">*</span></label>
                        <input id="{formIdPrefix}_${formName}" type="text" class="zipInputFor" name="${formName}" value="${formValue}" maxlength="10"/>

                        <c:set var="formName" value="_15_county"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <label for="{formIdPrefix}_${formName}">County: </label>
                        <select id="{formIdPrefix}_${formName}" class="countySelectFor" name="${formName}">
                            <option value="">Please select</option>
                            <c:forEach var="opt" items="${requestScope['_99_counties']}">
                                <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="row">
                        <label>Phone Number <span class="required">*</span></label>
                        <c:set var="formName" value="_15_phone1"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" title="Phone Number Area Code" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                        <span class="sep">-</span>
                        <c:set var="formName" value="_15_phone2"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" title="Phone Number Prefix" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                        <span class="sep">-</span>
                        <c:set var="formName" value="_15_phone3"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" title="Phone Number Line Number" class="autotab smallInputP" name="${formName}" value="${formValue}" maxlength="4"/>
                        <span class="sep"><strong>ext.</strong></span>
                        <c:set var="formName" value="_15_phone4"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" title="Phone Number Extension" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                    </div>

                    <div class="row">
                        <label>Fax Number <span class="required">*</span></label>
                        <c:set var="formName" value="_15_fax1"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" title="Fax Number Area Code" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                        <span class="sep">-</span>
                        <c:set var="formName" value="_15_fax2"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" title="Fax Number Prefix" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                        <span class="sep">-</span>
                        <c:set var="formName" value="_15_fax3"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" title="Fax Number Line Number" class="autotab smallInputP" name="${formName}" value="${formValue}" maxlength="4"/>
                    </div>

                    <div class="row">
                        <c:set var="formName" value="_15_npi"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <label for="{formIdPrefix}_${formName}">UMPI</label>
                        <input id="{formIdPrefix}_${formName}" type="text" class="umpiMasked normalInput" name="${formName}" value="${formValue}" maxlength="10"/>
                    </div>
                    <c:if test="${showNameOfPersonFillingTheForm}">
                        <div class="row">
                            <c:set var="formName" value="_15_personCompletingForm"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <label for="{formIdPrefix}_${formName}">Name of person completing this form</label>
                            <input id="{formIdPrefix}_${formName}" type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="100"/>
                        </div>
                    </c:if>
              </c:when>
              <c:otherwise>
                <div class="row requireField">
                    <c:choose>
                        <c:when test="${askUMPI}">
                            <c:set var="formName" value="_15_npi"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <label for="{formIdPrefix}_${formName}">UMPI</label>
                            <input id="{formIdPrefix}_${formName}" type="text" class="umpiMasked normalInput" name="${formName}" value="${formValue}" maxlength="10"/>
                        </c:when>
                        <c:when test="${askUMPIorNPI}">
                            <c:set var="formName" value="_15_npi"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <label for="{formIdPrefix}_${formName}">NPI / UMPI</label>
                            <input id="{formIdPrefix}_${formName}" type="text" class="umpiMasked normalInput" name="${formName}" value="${formValue}" maxlength="10"/>
                        </c:when>
                        <c:otherwise>
                            <c:set var="formName" value="_15_npi"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <label for="{formIdPrefix}_${formName}">
                              <abbr title="National Provider Identifier">NPI</abbr>
                              <c:if test="${requireNPI}"> <span class="required">*</span></c:if>
                              <a href="javascript:" class="userHelpLink NPIdefinition">?</a>
                            </label>
                            <input id="{formIdPrefix}_${formName}" type="text" class="npiMasked normalInput" name="${formName}" value="${formValue}" maxlength="10"/>
                        </c:otherwise>
                    </c:choose>
                </div>
                <c:if test="${askEffectiveDate}">
                <div class="row requireField">
                    <c:set var="formName" value="_15_effectiveDate"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <label for="{formIdPrefix}_${formName}">Effective Date <span class="required">*</span></label>

                    <span class="dateWrapper floatL">
                        <input id="{formIdPrefix}_${formName}" class="date" type="text" name="${formName}" value="${formValue}"/>
                    </span>
                </div>
                </c:if>

                <c:if test="${askTaxPayerName}">
                <div class="row requireField">
                    <c:set var="formName" value="_15_legalName"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <label for="legalName">Provide Taxpayer Name <span class="required">*</span></label>
                    <input type="text" class="normalInput" id="legalName" name="${formName}" value="${formValue}" maxlength="100"/>
                </div>
                </c:if>

                <div class="row requireField">
                    <c:set var="formName" value="_15_name"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <label for="name">${askDBAName ? 'DBA Name' : 'Doing Business As'} <span class="required">*</span></label>
                    <input type="text" class="normalInput" id="name" name="${formName}" value="${formValue}" maxlength="100"/>
                </div>

                <c:if test="${not askTaxPayerName}">
                <div class="row requireField">
                    <c:set var="formName" value="_15_legalName"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <label for="legalName">Legal Name <span class="required">*</span></label>
                    <input type="text" class="longNormalInput" id="legalName" name="${formName}" value="${formValue}" maxlength="1024"/>
                </div>
                </c:if>

                <div class="row addressline1">
                    <c:set var="formName" value="_15_addressLine1"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <label for="{formIdPrefix}_${formName}">Practice Address <span class="required">*</span></label>
                    <input id="{formIdPrefix}_${formName}" type="text" title="Address, Line 1" class="normalInput addressInputFor" name="${formName}" value="${formValue}" maxlength="28"/>
                </div>
                <div class="row inlineBox addressline2">
                    <c:set var="formName" value="_15_addressLine2"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <span class="label">(Practice location cannot be a<br />PO Box)</span>
                    <input type="text" title="Address, Line 2" class="normalInput addressInputFor" name="${formName}" value="${formValue}" maxlength="28"/>
                </div>

                <div class="row inlineBox">
                    <span class="label">&nbsp;</span>
                    <c:set var="formName" value="_15_city"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <label for="{formIdPrefix}_${formName}" class="cityLabel">City <span class="required">*</span></label>
                    <input id="{formIdPrefix}_${formName}" type="text"  class="cityInputFor" name="${formName}" value="${formValue}" maxlength="18"/>

                    <c:set var="formName" value="_15_state"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <label for="{formIdPrefix}_${formName}">State/Territory <span class="required">*</span></label>
                    <select id="{formIdPrefix}_${formName}" class="stateSelectFor" name="${formName}">
                        <option value="">Please select</option>
                        <c:forEach var="opt" items="${requestScope['_99_states']}">
                            <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                        </c:forEach>
                    </select>

                    <c:set var="formName" value="_15_zip"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <label for="{formIdPrefix}_${formName}">ZIP Code <span class="required">*</span></label>
                    <input id="{formIdPrefix}_${formName}" type="text" class="zipInputFor" name="${formName}" value="${formValue}" maxlength="10"/>

                    <c:set var="formName" value="_15_county"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <label for="{formIdPrefix}_${formName}">County</label>
                    <select id="{formIdPrefix}_${formName}" class="countySelectFor" name="${formName}">
                        <option value="">Please select</option>
                        <c:forEach var="opt" items="${requestScope['_99_counties']}">
                            <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                        </c:forEach>
                    </select>
                </div>

                <div class="row">
                    <label>Office Phone Number <span class="required">*</span></label>
                    <c:set var="formName" value="_15_phone1"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input type="text" title="Office Phone Area Code" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                    <span class="sep">-</span>
                    <c:set var="formName" value="_15_phone2"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input type="text" title="Office Phone Prefix" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                    <span class="sep">-</span>
                    <c:set var="formName" value="_15_phone3"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input type="text" title="Office Phone Line Number" class="autotab smallInputP" name="${formName}" value="${formValue}" maxlength="4"/>
                    <span class="sep"><strong>ext.</strong></span>
                    <c:set var="formName" value="_15_phone4"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input type="text" title="Office Phone Extension" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                </div>

                <div class="row">
                    <label>Office Fax Number</label>
                    <c:set var="formName" value="_15_fax1"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input type="text" title="Office Fax Area Code" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                    <span class="sep">-</span>
                    <c:set var="formName" value="_15_fax2"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input type="text" title="Office Fax Prefix" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                    <span class="sep">-</span>
                    <c:set var="formName" value="_15_fax3"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input type="text" title="Office Fax Line Number" class="autotab smallInputP" name="${formName}" value="${formValue}" maxlength="4"/>
                </div>

                <div class="row requireField">
                    <c:set var="formName" value="_15_fein"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <label for="fein">Federal Employer ID <span class="required">*</span></label>
                    <input type="text" class="normalInput feinMasked" id="fein" name="${formName}" value="${formValue}" maxlength="10"/>
                </div>

                <div class="row">
                    <c:set var="formName" value="_15_stateTaxId"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <label for="stateTaxId">State Tax ID</label>
                    <input type="text" class="normalInput taxIdMasked" id="stateTaxId" name="${formName}" value="${formValue}" maxlength="10"/>
                </div>

                <c:if test="${askFiscalYear}">
                <div class="row">
                    <c:set var="formName" value="_15_fye1"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <label>Fiscal Year End</label>
                    <input type="text" title="Fiscal Year End Month" class="fiscalMonthInput smallInput" name="${formName}" value="${formValue}" maxlength="2"/>
                    <span class="sep">/</span>
                    <c:set var="formName" value="_15_fye2"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input type="text" title="Fiscal Year End Day" class="fiscalYearInput smallInput" name="${formName}" value="${formValue}" maxlength="2"/>
                    <span class="shrtFldInfo">MM/DD</span>
                </div>
                </c:if>

              </c:otherwise>
          </c:choose>

            <div class="clearFixed"></div>
        </div>

     <c:if test="${not useEDILayout && not clearingHouseLayout}">
        <div class="tableHeader"><span>Alternate Mailing Addresses</span></div>
        <div class="clearFixed"></div>
        <div class="wholeCol">
            <span>Do not list additional practice location addresses here. If there are multiple clinic locations, each one must be enrolled separately,</span>
        </div>
        <div class="addPracticeLocations">
        <table class="generalTable alternateTable" id="tablePractice">
            <colgroup>
                <col width="115"/>
                <col width="142"/>
                <col width="142"/>
                <col width="80"/>
                <col width="80"/>
                <col width="80"/>
                <col width="80"/>
            </colgroup>
            <thead>
            <tr>
                <th class="firstTheader">#<span class="sep"></span></th>
                <th>ATTN <span class="required-dark-background">*</span><span class="sep"></span></th>
                <th>Address <span class="required-dark-background">*</span><span class="sep"></span></th>
                <th>City <span class="required-dark-background">*</span><span class="sep"></span></th>
                <th>State/Territory <span class="required-dark-background">*</span><span class="sep"></span></th>
                <th>ZIP Code <span class="required-dark-background">*</span><span class="sep"></span></th>
                <th>County<span class="sep"></span></th>
            </tr>
            </thead>
            <tbody>
                <tr>
                    <c:set var="disableLinkedFields" value=""></c:set>
                    <c:set var="linkedFieldClass" value=""></c:set>

                    <td class="alignCenter">${status.count}
                        <strong>Billing</strong>
                        <div class="clear"></div>
                        <c:set var="formName" value="_15_billingSameAsPrimary"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input id="{formIdPrefix}_${formName}_billing_same" type="checkbox" class="checkbox" name="${formName}" ${formValue eq 'Y' ? 'checked' : ''}/><label for="{formIdPrefix}_${formName}_billing_same">same as Above</label>
                        <c:if test="${formValue eq 'Y'}">
                            <c:set var="disableLinkedFields" value='disabled="disabled"'></c:set>
                            <c:set var="linkedFieldClass" value="disabled"></c:set>
                        </c:if>
                    </td>
                    <td>
                        <c:set var="formName" value="_15_billingAttention"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input ${disableLinkedFields} type="text" title="Billing ATTN" class="longInput ${linkedFieldClass}" name="${formName}" value="${formValue}" maxlength="30"/>
                    </td>
                    <td>
                        <c:set var="formName" value="_15_billingAddressLine1"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input ${disableLinkedFields} type="text" title="Billing Address" class="addressLine1 longInput ${linkedFieldClass}" name="${formName}" value="${formValue}" maxlength="28"/>
                    </td>
                    <td>
                        <c:set var="formName" value="_15_billingCity"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input ${disableLinkedFields} type="text" title="Billing City" class="smallInput ${linkedFieldClass}" name="${formName}" value="${formValue}" maxlength="18"/>
                    </td>
                    <td>
                        <c:set var="formName" value="_15_billingState"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <select ${disableLinkedFields} title="Billing State/Territory" name="${formName}" class="${linkedFieldClass}">
                            <option value="">Please select</option>
                            <c:forEach var="opt" items="${requestScope['_99_states']}">
                                <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                            </c:forEach>
                        </select>
                    </td>
                    <td>
                        <c:set var="formName" value="_15_billingZip"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input ${disableLinkedFields} type="text" title="Billing Zip" class="zipInputFor smallInput ${linkedFieldClass}" name="${formName}" value="${formValue}" maxlength="10"/>
                    </td>
                    <td>
                        <c:set var="formName" value="_15_billingCounty"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <select ${disableLinkedFields} title="Billing County" name="${formName}" class="${linkedFieldClass}">
                            <option value="">Please select</option>
                            <c:forEach var="opt" items="${requestScope['_99_counties']}">
                                <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>

                <tr>
                    <c:set var="disableLinkedFields" value=""></c:set>
                    <c:set var="linkedFieldClass" value=""></c:set>
                    <td class="alignCenter">${status.count}
                        <strong>1099</strong>
                        <div class="clear"></div>
                        <c:set var="formName" value="_15_ten99SameAsPrimary"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input id="{formIdPrefix}_${formName}_1099_same" type="checkbox" class="checkbox" name="${formName}" ${formValue eq 'Y' ? 'checked' : ''}/><label for="{formIdPrefix}_${formName}_1099_same">same as Above</label>
                        <c:if test="${formValue eq 'Y'}">
                            <c:set var="disableLinkedFields" value='disabled="disabled"'></c:set>
                            <c:set var="linkedFieldClass" value="disabled"></c:set>
                        </c:if>
                    </td>
                    <td>
                        <c:set var="formName" value="_15_ten99Attention"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input ${disableLinkedFields} type="text" title="1099 Attention" class="longInput ${linkedFieldClass}" name="${formName}" value="${formValue}" maxlength="30"/>
                    </td>
                    <td>
                        <c:set var="formName" value="_15_ten99AddressLine1"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input ${disableLinkedFields} type="text" title="1099 Address" class="addressline1 longInput ${linkedFieldClass}" name="${formName}" value="${formValue}" maxlength="28"/>
                    </td>
                    <td>
                        <c:set var="formName" value="_15_ten99City"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input ${disableLinkedFields} type="text" title="1099 City" class="smallInput ${linkedFieldClass}" name="${formName}" value="${formValue}" maxlength="18"/>
                    </td>
                    <td>
                        <c:set var="formName" value="_15_ten99State"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <select ${disableLinkedFields} title="1099 State/Territory" name="${formName}" class="${linkedFieldClass}">
                            <option value="">Please select</option>
                            <c:forEach var="opt" items="${requestScope['_99_states']}">
                                <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                            </c:forEach>
                        </select>
                    </td>
                    <td>
                        <c:set var="formName" value="_15_ten99Zip"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input ${disableLinkedFields} type="text" title="1099 Zip" class="zipInputFor smallInput ${linkedFieldClass}" name="${formName}" value="${formValue}" maxlength="10"/>
                    </td>
                    <td>
                        <c:set var="formName" value="_15_ten99County"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <select ${disableLinkedFields} title="1099 County" name="${formName}" class="${linkedFieldClass}">
                            <option value="">Please select</option>
                            <c:forEach var="opt" items="${requestScope['_99_counties']}">
                                <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
            </tbody>
        </table>
        <div class="clearFixed"></div>
    </div>
    </c:if>
     <c:if test="${useEDILayout || clearingHouseLayout}">
         <c:set var="formName" value="_15_billingSameAsPrimary"></c:set>
         <input type="hidden" name="${formName}" value="Y" />
         <c:set var="formName" value="_15_ten99SameAsPrimary"></c:set>
         <input type="hidden" name="${formName}" value="Y" />
     </c:if>

    <div class="tableHeader"><span>Contact Info</span></div>
    <div class="clearFixed"></div>
    <div class="wholeCol">
       <span>List the name of the person we can contact if we have any questions</span>
       <div class="row requireField">
           <c:set var="formName" value="_15_contactName"></c:set>
           <c:set var="formValue" value="${requestScope[formName]}"></c:set>
           <label for="contactName">Contact Name <span class="required">*</span></label>
           <input ${disableContact} type="text" class="normalInput" id="contactName" name="${formName}" value="${formValue}" maxlength="100"/>
       </div>

       <div class="row">
           <c:set var="formName" value="_15_contactPhone1"></c:set>
           <c:set var="formValue" value="${requestScope[formName]}"></c:set>
           <label>Contact Phone Number <span class="required">*</span></label>
           <input type="text" title="Contact Phone Area Code" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
           <span class="sep">-</span>
           <c:set var="formName" value="_15_contactPhone2"></c:set>
           <c:set var="formValue" value="${requestScope[formName]}"></c:set>
           <input type="text" title="Contact Phone Prefix" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
           <span class="sep">-</span>
           <c:set var="formName" value="_15_contactPhone3"></c:set>
           <c:set var="formValue" value="${requestScope[formName]}"></c:set>
           <input type="text" title="Contact Phone Line Number" class="autotab smallInputP" name="${formName}" value="${formValue}" maxlength="4"/>
           <span class="sep"><strong>ext.</strong></span>
           <c:set var="formName" value="_15_contactPhone4"></c:set>
           <c:set var="formValue" value="${requestScope[formName]}"></c:set>
           <input type="text" title="Contact Phone Extension" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
       </div>

       <div class="row">
           <label>Contact Fax Number</label>
           <c:set var="formName" value="_15_contactFax1"></c:set>
           <c:set var="formValue" value="${requestScope[formName]}"></c:set>
           <input type="text" title="Contact Fax Area Code" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
           <span class="sep">-</span>
           <c:set var="formName" value="_15_contactFax2"></c:set>
           <c:set var="formValue" value="${requestScope[formName]}"></c:set>
           <input type="text" title="Contact Fax Prefix" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
           <span class="sep">-</span>
           <c:set var="formName" value="_15_contactFax3"></c:set>
           <c:set var="formValue" value="${requestScope[formName]}"></c:set>
           <input type="text" title="Contact fax Line Number" class="autotab smallInputP" name="${formName}" value="${formValue}" maxlength="4"/>
       </div>

       <div class="row">
           <c:set var="formName" value="_15_contactEmail"></c:set>
           <c:set var="formValue" value="${requestScope[formName]}"></c:set>
           <label for="contactEmail">Contact Email Address <span class="required">*</span></label>
           <input ${disableContact} type="text" class="normalInput" id="contactEmail" name="${formName}" value="${formValue}" maxlength="50"/>
       </div>
       <div class="clearFixed"></div>
       </div>
    </div>
    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
</div>
