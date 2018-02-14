<%--
    JSP Fragment for ownership form.

    @author j3_guile
    @version 1.0
 --%>

<%@page import="gov.medicaid.entities.dto.ViewStatics"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:set var="formIdPrefix" value="ownership_information"></c:set>

<input type="hidden" name="formNames" value="<%= ViewStatics.OWNERSHIP_INFO_FORM %>">
<c:set var="selectedMarkup" value='selected="selected"' />
<c:set var="disabledMarkup" value='disabled="disabled"' />

<div class="newEnrollmentPanel practicePanel memberInfoPanel">
    <div class="tableHeader topHeader"><span>Disclosing Entity Structure</span></div>
    <div class="clearFixed"></div>
    <div class="section">

        <div class="leftCol">
            <div class="row requireField">
                <c:set var="formName" value="_17_entityType"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="entityType">Entity Type<span class="required">*</span></label>
                <span class="floatL"><b>:</b></span>
                <select id="entityType" name="${formName}">
                    <option value="">Please select</option>
                    <c:forEach var="opt" items="${entityStructureTypes}">
                       <option ${formValue eq opt.description ? selectedMarkup : ''} value="${opt.description}"><c:out value="${opt.description}" /></option>
                    </c:forEach>
                </select>
            </div>
            <div class="clearFixed"></div>
        </div>
        <div class="rightCol">
            <div class="row">
                <c:set var="formName" value="_17_entityDescription"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Specify Type</label>
                <span class="floatL"><b>:</b></span>
                <input id="${formIdPrefix}_${formName}" type="text" class="normalInput ${formValue eq 'Other' ? '' : 'disabled'}" ${formValue eq 'Other' ? '' : disabledMarkup} name="${formName}" value="${formValue}" maxlength="100"/>
            </div>
            <div class="clearFixed"></div>
        </div>
        <div class="clear"></div>
    </div>
    <!-- /.section -->
    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
</div>


<div class="requiredInfo">
    Each provider entity must complete the following sections for all persons and businesses or organizations that meet any of the following criteria:
    <ul>
        <li>Have an ownership or control interest of 5% or more in this disclosing entity</li>
        <li>Have an ownership or control interest in a subcontractor in which this disclosing entity has a direct or indirect ownership interest of 5% or more</li>
        <li>Are a managing employee</li>
    </ul>
</div>

