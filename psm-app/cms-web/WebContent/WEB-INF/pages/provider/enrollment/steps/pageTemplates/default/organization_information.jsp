<%--
    JSP Fragment for provider type selection form.

    @author j3_guile
    @version 1.0
 --%>

<%@page import="gov.medicaid.entities.dto.ViewStatics"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>

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

<div class="newEnrollmentPanel practicePanel">
    <div class="section">
    <input type="hidden" name="formNames" value="<%= ViewStatics.ORG_INFO_FORM %>">
        <div class="wholeCol organizationInfo">
          <c:choose>
              <c:when test="${useNursingFacilityLayout}">
                    <div class="row requireField">
                        <label>Name of Facility<span class="required">*</span></label>
                        <span class="floatL"><b>:</b></span>
                        <c:set var="formName" value="_15_name"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="100"/>
                    </div>
                    
                    <div class="row requireField">
                        <label>NPI<span class="required">*</span></label>
                        <span class="floatL"><b>:</b></span>

                        <c:set var="formName" value="_15_npi"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="npiMasked normalInput" name="${formName}" value="${formValue}" maxlength="10"/>
                    </div>

                    <div class="row addressline1">
                        <label>Street Address<span class="required">*</span></label>
                        <span class="floatL"><b>:</b></span>
                        <c:set var="formName" value="_15_addressLine1"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="normalInput addressInputFor" name="${formName}" value="${formValue}" maxlength="28"/>
                    </div>
                    <div class="row inlineBox addressline2">
                        <span class="label">(Practice location cannot be a<br />PO Box)</span>
                        <span class="floatL"><b>&nbsp;</b></span>
                        <c:set var="formName" value="_15_addressLine2"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="normalInput addressInputFor" name="${formName}" value="${formValue}" maxlength="28"/>
                    </div>
                    
                    <div class="row inlineBox">
                        <span class="label">&nbsp;</span>
                        <span class="floatL"><b>&nbsp;</b></span>
                        <label class="cityLabel">City<span class="required">*</span> : </label>
        
                        <c:set var="formName" value="_15_city"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text"  class="cityInputFor" name="${formName}" value="${formValue}" maxlength="18"/>
                        <label>State<span class="required">*</span> : </label>
                        <c:set var="formName" value="_15_state"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <select class="stateSelectFor" name="${formName}">
                            <option value="">Please select</option>
                            <c:forEach var="opt" items="${requestScope['_99_states']}">
                                <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                            </c:forEach>
                        </select>
                        <label>ZIP Code<span class="required">*</span> : </label>
                        <c:set var="formName" value="_15_zip"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="zipInputFor" name="${formName}" value="${formValue}" maxlength="10"/>
                        <label>County<span class="required">*</span> : </label>
                        <c:set var="formName" value="_15_orgCountyName"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <select class="countySelectFor" name="${formName}">
                                <option value="">Please select</option>
                                <c:forEach var="opt" items="${requestScope['_99_counties']}">
                                    <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                                </c:forEach>
                            </select>
                        
                    </div>
                    
                    <div class="row requireField">
                        <label>Federal Employer ID<span class="required">*</span></label>
                        <span class="floatL"><b>:</b></span>
                        
                        <c:set var="formName" value="_15_fein"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="normalInput feinMasked" id="fein" name="${formName}" value="${formValue}" maxlength="10"/>
                    </div>

                    <div class="row requireField">
                        <label>TaxPayer Name<span class="required">*</span></label>
                        <span class="floatL"><b>:</b></span>
                        
                        <c:set var="formName" value="_15_legalName"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="normalInput" id="legalName" name="${formName}" value="${formValue}" maxlength="100"/>
                    </div>
                    
                    <div class="row">
                        <label>MN Tax ID</label>
                        <span class="floatL"><b>:</b></span>
                        
                        <c:set var="formName" value="_15_stateTaxId"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="normalInput taxIdMasked" id="stateTaxId" name="${formName}" value="${formValue}" maxlength="10"/>
                    </div>

                    <div class="row requiredField">
                        <label>Fiscal Year End<span class="required">*</span></label>
                        <span class="floatL"><b>:</b></span>
                        <c:set var="formName" value="_15_fye1"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="fiscalMonthInput smallInput" name="${formName}" value="${formValue}" maxlength="2"/>
                        <span class="sep">/</span>
                        <c:set var="formName" value="_15_fye2"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="fiscalYearInput smallInput" name="${formName}" value="${formValue}" maxlength="2"/>
                        <span class="shrtFldInfo">MM/DD</span>
                    </div>
                    
                    <div class="row">
                        <label>Office Phone Number<span class="required">*</span></label>
                        <span class="floatL"><b>:</b></span>
                        <c:set var="formName" value="_15_phone1"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                        <span class="sep">-</span>
                        <c:set var="formName" value="_15_phone2"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                        <span class="sep">-</span>
                        <c:set var="formName" value="_15_phone3"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="autotab smallInputP" name="${formName}" value="${formValue}" maxlength="4"/>
                        <span class="sep"><strong>ext.</strong></span>
                        <c:set var="formName" value="_15_phone4"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                    </div>
                    
                    <div class="row">
                        <label>Office Fax Number</label>
                        <span class="floatL"><b>:</b></span>
                        <c:set var="formName" value="_15_fax1"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                        <span class="sep">-</span>
                        <c:set var="formName" value="_15_fax2"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                        <span class="sep">-</span>
                        <c:set var="formName" value="_15_fax3"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="autotab smallInputP" name="${formName}" value="${formValue}" maxlength="4"/>
                    </div>
              </c:when>
              <c:when test="${useEducationPlanLayout}">
                    <div class="row requireField">
                        <label>Complete Provider Name<span class="required">*</span></label>
                        <span class="floatL"><b>:</b></span>
                        <c:set var="formName" value="_15_name"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="normalInput" id="legalName" name="${formName}" value="${formValue}" maxlength="100"/>
                        <span class="fldInfo">(number of the independent school district or complete name of regional cooperative or charter school)</span>
                    </div>
                    
                    <div class="row requireField">
                        <label>NPI<span class="required">*</span></label>
                        <span class="floatL"><b>:</b></span>

                        <c:set var="formName" value="_15_npi"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="npiMasked normalInput" name="${formName}" value="${formValue}" maxlength="10"/>
                    </div>

                    <div class="row addressline1">
                        <label>Actual Street Address<span class="required">*</span></label>
                        <span class="floatL"><b>:</b></span>
                        <c:set var="formName" value="_15_addressLine1"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="normalInput addressInputFor" name="${formName}" value="${formValue}" maxlength="28"/>
                    </div>
                    <div class="row inlineBox addressline2">
                        <span class="label">(Practice location cannot be a<br />PO Box)</span>
                        <span class="floatL"><b>&nbsp;</b></span>
                        <c:set var="formName" value="_15_addressLine2"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="normalInput addressInputFor" name="${formName}" value="${formValue}" maxlength="28"/>
                    </div>
                    
                    <div class="row inlineBox">
                        <span class="label">&nbsp;</span>
                        <span class="floatL"><b>&nbsp;</b></span>
                        <label class="cityLabel">City<span class="required">*</span> : </label>
        
                        <c:set var="formName" value="_15_city"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text"  class="cityInputFor" name="${formName}" value="${formValue}" maxlength="18"/>
                        <label>State<span class="required">*</span> : </label>
                        <c:set var="formName" value="_15_state"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <select class="stateSelectFor" name="${formName}">
                            <option value="">Please select</option>
                            <c:forEach var="opt" items="${requestScope['_99_states']}">
                                <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                            </c:forEach>
                        </select>
                        <label>ZIP<span class="required">*</span> Code : </label>
                        <c:set var="formName" value="_15_zip"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="zipInputFor" name="${formName}" value="${formValue}" maxlength="10"/>
                    </div>
                    
                    <div class="row requireField">
                        <label>County<span class="required">*</span></label>
                        <span class="floatL"><b>:</b></span>
            
                        <c:set var="formName" value="_15_orgCountyName"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <select class="countySelectFor" name="${formName}">
                            <option value="">Please select</option>
                            <c:forEach var="opt" items="${requestScope['_99_counties']}">
                                <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                            </c:forEach>
                        </select>
                        <span class="fldInfo">(name of the county where the ISD, regional cooperative or charter school is located)</span>
                    </div>

                    <div class="row requireField">
                        <label>Federal Employer ID<span class="required">*</span></label>
                        <span class="floatL"><b>:</b></span>
                        
                        <c:set var="formName" value="_15_fein"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="normalInput feinMasked" id="fein" name="${formName}" value="${formValue}" maxlength="10"/>
                    </div>

                    <div class="row requireField">
                        <label>Legal Name According to the IRS<span class="required">*</span></label>
                        <span class="floatL"><b>:</b></span>
                        
                        <c:set var="formName" value="_15_legalName"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="normalInput" id="legalName" name="${formName}" value="${formValue}" maxlength="100"/>
                    </div>
                    
                    <div class="row">
                        <label>MN Tax ID</label>
                        <span class="floatL"><b>:</b></span>
                        
                        <c:set var="formName" value="_15_stateTaxId"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="normalInput taxIdMasked" id="stateTaxId" name="${formName}" value="${formValue}" maxlength="10"/>
                    </div>

                    <div class="row requiredField">
                        <label>Fiscal Year End<span class="required">*</span></label>
                        <span class="floatL"><b>:</b></span>
                        <c:set var="formName" value="_15_fye1"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="fiscalMonthInput smallInput" name="${formName}" value="${formValue}" maxlength="2"/>
                        <span class="sep">/</span>
                        <c:set var="formName" value="_15_fye2"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="fiscalYearInput smallInput" name="${formName}" value="${formValue}" maxlength="2"/>
                        <span class="shrtFldInfo">MM/DD</span>
                    </div>
                    
                    <div class="row">
                        <label>Office Phone Number<span class="required">*</span></label>
                        <span class="floatL"><b>:</b></span>
                        <c:set var="formName" value="_15_phone1"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                        <span class="sep">-</span>
                        <c:set var="formName" value="_15_phone2"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                        <span class="sep">-</span>
                        <c:set var="formName" value="_15_phone3"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="autotab smallInputP" name="${formName}" value="${formValue}" maxlength="4"/>
                        <span class="sep"><strong>ext.</strong></span>
                        <c:set var="formName" value="_15_phone4"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                    </div>
                    
                    <div class="row">
                        <label>Office Fax Number</label>
                        <span class="floatL"><b>:</b></span>
                        <c:set var="formName" value="_15_fax1"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                        <span class="sep">-</span>
                        <c:set var="formName" value="_15_fax2"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                        <span class="sep">-</span>
                        <c:set var="formName" value="_15_fax3"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="autotab smallInputP" name="${formName}" value="${formValue}" maxlength="4"/>
                    </div>
                    
                    <div class="row requireField">
                        <label>Requested Enrollment Date<span class="required">*</span></label>
                        <span class="floatL"><b>:</b></span>
                        <span class="dateWrapper floatL">

                            <c:set var="formName" value="_15_effectiveDate"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <input class="date" type="text" name="${formName}" value="${formValue}"/>
                        </span>
                    </div>
                    
              </c:when>
              <c:when test="${useEDILayout}">
                      <c:if test="${showInitialChoices}">
                    <div class="row requireField">
                        <label>Please Select<span class="required">*</span></label>
                        <span class="floatL"><b>:</b></span>
                        <c:set var="formName" value="_15_subType"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <span class="inline"><input type="radio" ${formValue eq 'Billing Agent' ? 'checked' : ''} value="Billing Agent" name="${formName}"/>Billing Agent</span>
                        <span class="inline"><input type="radio" ${formValue eq 'Eligibility Verification Vendor' ? 'checked' : ''} value="Eligibility Verification Vendor" name="${formName}"/>Eligibility Verification Vendor</span>
                        <span class="inline"><input type="radio" ${formValue eq 'Consolidated Billing Agent' ? 'checked' : ''} value="Consolidated Billing Agent" name="${formName}"/>Consolidated Billing Agent</span>
                        <span class="inline"><input type="radio" ${formValue eq 'Health Care Data Trading Partner' ? 'checked' : ''} value="Health Care Data Trading Partner" name="${formName}"/>Health Care Data Trading Partner</span>
                    </div>
                    <div class="row requireField">
                        <label>&nbsp;</label>
                        <span class="floatL"><b>&nbsp;</b></span>
                        <span class="inline"><input type="radio" ${formValue eq 'Medicare Carrier' ? 'checked' : ''} value="Medicare Carrier" name="${formName}"/>Medicare Carrier</span>
                        <span class="inline"><input type="radio" ${formValue eq 'Mental Health Information System Grantee' ? 'checked' : ''} value="Mental Health Information System Grantee" name="${formName}"/>Mental Health Information System Grantee</span>
                        <span class="inline"><input type="radio" ${formValue eq 'MN Health Insurance Exchange Carrier' ? 'checked' : ''} value="MN Health Insurance Exchange Carrier" name="${formName}"/>MN Health Insurance Exchange Carrier</span>
                    </div>
                    </c:if>
                    <div class="row requireField">
                        <label>Organization Name<span class="required">*</span></label>
                        <span class="floatL"><b>:</b></span>

                        <c:set var="formName" value="_15_name"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="normalInput" id="legalName" name="${formName}" value="${formValue}" maxlength="100"/>
                    </div>
                    <div class="row requireField">
                        <label>Effective Date<span class="required">*</span></label>
                        <span class="floatL"><b>:</b></span>
                        <span class="dateWrapper floatL">

                            <c:set var="formName" value="_15_effectiveDate"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <input class="date" type="text" name="${formName}" value="${formValue}"/>
                        </span>
                    </div>

                    <div class="row requireField">
                        <label>Federal Employer ID<span class="required">*</span></label>
                        <span class="floatL"><b>:</b></span>

                        <c:set var="formName" value="_15_fein"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="normalInput feinMasked" id="fein" name="${formName}" value="${formValue}" maxlength="10"/>
                    </div>

                    <div class="row">
                        <label>MN Tax ID</label>
                        <span class="floatL"><b>:</b></span>

                        <c:set var="formName" value="_15_stateTaxId"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="normalInput taxIdMasked" id="stateTaxId" name="${formName}" value="${formValue}" maxlength="10"/>
                    </div>

                    <div class="row requireField">
                        <label>Legal Name<span class="required">*</span></label>
                        <span class="floatL"><b>:</b></span>

                        <c:set var="formName" value="_15_legalName"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="normalInput" id="legalName" name="${formName}" value="${formValue}" maxlength="100"/>
                    </div>
                
                    <div class="row addressline1">
                        <label>Address<span class="required">*</span></label>
                        <span class="floatL"><b>:</b></span>
                        <c:set var="formName" value="_15_addressLine1"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="normalInput addressInputFor" name="${formName}" value="${formValue}" maxlength="28"/>
                    </div>
                    <div class="row inlineBox addressline2">
                        <span class="label">(Practice location cannot be a<br />PO Box)</span>
                        <span class="floatL"><b>&nbsp;</b></span>
                        <c:set var="formName" value="_15_addressLine2"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="normalInput addressInputFor" name="${formName}" value="${formValue}" maxlength="28"/>
                    </div>
                    
                    <div class="row inlineBox">
                        <span class="label">&nbsp;</span>
                        <span class="floatL"><b>&nbsp;</b></span>
                        <label class="cityLabel">City<span class="required">*</span> : </label>

                        <c:set var="formName" value="_15_city"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text"  class="cityInputFor" name="${formName}" value="${formValue}" maxlength="18"/>
                        <label>State<span class="required">*</span> : </label>
                        <c:set var="formName" value="_15_state"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <select class="stateSelectFor" name="${formName}">
                            <option value="">Please select</option>
                            <c:forEach var="opt" items="${requestScope['_99_states']}">
                                <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                            </c:forEach>
                        </select>
                        <label>ZIP Code<span class="required">*</span> : </label>
                        <c:set var="formName" value="_15_zip"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="zipInputFor" name="${formName}" value="${formValue}" maxlength="10"/>
                        <label>County : </label>
                        <c:set var="formName" value="_15_county"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <select class="countySelectFor" name="${formName}">
                            <option value="">Please select</option>
                            <c:forEach var="opt" items="${requestScope['_99_counties']}">
                                <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <div class="row">
                        <label>Phone Number<span class="required">*</span></label>
                        <span class="floatL"><b>:</b></span>
                        <c:set var="formName" value="_15_phone1"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                        <span class="sep">-</span>
                        <c:set var="formName" value="_15_phone2"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                        <span class="sep">-</span>
                        <c:set var="formName" value="_15_phone3"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="autotab smallInputP" name="${formName}" value="${formValue}" maxlength="4"/>
                        <span class="sep"><strong>ext.</strong></span>
                        <c:set var="formName" value="_15_phone4"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                    </div>

                    <div class="row">
                        <label>Fax Number<span class="required">*</span></label>
                        <span class="floatL"><b>:</b></span>
                        <c:set var="formName" value="_15_fax1"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                        <span class="sep">-</span>
                        <c:set var="formName" value="_15_fax2"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                        <span class="sep">-</span>
                        <c:set var="formName" value="_15_fax3"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="autotab smallInputP" name="${formName}" value="${formValue}" maxlength="4"/>
                    </div>
                
                    <div class="row">
                        <label>UMPI</label>
                        <span class="floatL"><b>:</b></span>
            
                        <c:set var="formName" value="_15_npi"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="umpiMasked normalInput" name="${formName}" value="${formValue}" maxlength="10"/>
                    </div>
                    <c:if test="${showNameOfPersonFillingTheForm}">
                        <div class="row">
                            <label>Name of person completing this form</label>
                            <span class="floatL"><b>:</b></span>

                            <c:set var="formName" value="_15_personCompletingForm"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <input type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="100"/>
                        </div>
                    </c:if>
              </c:when>
              <c:otherwise>
                <div class="row requireField">
                    <c:choose>
                        <c:when test="${askUMPI}">
                            <label>UMPI</label>
                            <span class="floatL"><b>:</b></span>

                            <c:set var="formName" value="_15_npi"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <input type="text" class="umpiMasked normalInput" name="${formName}" value="${formValue}" maxlength="10"/>
                        </c:when>
                        <c:when test="${askUMPIorNPI}">
                            <label>NPI / UMPI</label>
                            <span class="floatL"><b>:</b></span>

                            <c:set var="formName" value="_15_npi"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <input type="text" class="umpiMasked normalInput" name="${formName}" value="${formValue}" maxlength="10"/>
                        </c:when>
                        <c:otherwise>
                            <label>NPI <c:if test="${requireNPI}"><span class="required">*</span></c:if></label>
                            <span class="floatL"><b>:</b></span>

                            <c:set var="formName" value="_15_npi"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <input type="text" class="npiMasked normalInput" name="${formName}" value="${formValue}" maxlength="10"/>
                        </c:otherwise>
                    </c:choose>
                </div>
                <c:if test="${askEffectiveDate}">
                <div class="row requireField">
                    <label>Effective Date<span class="required">*</span></label>
                    <span class="floatL"><b>:</b></span>
                    <span class="dateWrapper floatL">

                        <c:set var="formName" value="_15_effectiveDate"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input class="date" type="text" name="${formName}" value="${formValue}"/>
                    </span>
                </div>
                </c:if>

                <c:if test="${askTaxPayerName}">
                <div class="row requireField">
                    <label>Provide Taxpayer Name<span class="required">*</span></label>
                    <span class="floatL"><b>:</b></span>

                    <c:set var="formName" value="_15_legalName"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input type="text" class="normalInput" id="legalName" name="${formName}" value="${formValue}" maxlength="100"/>
                </div>
                </c:if>

                <div class="row requireField">
                    <label>${askDBAName ? 'DBA Name' : 'Doing Business As'}<span class="required">*</span></label>
                    <span class="floatL"><b>:</b></span>

                    <c:set var="formName" value="_15_name"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input type="text" class="normalInput" id="name" name="${formName}" value="${formValue}" maxlength="100"/>
                </div>

                <c:if test="${not askTaxPayerName}">
                <div class="row requireField">
                    <label>Legal Name<span class="required">*</span></label>
                    <span class="floatL"><b>:</b></span>

                    <c:set var="formName" value="_15_legalName"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input type="text" class="normalInput" id="legalName" name="${formName}" value="${formValue}" maxlength="100"/>
                </div>
                </c:if>

                    <div class="row addressline1">
                        <label>Practice Address<span class="required">*</span></label>
                        <span class="floatL"><b>:</b></span>
                        <c:set var="formName" value="_15_addressLine1"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="normalInput addressInputFor" name="${formName}" value="${formValue}" maxlength="28"/>
                    </div>
                    <div class="row inlineBox addressline2">
                        <span class="label">(Practice location cannot be a<br />PO Box)</span>
                        <span class="floatL"><b>&nbsp;</b></span>
                        <c:set var="formName" value="_15_addressLine2"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" class="normalInput addressInputFor" name="${formName}" value="${formValue}" maxlength="28"/>
                    </div>
                    
                    <div class="row inlineBox">
                        <span class="label">&nbsp;</span>
                        <span class="floatL"><b>&nbsp;</b></span>
                        <label class="cityLabel">City<span class="required">*</span> : </label>

                    <c:set var="formName" value="_15_city"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input type="text"  class="cityInputFor" name="${formName}" value="${formValue}" maxlength="18"/>
                    <label>State<span class="required">*</span> : </label>
                    <c:set var="formName" value="_15_state"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <select class="stateSelectFor" name="${formName}">
                        <option value="">Please select</option>
                        <c:forEach var="opt" items="${requestScope['_99_states']}">
                            <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                        </c:forEach>
                    </select>
                    <label>ZIP Code<span class="required">*</span> : </label>
                    <c:set var="formName" value="_15_zip"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input type="text" class="zipInputFor" name="${formName}" value="${formValue}" maxlength="10"/>
                    <label>County : </label>
                    <c:set var="formName" value="_15_county"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <select class="countySelectFor" name="${formName}">
                            <option value="">Please select</option>
                            <c:forEach var="opt" items="${requestScope['_99_counties']}">
                                <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                            </c:forEach>
                        </select>
                </div>

                <div class="row">
                    <label>Office Phone Number<span class="required">*</span></label>
                    <span class="floatL"><b>:</b></span>
                    <c:set var="formName" value="_15_phone1"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input type="text" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                    <span class="sep">-</span>
                    <c:set var="formName" value="_15_phone2"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input type="text" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                    <span class="sep">-</span>
                    <c:set var="formName" value="_15_phone3"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input type="text" class="autotab smallInputP" name="${formName}" value="${formValue}" maxlength="4"/>
                    <span class="sep"><strong>ext.</strong></span>
                    <c:set var="formName" value="_15_phone4"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input type="text" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                </div>

                <div class="row">
                    <label>Office Fax Number</label>
                    <span class="floatL"><b>:</b></span>
                    <c:set var="formName" value="_15_fax1"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input type="text" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                    <span class="sep">-</span>
                    <c:set var="formName" value="_15_fax2"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input type="text" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                    <span class="sep">-</span>
                    <c:set var="formName" value="_15_fax3"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input type="text" class="autotab smallInputP" name="${formName}" value="${formValue}" maxlength="4"/>
                </div>

                <div class="row requireField">
                    <label>Federal Employer ID<span class="required">*</span></label>
                    <span class="floatL"><b>:</b></span>

                    <c:set var="formName" value="_15_fein"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input type="text" class="normalInput feinMasked" id="fein" name="${formName}" value="${formValue}" maxlength="10"/>
                </div>

                <div class="row">
                    <label>MN Tax ID</label>
                    <span class="floatL"><b>:</b></span>

                    <c:set var="formName" value="_15_stateTaxId"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input type="text" class="normalInput taxIdMasked" id="stateTaxId" name="${formName}" value="${formValue}" maxlength="10"/>
                </div>

                <c:if test="${askFiscalYear}">
                <div class="row">
                    <label>Fiscal Year End</label>
                    <span class="floatL"><b>:</b></span>
                    <c:set var="formName" value="_15_fye1"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input type="text" class="fiscalMonthInput smallInput" name="${formName}" value="${formValue}" maxlength="2"/>
                    <span class="sep">/</span>
                    <c:set var="formName" value="_15_fye2"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input type="text" class="fiscalYearInput smallInput" name="${formName}" value="${formValue}" maxlength="2"/>
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
        <table cellpadding="0" cellspacing="0" class="generalTable alternateTable" id="tablePractice">
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
                <th>ATTN<span class="required">*</span><span class="sep"></span></th>
                <th>Address<span class="required">*</span><span class="sep"></span></th>
                <th>City<span class="required">*</span><span class="sep"></span></th>
                <th>State<span class="required">*</span><span class="sep"></span></th>
                <th>ZIP Code<span class="required">*</span><span class="sep"></span></th>
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
                        <input type="checkbox" class="checkbox" name="${formName}" ${formValue eq 'Y' ? 'checked' : ''}/>same as Above
                        <c:if test="${formValue eq 'Y'}">
                            <c:set var="disableLinkedFields" value='disabled="disabled"'></c:set>
                            <c:set var="linkedFieldClass" value="disabled"></c:set>
                        </c:if>
                    </td>
                    <td>
                        <c:set var="formName" value="_15_billingAttention"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input ${disableLinkedFields} type="text" class="longInput ${linkedFieldClass}" name="${formName}" value="${formValue}" maxlength="30"/>
                    </td>
                    <td>
                        <c:set var="formName" value="_15_billingAddressLine1"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input ${disableLinkedFields} type="text" class="addressLine1 longInput ${linkedFieldClass}" name="${formName}" value="${formValue}" maxlength="28"/>
                    </td>
                    <td>
                        <c:set var="formName" value="_15_billingCity"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input ${disableLinkedFields} type="text" class="smallInput ${linkedFieldClass}" name="${formName}" value="${formValue}" maxlength="18"/>
                    </td>
                    <td>
                        <c:set var="formName" value="_15_billingState"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <select ${disableLinkedFields} name="${formName}" class="${linkedFieldClass}">
                            <option value="">Please select</option>
                            <c:forEach var="opt" items="${requestScope['_99_states']}">
                                <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                            </c:forEach>
                        </select>
                    </td>
                    <td>
                        <c:set var="formName" value="_15_billingZip"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input ${disableLinkedFields} type="text" class="zipInputFor smallInput ${linkedFieldClass}" name="${formName}" value="${formValue}" maxlength="10"/>
                    </td>
                    <td>
                        <c:set var="formName" value="_15_billingCounty"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <select ${disableLinkedFields} name="${formName}" class="${linkedFieldClass}">
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
                        <input type="checkbox" class="checkbox" name="${formName}" ${formValue eq 'Y' ? 'checked' : ''}/>same as Above
                        <c:if test="${formValue eq 'Y'}">
                            <c:set var="disableLinkedFields" value='disabled="disabled"'></c:set>
                            <c:set var="linkedFieldClass" value="disabled"></c:set>
                        </c:if>
                    </td>
                    <td>
                        <c:set var="formName" value="_15_ten99Attention"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input ${disableLinkedFields} type="text" class="longInput ${linkedFieldClass}" name="${formName}" value="${formValue}" maxlength="30"/>
                    </td>
                    <td>
                        <c:set var="formName" value="_15_ten99AddressLine1"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input ${disableLinkedFields} type="text" class="addressline1 longInput ${linkedFieldClass}" name="${formName}" value="${formValue}" maxlength="28"/>
                    </td>
                    <td>
                        <c:set var="formName" value="_15_ten99City"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input ${disableLinkedFields} type="text" class="smallInput ${linkedFieldClass}" name="${formName}" value="${formValue}" maxlength="18"/>
                    </td>
                    <td>
                        <c:set var="formName" value="_15_ten99State"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <select ${disableLinkedFields} name="${formName}" class="${linkedFieldClass}">
                            <option value="">Please select</option>
                            <c:forEach var="opt" items="${requestScope['_99_states']}">
                                <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                            </c:forEach>
                        </select>
                    </td>
                    <td>
                        <c:set var="formName" value="_15_ten99Zip"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input ${disableLinkedFields} type="text" class="zipInputFor smallInput ${linkedFieldClass}" name="${formName}" value="${formValue}" maxlength="10"/>
                    </td>
                    <td>
                        <c:set var="formName" value="_15_ten99County"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <select ${disableLinkedFields} name="${formName}" class="${linkedFieldClass}">
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
           <label>Contact Name<span class="required">*</span></label>
           <span class="floatL"><b>:</b></span>
           <c:set var="formName" value="_15_contactName"></c:set>
           <c:set var="formValue" value="${requestScope[formName]}"></c:set>
           <input ${disableContact} type="text" class="normalInput" id="contactName" name="${formName}" value="${formValue}" maxlength="100"/>
       </div>
       
       <div class="row">
           <label>Contact Phone Number<span class="required">*</span></label>
           <span class="floatL"><b>:</b></span>
           <c:set var="formName" value="_15_contactPhone1"></c:set>
           <c:set var="formValue" value="${requestScope[formName]}"></c:set>
           <input type="text" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
           <span class="sep">-</span>
           <c:set var="formName" value="_15_contactPhone2"></c:set>
           <c:set var="formValue" value="${requestScope[formName]}"></c:set>
           <input type="text" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
           <span class="sep">-</span>
           <c:set var="formName" value="_15_contactPhone3"></c:set>
           <c:set var="formValue" value="${requestScope[formName]}"></c:set>
           <input type="text" class="autotab smallInputP" name="${formName}" value="${formValue}" maxlength="4"/>
           <span class="sep"><strong>ext.</strong></span>
           <c:set var="formName" value="_15_contactPhone4"></c:set>
           <c:set var="formValue" value="${requestScope[formName]}"></c:set>
           <input type="text" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
       </div>

       <div class="row">
           <label>Contact Fax Number</label>
           <span class="floatL"><b>:</b></span>
           <c:set var="formName" value="_15_contactFax1"></c:set>
           <c:set var="formValue" value="${requestScope[formName]}"></c:set>
           <input type="text" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
           <span class="sep">-</span>
           <c:set var="formName" value="_15_contactFax2"></c:set>
           <c:set var="formValue" value="${requestScope[formName]}"></c:set>
           <input type="text" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
           <span class="sep">-</span>
           <c:set var="formName" value="_15_contactFax3"></c:set>
           <c:set var="formValue" value="${requestScope[formName]}"></c:set>
           <input type="text" class="autotab smallInputP" name="${formName}" value="${formValue}" maxlength="4"/>
       </div>
       
       <div class="row">
           <label>Contact Email Address</label>
           <span class="floatL"><b>:</b></span>
           
           <c:set var="formName" value="_15_contactEmail"></c:set>
           <c:set var="formValue" value="${requestScope[formName]}"></c:set>
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