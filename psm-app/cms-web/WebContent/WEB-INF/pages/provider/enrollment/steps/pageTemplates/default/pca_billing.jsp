<%--
    JSP Fragment for provider type selection form.

    @author j3_guile
    @version 1.0
 --%>

<%@page import="gov.medicaid.entities.dto.ViewStatics"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:set var="formIdPrefix" value="pca_billing"></c:set>

<div class="newEnrollmentPanel practicePanel">
    <div class="tableHeader topHeader"><span>Designation of PCA Billing Person</span></div>
    <div class="sectionInfo">By signing below, I, the above named owner of the named PCA agency, am assigning the following individual as responsible and accountable for understanding my agency's billing practices related to reimbursement of MHCP claims for PCA services provided.</div>
    <div class="clearFixed"></div>
    <div class="section line">
        <input type="hidden" name="formNames" value="<%= ViewStatics.PCA_BILLING_CONTACT_FORM %>">
        <div class="wholeCol organizationInfo">
            <div class="row requireField">
                <c:set var="formName" value="_24_billingContactName"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">NAME OF RESPONSIBLE BILLING PERSON<span class="required">*</span></label>
                <span class="floatL"><b>:</b></span>
                <input id="${formIdPrefix}_${formName}" type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="100"/>
            </div>
            <div class="row requireField">
                <c:set var="formName" value="_24_billingContactTitle"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">TITLE<span class="required">*</span></label>
                <span class="floatL"><b>:</b></span>
                <input id="${formIdPrefix}_${formName}" type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="45"/>
            </div>
            <div class="row">
                <c:set var="formName" value="_24_billingContactHireDate"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">DATE OF EMPLOYMENT</label>
                <span class="floatL"><b>:</b></span>
                <span class="dateWrapper floatL">
                    <input id="${formIdPrefix}_${formName}" class="date" type="text" name="${formName}" value="${formValue}"/>
                </span>
            </div>
            <div class="row requireField">
                <c:set var="formName" value="_24_billingContactSSN"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">SOCIAL SECURITY NUMBER<span class="required">*</span></label>
                <span class="floatL"><b>:</b></span>
                <input id="${formIdPrefix}_${formName}" type="text" class="ssnMasked normalInput" name="${formName}" value="${formValue}" maxlength="11"/>
            </div>
            <div class="row">
                <c:set var="formName" value="_24_billingContactDOB"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">DATE OF BIRTH</label>
                <span class="floatL"><b>:</b></span>
                <span class="dateWrapper floatL">
                    <input id="${formIdPrefix}_${formName}" class="date" type="text" name="${formName}" value="${formValue}"/>
                </span>
            </div>
            <div class="clearFixed"></div>
        </div>
       <div class="clearFixed"></div>
    </div>
    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
</div>
