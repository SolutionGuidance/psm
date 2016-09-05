<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:if test="${requestScope['_18_bound'] eq 'Y'}">
<div class="tableHeader">
    <span>Provider Disclosure</span>
</div>

<div class="section orgDisclosureRd">
    
    <div class="eightytwenty">
        <div class="row">
            <h3>Has any person having an ownership or control interest ever:</h3>
        </div>
    
        <div class="row">
            <label>Been convicted of a criminal offense related to that person's involvement in any program under Medicare, Medicaid, Title XX, or Title XXI in Minnesota or any other state or jurisdiction since the inception of these programs?</label>
            <span class="floatL"><b>:</b></span>
            <c:if test="${requestScope['_18_empCriminalConvictionInd'] eq 'Y'}"><span>Yes</span></c:if>
            <c:if test="${requestScope['_18_empCriminalConvictionInd'] eq 'N'}"><span>No</span></c:if>
        </div>
        <div class="row">
            <label>Had civil money penalties or assessments imposed under section 1128A of the Social Security Act?</label>
            <span class="floatL"><b>:</b></span>
            <c:if test="${requestScope['_18_empCivilPenaltyInd'] eq 'Y'}"><span>Yes</span></c:if>
            <c:if test="${requestScope['_18_empCivilPenaltyInd'] eq 'N'}"><span>No</span></c:if>
        </div>
        <div class="row">
            <label>Been excluded from participation in Medicare or any of the State health care programs?</label>
            <span class="floatL"><b>:</b></span>
            <c:if test="${requestScope['_18_empPreviousExclusionInd'] eq 'Y'}"><span>Yes</span></c:if>
            <c:if test="${requestScope['_18_empPreviousExclusionInd'] eq 'N'}"><span>No</span></c:if>
        </div>
        
        <div class="row">
            <h3>Has any managing employee or agent ever:</h3>
        </div>
    
        <div class="row">
            <label>Been convicted of a criminal offense related to that person's involvement in any program under Medicare, Medicaid, Title XX, or Title XXI in Minnesota or any other state or jurisdiction since the inception of these programs?</label>
            <span class="floatL"><b>:</b></span>
            <c:if test="${requestScope['_18_criminalConvictionInd'] eq 'Y'}"><span>Yes</span></c:if>
            <c:if test="${requestScope['_18_criminalConvictionInd'] eq 'N'}"><span>No</span></c:if>
        </div>
        <div class="row">
            <label>Had civil money penalties or assessments imposed under section 1128A of the Social Security Act?</label>
            <span class="floatL"><b>:</b></span>
            <c:if test="${requestScope['_18_civilPenaltyInd'] eq 'Y'}"><span>Yes</span></c:if>
            <c:if test="${requestScope['_18_civilPenaltyInd'] eq 'N'}"><span>No</span></c:if>
        </div>
        <div class="row">
            <label>Been excluded from participation in Medicare or any of the State health care programs?</label>
            <span class="floatL"><b>:</b></span>
            <c:if test="${requestScope['_18_previousExclusionInd'] eq 'Y'}"><span>Yes</span></c:if>
            <c:if test="${requestScope['_18_previousExclusionInd'] eq 'N'}"><span>No</span></c:if>
        </div>
        <div class="clearFixed"></div>
    </div>
</div>        
</c:if>