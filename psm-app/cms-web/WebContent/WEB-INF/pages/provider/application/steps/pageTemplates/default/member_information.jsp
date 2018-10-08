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
<c:set var="formIdPrefix" value="member_information"></c:set>

<input type="hidden" name="formNames" value="<%= ViewStatics.MEMBER_INFO_FORM %>">
<c:set var="selectedMarkup" value='selected="selected"' />
<c:set var="askBGSInfo" value="${viewModel.tabModels[viewModel.currentTab].formSettings['Member Information Form'].settings['askBGSInfo']}"></c:set>
<c:set var="askUMPIorNPI" value="${viewModel.tabModels[viewModel.currentTab].formSettings['Member Information Form'].settings['askUMPIorNPI']}"></c:set>

<div id="membersTable">
<c:set var="formName" value="_16_memberSize"></c:set>

<c:forEach begin="1" end="${requestScope[formName]}" varStatus="status">
<div class="newApplicationPanel practicePanel memberInfoPanel">
    <div class="section">
        <c:set var="formName" value="_16_objectId_${status.index - 1}"></c:set>
        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
        <input type="hidden" name="${formName}" value="${formValue}"/>

        <div class="">
            <div class="row requireField">
                <c:set var="formName" value="_16_npi_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">
                  NPI/UMPI
                  <span class="required">*</span>
                  <a href="javascript:;" class="userHelpLink NPIdefinition">?</a>
                </label>
                <input id="${formIdPrefix}_${formName}" type="text" class="umpiMasked smallInput" name="${formName}" value="${formValue}" maxlength="10"/>
                <a href="javascript:;" class="purpleBtn NPILook"><span class="icon">
                <c:choose>
                    <c:when test="${askUMPIorNPI}">
                        NPI/UMPI Lookup
                    </c:when>
                    <c:otherwise>
                        NPI Lookup
                    </c:otherwise>
                </c:choose>
                </span></a>
                <span class="errorMsg">No records found with NPI number <span></span></span>
            </div>
        </div>
        <div class="leftCol">
            <div class="row requireField">
                <c:set var="formName" value="_16_providerType_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Individual Provider Type <span class="required">*</span></label>
                <select id="${formIdPrefix}_${formName}" name="${formName}">
                    <c:choose>
                        <c:when test="${onlyPharmacist}">
                            <option value="Pharmacist">Pharmacist</option>
                        </c:when>
                        <c:otherwise>
                            <option value="">Please select</option>
                            <c:forEach var="opt" items="${individualMemberProviderTypes}">
                               <option ${formValue eq opt.description ? selectedMarkup : ''} value="${opt.description}"><c:out value="${opt.description}" /></option>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </select>
            </div>
            <div class="row requireField">
                <c:set var="formName" value="_16_dob_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Date of Birth <span class="required">*</span>
                    <span class="label">(MM/DD/YYYY)</span>
                </label>
                <span class="dateWrapper floatL">
                    <input id="${formIdPrefix}_${formName}" class="date" type="text" name="${formName}" value="${formValue}"/>
                </span>
            </div>
            <div class="row requireField">
                <c:set var="formName" value="_16_startDate_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Start Date <span class="required">*</span>
                    <span class="label">(MM/DD/YYYY)</span>
                </label>
                <span class="dateWrapper floatL">
                    <input id="${formIdPrefix}_${formName}" class="date" type="text" name="${formName}" value="${formValue}"/>
                </span>
            </div>
            <div class="clearFixed"></div>
        </div>
        <div class="rightCol">
            <div class="row requireField">
                <c:set var="formName" value="_16_name_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}" class="">Name <span class="required">*</span></label>
                <input id="${formIdPrefix}_${formName}" type="text" class="nameInput normalInput" name="${formName}" value="${formValue}" maxlength="100"/>
            </div>
            <div class="row requireField">
                <c:set var="formName" value="_16_ssn_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}" class="">Social Security Number <span class="required">*</span></label>
                <input id="${formIdPrefix}_${formName}" type="text" class="ssnMasked normalInput" name="${formName}" value="${formValue}" maxlength="11"/>
            </div>
            <c:if test="${askBGSInfo == true}">
                <div class="row requireField">
                    <c:set var="formName" value="_16_bgsStudyId_${status.index - 1}"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <label for="${formIdPrefix}_${formName}" class="">BGS Study ID <span class="required">*</span></label>
                    <input id="${formIdPrefix}_${formName}" type="text" class="nameInput normalInput" name="${formName}" value="${formValue}" maxlength="75"/>
                </div>
                <div class="row requireField">
                    <c:set var="formName" value="_16_bgsClearanceDate_${status.index - 1}"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <label for="${formIdPrefix}_${formName}">BGS Clearance Date <span class="required">*</span>
                        <span class="label">(MM/DD/YYYY)</span>
                    </label>
                        <span class="dateWrapper floatL">
                        <input id="${formIdPrefix}_${formName}" class="date" type="text" name="${formName}" value="${formValue}"/>
                    </span>
                </div>
            </c:if>
            <div class="clearFixed"></div>
        </div>
        <div class="clear"></div>
    </div>
    <!-- /.section -->
    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
    <button class="closeSection" title="Close" aria-label="Close" type="button"></button>
