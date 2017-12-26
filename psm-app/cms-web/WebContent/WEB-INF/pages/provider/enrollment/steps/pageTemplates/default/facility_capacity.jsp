<%--
    JSP Fragment for provider type selection form.

    @author j3_guile
    @version 1.0
 --%>

<%@page import="gov.medicaid.entities.dto.ViewStatics"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:set var="formIdPrefix" value="facility_capacity"></c:set>
<c:set var="selectedMarkup" value='selected="selected"' />

<input type="hidden" name="formNames" value="<%= ViewStatics.FACILITY_CAPACITY_FORM %>">
<div class="newEnrollmentPanel practicePanel memberInfoPanel">
    <div class="section">
        <div class="leftCol">
            <div class="row requireField">
                <label class="">Number of Beds<span class="required">*</span></label>
                <span class="floatL"><b>:</b></span>
                <c:set var="formName" value="_27_numberOfBeds"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="6"/>
            </div>
            <div class="clearFixed"></div>
        </div>
        <div class="rightCol">
            <div class="row requireField">
                <label>Effective Date<span class="required">*</span>
                    <span class="label">(MM/DD/YYYY)</span>
                </label>
                <span class="floatL"><b>:</b></span>
                            <span class="dateWrapper floatL">
                    <c:set var="formName" value="_27_effectiveDate"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input class="date" type="text" name="${formName}" value="${formValue}"/>
                                    </span>
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
