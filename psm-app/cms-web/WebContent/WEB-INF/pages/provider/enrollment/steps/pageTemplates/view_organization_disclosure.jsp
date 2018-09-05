<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<div id="tabStatement" class="tabContent">
    <div class="topPanel">
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
                    <span>${requestScope['_19_name']}</span>
                </div>
                <div class="row">
                    <label>Provider Title</label>
                    <span>${requestScope['_19_title']}</span>
                </div>
            </div>
        </div>
        <div class="row">&nbsp;</div>
        <div class="bl"></div>
        <div class="br"></div>
    </div>
</div>
