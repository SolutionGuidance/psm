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

<div class="practicePanel">
    <input type="hidden" name="formNames" value="<%= ViewStatics.ADDITIONAL_PRACTICE_FORM %>">

    <div class="tableHeader otherTableHeader">
        <span class="additionalPracticeLocations">Additional Practice Locations</span>
        <a href="javascript:openPracticeLookup(false, false);" class="purpleSmallBtn practiceLookupModalBtn">Practice Lookup</a>
    </div>
    <!-- /.tableHeader -->
    <div class="addPracticeLocations">
        <table class="generalTable" id="tablePractice">
            <colgroup>
                <col width="22" />
                <col width="126" />
                <col width="127" />
                <col width="121" />
                <col width="130" />
                <col width="86" />
                <col width="145" />
                <col width="86" />
                <col width="87" />
                <col width="28" />
            </colgroup>
            <thead>
                <tr>
                    <th class="firstTheader">#<span class="sep"></span></th>
                    <th>Group NPI / UMPI <span class="required-dark-background">*</span><span class="sep"></span></th>
                    <th>Group Name <span class="required-dark-background">*</span><span class="sep"></span></th>
                    <th>Effective Date <span class="required-dark-background">*</span><span class="sep"></span></th>
                    <th>Practice Address <span class="required-dark-background">*</span><span class="sep"></span></th>
                    <th>City <span class="required-dark-background">*</span><span class="sep"></span></th>
                    <th>State/Territory <span class="required-dark-background">*</span><span class="sep"></span></th>
                    <th>ZIP Code <span class="required-dark-background">*</span><span class="sep"></span></th>
                    <th>County<span class="sep"></span></th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <c:set var="formName" value="_07_additonalLocationSize"></c:set>
                <c:forEach begin="1" end="${requestScope[formName]}" varStatus="status">
                    <tr>
                        <td class="alignCenter">${status.count}
                            <c:set var="formName" value="_07_objectId_${status.index - 1}"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <input type="hidden" name="${formName}" value="${formValue}">
                            <c:set var="disableLinkedFields" value=""></c:set>
                            <c:set var="isLinked" value="${false}"></c:set>
                            <c:if test="${not empty formValue}">
                                <c:set var="disableLinkedFields" value='disabled="disabled"'></c:set>
                                <c:set var="isLinked" value="${true}"></c:set>
                            </c:if>
                            <c:set var="formName" value="_07_objectIdHash_${status.index - 1}"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <input type="hidden" name="${formName}" value="${formValue}">
                        </td>
                        <td>
                            <c:set var="formName" value="_07_npi_${status.index - 1}"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <input ${disableLinkedFields} type="text" title="Group NPI / UMPI" class="npiMasked normalInput" name="${formName}" value="${formValue}" maxlength="10"/>
                        </td>
                        <td>
                            <c:set var="formName" value="_07_name_${status.index - 1}"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <input ${disableLinkedFields} type="text" title="Group Name" class="normalInput" name="${formName}" value="${formValue}" maxlength="100"/>
                        </td>
                        <td>
                            <span class="dateWrapper">
                                <c:set var="formName" value="_07_effectiveDate_${status.index - 1}"></c:set>
                                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                                <input ${disableLinkedFields} type="text" title="Effective Date" class="date" name="${formName}" value="${formValue}" maxlength="10"/>
                            </span>
                        </td>
                        <td>
                            <c:set var="formName" value="_07_addressLine1_${status.index - 1}"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <input ${disableLinkedFields} title="Practice Address, Line 1" type="text" class="addressLine1 normalInput" name="${formName}" value="${formValue}" maxlength="28"/>

                            <c:set var="formName" value="_07_addressLine2_${status.index - 1}"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <input ${disableLinkedFields} title="Practice Address, Line 2" type="text" class="addressLine2 normalInput" name="${formName}" value="${formValue}" maxlength="28"/>
                        </td>
                        <td>
                            <c:set var="formName" value="_07_city_${status.index - 1}"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <input ${disableLinkedFields} title="Practice City" type="text" class="smallInput" name="${formName}" value="${formValue}" maxlength="18"/>
                        </td>
                        <td>
                            <c:set var="formName" value="_07_state_${status.index - 1}"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <select ${disableLinkedFields} title="Practice State" name="${formName}">
                                <option value="">Please select</option>
                                <c:forEach var="opt" items="${requestScope['_99_states']}">
                                    <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                                </c:forEach>
                            </select>
                        </td>
                        <td>
                            <c:set var="formName" value="_07_zip_${status.index - 1}"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <input ${disableLinkedFields} type="text" title="Practice ZIP" class="zipInputFor smallInput" name="${formName}" value="${formValue}" maxlength="10"/>
                        </td>
                        <td>
                            <c:set var="formName" value="_07_county_${status.index - 1}"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <input ${disableLinkedFields} type="text" title="Practice County" class="smallInput countyMask" name="${formName}" value="${formValue}" maxlength="3"/>
                        </td>
                        <td class="alignCenter"><a href="javascript:;" class="remove">REMOVE</a></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <div class="clearFixed"></div>
        <div class="tableBottom">
            <c:if test="${requestScope['_07_allowAdd'] eq 'Y'}">
                <a href="javascript:;" id="addPractice">+ Add Another Practice Location</a>
            </c:if>
        </div>
    </div>
    <!-- /.section -->
    <div class="clear"></div>
    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
</div>
<!-- /.practicePanel -->
<div class="hide">
    <table class="hide" id="tablePracticeTemplate">
        <tbody>
            <tr>
                <td class="alignCenter"><span>1</span>
                    <input type="hidden" name="_07_objectId" value=""><input type="hidden" name="_07_objectIdHash" value="">
                </td>
                <td><input type="text" title="Group NPI/UMPI" class="npiMasked normalInput"  maxlength="10"/></td>
                <td><input type="text" title="Group Name" class="normalInput"  maxlength="100"/></td>
                <td>
                    <span class="dateWrapper">
                        <input type="text" title="Effective Date" class="date" maxlength="10"/>
                    </span>
                </td>
                <td>
                    <input type="text" title="Practice Address, Line 1" class="addressLine1 normalInput"  maxlength="28"/>
                    <input type="text" title="Practice Address, Line 2" class="addressLine2 normalInput"  maxlength="28"/>
                </td>
                <td><input type="text" title="Practice City" class="smallInput"  maxlength="18"/></td>
                <td>
                    <select title="Practice State/Territory">
                        <option value="">Please select</option>
                        <c:forEach var="opt" items="${requestScope['_99_states']}">
                            <option value="${opt.code}"><c:out value="${opt.description}" /></option>
                        </c:forEach>
                    </select>
                </td>
                <td><input type="text" title="Practice ZIP" class="zipInputFor smallInput"  maxlength="10"/></td>
                <td><input type="text" title="Practice County" class="smallInput"  maxlength="20"/></td>
                <td class="alignCenter"><a href="javascript:;" class="remove">REMOVE</a></td>
            </tr>
        </tbody>
    </table>
</div>