<div class="personOwnersTable">
<c:set var="formName" value="_17_personOwnersSize"></c:set>
<div class="newEnrollmentPanel practicePanel memberInfoPanel">
    <div class="tableHeader topHeader"><span>Individual Person(s) Ownership or Control Interest</span></div>
    <div class="clearFixed"></div>
    <div class="requiredInfo">List all individual owners, managing employees, and persons with control interest.</div>
    <div class="section">
    </div>
    <c:forEach begin="1" end="${requestScope[formName]}" varStatus="status">
    <div class="personOwner">
    <div class="section line">
        <div class="">
            <div class="row requireField">
                <c:set var="formName" value="_17_iboType_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Type<span class="required">*</span><span><a href="javascript:" class="definition">?</a></span></label>
                <span class="floatL"><b>:</b></span>
                <select id="${formIdPrefix}_${formName}" class="ownershipType" name="${formName}">
                    <option value="">Please select</option>
                    <c:forEach var="opt" items="${beneficialOwnerTypes}">
                        <c:if test="${opt.ownerType ne 'O'}">
                           <option ${formValue eq opt.description ? selectedMarkup : ''} value="${opt.description}"><c:out value="${opt.description}" /></option>
                        </c:if>
                    </c:forEach>
                </select>

                <div class="subType subcontractor">
                    <c:set var="formName" value="_17_iboSubcontractorName_${status.index - 1}"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <label for="${formIdPrefix}_${formName}">Name Subcontractor</label>
                    <span class="floatL"><b>:</b></span>
                    <input id="${formIdPrefix}_${formName}" type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="100"/>
                    <div class="clear"></div>
                </div>
                <div class="subType owner">
                    <c:set var="formName" value="_17_iboPercentOwnership_${status.index - 1}"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <label for="${formIdPrefix}_${formName}">List % of Ownership Interest
                        <span class="label">if 5% or more</span>
                    </label>
                    <span class="floatL"><b>:</b></span>
                    <input id="${formIdPrefix}_${formName}" type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="6"/>
                    <div class="clear"></div>
                </div>
                <div class="subType other">
                    <c:set var="formName" value="_17_iboOtherType_${status.index - 1}"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <label for="${formIdPrefix}_${formName}">Other</label>
                    <span class="floatL"><b>:</b></span>
                    <input id="${formIdPrefix}_${formName}" type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="100"/>
                    <div class="clear"></div>
                </div>
            </div>
            <div class="clearFixed"></div>
        </div>
        <div class="clearFixed"></div>
        <div class="leftCol">
            <div class="row requireField">
                <c:set var="formName" value="_17_iboFirstName_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">First Name<span class="required">*</span></label>
                <span class="floatL"><b>:</b></span>
                <input id="${formIdPrefix}_${formName}" type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="45"/>
            </div>
            <div class="row">
                <c:set var="formName" value="_17_iboMiddleName_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Middle Name</label>
                <span class="floatL"><b>:</b></span>
                <input id="${formIdPrefix}_${formName}" type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="45"/>
            </div>
            <div class="row requireField">
                <c:set var="formName" value="_17_iboLastName_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Last Name<span class="required">*</span></label>
                <span class="floatL"><b>:</b></span>
                <input id="${formIdPrefix}_${formName}" type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="45"/>
            </div>
            <div class="row requireField">
                <c:set var="formName" value="_17_iboSSN_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Social Security Number<span class="required">*</span></label>
                <span class="floatL"><b>:</b></span>
                <input id="${formIdPrefix}_${formName}" type="text" class="ssnMasked normalInput" name="${formName}" value="${formValue}" maxlength="11"/>
            </div>
            <div class="clearFixed"></div>
        </div>
        <div class="rightCol">
            <div class="row requireField">
                <c:set var="formName" value="_17_iboDOB_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Date of Birth<span class="required">*</span>
                    <span class="label">(MM/DD/YYYY)</span>
                </label>
                <span class="floatL"><b>:</b></span>
                <span class="dateWrapper floatL">
                    <input id="${formIdPrefix}_${formName}" class="date" type="text" name="${formName}" value="${formValue}"/>
                </span>
            </div>
            <div class="row requireField">
                <c:set var="formName" value="_17_iboHireDate_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Hire Date<span class="required">*</span>
                    <span class="label">(MM/DD/YYYY)</span>
                </label>
                <span class="floatL"><b>:</b></span>
                <span class="dateWrapper floatL">
                    <input id="${formIdPrefix}_${formName}" class="date" type="text" name="${formName}" value="${formValue}"/>
                </span>
            </div>
            <div class="row requireField">
                <c:set var="formName" value="_17_iboRelationship_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label class="multiLine">Relationship to any other listed person</label>
                <span class="floatL"><b>:</b></span>
                <label class="inline"><input type="radio" ${formValue eq 'Spouse' ? 'checked' : ''} name="${formName}" value="Spouse"/>Spouse</label>
                <label class="inline"><input type="radio" ${formValue eq 'Child' ? 'checked' : ''} name="${formName}" value="Child"/>Child</label>
                <label class="inline"><input type="radio" ${formValue eq 'Parent' ? 'checked' : ''} name="${formName}" value="Parent"/>Parent</label>
                <label class="inline"><input type="radio" ${formValue eq 'Sibling' ? 'checked' : ''} name="${formName}" value="Sibling"/>Sibling</label>
            </div>
            <div class="clearFixed"></div>
        </div>
        <div class="">
            <div class="row requiredField addressline1">
                <c:set var="formName" value="_17_iboAddressLine1_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Home Residence Address<span class="required">*</span></label>
                <span class="floatL"><b>:</b></span>
                <input id="${formIdPrefix}_${formName}" type="text" title="Home Residence Address, Line 1" class="normalInput addressInputFor" name="${formName}" value="${formValue}" maxlength="28"/>
            </div>

            <div class="row inlineBox addressline2">
                <c:set var="formName" value="_17_iboAddressLine2_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <span class="label">(Practice location cannot be a<br />PO Box)</span>
                <span class="floatL"><b>&nbsp;</b></span>
                <input type="text" title="Home Residence Address, Line 2" class="normalInput addressInputFor" name="${formName}" value="${formValue}" maxlength="28"/>
            </div>

            <div class="row inlineBox">
                <span class="label">&nbsp;</span>
                <span class="floatL"><b>&nbsp;</b></span>
                <c:set var="formName" value="_17_iboCity_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}" class="cityLabel">City : </label>
                <input id="${formIdPrefix}_${formName}" type="text"  class="cityInputFor" name="${formName}" value="${formValue}" maxlength="18"/>

                <c:set var="formName" value="_17_iboState_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">State : </label>
                <select id="${formIdPrefix}_${formName}" class="stateSelectFor" name="${formName}">
                    <option value="">Please select</option>
                    <c:forEach var="opt" items="${requestScope['_99_states']}">
                        <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                    </c:forEach>
                </select>

                <c:set var="formName" value="_17_iboZip_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">ZIP Code : </label>
                <input id="${formIdPrefix}_${formName}" type="text" class="zipInputFor" name="${formName}" value="${formValue}" maxlength="10"/>

                <c:set var="formName" value="_17_iboCounty_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">County : </label>
                <select id="${formIdPrefix}_${formName}" class="countySelectFor" name="${formName}">
                    <option value="">Please select</option>
                    <c:forEach var="opt" items="${requestScope['_99_counties']}">
                        <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="clearFixed"></div>
        <span class="control">
            <c:set var="formName" value="_17_iboOtherInterestInd_${status.index - 1}"></c:set>
            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
            <label class="checkboxLabel">
              <input class="showHidePanel" value="Y" type="checkbox" ${formValue eq 'Y' ? 'checked' : ''} name="${formName}" />
              This person/business has an ownership or control interest in another Medicaid disclosing entity, or an
              entity that does not participate in Medicaid but is required to disclose ownership and control interest
              because of participation in any Title V, XVIII, or XX programs.
            </label>
        </span>
    </div>
    <!-- /.section -->


    <div class="section line hiddenSection" style="display: ${formValue eq 'Y' ? 'block' : 'none'};">
        <div>
            <div class="row requireField">
                <c:set var="formName" value="_17_iboOtherInterestName_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}" class="multiLine">Full Legal Name of Other Provider<span class="required">*</span></label>
                <span class="floatL"><b>:</b></span>
                <span class="floatL inputCnt">
                    <input id="${formIdPrefix}_${formName}" type="text" class="wholeInput fullLengthName" name="${formName}" value="${formValue}" maxlength="100"/><br/>
                    <span class="label">(Taxpayer name of FEIN or on W-9 from IRS)</span>
                </span>

                <c:set var="formName" value="_17_iboOtherInterestPct_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}" class="inlineLabel">% of Ownership Interest<span class="required">*</span></label>
                <span class="floatL"><b>:</b></span>
                <input id="${formIdPrefix}_${formName}" type="text" class="wholeInput smallInput" name="${formName}" value="${formValue}" maxlength="6"/>
                <div class="clearFixed"></div>
            </div>
            <div class="row requireField addressline1">
                <c:set var="formName" value="_17_iboOtherAddressLine1_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Address of Other Provider<span class="required">*</span></label>
                <span class="floatL"><b>:</b></span>
                <input id="${formIdPrefix}_${formName}" type="text" title="Other Provider Address, Line 1" class="normalInput addressInputFor" name="${formName}" value="${formValue}" maxlength="28"/>
                <div class="clearFixed"></div>
            </div>
            <div class="row inlineBox addressline2">
                <c:set var="formName" value="_17_iboOtherAddressLine2_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <span class="label">&nbsp;</span>
                <span class="floatL"><b>&nbsp;</b></span>
                <input type="text" title="Other Provider Address, Line 2" class="normalInput addressInputFor" name="${formName}" value="${formValue}" maxlength="28"/>
            </div>
            <div class="row inlineBox">
                <span class="label">&nbsp;</span>
                <span class="floatL"><b>&nbsp;</b></span>
                <c:set var="formName" value="_17_iboOtherCity_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}" class="cityLabel">City : </label>
                <input id="${formIdPrefix}_${formName}" type="text" class="cityInputFor" name="${formName}" value="${formValue}" maxlength="18"/>

                <c:set var="formName" value="_17_iboOtherCounty_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">County/Indian Reservation:</label>
                <select id="${formIdPrefix}_${formName}" class="countySelectFor" name="${formName}">
                    <option value="">Please select</option>
                    <c:forEach var="opt" items="${requestScope['_99_counties']}">
                        <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                    </c:forEach>
                </select>

                <c:set var="formName" value="_17_iboOtherState_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">State : </label>
                <select id="${formIdPrefix}_${formName}" class="stateSelectFor" name="${formName}">
                    <option value="">Please select</option>
                    <c:forEach var="opt" items="${requestScope['_99_states']}">
                        <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                    </c:forEach>
                </select>

                <c:set var="formName" value="_17_iboOtherZip_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">ZIP Code : </label>
                <input id="${formIdPrefix}_${formName}" type="text" class="zipInputFor" name="${formName}" value="${formValue}" maxlength="10"/>
            </div>
        </div>
        <div class="clearFixed"></div>
    </div>
    </div>
    </c:forEach>

    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
