<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:if test="${requestScope['_40_bound'] eq 'Y'}">
<div class="section">
    <div class="">
        <div class="row">
            <label>Facility Qualifications</label>
            <span>
                <label>Hospital Based Clinic Designation:  approval letter from CMS</label>
                <span>
                    <c:if test="${requestScope['_40_designationApprovalIndicator'] eq 'Y'}">
                         Provided
                    </c:if>
                    <c:if test="${requestScope['_40_designationApprovalIndicator'] ne 'Y'}">
                         None
                    </c:if>
                </span>
            </span>
        </div>
    </div>
    <div class="clearFixed"></div>
</div>
</c:if>
