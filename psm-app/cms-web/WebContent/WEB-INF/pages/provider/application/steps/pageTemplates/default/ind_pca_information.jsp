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
<c:set var="formIdPrefix" value="ind_pca_information"></c:set>

<div class="practicePanel">
    <div>
    <div class="section">
        <input type="hidden" name="formNames" value="<%= ViewStatics.PCA_INDIVIDUAL_FORM %>">
        <div class="wholeCol">
            <div class="row requireField">
                <c:set var="formName" value="_10_firstName"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="firstName">First Name <span class="required">*</span></label>
                <input id="firstName" type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="45"/>
            </div>
            <div class="row">
                <c:set var="formName" value="_10_middleName"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="middleName">Middle Name</label>
                <input id="middleName" type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="45"/>
            </div>
            <div class="row requireField">
                <c:set var="formName" value="_10_lastName"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Last Name <span class="required">*</span></label>
                <input id="${formIdPrefix}_${formName}" type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="45"/>
            </div>
            <div class="row requireField">
                <c:set var="formName" value="_10_ssn"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Social Security Number <span class="required">*</span></label>
                <input id="${formIdPrefix}_${formName}" type="text" class="normalInput ssnMasked" name="${formName}" value="${formValue}" maxlength="11"/>
            </div>

            <div class="row addressline1">
                <c:set var="formName" value="_10_addressLine1"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Residential Address <span class="required">*</span></label>
                <input id="${formIdPrefix}_${formName}" type="text" title="Address, Line 1" class="wholeInput addressInputFor" name="${formName}" value="${formValue}" maxlength="28"/>
            </div>
            <div class="row inlineBox addressline2">
                <c:set var="formName" value="_10_addressLine2"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <span class="label">(Residential Address only - do not<br />enter a PO Box)</span>
                <input type="text" title="Address, Line 2" class="wholeInput addressInputFor" name="${formName}" value="${formValue}" maxlength="28"/>
            </div>

            <div class="row inlineBox">
                <span class="label">&nbsp;</span>
                <c:set var="formName" value="_10_city"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}" class="cityLabel">City <span class="required">*</span></label>
                <input id="${formIdPrefix}_${formName}" type="text" class="cityInputFor" name="${formName}" value="${formValue}" maxlength="18"/>

                <c:set var="formName" value="_10_state"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">State/Territory <span class="required">*</span></label>
                <select id="${formIdPrefix}_${formName}" class="stateSelectFor" name="${formName}">
                    <option value="">Please select</option>
                    <c:forEach var="opt" items="${requestScope['_99_states']}">
                        <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                    </c:forEach>
                </select>

                <c:set var="formName" value="_10_zip"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">ZIP Code <span class="required">*</span></label>
                <input id="${formIdPrefix}_${formName}" type="text" class="zipInputFor" name="${formName}" value="${formValue}" maxlength="10"/>

                <c:set var="formName" value="_10_county"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">County</label>
                <select id="${formIdPrefix}_${formName}" class="countySelectFor" name="${formName}">
                       <option value="">Please select</option>
                       <c:forEach var="opt" items="${requestScope['_99_counties']}">
                        <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                    </c:forEach>
                   </select>
            </div>

            <div class="row">
                <c:set var="formName" value="_10_umpi"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">UMPI</label>
                <input id="${formIdPrefix}_${formName}" type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="10"/>
            </div>

            <div class="row requireField">
                <c:set var="formName" value="_10_dob"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Date of Birth <span class="required">*</span></label>
                <span class="dateWrapper floatL">
                    <input id="${formIdPrefix}_${formName}" class="date" type="text" name="${formName}" value="${formValue}"/>
                </span>
            </div>

            <div class="row">
                <label>Phone Number</label>
                <c:set var="formName" value="_10_phone1"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input type="text" title="Area Code" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                <span class="sep">-</span>
                <c:set var="formName" value="_10_phone2"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input type="text" title="Prefix" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                <span class="sep">-</span>
                <c:set var="formName" value="_10_phone3"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input type="text" title="Line Number" class="autotab smallInputP" name="${formName}" value="${formValue}" maxlength="4"/>
                <span class="sep"><strong>ext.</strong></span>
                <c:set var="formName" value="_10_phone4"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input type="text" title="Phone Extension" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
            </div>

            <div class="clearFixed"></div>
        </div>
    </div>
    <!-- /.section -->
    </div>
    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
</div>

<!-- /.newApplicationPanel -->
<div class="radioPanel">
    <div class="section">
        <div id="RadioWrapper" class="row">
            <c:set var="formName" value="_10_adultInd"></c:set>
            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
            <label>Are you 18 years or older? <span class="required">*</span></label>
            <div>
                <input id="${formIdPrefix}_${formName}_yes" type="radio" value="Y" name="${formName}" ${formValue eq 'Y' ? 'checked' : ''}><label for="${formIdPrefix}_${formName}_yes" class="span">Yes</label>
                <input id="${formIdPrefix}_${formName}_no" type="radio" value="N" name="${formName}" ${formValue eq 'N' ? 'checked' : ''}><label for="${formIdPrefix}_${formName}_no" class="span">No</label>
            </div>
        </div>
        <div class="clearFixed"></div>
    </div>
    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
</div>
