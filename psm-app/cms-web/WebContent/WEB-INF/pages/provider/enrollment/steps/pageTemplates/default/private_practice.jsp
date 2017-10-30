<%--
    JSP Fragment for provider type selection form.

    @author j3_guile
    @version 1.0
 --%>

<%@page import="gov.medicaid.binders.ProviderTypeFormBinder"%>
<%@page import="gov.medicaid.entities.dto.ViewStatics"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>

<c:if test="${requestScope['_05_bound'] eq 'Y'}">
<!-- /.radioPanel -->
<div class="practicePanel">
    <input type="hidden" name="formNames" value="<%= ViewStatics.PRIVATE_PRACTICE_FORM %>">
    <c:set var="formName" value="_05_objectId"></c:set>
    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
    <input type="hidden" name="${formName}" value="${formValue}"/>

    <c:set var="disableLinkedFields" value=""></c:set>
    <c:set var="isLinked" value="${false}"></c:set>
    <c:if test="${not empty formValue}">
        <c:set var="disableLinkedFields" value='disabled="disabled"'></c:set>
        <c:set var="isLinked" value="${true}"></c:set>
    </c:if>

    <c:set var="disableBillingAddress" value="${isLinked}" />
    <c:set var="billingAddressMarkup" value="${disableLinkedFields}" />
    <c:set var="formName" value="_05_billingSameAsPrimary"></c:set>
    <c:set var="formValue" value="${requestScope[formName]}"></c:set>

    <c:if test="${formValue eq 'Y'}">
        <c:set var="disableBillingAddress" value="${true}" />
        <c:set var="billingAddressMarkup" value='disabled="disabled"'></c:set>
    </c:if>

    <c:set var="formName" value="_05_objectIdHash"></c:set>
    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
    <input type="hidden" name="${formName}" value="${formValue}"/>

    <div id="privatePractice">
        <div class="tableHeader otherTableHeader">
            <span>Private Practice or Primary Office Location Information</span>
            <a href="javascript:openPracticeLookup(true, true);" class="purpleSmallBtn practiceLookupModalBtn"><span class="btR"><span class="btM">Practice Lookup</span></span></a>
        </div>
        <!-- /.tableHeader -->
        <div class="section">
            <div class="wholeCol">
                <div class="row">
                    <label>Private Practice Name<span class="required">*</span></label>
                    <span class="floatL"><b>:</b></span>

                    <c:set var="formName" value="_05_name"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input ${disableLinkedFields} type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="100"/>
                </div>
                <div class="row">
                    <label>Group NPI / UMPI</label>
                    <span class="floatL"><b>:</b></span>

                    <c:set var="formName" value="_05_npi"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input ${disableLinkedFields} type="text" class="npiMasked normalInput" name="${formName}" value="${formValue}" maxlength="10"/>
                    <input id="unlinkPracticeButton" type="button" value="Remove Reference" onclick="unlinkPractice('_05_')" style="display: ${isLinked ? 'inline' : 'none'}"/>
                </div>
                <div class="row">
                    <label>Effective Date<span class="required">*</span></label>
                    <span class="floatL"><b>:</b></span>
                    <span class="dateWrapper">
                        <c:set var="formName" value="_05_effectiveDate"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input class="date" type="text" name="${formName}" value="${formValue}"/>
                    </span>
                </div>
                <div class="row addressline1">
                    <label>Practice Address<span class="required">*</span></label>
                    <span class="floatL"><b>:</b></span>

                    <c:set var="formName" value="_05_addressLine1"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input ${disableLinkedFields} type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="28"/>
                </div>
                <div class="row inlineBox addressline2">
                    <span class="label">(Practice location cannot be<br />a PO Box)</span>
                    <span class="floatL"><b>&nbsp;</b></span>
                    <c:set var="formName" value="_05_addressLine2"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input ${disableLinkedFields} type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="28"/>
                </div>
                <div class="row inlineBox">
                    <span class="label">&nbsp;</span>
                    <span class="floatL"><b>&nbsp;</b></span>
                    <label class="cityLabel">City<span class="required">*</span> : </label>

                    <c:set var="formName" value="_05_city"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input ${disableLinkedFields} type="text"  class="cityInputFor" name="${formName}" value="${formValue}" maxlength="18"/>
                    <label>State<span class="required">*</span> : </label>
                    <c:set var="formName" value="_05_state"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <select ${disableLinkedFields} class="stateSelectFor" name="${formName}">
                        <option value="">Please select</option>
                        <c:forEach var="opt" items="${requestScope['_99_states']}">
                            <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                        </c:forEach>
                    </select>
                    <label>ZIP Code<span class="required">*</span> : </label>
                    <c:set var="formName" value="_05_zip"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input ${disableLinkedFields} type="text" class="zipInputFor" name="${formName}" value="${formValue}" maxlength="10"/>
                    <label>County : </label>
                    <c:set var="formName" value="_05_county"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <select ${disableLinkedFields} class="countySelectFor" name="${formName}">
                        <option value="">Please select</option>
                        <c:forEach var="opt" items="${requestScope['_99_counties']}">
                            <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                        </c:forEach>
                    </select>
                </div>
                <div class="row">
                    <label>Practice Phone Number<span class="required">*</span></label>
                    <span class="floatL"><b>:</b></span>
                    <c:set var="formName" value="_05_phone1"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input ${disableLinkedFields} type="text" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                    <span class="sep">-</span>
                    <c:set var="formName" value="_05_phone2"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input ${disableLinkedFields} type="text" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                    <span class="sep">-</span>
                    <c:set var="formName" value="_05_phone3"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input ${disableLinkedFields} type="text" class="autotab smallInputP" name="${formName}" value="${formValue}" maxlength="4"/>
                    <span class="sep"><strong>ext.</strong></span>
                    <c:set var="formName" value="_05_phone4"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input ${disableLinkedFields} type="text" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                </div>
                <div class="row">
                    <label>Practice Fax Number</label>
                    <span class="floatL"><b>:</b></span>
                    <c:set var="formName" value="_05_fax1"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input ${disableLinkedFields} type="text" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                    <span class="sep">-</span>
                    <c:set var="formName" value="_05_fax2"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input ${disableLinkedFields} type="text" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                    <span class="sep">-</span>
                    <c:set var="formName" value="_05_fax3"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input ${disableLinkedFields} type="text" class="autotab smallInputP" name="${formName}" value="${formValue}" maxlength="4"/>
                </div>
                <div class="row reimbursementAddressRow">
                    <label>Billing Address<span class="required">*</span></label>
                    <span class="floatL"><b>:</b></span>
                    <div class="inputContainer">
                        <div class="checkboxWrapper">
                            <c:set var="formName" value="_05_billingSameAsPrimary"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <input ${disableLinkedFields} type="checkbox" class="checkbox" name="${formName}" ${formValue eq 'Y' ? 'checked' : ''}/>Same as Above
                        </div>

                        <div class="row addressline1">
                            <c:set var="formName" value="_05_billingAddressLine1"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <input ${billingAddressMarkup} type="text" class="${disableBillingAddress ? 'disabled' : '' } addressInput normalInput" name="${formName}" value="${formValue}" maxlength="28"/>
                        </div>

                        <div class="row addressline2">
                            <c:set var="formName" value="_05_billingAddressLine2"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <input ${billingAddressMarkup} type="text" class="${disableBillingAddress ? 'disabled' : '' } addressInput normalInput" name="${formName}" value="${formValue}" maxlength="28"/>
                        </div>

                        <div class="addreddWrapper">
                            <label class="smallLabel">City<span class="required">*</span> : </label>
                            <c:set var="formName" value="_05_billingCity"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <input ${billingAddressMarkup} type="text" class="${disableBillingAddress ? 'disabled' : '' } cityInput" name="${formName}" value="${formValue}" maxlength="20"/>
                            <c:set var="formName" value="_05_billingState"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <label class="smallLabel">State<span class="required">*</span> : </label>
                            <select ${billingAddressMarkup} class="${disableBillingAddress ? 'disabled' : '' } stateSelect" name="${formName}">
                                <option value="">Please select</option>
                                <c:forEach var="opt" items="${requestScope['_99_states']}">
                                    <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                                </c:forEach>
                            </select>
                            <c:set var="formName" value="_05_billingZip"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <label class="smallLabel">ZIP Code<span class="required">*</span> : </label>
                            <input ${billingAddressMarkup} type="text" class="${disableBillingAddress ? 'disabled' : '' } zipInputFor" id="privateReimbursementZip" name="${formName}" value="${formValue}" maxlength="10"/>
                            <c:set var="formName" value="_05_billingCounty"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <label class="smallLabel">County : </label>
                            <select ${billingAddressMarkup} class="${disableBillingAddress ? 'disabled' : '' } stateSelect" name="${formName}">
                                        <option value="">Please select</option>
                                        <c:forEach var="opt" items="${requestScope['_99_counties']}">
                                            <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                                        </c:forEach>
                                    </select>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <label>FEIN</label>
                    <span class="floatL"><b>:</b></span>
                    <c:set var="formName" value="_05_fein"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input ${disableLinkedFields} type="text" class="normalInput feinMasked" name="${formName}" value="${formValue}" maxlength="10"/>
                </div>
                <div class="row">
                    <label>State Tax ID</label>
                    <span class="floatL"><b>:</b></span>
                    <c:set var="formName" value="_05_stateTaxId"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input ${disableLinkedFields} type="text" class="normalInput taxIdMasked" name="${formName}" value="${formValue}" maxlength="7"/>
                </div>
                <div class="row">
                    <label>Fiscal Year End<span class="required">*</span></label>
                    <span class="floatL"><b>:</b></span>
                    <c:set var="formName" value="_05_fye1"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input ${disableLinkedFields} type="text" class="fiscalMonthInput smallInput" name="${formName}" value="${formValue}" maxlength="2"/>
                    <span class="floatL">/</span>
                    <c:set var="formName" value="_05_fye2"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input ${disableLinkedFields} type="text" class="fiscalYearInput smallInput" name="${formName}" value="${formValue}" maxlength="2"/>
                    <span class="shrtFldInfo">MM/DD</span>
                </div>
                <div class="row">
                    <label>EFT Vendor Number</label>
                    <span class="floatL"><b>:</b></span>
                    <c:set var="formName" value="_05_eftVendorNo"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input ${disableLinkedFields} type="text" class="normalInput eftMasked" name="${formName}" value="${formValue}" maxlength="14"/>
                </div>
                <div class="row">
                    <label>Remittance Sequence<span class="required">*</span></label>
                    <span class="floatL"><b>:</b></span>
                    <c:set var="formName" value="_05_remittanceSequence"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <div class="rowWrapper">
                        <div class="row">
                            <input ${disableLinkedFields} type="radio" value="PATIENT_ACCOUNT_OR_OWN_REFERENCE_ORDER" name="${formName}" ${formValue eq 'PATIENT_ACCOUNT_OR_OWN_REFERENCE_ORDER' ? 'checked' : ''}/>
                            <span>Patient Account or Own Reference Number Order</span>
                        </div>
                        <div class="row">
                            <input ${disableLinkedFields} type="radio" value="DHS_TRANSACTION_CONTROL_ORDER" name="${formName}"  ${formValue eq 'DHS_TRANSACTION_CONTROL_ORDER' ? 'checked' : ''}/>
                            <span>DHS Transaction Control Number Order</span>
                        </div>
                        <div class="row">
                            <input ${disableLinkedFields} type="radio" value="RECIPIENT_MHCP_ID_NUMBER_ORDER" name="${formName}"  ${formValue eq 'RECIPIENT_MHCP_ID_NUMBER_ORDER' ? 'checked' : ''}/>
                            <span>Recipient MHCP ID Number Order</span>
                        </div>
                    </div>
                </div>
                <div class="clearFixed"></div>
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
