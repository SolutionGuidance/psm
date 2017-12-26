<%--
    JSP Fragment for provider type selection form.

    @author j3_guile
    @version 1.0
 --%>

<%@page import="gov.medicaid.entities.dto.ViewStatics"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:set var="formIdPrefix" value="ind_agency_information"></c:set>

<div class="practicePanel">
    <div class="tableHeader otherTableHeader">
        <span>Group Affiliation Information</span>
        <a href="javascript:openAgencyLookup(true);" class="purpleSmallBtn practiceLookupModalBtn">Agency Lookup</a>
    </div>

    <div>
    <div class="section">
        <input type="hidden" name="formNames" value="<%= ViewStatics.INDIVIDUAL_AGENCY_FORM %>">
        <div class="wholeCol">
            <div class="row requireField">
                <label>Agency Name<span class="required">*</span></label>
                <span class="floatL"><b>:</b></span>

                <c:set var="formName" value="_11_name"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="100"/>
            </div>
            <div class="row requireField">
                <label>Agency Id<span class="required">*</span></label>
                <span class="floatL"><b>:</b></span>

                <c:set var="formName" value="_11_agencyId"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input type="text" class="normalInput" id="firstName" name="${formName}" value="${formValue}" maxlength="100"/>
            </div>
            <div class="row">
                <label>Agency NPI/UMPI<span class="required">*</span></label>
                <span class="floatL"><b>:</b></span>

                <c:set var="formName" value="_11_npi"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input type="text" class="npiMasked normalInput" id="middleName" name="${formName}" value="${formValue}" maxlength="10"/>
            </div>
                
            <div class="row">
                <label>Fax Number<span class="required">*</span></label>
                <span class="floatL"><b>:</b></span>
                <c:set var="formName" value="_11_fax1"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input type="text" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                <span class="sep">-</span>
                <c:set var="formName" value="_11_fax2"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input type="text" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                <span class="sep">-</span>
                <c:set var="formName" value="_11_fax3"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input type="text" class="autotab smallInputP" name="${formName}" value="${formValue}" maxlength="4"/>
            </div>

            <div class="row">
                <label>Agency Contact Name<span class="required">*</span></label>
                <span class="floatL"><b>:</b></span>
                
                <c:set var="formName" value="_11_contactName"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input type="text" class="normalInput" id="contactName" name="${formName}" value="${formValue}" maxlength="100"/>
            </div>
            
            <div class="row">
                <label>Background Study ID<span class="required">*</span></label>
                <span class="floatL"><b>:</b></span>
                
                <c:set var="formName" value="_11_bgsId"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input type="text" class="normalInput" id="bgsId" name="${formName}" value="${formValue}" maxlength="100"/>
            </div>

            <div class="row">
                <label>Clearance Date<span class="required">*</span></label>
                <span class="floatL"><b>:</b></span>
                
                <c:set var="formName" value="_11_clearanceDate"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input class="date" type="text" name="${formName}" value="${formValue}"/>
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

<!-- /.newEnrollmentPanel -->
<div class="radioPanel">
    <div class="section">
        <div id="RadioWrapper" class="row">
            <label>Has this individual maintained continuous employment with your agency since this BGS was completed?</label>
            <div>
                <c:set var="formName" value="_11_continuousEmployment"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input type="radio" value="Y" name="${formName}" ${formValue eq 'Y' ? 'checked' : ''}><label class="span">Yes</label>
                <input type="radio" value="N" name="${formName}" ${formValue eq 'N' ? 'checked' : ''}><label class="span">No</label>            
            </div>
        </div>
        <c:url var="rebindUrl" value="/provider/enrollment/steps/rebind" />
        <div id="RadioWrapper" class="row">
            <label>You have the option to affiliate/enroll the individual PCA  with other agencies you own without completing another <br/> 
            application and agreement. Do you want to affiliate this individual PCA with any other agency(ies) you own?</label>
            <div>
                <c:set var="formName" value="_11_additionalAgency"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input onchange="javascript:submitFormById('enrollmentForm', '${rebindUrl}')" type="radio" value="Y" name="${formName}" ${formValue eq 'Y' ? 'checked' : ''}><label class="span">Yes</label>
                <input onchange="javascript:submitFormById('enrollmentForm', '${rebindUrl}')" type="radio" value="N" name="${formName}" ${formValue eq 'N' ? 'checked' : ''}><label class="span">No</label>            
            </div>
        </div>
        <div class="clearFixed"></div>
    </div>
    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
</div>