</div>
</c:forEach>
</div>

<div class="hide">
<div class="newApplicationPanel practicePanel memberInfoPanel" id="memberPanelTemplate">
    <div class="section">
        <c:set var="formName" value="_16_objectId"></c:set>
        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
        <input type="hidden" name="${formName}" value="${formValue}"/>

        <div class="">
            <div class="row requireField">
                <c:set var="formName" value="_16_npi"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">
                  NPI/UMPI
                  <span class="required">*</span>
                  <a href="javascript:;" class="userHelpLink NPIdefinition">?</a>
                </label>
                <input id="${formIdPrefix}_${formName}" type="text" class="umpiMasked smallInput" name="${formName}" value="${formValue}" maxlength="10"/>
                <a href="javascript:;" class="purpleBtn NPILook"><span class="icon"></span>
                <c:choose>
                    <c:when test="${askUMPIorNPI}">
                        NPI/UMPI Lookup
                    </c:when>
                    <c:otherwise>
                        NPI Lookup
                    </c:otherwise>
                </c:choose>
                </a>
                <span class="errorMsg">No records found with NPI number <span></span></span>
            </div>
        </div>
        <div class="leftCol">
            <div class="row requireField">
                <c:set var="formName" value="_16_providerType"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Individual Provider Type <span class="required">*</span></label>
                <select id="${formIdPrefix}_${formName}" name="${formName}">
                    <c:choose>
                        <c:when test="${onlyPharmacist}">
                            <option value="Pharmacist">Pharmacist</option>
                        </c:when>
                        <c:otherwise>
                            <option value="">Please select</option>
                            <c:forEach var="opt" items="${individualMemberProviderTypes}">
                               <option ${formValue eq opt.description ? selectedMarkup : ''} value="${opt.description}"><c:out value="${opt.description}" /></option>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </select>
            </div>
            <div class="row requireField">
                <c:set var="formName" value="_16_dob"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Date of Birth <span class="required">*</span>
                    <span class="label">(MM/DD/YYYY)</span>
                </label>
                <span class="dateWrapper floatL">
                    <input id="${formIdPrefix}_${formName}" class="date" type="text" name="${formName}" value="${formValue}"/>
                </span>
            </div>
            <div class="row requireField">
                <c:set var="formName" value="_16_startDate"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Start Date <span class="required">*</span>
                    <span class="label">(MM/DD/YYYY)</span>
                </label>
                <span class="dateWrapper floatL">
                    <input id="${formIdPrefix}_${formName}" class="date" type="text" name="${formName}" value="${formValue}"/>
                </span>
            </div>
            <div class="clearFixed"></div>
        </div>
        <div class="rightCol">
            <div class="row requireField">
                <c:set var="formName" value="_16_name"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Name <span class="required">*</span></label>
                <input id="${formIdPrefix}_${formName}" type="text" class="nameInput normalInput" name="${formName}" value="${formValue}" maxlength="100"/>
            </div>
            <div class="row requireField">
                <c:set var="formName" value="_16_ssn"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Social Security Number <span class="required">*</span></label>
                <input id="${formIdPrefix}_${formName}" type="text" class="ssnMasked normalInput" name="${formName}" value="${formValue}" maxlength="11"/>
            </div>
            <c:if test="${askBGSInfo == true}">
                <div class="row requireField">
                    <c:set var="formName" value="_16_bgsStudyId"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <label for="${formIdPrefix}_${formName}">BGS Study ID <span class="required">*</span></label>
                    <input id="${formIdPrefix}_${formName}" type="text" class="nameInput normalInput" name="${formName}" value="${formValue}" maxlength="75"/>
                </div>
                <div class="row requireField">
                    <c:set var="formName" value="_16_bgsClearanceDate"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <label for="${formIdPrefix}_${formName}">BGS Clearance Date <span class="required">*</span>
                        <span class="label">(MM/DD/YYYY)</span>
                    </label>
                    <span class="dateWrapper floatL">
                        <input id="${formIdPrefix}_${formName}" class="date" type="text" name="${formName}" value="${formValue}"/>
                    </span>
                </div>
            </c:if>
            <div class="clearFixed"></div>
        </div>
        <div class="clear"></div>
    </div>
    <!-- /.section -->
    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
    <button class="closeSection" title="Close" aria-label="Close" type="button"></button>
</div>

<c:url var="lookupUrl" value="/provider/application/lookupProvider" />
<input type="hidden" id="memberLookupURL" value="${lookupUrl}"/>

</div>

<div class="tableBottom">
    <a href="javascript:;" id="addMember">+ Add Another Individual Member</a>
</div>
