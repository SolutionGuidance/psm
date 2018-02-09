<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<div class="summaryPrint">
    <c:if test="${requestScope['_02_bound'] eq 'Y'}">
    <div class="tabSection">
        <div class="tabHead" style="width: 888px;">
            <div class="tabR">
                <div class="tabM">
                    <h5>Personal Info</h5>
                </div>
            </div>
        </div>
        <!-- /.tabHead -->
        <div class="tabContent" style="">
            <div class="tableContainer">
                <div class="topPanel">
                    <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/common/person_info.jsp" %>
                </div>
            </div>
            <!-- /.tableContainer -->
        </div>
        <!-- /#tabSection -->
        <div class="clear"></div>
    </div>
    </c:if>

    <c:if test="${requestScope['_10_bound'] eq 'Y'}">
    <div class="tabSection">
        <div class="tabHead" style="width: 888px;">
            <div class="tabR">
                <div class="tabM">
                    <h5>Individual PCA Information</h5>
                </div>
            </div>
        </div>
        <!-- /.tabHead -->
        <div class="tabContent">
            <div class="tableContainer">
                <div class="bottomPanel">
                    <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/common/ind_pca_rows.jsp" %>
                </div>
            </div>
            <!-- /.tableContainer -->
        </div>
        <!-- /#tabSection -->
        <div class="clear"></div>
    </div>
    </c:if>
    <!-- /#tabSection -->

    <c:if test="${requestScope['_08_bound'] eq 'Y'}">
    <div class="tabSection">
        <div class="tabHead" style="width: 888px;">
            <div class="tabR">
                <div class="tabM">
                    <h5>Provider Statement</h5>
                </div>
            </div>
        </div>
        <!-- /.tabHead -->
        <div class="tabContent">
            <div class="tableContainer">
                <div class="bottomPanel">
                    <div class="leftCol">
	                    <div class="row">
	                        <label>Provider Name</label>
	                        <span class="floatL"><b>:</b></span>
	                        <span>${requestScope['_08_name']}</span>
	                    </div>
	                    <div class="row">
	                        <label>Provider Title</label>
	                        <span class="floatL"><b>:</b></span>
	                        <span>${requestScope['_08_title']}</span>
	                    </div>
	                    <div class="row">
	                        <label>Provider Signature</label>
	                        <span class="floatL"><b>:</b></span>
	                        <span></span>
	                    </div>
	                    <div class="row">
	                        <label>Date</label>
	                        <span class="floatL"><b>:</b></span>
	                        <span>${requestScope['_08_date']}</span>
	                    </div>
                    </div>
                    <div class="clear"></div>
                </div>
            </div>
            <!-- /.tableContainer -->
        </div>
        <!-- /#tabSection -->
        <div class="clear"></div>

    </div>
    </c:if>
    <!-- /#tabSection -->

    <c:if test="${requestScope['_03_bound'] eq 'Y'}">
        <div class="tabSection">
        <div class="tabHead" style="width: 888px;">
            <div class="tabR">
                <div class="tabM">
                    <h5>License Info</h5>
                </div>
            </div>
        </div>
        <!-- /.tabHead -->
        <div class="tabContent">
            <div class="tableContainer">
                <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/summary/tribal_information.jsp" %>
                <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/common/license_information.jsp" %>
            </div>
            <!-- /.tableContainer -->
        </div>
        <!-- /#tabSection -->
        <div class="clear"></div>
    </div>
    </c:if>
    <!-- /#tabSection -->

    <c:if test="${requestScope['_09_bound'] eq 'Y'}">
        <div class="tabSection">
        <div class="tabHead" style="width: 888px;">
            <div class="tabR">
                <div class="tabM">
                    <h5>Specialty Info</h5>
                </div>
            </div>
        </div>
        <!-- /.tabHead -->
        <div class="tabContent">
            <div class="tableContainer">
                <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/common/specialty_information.jsp" %>
            </div>
            <!-- /.tableContainer -->
        </div>
        <!-- /#tabSection -->
        <div class="clear"></div>
    </div>
    </c:if>
    <!-- /#tabSection -->

    <c:if test="${requestScope['_04_bound'] eq 'Y' or requestScope['_05_bound'] eq 'Y' or requestScope['_06_bound'] eq 'Y'}">
        <div class="tabSection">
        <div class="tabHead" style="width: 888px;">
            <div class="tabR">
                <div class="tabM">
                    <h5>Practice Info</h5>
                </div>
            </div>
        </div>
        <!-- /.tabHead -->
         <div class="tabContent tabContentPI">
             <div class="tableContainer">
                 <div class="bottomPanel">
                     <c:if test="${requestScope['_04_bound'] eq 'Y'}">
                        <div class="wholeCol">
                            <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/common/practice_type.jsp" %>
                        </div>
                     </c:if>
                     <c:if test="${requestScope['_05_bound'] eq 'Y'}">
                        <div class="wholeCol">
                         <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/common/private_practice.jsp" %>
                        </div>
                     </c:if>
                     <c:if test="${requestScope['_06_bound'] eq 'Y'}">
                         <div class="wholeCol">
                            <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/common/primary_practice.jsp" %>
                         </div>
                     </c:if>
                 </div>
             </div>
             <!-- /.tableContainer -->
        </div>
        <!-- /#tabSection -->
        <div class="clear"></div>
    </div>
    </c:if>
    <!-- /#tabSection -->

    <c:if test="${requestScope['_07_bound'] eq 'Y'}">
    <div class="tabSection tabContentP">
        <div class="tabHead" style="width: 888px;">
            <div class="tabR">
                <div class="tabM">
                    <h5>Additional Info</h5>
                </div>
            </div>
        </div>
        <!-- /.tabHead -->
        <div class="tabContent">
            <div class="tableContainer">
                <div class="topPanel">
                    <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/common/additional_practice.jsp" %>
                </div>
            </div>
            <!-- /.tableContainer -->
        </div>
        <!-- /#tabSection -->
        <div class="clear"></div>

    </div>
    <!-- /#tabSection -->
    </c:if>

    <c:if test="${requestScope['_02_bound'] eq 'Y'}">
    <div class="tabSection">
        <div class="tabHead" style="width: 888px;">
            <div class="tabR">
                <div class="tabM">
                    <h5>Contact Info</h5>
                </div>
            </div>
        </div>
        <!-- /.tabHead -->
        <div class="tabContent" style="">
            <div class="tableContainer">
                <div class="topPanel">
	                <div class="leftCol">
                        <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/common/contact_info.jsp" %>
                    </div>
                </div>
            </div>
            <!-- /.tableContainer -->
        </div>
        <!-- /#tabSection -->
        <div class="clear"></div>

    </div>
    <!-- /#tabSection -->
    </c:if>

    <c:if test="${requestScope['_11_bound'] eq 'Y'}">
    <div class="tabSection tabContentP">
        <div class="tabHead" style="width: 888px;">
            <div class="tabR">
                <div class="tabM">
                    <h5>Agency Information</h5>
                </div>
            </div>
        </div>
        <!-- /.tabHead -->
        <div class="tabContent">
            <div class="tableContainer">
                <div class="bottomPanel">
                    <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/common/ind_agency_rows.jsp" %>
                </div>
            </div>
            <!-- /.tableContainer -->
        </div>
        <!-- /#tabSection -->
        <div class="clear"></div>
    </div>
    </c:if>
    <!-- /#tabSection -->

    <c:if test="${requestScope['_12_bound'] eq 'Y'}">
    <div class="tabSection tabContentP">
        <div class="tabHead" style="width: 888px;">
            <div class="tabR">
                <div class="tabM">
                    <h5>Group Affiliation</h5>
                </div>
            </div>
        </div>
        <!-- /.tabHead -->
        <div class="tabContent">
            <div class="tableContainer">
                <div class="topPanel">
                    <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/summary/additional_agency.jsp" %>
                </div>
            </div>
            <!-- /.tableContainer -->
        </div>
        <!-- /#tabSection -->
        <div class="clear"></div>
    </div>
    </c:if>
    <!-- /#tabSection -->


    <c:if test="${requestScope['_08_bound'] eq 'Y'}">
    <div class="tabSection">
        <div class="tabHead" style="width: 888px;">
            <div class="tabR">
                <div class="tabM">
                    <h5>Provider Disclosure</h5>
                </div>
            </div>
        </div>
        <!-- /.tabHead -->
        <div class="tabContent">
            <div class="tableContainer">
                <div class="bottomPanel">
                    <div class="eightytwenty">
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
            </div>
            <!-- /.tableContainer -->
        </div>
        <!-- /#tabSection -->
        <div class="clear"></div>

    </div>
    </c:if>

    <c:if test="${requestScope['_15_bound'] eq 'Y'}">
    <div class="tabSection">
        <div class="tabHead" style="width: 888px;">
            <div class="tabR">
                <div class="tabM">
                    <h5>Organization Information</h5>
                </div>
            </div>
        </div>
        <!-- /.tabHead -->
        <div class="tabContent">
            <div class="tableContainer">
                <div class="topPanel">
                    <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/summary/organization_information.jsp" %>
                    <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/summary/pca_billing.jsp" %>
                </div>
            </div>
            <!-- /.tableContainer -->
        </div>
        <!-- /#tabSection -->
        <div class="clear"></div>
    </div>
    </c:if>
    <!-- /#tabSection -->

    <c:if test="${requestScope['_21_bound'] eq 'Y' or requestScope['_30_bound'] eq 'Y' or requestScope['_34_bound'] eq 'Y'}">
    <div class="tabSection">
        <div class="tabHead" style="width: 888px;">
            <div class="tabR">
                <div class="tabM">
                    <h5>Facility Credentials</h5>
                </div>
            </div>
        </div>
        <!-- /.tabHead -->
        <div class="tabContent">
            <div class="tableContainer">
                <div class="topPanel">
                    <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/summary/ctcc_credentials.jsp" %>
                    <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/summary/facility_license.jsp" %>
                    <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/summary/clia_license.jsp" %>
                    <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/summary/phn_agency.jsp" %>
                    <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/summary/facility_capacity.jsp" %>
                    <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/summary/facility_contracts.jsp" %>
                    <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/summary/facility_eligibility.jsp" %>
                </div>
            </div>
            <!-- /.tableContainer -->
        </div>
        <!-- /#tabSection -->
        <div class="clear"></div>
    </div>
    </c:if>
    <!-- /#tabSection -->

    <c:if test="${requestScope['_29_bound'] eq 'Y'}">
    <div class="tabSection">
        <div class="tabHead" style="width: 888px;">
            <div class="tabR">
                <div class="tabM">
                    <h5>Qualified Professional</h5>
                </div>
            </div>
        </div>
        <!-- /.tabHead -->
        <div class="tabContent">
            <div class="tableContainer">
                <div class="topPanel">
                    <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/summary/qualified_professional.jsp" %>
                </div>
            </div>
            <!-- /.tableContainer -->
        </div>
        <!-- /#tabSection -->
        <div class="clear"></div>
    </div>
    </c:if>
    <!-- /#tabSection -->


    <c:if test="${requestScope['_16_bound'] eq 'Y'}">
    <div class="tabSection">
        <div class="tabHead" style="width: 888px;">
            <div class="tabR">
                <div class="tabM">
                    <h5>Individual Member Information</h5>
                </div>
            </div>
        </div>
        <!-- /.tabHead -->
        <div class="tabContent">
            <div class="tableContainer">
                <div class="topPanel">
                    <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/summary/member_information.jsp" %>
                </div>
            </div>
            <!-- /.tableContainer -->
        </div>
        <!-- /#tabSection -->
        <div class="clear"></div>
    </div>
    </c:if>
    <!-- /#tabSection -->

    <c:if test="${requestScope['_17_bound'] eq 'Y'}">
    <div class="tabSection">
        <div class="tabHead" style="width: 888px;">
            <div class="tabR">
                <div class="tabM">
                    <h5>Ownership Information</h5>
                </div>
            </div>
        </div>
        <!-- /.tabHead -->
        <div class="tabContent">
            <div class="tableContainer">
                <div class="topPanel">
                    <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/summary/ownership_information.jsp" %>
                </div>
            </div>
            <!-- /.tableContainer -->
        </div>
        <!-- /#tabSection -->
        <div class="clear"></div>
    </div>
    </c:if>
    <!-- /#tabSection -->

    <div class="clear"></div>
</div>