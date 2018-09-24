<%@page import="gov.medicaid.entities.dto.ViewStatics"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="h" tagdir="/WEB-INF/tags" %>

<c:set var="formIdPrefix" value="pcpo_insurance"></c:set>

<input type="hidden" name="formNames" value="<%= ViewStatics.PCPO_INSURANCE_FORM %>">
<c:set var="selectedMarkup" value='selected="selected"' />

<div class="newEnrollmentPanel memberInfoPanel">
    <div class="clearFixed"></div>
    <div class="section">
        <div class="wholeCol organizationInfo">
            <div class="row requireField">
                <label class="mediumLbl">Copy of certificate of liability insurance</label>
                <span class="floatL">
                    <c:set var="formName" value="_25_liabilityInsuranceId" />
                    <h:attachment
                        name="${formName}"
                        title="Certificate of liability insurance"
                        attachmentId="${requestScope[formName]}"
                        attachmentIdName="${formName}"
                        filename="Download"
                    />
                </span>
            </div>
            <div class="row">
            </div>

            <div class="row">
                <label class="mediumLbl">Copy of Workers' Compensation insurance</label>
                <span class="floatL">
                    <c:set var="formName" value="_25_compensationInsuranceId" />
                    <h:attachment
                        name="${formName}"
                        title="Workers' Compensation insurance"
                        attachmentId="${requestScope[formName]}"
                        attachmentIdName="${formName}"
                        filename="Download"
                    />
                </span>
            </div>
            <div class="row">
            </div>

            <div class="row requireField">
                <label class="mediumLbl">Copy of fidelity bond</label>
                <span class="floatL">
                    <c:set var="formName" value="_25_fidelityBondId" />
                    <h:attachment
                        name="${formName}"
                        title="Fidelity bond"
                        attachmentId="${requestScope[formName]}"
                        attachmentIdName="${formName}"
                        filename="Download"
                    />
                </span>
            </div>
            <div class="row">
            </div>

            <div class="row requireField">
                <label class="mediumLbl">Copy of surety bond</label>
                <span class="floatL">
                    <c:set var="formName" value="_25_suretyBondId" />
                    <h:attachment
                        name="${formName}"
                        title="Surety bond"
                        attachmentId="${requestScope[formName]}"
                        attachmentIdName="${formName}"
                        filename="Download"
                    />
                </span>
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
