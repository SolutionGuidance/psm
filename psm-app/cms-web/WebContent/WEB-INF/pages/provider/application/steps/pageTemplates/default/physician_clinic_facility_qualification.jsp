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
<%--
    JSP Fragment for facility type selection form.

 --%>

<%@page import="gov.medicaid.entities.dto.ViewStatics"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="h" tagdir="/WEB-INF/tags" %>

<c:set var="formIdPrefix" value="physician_clinic_facility_qualification"></c:set>
<input type="hidden" name="formNames" value="<%= ViewStatics.PHYSICIAN_CLINIC_FACILITY_QUALIFICATION_FORM %>">
<c:set var="selectedMarkup" value='selected="selected"' />

<div class="newApplicationPanel practicePanel memberInfoPanel">
    <div class="tableHeader topHeader"><span>Facility Qualification</span></div>
    <div class="clearFixed"></div>
    <div class="section">
        <div>
            <div class="row">
                <table>
                    <tbody>
                    <tr>
                        <td>
                            <c:set var="formName" value="_40_designationApprovalIndicator"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <label class="checkboxLabel">
                              <input type="checkbox" value="Y" name="${formName}"  ${formValue eq 'Y' ? 'checked' : ''}/>
                              Hospital Based Clinic Designation:  approval letter from CMS
                            </label>
                        </td>
                        <td>
                           <c:set var="formName" value="_40_designationApproval" />
                           <h:attachment
                               name="${formName}"
                               title="Approval Letter File"
                               attachmentId="${requestScope[formName]}"
                               attachmentIdName="${formName}"
                               filename="Download"
                           />
                        </td>
                    </tr>
                    </tbody>
                </table>
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
