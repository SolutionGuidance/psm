<%--
    JSP Fragment for provider type selection form.

    @author j3_guile
    @version 1.0
 --%>

<%@page import="gov.medicaid.entities.dto.ViewStatics"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:set var="formIdPrefix" value="remittance_sequence"></c:set>

<input type="hidden" name="formNames" value="<%= ViewStatics.REMITTANCE_SEQUENCE_FORM %>">
<c:set var="selectedMarkup" value='selected="selected"' />

<div class="newEnrollmentPanel practicePanel memberInfoPanel">
    <div class="tableHeader topHeader"><span>Remittance Sequence</span></div>
    <div class="sectionInfo">
        Every two weeks, MHCP provides you with a report called a remittance advice (RA) that tells you the status of claims you submitted to MHCP. This information is listed alphabetically by recipient name unless you request a different order here. If you want the RA sorted in a different order, check one of the boxes below.
    </div>
    <div class="clear"></div>
    <div class="section">
        <div class="">
            <div class="row">
                <c:set var="formName" value="_23_remittanceSequenceNumber"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <div class="rowWrapper">
                    <div class="row">
                        <input id="${formIdPrefix}_${formName}_patient" ${disableLinkedFields} type="radio" value="PATIENT_ACCOUNT_OR_OWN_REFERENCE_ORDER" name="${formName}" ${formValue eq 'PATIENT_ACCOUNT_OR_OWN_REFERENCE_ORDER' ? 'checked' : ''}/>
                        <label for="${formIdPrefix}_${formName}_patient">Patient Account or Own Reference Number Order</label>
                    </div>
                    <div class="row">
                        <input id="${formIdPrefix}_${formName}_dhs" ${disableLinkedFields} type="radio" value="DHS_TRANSACTION_CONTROL_ORDER" name="${formName}"  ${formValue eq 'DHS_TRANSACTION_CONTROL_ORDER' ? 'checked' : ''}/>
                        <label for="${formIdPrefix}_${formName}_dhs">DHS Transaction Control Number Order</label>
                    </div>
                    <div class="row">
                        <input id="${formIdPrefix}_${formName}_mhcp" ${disableLinkedFields} type="radio" value="RECIPIENT_MHCP_ID_NUMBER_ORDER" name="${formName}"  ${formValue eq 'RECIPIENT_MHCP_ID_NUMBER_ORDER' ? 'checked' : ''}/>
                        <label for="${formIdPrefix}_${formName}_mhcp">Recipient MHCP ID Number Order</label>
                    </div>
                </div>
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