</div>
</div>

<div class="tableBottom">
    <a href="javascript:;" id="addIndividualOwnership">+ Add Another Individual Person Ownership or Control Interest</a>
</div>


<div class="corpOwnersTable">
<c:set var="formName" value="_17_corpOwnersSize"></c:set>
<div class="newEnrollmentPanel practicePanel memberInfoPanel">
    <div class="tableHeader topHeader"><span>Business Ownership or Control Interest</span></div>
    <div class="clearFixed"></div>
    <div class="requiredInfo">If an entity owns or has a control interest in your business (listed in the first box on page 1), list those other entities below.</div>
    <div class="section">
    </div>
    <c:forEach begin="1" end="${requestScope[formName]}" varStatus="status">
    <div class="corpOwner">
    <div class="section line">
        <div class="">
            <div class="row requireField">
                <c:set var="formName" value="_17_cboType_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Type<span class="required">*</span><span><a href="javascript:" class="definition">?</a></span></label>
                <span class="floatL"><b>:</b></span>
                <select id="${formIdPrefix}_${formName}" class="businessOwnershipType" name="${formName}">
                    <option value="">Please select</option>
                    <c:forEach var="opt" items="${beneficialOwnerTypes}">
                        <c:if test="${opt.ownerType ne 'P'}">
                           <option ${formValue eq opt.description ? selectedMarkup : ''} value="${opt.description}"><c:out value="${opt.description}" /></option>
                        </c:if>
                    </c:forEach>
                </select>

                <div class="subType subcontractor">
                    <c:set var="formName" value="_17_cboSubcontractorName_${status.index - 1}"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <label for="${formIdPrefix}_${formName}">Name Subcontractor</label>
                    <span class="floatL"><b>:</b></span>
                    <input id="${formIdPrefix}_${formName}" type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="100"/>
                    <div class="clear"></div>
                </div>
                <div class="subType owner">
                    <c:set var="formName" value="_17_cboPercentOwnership_${status.index - 1}"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <label for="${formIdPrefix}_${formName}">List % of Ownership Interest
                        <span class="label">if 5% or more</span>
                    </label>
                    <span class="floatL"><b>:</b></span>
                    <input id="${formIdPrefix}_${formName}" type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="6"/>
                    <div class="clear"></div>
                </div>
                <div class="subType other">
                    <c:set var="formName" value="_17_cboOtherType_${status.index - 1}"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <label for="${formIdPrefix}_${formName}">Other</label>
                    <span class="floatL"><b>:</b></span>
                    <input id="${formIdPrefix}_${formName}" type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="100"/>
                    <div class="clear"></div>
                </div>
            </div>
            <div class="clearFixed"></div>
        </div>
        <div class="clearFixed"></div>
        <div class="">
            <div class="row requireField">
                <c:set var="formName" value="_17_cboLegalName_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Full Legal Name<span class="required">*</span></label>
                <span class="floatL"><b>:</b></span>
                <span class="floatL inputCnt">
                    <input id="${formIdPrefix}_${formName}" type="text" class="wholeInput fullLengthName" name="${formName}" value="${formValue}" maxlength="100"/><br/>
                    <span class="label">(Taxpayer name of FEIN or on W-9 from IRS)</span>
                </span>

                <c:set var="formName" value="_17_cboFEIN_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}" class="inlineLabel">FEIN<span class="required">*</span></label>
                <span class="floatL"><b>:</b></span>
                <input id="${formIdPrefix}_${formName}" type="text" class="wholeInput smallInput feinMasked" name="${formName}" value="${formValue}" maxlength="10"/>
                <div class="clearFixed"></div>
            </div>
            <div class="row requiredField addressline1">
                <c:set var="formName" value="_17_cboAddressLine1_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Business Address<span class="required">*</span></label>
                <span class="floatL"><b>:</b></span>
                <input id="${formIdPrefix}_${formName}" type="text" title="Business Address, Line 1" class="normalInput addressInputFor" name="${formName}" value="${formValue}" maxlength="28"/>
            </div>

            <div class="row inlineBox addressline2">
                <c:set var="formName" value="_17_cboAddressLine2_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <span class="label">&nbsp;</span>
                <span class="floatL"><b>&nbsp;</b></span>
                <input type="text" title="Business Address, Line 2" class="normalInput addressInputFor" name="${formName}" value="${formValue}" maxlength="28"/>
            </div>

            <div class="row inlineBox">
                <span class="label">&nbsp;</span>
                <span class="floatL"><b>&nbsp;</b></span>
                <c:set var="formName" value="_17_cboCity_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}" class="cityLabel">City : </label>
                <input id="${formIdPrefix}_${formName}" type="text"  class="cityInputFor" name="${formName}" value="${formValue}" maxlength="18"/>

                <c:set var="formName" value="_17_cboState_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">State : </label>
                <select id="${formIdPrefix}_${formName}" class="stateSelectFor" name="${formName}">
                    <option value="">Please select</option>
                    <c:forEach var="opt" items="${requestScope['_99_states']}">
                        <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                    </c:forEach>
                </select>

                <c:set var="formName" value="_17_cboZip_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">ZIP Code : </label>
                <input id="${formIdPrefix}_${formName}" type="text" class="zipInputFor" name="${formName}" value="${formValue}" maxlength="10"/>

                <c:set var="formName" value="_17_cboCounty_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">County : </label>
                <select id="${formIdPrefix}_${formName}" class="countySelectFor" name="${formName}">
                    <option value="">Please select</option>
                    <c:forEach var="opt" items="${requestScope['_99_counties']}">
                        <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="clearFixed"></div>
        <span class="control">
            <c:set var="formName" value="_17_cboOtherInterestInd_${status.index - 1}"></c:set>
            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
            <label class="checkboxLabel">
              <input class="showHidePanel" value="Y" type="checkbox" ${formValue eq 'Y' ? 'checked' : ''} name="${formName}" />
              This person/business has an ownership or control interest in another Medicaid disclosing entity, or an
              entity that does not participate in Medicaid but is required to disclose ownership and control interest
              because of participation in any Title V, XVIII, or XX programs.
            </label>
        </span>
    </div>
    <!-- /.section -->

    <div class="section line hiddenSection" style="display: ${formValue eq 'Y' ? 'block' : 'none'};">
        <div>
            <div class="row requireField">
                <c:set var="formName" value="_17_cboOtherInterestName_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}" class="multiLine">Full Legal Name of Other Provider<span class="required">*</span></label>
                <span class="floatL"><b>:</b></span>
                <span class="floatL inputCnt">
                    <input id="${formIdPrefix}_${formName}" type="text" class="wholeInput fullLengthName" name="${formName}" value="${formValue}" maxlength="100"/><br/>
                    <span class="label">(Taxpayer name of FEIN or on W-9 from IRS)</span>
                </span>

                <c:set var="formName" value="_17_cboOtherInterestPct_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}" class="inlineLabel">% of Ownership Interest<span class="required">*</span></label>
                <span class="floatL"><b>:</b></span>
                <input id="${formIdPrefix}_${formName}" type="text" class="wholeInput smallInput" name="${formName}" value="${formValue}" maxlength="6"/>
                <div class="clearFixed"></div>
            </div>
            <div class="row requireField addressline1">
                <c:set var="formName" value="_17_cboOtherAddressLine1_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Address of Other Provider<span class="required">*</span></label>
                <span class="floatL"><b>:</b></span>
                <input id="${formIdPrefix}_${formName}" type="text" title="Other Provider Address, Line 1" class="normalInput addressInputFor" name="${formName}" value="${formValue}" maxlength="28"/>
                <div class="clearFixed"></div>
            </div>
            <div class="row inlineBox addressline2">
                <c:set var="formName" value="_17_cboOtherAddressLine2_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <span class="label">&nbsp;</span>
                <span class="floatL"><b>&nbsp;</b></span>
                <input type="text" title="Other Provider Address, Line 2" class="normalInput addressInputFor" name="${formName}" value="${formValue}" maxlength="28"/>
            </div>
            <div class="row inlineBox">
                <c:set var="formName" value="_17_cboOtherCity_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <span class="label">&nbsp;</span>
                <span class="floatL"><b>&nbsp;</b></span>
                <label for="${formIdPrefix}_${formName}" class="cityLabel">City : </label>
                <input id="${formIdPrefix}_${formName}" type="text" class="cityInputFor" name="${formName}" value="${formValue}" maxlength="18"/>

                <c:set var="formName" value="_17_cboOtherCounty_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">County/Indian Reservation:</label>
                <select id="${formIdPrefix}_${formName}" class="countySelectFor" name="${formName}">
                    <option value="">Please select</option>
                    <c:forEach var="opt" items="${requestScope['_99_counties']}">
                        <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                    </c:forEach>
                </select>

                <c:set var="formName" value="_17_cboOtherState_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">State : </label>
                <select id="${formIdPrefix}_${formName}" class="stateSelectFor" name="${formName}">
                    <option value="">Please select</option>
                    <c:forEach var="opt" items="${requestScope['_99_states']}">
                        <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                    </c:forEach>
                </select>

                <c:set var="formName" value="_17_cboOtherZip_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">ZIP Code : </label>
                <input id="${formIdPrefix}_${formName}" type="text" class="zipInputFor" name="${formName}" value="${formValue}" maxlength="10"/>
            </div>
        </div>
        <div class="clearFixed"></div>
    </div>
    </div>
    </c:forEach>
    <!-- /.section -->
    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
