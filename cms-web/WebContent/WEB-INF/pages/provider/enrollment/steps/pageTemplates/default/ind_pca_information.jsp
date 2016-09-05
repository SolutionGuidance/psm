<%--
    JSP Fragment for provider type selection form.

    @author j3_guile
    @version 1.0
 --%>

<%@page import="gov.medicaid.entities.dto.ViewStatics"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>

<div class="practicePanel">
    <div>
	<div class="section">
	    <input type="hidden" name="formNames" value="<%= ViewStatics.PCA_INDIVIDUAL_FORM %>">
	    <div class="wholeCol">
	        <div class="row requireField">
	            <label>First Name<span class="required">*</span></label>
	            <span class="floatL"><b>:</b></span>
	            
	            <c:set var="formName" value="_10_firstName"></c:set>
	            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
	            <input type="text" class="normalInput" id="firstName" name="${formName}" value="${formValue}" maxlength="45"/>
	        </div>
	        <div class="row">
	            <label>Middle Name</label>
	            <span class="floatL"><b>:</b></span>
	            
	            <c:set var="formName" value="_10_middleName"></c:set>
	            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
	            <input type="text" class="normalInput" id="middleName" name="${formName}" value="${formValue}" maxlength="45"/>
	        </div>
	        <div class="row requireField">
	            <label>Last Name<span class="required">*</span></label>
	            <span class="floatL"><b>:</b></span>
	
		        <c:set var="formName" value="_10_lastName"></c:set>
		        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
	            <input type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="45"/>
	        </div>
            <div class="row requireField">
                <label>Social Security Number<span class="required">*</span></label>
                <span class="floatL"><b>:</b></span>
    
                <c:set var="formName" value="_10_ssn"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="9"/>
            </div>

            <div class="row addressline1">
                <label>Residential Address<span class="required">*</span></label>
                <span class="floatL"><b>:</b></span>

                <c:set var="formName" value="_10_addressLine1"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input type="text" class="wholeInput addressInputFor" name="${formName}" value="${formValue}" maxlength="28"/>
            </div>
            <div class="row inlineBox addressline2">
                <span class="label">(Residential Address only - do not<br />enter a PO Box)</span>
                <span class="floatL"><b>&nbsp;</b></span>

                <c:set var="formName" value="_10_addressLine2"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input type="text" class="wholeInput addressInputFor" name="${formName}" value="${formValue}" maxlength="28"/>
            </div>
            
            <div class="row inlineBox">
                <span class="label">&nbsp;</span>
                <span class="floatL"><b>&nbsp;</b></span>
                <label class="cityLabel">City<span class="required">*</span> : </label>

                <c:set var="formName" value="_10_city"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input type="text"  class="cityInputFor" name="${formName}" value="${formValue}" maxlength="18"/>
                <label>State<span class="required">*</span> : </label>
                <c:set var="formName" value="_10_state"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <select class="stateSelectFor" name="${formName}">
                    <option value="">Please select</option>
                    <c:forEach var="opt" items="${requestScope['_99_states']}">
                        <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                    </c:forEach>
                </select>
                <label>ZIP Code<span class="required">*</span> : </label>
                <c:set var="formName" value="_10_zip"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input type="text" class="zipInputFor" name="${formName}" value="${formValue}" maxlength="6"/>
                <label>County : </label>
                <c:set var="formName" value="_10_county"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input type="text" class="countryInput conurtyInputFor countyMask" name="${formName}" value="${formValue}" maxlength="3"/>
            </div>
                
            <div class="row">
                <label>UMPI</label>
                <span class="floatL"><b>:</b></span>
                
                <c:set var="formName" value="_10_umpi"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="10"/>
            </div>
            
            <div class="row requireField">
                <label>Date of Birth<span class="required">*</span></label>
                <span class="floatL"><b>:</b></span>
                <span class="dateWrapper floatL">
    
                    <c:set var="formName" value="_10_dob"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <input class="date" type="text" name="${formName}" value="${formValue}"/>
                </span>
            </div>
                
            <div class="row">
                <label>Phone Number</label>
                <span class="floatL"><b>:</b></span>
                <c:set var="formName" value="_10_phone1"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input type="text" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                <span class="sep">-</span>
                <c:set var="formName" value="_10_phone2"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input type="text" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                <span class="sep">-</span>
                <c:set var="formName" value="_10_phone3"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input type="text" class="autotab smallInputP" name="${formName}" value="${formValue}" maxlength="4"/>
                <span class="sep"><strong>ext.</strong></span>
                <c:set var="formName" value="_10_phone4"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input type="text" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
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
            <label>Are you 18 years or older?<span class="required">*</span></label>
            <div>
                <c:set var="formName" value="_10_adultInd"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input type="radio" value="Y" name="${formName}" ${formValue eq 'Y' ? 'checked' : ''}><label class="span">Yes</label>
                <input type="radio" value="N" name="${formName}" ${formValue eq 'N' ? 'checked' : ''}><label class="span">No</label>            
            </div>
        </div>
        <div class="clearFixed"></div>
    </div>
    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
</div>