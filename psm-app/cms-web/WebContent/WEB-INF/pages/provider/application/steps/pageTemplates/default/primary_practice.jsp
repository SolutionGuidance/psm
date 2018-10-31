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
<c:set var="formIdPrefix" value="primary_practice"></c:set>

<c:if test="${requestScope['_06_bound'] eq 'Y'}">
<!-- /.radioPanel -->
<div class="practicePanel">
    <input type="hidden" name="formNames" value="<%= ViewStatics.PRIMARY_PRACTICE_FORM %>">
    <c:set var="formName" value="_06_objectId"></c:set>
    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
    <input type="hidden" name="${formName}" value="${formValue}"/>

    <c:set var="disableLinkedFields" value=""></c:set>
    <c:set var="isLinked" value="${false}"></c:set>
    <c:if test="${not empty formValue}">
        <c:set var="disableLinkedFields" value='disabled="disabled"'></c:set>
        <c:set var="isLinked" value="${true}"></c:set>
    </c:if>

    <c:set var="disableReimbursementAddress" value="${isLinked}" />
    <c:set var="reimbursementAddressMarkup" value="${disableLinkedFields}" />
    <c:set var="formName" value="_06_reimbursementSameAsPrimary"></c:set>
    <c:set var="formValue" value="${requestScope[formName]}"></c:set>

    <c:if test="${formValue eq 'Y'}">
        <c:set var="disableReimbursementAddress" value="${true}" />
        <c:set var="reimbursementAddressMarkup" value='disabled="disabled"'></c:set>
    </c:if>

    <c:set var="formName" value="_06_objectIdHash"></c:set>
    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
    <input type="hidden" name="${formName}" value="${formValue}"/>


    <div id="primaryOffice">
        <div class="tableHeader otherTableHeader">
            <span>Primary Office Location Information</span>
            <a href="javascript:openPracticeLookup(true, false);" class="purpleSmallBtn practiceLookupModalBtn">Practice Lookup</a>
        </div>
        <!-- /.tableHeader -->
        <div class="section">
            <div class="wholeCol">
                <div class="row">
                    <c:set var="formName" value="_06_name"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <label for="${formIdPrefix}_${formName}">Primary Practice Name <span class="required">*</span></label>
                    <input id="${formIdPrefix}_${formName}" ${disableLinkedFields} type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="100"/>
                </div>
                <div class="row">
                    <c:set var="formName" value="_06_npi"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <label for="${formIdPrefix}_${formName}">
                      Group NPI/UMPI
                      <span class="required">*</span>
                      <a href="javascript:;" class="userHelpLink NPIdefinition">?</a>
                    </label>
                    <input id="${formIdPrefix}_${formName}" ${disableLinkedFields} type="text" class="npiMasked normalInput" name="${formName}" value="${formValue}" maxlength="10"/>
                    <input id="unlinkPracticeButton" type="button" value="Remove Reference" onclick="unlinkPractice('_06_')" style="display: ${isLinked ? 'inline' : 'none'}"/>
                </div>
                <div class="row">
                    <c:set var="formName" value="_06_stateMedicaidId"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <label for="${formIdPrefix}_${formName}">State Medicaid ID</label>
                    <input id="${formIdPrefix}_${formName}" ${disableLinkedFields} type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="100"/>
                </div>
                <div class="row">
                    <c:set var="formName" value="_06_effectiveDate"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <label for="${formIdPrefix}_${formName}">Effective Date <span class="required">*</span></label>
                    <span class="dateWrapper floatL">
                        <input id="${formIdPrefix}_${formName}" class="date" type="text" name="${formName}" value="${formValue}" maxlength="10"/>
                    </span>
                </div>
                <div class="row addressline1">
                    <c:set var="formName" value="_06_addressLine1"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <label for="${formIdPrefix}_${formName}">Practice Address <span class="required">*</span></label>
                    <input id="${formIdPrefix}_${formName}" ${disableLinkedFields} type="text" title="Practice Address, Line 1" class="normalInput" name="${formName}" value="${formValue}" maxlength="28"/>
                </div>
                <div class="row inlineBox addressline2">
                    <span class="label">(Practice location cannot be<br />a PO Box)</span>
                    <c:set var="formName" value="_06_addressLine2"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input ${disableLinkedFields} type="text" title="Practice Address, Line 2" class="normalInput" name="${formName}" value="${formValue}" maxlength="28"/>
                </div>
                <div class="row inlineBox">
                    <span class="label">&nbsp;</span>
                    <c:set var="formName" value="_06_city"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <label for="${formIdPrefix}_${formName}" class="cityLabel">
                      City
                      <span class="required">*</span>
                    </label>
                    <input id="${formIdPrefix}_${formName}" ${disableLinkedFields} type="text"  class="cityInputFor" name="${formName}" value="${formValue}" maxlength="18"/>

                    <c:set var="formName" value="_06_state"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <label for="${formIdPrefix}_${formName}">
                      State/Territory
                      <span class="required">*</span>
                    </label>
                    <select id="${formIdPrefix}_${formName}" ${disableLinkedFields} class="stateSelectFor" name="${formName}">
                        <option value="">Please select</option>
                        <c:forEach var="opt" items="${requestScope['_99_states']}">
                            <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                        </c:forEach>
                    </select>

                    <c:set var="formName" value="_06_zip"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <label for="${formIdPrefix}_${formName}">
                      ZIP Code
                      <span class="required">*</span>
                    </label>
                    <input id="${formIdPrefix}_${formName}" ${disableLinkedFields} type="text" class="zipInputFor" name="${formName}" value="${formValue}" maxlength="10"/>

                    <c:set var="formName" value="_06_county"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <label for="${formIdPrefix}_${formName}">
                      County
                    </label>
                    <select id="${formIdPrefix}_${formName}" ${disableLinkedFields} class="countySelectFor" name="${formName}">
                        <option value="">Please select</option>
                        <c:forEach var="opt" items="${requestScope['_99_counties']}">
                            <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                        </c:forEach>
                    </select>
                </div>
                <div class="row">
                    <label>Practice Phone Number <span class="required">*</span></label>
                    <c:set var="formName" value="_06_phone1"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input ${disableLinkedFields} type="text" title="Practice Phone Area Code" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                    <span class="sep">-</span>
                    <c:set var="formName" value="_06_phone2"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input ${disableLinkedFields} type="text" title="Practice Phone Prefix" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                    <span class="sep">-</span>
                    <c:set var="formName" value="_06_phone3"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input ${disableLinkedFields} type="text" title="Practice Phone Line Number" class="autotab smallInputP" name="${formName}" value="${formValue}" maxlength="4"/>
                    <span class="sep"><strong>ext.</strong></span>
                    <c:set var="formName" value="_06_phone4"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input ${disableLinkedFields} type="text" title="Practice Phone Extension" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                </div>
                <div class="row">
                    <label>Practice Fax Number</label>
                    <c:set var="formName" value="_06_fax1"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input ${disableLinkedFields} type="text" title="Practice Fax Area Code" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                    <span class="sep">-</span>
                    <c:set var="formName" value="_06_fax2"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input ${disableLinkedFields} type="text" title="Practice Fax Prefix" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                    <span class="sep">-</span>
                    <c:set var="formName" value="_06_fax3"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input ${disableLinkedFields} type="text" title="Pratice fax Line Number" class="autotab smallInputP" name="${formName}" value="${formValue}" maxlength="4"/>
                </div>
                <div class="row reimbursementAddressRow">
                    <label>Reimbursement Address <span class="required">*</span></label>
                    <div class="inputContainer">
                        <div class="checkboxWrapper">
                            <c:set var="formName" value="_06_reimbursementSameAsPrimary"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <label class="checkboxLabel">
                              <input ${disableLinkedFields} type="checkbox" class="checkbox" name="${formName}" ${formValue eq 'Y' ? 'checked' : ''}/>
                              Same as Above
                            </label>
                        </div>

                        <div class="row addressline1">
                            <c:set var="formName" value="_06_reimbursementAddressLine1"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <input ${reimbursementAddressMarkup} type="text" title="Reimbursement Address, Line 1" class="${disableReimbursementAddress ? 'disabled' : '' } addressInput normalInput" name="${formName}" value="${formValue}" maxlength="28"/>
                        </div>

                        <div class="row addressline2">
                            <c:set var="formName" value="_06_reimbursementAddressLine2"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <input ${reimbursementAddressMarkup} type="text" title="Reimbursement Address, Line 2" class="${disableReimbursementAddress ? 'disabled' : '' } addressInput normalInput" name="${formName}" value="${formValue}" maxlength="28"/>
                        </div>

                        <div class="addreddWrapper">
                            <c:set var="formName" value="_06_reimbursementCity"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <label for="${formIdPrefix}_${formName}" class="smallLabel">
                              City
                              <span class="required">*</span>
                            </label>
                            <input id="${formIdPrefix}_${formName}" ${reimbursementAddressMarkup} type="text" class="${disableReimbursementAddress ? 'disabled' : '' } cityInput" name="${formName}" value="${formValue}" maxlength="20"/>

                            <c:set var="formName" value="_06_reimbursementState"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <label for="${formIdPrefix}_${formName}" class="smallLabel">
                              State/Territory
                              <span class="required">*</span>
                            </label>
                            <select id="${formIdPrefix}_${formName}" ${reimbursementAddressMarkup} class="${disableReimbursementAddress ? 'disabled' : '' } stateSelect" name="${formName}">
                                <option value="">Please select</option>
                                <c:forEach var="opt" items="${requestScope['_99_states']}">
                                    <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                                </c:forEach>
                            </select>

                            <c:set var="formName" value="_06_reimbursementZip"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <label for="${formIdPrefix}_${formName}" class="smallLabel">
                              ZIP Code
                              <span class="required">*</span>
                            </label>
                            <input id="${formIdPrefix}_${formName}" ${reimbursementAddressMarkup} type="text" class="${disableReimbursementAddress ? 'disabled' : '' } zipInputFor" id="primaryReimbursementZip" name="${formName}" value="${formValue}" maxlength="10"/>
                        </div>
                    </div>
                </div>
                <div class="clear"></div>
            </div>
        </div>
        <!-- /.section -->
    </div>
    <!-- /#primaryOffice -->
    <div class="clear"></div>
    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
</div>
<!-- /.practicePanel -->
</c:if>
