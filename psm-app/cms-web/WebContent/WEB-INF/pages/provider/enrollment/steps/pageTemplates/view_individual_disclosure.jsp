<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<div id="tabStatement" class="tabContent">
    <div class="topPanel">
        <div class="tableHeader">
            <span>Provider Disclosure</span>
        </div>
        <div class="wideCol">
            <div class="row">
                <label>Have you ever been convicted of a criminal offense related to involvement in any program under Medicare, Medicaid, Title XX, or Title XXI in
                    Minnesota or any other state or jurisdiction since the inception of these programs?</label>
                <c:if test="${requestScope['_08_criminalConvictionInd'] eq 'Y'}"><span>Yes</span></c:if>
                <c:if test="${requestScope['_08_criminalConvictionInd'] eq 'N'}"><span>No</span></c:if>
            </div>
            <div class="row">
                <label>Have you had civil money penalties or assessments imposed under section 1128A of the Social Security Act?</label>
                <c:if test="${requestScope['_08_civilPenaltyInd'] eq 'Y'}"><span>Yes</span></c:if>
                <c:if test="${requestScope['_08_civilPenaltyInd'] eq 'N'}"><span>No</span></c:if>
            </div>
            <div class="row">
                <label>Have you ever been excluded or terminated from participation in Medicare, Medicaid, Children's Health Insurance Program (CHIP),
                    or the Title XXI services program in Minnesota or any other state since the inception of these programs? </label>
                <c:if test="${requestScope['_08_previousExclusionInd'] eq 'Y'}"><span>Yes</span></c:if>
                <c:if test="${requestScope['_08_previousExclusionInd'] eq 'N'}"><span>No</span></c:if>
            </div>
        </div>
    </div>
    <div class="tableHeader">
        <span>Provider Statement</span>
    </div>
    <div class="bottomPanel">
        <div class="row">
            <p>
                I certify that the information provided on this form is accurate, complete and truthful.
                I will notify MHCP Provider Enrollment of any changes to this information. I acknowledge
                that any misrepresentations in the information submitted to MHCP, including false claims,
                statements, documents, or concealment of a material fact, may be cause for denial or termination
                of participation as a Medicaid provider.
            </p>
        </div>
        <div class="row">
            <div class="leftCol">
                <div class="row">
                    <label>Provider Name</label>
                    <span>${requestScope['_08_name']}</span>
                </div>
                <div class="row">
                    <label>Provider Title</label>
                    <span>${requestScope['_08_title']}</span>
                </div>
            </div>
        </div>
        <div class="row">&nbsp;</div>
        <div class="bl"></div>
        <div class="br"></div>
    </div>
</div>