</div>
</div>

<div class="tableBottom">
    <a href="javascript:;" id="addBusinessOwnership">+ Add Another Business Ownership or Control Interest</a>
</div>


<div class="hide">
<div id="corpOwnerTemplate" class="corpOwner">
    <div class="section line">
        <div>
            <div class="row requireField">
                <c:set var="formName" value="_17_cboType"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Type<span class="required">*</span><span><a href="javascript:" class="definition">?</a></span></label>
                <span class="floatL"><b>:</b></span>
                <select id="${formIdPrefix}_${formName}" class="businessOwnershipType" name="${formName}">
                    <option value="">Please select</option>
                    <c:forEach var="opt" items="${beneficialOwnerTypes}">
                       <c:if test="${opt.ownerType ne 'P'}">
                        <option ${formValue eq opt.description ? selectedMarkup : ''} value="${opt.description}"><c:out value="${opt.description}" /></option>
                       </c:if>
                    </c:forEach>
                </select>

                <div class="subType subcontractor">
                    <c:set var="formName" value="_17_cboSubcontractorName"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <label for="${formIdPrefix}_${formName}">Name Subcontractor</label>
                    <span class="floatL"><b>:</b></span>
                    <input id="${formIdPrefix}_${formName}" type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="100"/>
                    <div class="clear"></div>
                </div>
                <div class="subType owner">
                    <c:set var="formName" value="_17_cboPercentOwnership"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <label for="${formIdPrefix}_${formName}">List % of Ownership Interest
                        <span class="label">if 5% or more</span>
                    </label>
                    <span class="floatL"><b>:</b></span>
                    <input id="${formIdPrefix}_${formName}" type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="6"/>
                    <div class="clear"></div>
                </div>
                <div class="subType other">
                    <c:set var="formName" value="_17_cboOtherType"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <label for="${formIdPrefix}_${formName}">Other</label>
                    <span class="floatL"><b>:</b></span>
                    <input id="${formIdPrefix}_${formName}" type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="100"/>
                    <div class="clear"></div>
                </div>
            </div>
            <div class="clearFixed"></div>
        </div>
        <div class="clearFixed"></div>
        <div>
            <div class="row requireField">
                <c:set var="formName" value="_17_cboLegalName"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Full Legal Name<span class="required">*</span></label>
                <span class="floatL"><b>:</b></span>
                <span class="floatL inputCnt">
                    <input id="${formIdPrefix}_${formName}" type="text" class="wholeInput fullLengthName" name="${formName}" value="${formValue}" maxlength="100"/><br/>
                    <span class="label">(Taxpayer name of FEIN or on W-9 from IRS)</span>
                </span>

                <c:set var="formName" value="_17_cboFEIN"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}" class="inlineLabel">FEIN<span class="required">*</span></label>
                <span class="floatL"><b>:</b></span>
                <input id="${formIdPrefix}_${formName}" type="text" class="wholeInput smallInput feinMasked" name="${formName}" value="${formValue}" maxlength="7"/>
                <div class="clearFixed"></div>
            </div>
            <div class="row requiredField addressline1">
                <c:set var="formName" value="_17_cboAddressLine1"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Business Address<span class="required">*</span></label>
                <span class="floatL"><b>:</b></span>
                <input id="${formIdPrefix}_${formName}" type="text" title="Business Address, Line 1" class="normalInput addressInputFor" name="${formName}" value="${formValue}" maxlength="28"/>
            </div>

            <div class="row inlineBox addressline2">
                <c:set var="formName" value="_17_cboAddressLine2"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <span class="label">&nbsp;</span>
                <span class="floatL"><b>&nbsp;</b></span>
                <input type="text" title="Business Address, Line 2" class="normalInput addressInputFor" name="${formName}" value="${formValue}" maxlength="28"/>
            </div>

            <div class="row inlineBox">
                <span class="label">&nbsp;</span>
                <span class="floatL"><b>&nbsp;</b></span>
                <c:set var="formName" value="_17_cboCity"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}" class="cityLabel">City : </label>
                <input id="${formIdPrefix}_${formName}" type="text"  class="cityInputFor" name="${formName}" value="${formValue}" maxlength="18"/>

                <c:set var="formName" value="_17_cboState"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">State : </label>
                <select id="${formIdPrefix}_${formName}" class="stateSelectFor" name="${formName}">
                    <option value="">Please select</option>
                    <c:forEach var="opt" items="${requestScope['_99_states']}">
                        <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                    </c:forEach>
                </select>

                <c:set var="formName" value="_17_cboZip"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">ZIP Code : </label>
                <input id="${formIdPrefix}_${formName}" type="text" class="zipInputFor" name="${formName}" value="${formValue}" maxlength="10"/>

                <c:set var="formName" value="_17_cboCounty"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">County : </label>
                <select id="${formIdPrefix}_${formName}" class="countySelectFor" name="${formName}">
                    <option value="">Please select</option>
                    <c:forEach var="opt" items="${requestScope['_99_counties']}">
                        <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="clearFixed"></div>
        <span class="control">
            <c:set var="formName" value="_17_cboOtherInterestInd"></c:set>
            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
            <label class="checkboxLabel">
              <input class="showHidePanel" value="Y" type="checkbox" ${formValue eq 'Y' ? 'checked' : ''} name="${formName}" />
              This person/business has an ownership or control interest in another Medicaid disclosing entity, or an
              entity that does not participate in Medicaid but is required to disclose ownership and control interest
              because of participation in any Title V, XVIII, or XX programs.
            </label>
        </span>
    </div>
    <!-- /.section -->

    <div class="section line hiddenSection" style="display: ${formValue eq 'Y' ? 'block' : 'none'};">
        <div>
            <div class="row requireField">
                <c:set var="formName" value="_17_cboOtherInterestName"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}" class="multiLine">Full Legal Name of Other Provider<span class="required">*</span></label>
                <span class="floatL"><b>:</b></span>
                <span class="floatL inputCnt">
                    <input id="${formIdPrefix}_${formName}" type="text" class="wholeInput fullLengthName" name="${formName}" value="${formValue}" maxlength="100"/><br/>
                    <span class="label">(Taxpayer name of FEIN or on W-9 from IRS)</span>
                </span>

                <c:set var="formName" value="_17_cboOtherInterestPct"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}"class="inlineLabel">% of Ownership Interest<span class="required">*</span></label>
                <span class="floatL"><b>:</b></span>
                <input id="${formIdPrefix}_${formName}" type="text" class="wholeInput smallInput" name="${formName}" value="${formValue}" maxlength="6"/>
                <div class="clearFixed"></div>
            </div>
            <div class="row requireField addressline1">
                <c:set var="formName" value="_17_cboOtherAddressLine1"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Address of Other Provider<span class="required">*</span></label>
                <span class="floatL"><b>:</b></span>
                <input id="${formIdPrefix}_${formName}" type="text" title="Other Provider Address, Line 1" class="normalInput addressInputFor" name="${formName}" value="${formValue}" maxlength="28"/>
                <div class="clearFixed"></div>
            </div>

            <div class="row inlineBox addressline2">
                <c:set var="formName" value="_17_cboOtherAddressLine2"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <span class="label">&nbsp;</span>
                <span class="floatL"><b>&nbsp;</b></span>
                <input type="text" title="Other Provider Address, Line 2" class="normalInput addressInputFor" name="${formName}" value="${formValue}" maxlength="28"/>
            </div>

            <div class="row inlineBox">
                <span class="label">&nbsp;</span>
                <span class="floatL"><b>&nbsp;</b></span>
                <c:set var="formName" value="_17_cboOtherCity"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}" class="cityLabel">City : </label>
                <input id="${formIdPrefix}_${formName}" type="text" class="cityInputFor" name="${formName}" value="${formValue}" maxlength="18"/>

                <c:set var="formName" value="_17_cboOtherCounty"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">County/Indian Reservation:</label>
                <select id="${formIdPrefix}_${formName}" class="countySelectFor" name="${formName}">
                    <option value="">Please select</option>
                    <c:forEach var="opt" items="${requestScope['_99_counties']}">
                        <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                    </c:forEach>
                </select>

                <c:set var="formName" value="_17_cboOtherState"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">State : </label>
                <select id="${formIdPrefix}_${formName}"class="stateSelectFor" name="${formName}">
                    <option value="">Please select</option>
                    <c:forEach var="opt" items="${requestScope['_99_states']}">
                        <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                    </c:forEach>
                </select>

                <c:set var="formName" value="_17_cboOtherZip"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">ZIP Code : </label>
                <input id="${formIdPrefix}_${formName}" type="text" class="zipInputFor" name="${formName}" value="${formValue}" maxlength="10"/>
            </div>
        </div>
        <div class="clearFixed"></div>
    </div>
</div>

<div id="ownerTemplate" class="personOwner">
    <div class="section line">
        <div>
            <div class="row requireField">
                <c:set var="formName" value="_17_iboType"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Type<span class="required">*</span><span><a href="javascript:" class="definition">?</a></span></label>
                <span class="floatL"><b>:</b></span>
                <select id="${formIdPrefix}_${formName}" class="ownershipType" name="${formName}">
                    <option value="">Please select</option>
                    <c:forEach var="opt" items="${beneficialOwnerTypes}">
                       <c:if test="${opt.ownerType ne 'O'}">
                          <option ${formValue eq opt.description ? selectedMarkup : ''} value="${opt.description}"><c:out value="${opt.description}" /></option>
                       </c:if>
                    </c:forEach>
                </select>

                <div class="subType subcontractor">
                    <c:set var="formName" value="_17_iboSubcontractorName"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <label for="${formIdPrefix}_${formName}">Name Subcontractor</label>
                    <span class="floatL"><b>:</b></span>
                    <input id="${formIdPrefix}_${formName}" type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="100"/>
                    <div class="clear"></div>
                </div>
                <div class="subType owner">
                    <c:set var="formName" value="_17_iboPercentOwnership"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <label for="${formIdPrefix}_${formName}">List % of Ownership Interest
                        <span class="label">if 5% or more</span>
                    </label>
                    <span class="floatL"><b>:</b></span>
                    <input id="${formIdPrefix}_${formName}" type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="6"/>
                    <div class="clear"></div>
                </div>
                <div class="subType other">
                    <c:set var="formName" value="_17_iboOtherType"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <label for="${formIdPrefix}_${formName}">Other</label>
                    <span class="floatL"><b>:</b></span>
                    <input id="${formIdPrefix}_${formName}" type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="100"/>
                    <div class="clear"></div>
                </div>
            </div>
            <div class="clearFixed"></div>
        </div>
        <div class="clearFixed"></div>
        <div class="leftCol">
            <div class="row requireField">
                <c:set var="formName" value="_17_iboFirstName"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">First Name<span class="required">*</span></label>
                <span class="floatL"><b>:</b></span>
                <input id="${formIdPrefix}_${formName}" type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="45"/>
            </div>
            <div class="row">
                <c:set var="formName" value="_17_iboMiddleName"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Middle Name</label>
                <span class="floatL"><b>:</b></span>
                <input id="${formIdPrefix}_${formName}" type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="45"/>
            </div>
            <div class="row requireField">
                <c:set var="formName" value="_17_iboLastName"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Last Name<span class="required">*</span></label>
                <span class="floatL"><b>:</b></span>
                <input id="${formIdPrefix}_${formName}" type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="45"/>
            </div>
            <div class="row requireField">
                <c:set var="formName" value="_17_iboSSN"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Social Security Number<span class="required">*</span></label>
                <span class="floatL"><b>:</b></span>
                <input id="${formIdPrefix}_${formName}" type="text" class="ssnMasked normalInput" name="${formName}" value="${formValue}" maxlength="11"/>
            </div>
            <div class="clearFixed"></div>
        </div>
        <div class="rightCol">
            <div class="row requireField">
                <c:set var="formName" value="_17_iboDOB"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Date of Birth<span class="required">*</span>
                    <span class="label">(MM/DD/YYYY)</span>
                </label>
                <span class="floatL"><b>:</b></span>
                <span class="dateWrapper floatL">
                    <input id="${formIdPrefix}_${formName}" class="date" type="text" name="${formName}" value="${formValue}"/>
                </span>
            </div>
            <div class="row requireField">
                <c:set var="formName" value="_17_iboHireDate"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Hire Date<span class="required">*</span>
                    <span class="label">(MM/DD/YYYY)</span>
                </label>
                <span class="floatL"><b>:</b></span>
                <span class="dateWrapper floatL">
                    <input id="${formIdPrefix}_${formName}" class="date" type="text" name="${formName}" value="${formValue}"/>
                </span>
            </div>
            <div class="row requireField">
                <c:set var="formName" value="_17_iboRelationship"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label class="multiLine">Relationship to any other listed person</label>
                <span class="floatL"><b>:</b></span>
                <label class="inline"><input type="radio" ${formValue eq 'Spouse' ? 'checked' : ''} name="${formName}" value="Spouse"/>Spouse</label>
                <label class="inline"><input type="radio" ${formValue eq 'Child' ? 'checked' : ''} name="${formName}" value="Child"/>Child</label>
                <label class="inline"><input type="radio" ${formValue eq 'Parent' ? 'checked' : ''} name="${formName}" value="Parent"/>Parent</label>
                <label class="inline"><input type="radio" ${formValue eq 'Sibling' ? 'checked' : ''} name="${formName}" value="Sibling"/>Sibling</label>
            </div>
            <div class="clearFixed"></div>
        </div>
        <div class="">
            <div class="row requiredField addressline1">
                <c:set var="formName" value="_17_iboAddressLine1"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Home Residence Address<span class="required">*</span></label>
                <span class="floatL"><b>:</b></span>
                <input id="${formIdPrefix}_${formName}" type="text" title="Home Residence Address, Line 1" class="normalInput addressInputFor" name="${formName}" value="${formValue}" maxlength="28"/>
            </div>

            <div class="row inlineBox addressline2">
                <c:set var="formName" value="_17_iboAddressLine2"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <span class="label">(Practice location cannot be a<br />PO Box)</span>
                <span class="floatL"><b>&nbsp;</b></span>
                <input type="text" title="Home Residence Address, Line 2" class="normalInput addressInputFor" name="${formName}" value="${formValue}" maxlength="28"/>
            </div>

            <div class="row inlineBox">
                <span class="label">&nbsp;</span>
                <span class="floatL"><b>&nbsp;</b></span>
                <c:set var="formName" value="_17_iboCity"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}" class="cityLabel">City : </label>
                <input id="${formIdPrefix}_${formName}" type="text"  class="cityInputFor" name="${formName}" value="${formValue}" maxlength="18"/>

                <c:set var="formName" value="_17_iboState"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">State : </label>
                <select id="${formIdPrefix}_${formName}" class="stateSelectFor" name="${formName}">
                    <option value="">Please select</option>
                    <c:forEach var="opt" items="${requestScope['_99_states']}">
                        <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                    </c:forEach>
                </select>

                <c:set var="formName" value="_17_iboZip"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">ZIP Code : </label>
                <input id="${formIdPrefix}_${formName}" type="text" class="zipInputFor" name="${formName}" value="${formValue}" maxlength="10"/>

                <c:set var="formName" value="_17_iboCounty"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">County : </label>
                <select id="${formIdPrefix}_${formName}" class="countySelectFor" name="${formName}">
                    <option value="">Please select</option>
                    <c:forEach var="opt" items="${requestScope['_99_counties']}">
                        <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="clearFixed"></div>
        <span class="control">
            <c:set var="formName" value="_17_iboOtherInterestInd"></c:set>
            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
            <label class="checkboxLabel">
              <input class="showHidePanel" type="checkbox" name="${formName}" />
              This person/business has an ownership or control interest in another Medicaid disclosing entity, or an
              entity that does not participate in Medicaid but is required to disclose ownership and control interest
              because of participation in any Title V, XVIII, or XX programs.
            </label>
        </span>
    </div>
    <!-- /.section -->


    <div class="section line hiddenSection">
        <div>
            <div class="row requireField">
                <c:set var="formName" value="_17_iboOtherInterestName"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}" class="multiLine">Full Legal Name of Other Provider<span class="required">*</span></label>
                <span class="floatL"><b>:</b></span>
                <span class="floatL inputCnt">
                    <input id="${formIdPrefix}_${formName}" type="text" class="wholeInput fullLengthName" name="${formName}" value="${formValue}" maxlength="100"/><br/>
                    <span class="label">(Taxpayer name of FEIN or on W-9 from IRS)</span>
                </span>

                <!-- TODO: Issue #564: Why doesn't this field have a name? -->
                <label class="inlineLabel">% of Ownership Interest<span class="required">*</span></label>
                <span class="floatL"><b>:</b></span>
                <input type="text" class="wholeInput smallInput" maxlength="6"/>
                <div class="clearFixed"></div>
            </div>
            <div class="row requireField addressline1">
                <c:set var="formName" value="_17_iboOtherAddressLine1"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Address of Other Provider<span class="required">*</span></label>
                <span class="floatL"><b>:</b></span>
                <input id="${formIdPrefix}_${formName}" type="text" title="Other Provider Address, Line 1" class="normalInput addressInputFor" name="${formName}" value="${formValue}" maxlength="28"/>
                <div class="clearFixed"></div>
            </div>
            <div class="row inlineBox addressline2">
                <c:set var="formName" value="_17_iboOtherAddressLine2"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <span class="label">&nbsp;</span>
                <span class="floatL"><b>&nbsp;</b></span>
                <input type="text" title="Other Provider Address, Line 2" class="normalInput addressInputFor" name="${formName}" value="${formValue}" maxlength="28"/>
            </div>
            <div class="row inlineBox">
                <span class="label">&nbsp;</span>
                <span class="floatL"><b>&nbsp;</b></span>
                <c:set var="formName" value="_17_iboOtherCity"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}" class="cityLabel">City : </label>
                <input id="${formIdPrefix}_${formName}" type="text" class="cityInputFor" name="${formName}" value="${formValue}" maxlength="18"/>

                <c:set var="formName" value="_17_iboOtherCounty"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">County/Indian Reservation:</label>
                <select id="${formIdPrefix}_${formName}" class="countySelectFor" name="${formName}">
                    <option value="">Please select</option>
                    <c:forEach var="opt" items="${requestScope['_99_counties']}">
                        <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                    </c:forEach>
                </select>

                <c:set var="formName" value="_17_iboOtherState"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">State : </label>
                <select id="${formIdPrefix}_${formName}"class="stateSelectFor" name="${formName}">
                    <option value="">Please select</option>
                    <c:forEach var="opt" items="${requestScope['_99_states']}">
                        <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                    </c:forEach>
                </select>

                <c:set var="formName" value="_17_iboOtherZip"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">ZIP Code : </label>
                <input id="${formIdPrefix}_${formName}" type="text" class="zipInputFor" name="${formName}" value="${formValue}" maxlength="10"/>
            </div>
        </div>
        <div class="clearFixed"></div>
    </div>
</div>

    <c:url var="lookupUrl" value="/provider/enrollment/ownerTypes" />
    <input type="hidden" id="ownerTypeLookupURL" value="${lookupUrl}"/>
</div>
