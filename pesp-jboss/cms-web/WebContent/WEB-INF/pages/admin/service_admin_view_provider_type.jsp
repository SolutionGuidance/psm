 <%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: This is the admin provider types page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <c:set var="title" value="Functions (Service Admin)"/>
    <%@ include file="/WEB-INF/pages/admin/includes/html_head.jsp" %>
    <body>
        <div id="wrapper">
            <%@ include file="/WEB-INF/pages/includes/header.jsp" %>
            <div id="mainContent">
                <div class="contentWidth">
                    <div class="mainNav">
                        <a class="logo" href="javascript:;"><img src="<c:url value="/i/logo.gif" />" alt="Medicaid Provider"/></a>
                        <c:set var="activeTab" value="4"></c:set>
                        <%@include file="/WEB-INF/pages/includes/nav.jsp" %>
                    </div>
                    <div class="breadCrumb">
                        Functions
                    </div>
                    <h1>Functions</h1>
                    <div class="tabSection functionTab" id="enrollmentSection">
                        <c:set var="functions_service_active_menu" value="providerTypes"/>
                        <%@ include file="/WEB-INF/pages/admin/includes/functions_service_nav.jsp" %>
                        <div class="tabContent" id="tabProviderTypes">
                            <div id="viewProviderPanel">
                                <div class="sideBorder">
                                    <h3>Provider Type Details</h3>
                                    <a href="${ctx}/admin/viewProviderTypes" class="greyBtn"><span class="btR"><span class="btM">Back</span></span></a>
                                    <c:choose>
                                        <c:when test="${providerType.canDelete}"><a href="javascript:;" rel="${providerType.code}" class="greyBtn deleteProviderTypesOnViewBtn"><span class="btR"><span class="btM">Delete</span></span></a></c:when>
                                        <c:otherwise>
                                            <a href="javascript:;"  style="text-decoration: none;color: gray;cursor: default;" class="greyBtn disabledBtn"><span class="btR"><span class="btM">Delete</span></span></a>
                                        </c:otherwise>
                                    </c:choose>  
                                    <a href="${ctx}/admin/beginEditProviderType?providerTypeId=${providerType.code}" class="purpleBtn editProviderLink"><span class="btR"><span class="btM">Edit</span></span></a>
                                </div>
                                <div class="newEnrollmentPanel">
                                    <input id="containedRequiredFields" type="hidden" value="${containedRequiredFields}"/>
                                    <div class="section">
                                        <div class="wholeCol">
                                            <label>Provider Type</label>
                                            <span class="floatL"><b>:</b></span>
                                            <span class="marginLeft10">${providerType.description}</span>
                                        </div>
                                        <div class="tableHeader"><span>Business Rules for Enrollment</span></div>
                                        <div class="wholeCol">
                                            <div class="row">
                                                <label>Provider Info</label>
                                                <span class="floatL"><b>:</b></span>
                                                <div class="rightBoxes">
                                                    <div class="row">
                                                        <input <c:if test="${providerType.hasPrivateOffice}">checked="checked"</c:if> type="checkbox" disabled="disabled" id="editTypeCheck1"/>
                                                        <label for="editTypeCheck1">Private practice</label>
                                                    </div>
                                                    <div class="row">
                                                        <input <c:if test="${providerType.employedAndOrContracted}">checked="checked"</c:if> type="checkbox" disabled="disabled" id="editTypeCheck2"/>
                                                        <label for="editTypeCheck2">Employed/contracted by group practice</label>
                                                    </div>
                                                    <div class="row">
                                                        <input <c:if test="${providerType.hasAdditionalPractice}">checked="checked"</c:if> type="checkbox" disabled="disabled" id="editTypeCheck3" />
                                                        <label for="editTypeCheck3">Additional practice</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <label>Payment</label>
                                                <span class="floatL"><b>:</b></span>
                                                <span class="marginLeft10">
                                                    <c:choose>
                                                        <c:when test="${providerType.paymentRequired}">Required</c:when>
                                                        <c:otherwise>Not Required</c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </div>
                                            <div class="row">
                                                <label>Required Fields</label>
                                                <span class="floatL"><b>:</b></span>
                                                <div class="rightBoxes">
                                                    <div class="row"><h4>Personal Info</h4></div>
                                                    <div class="row requiredFieldsRightBoxes">
                                                        <div class="col">
                                                            <div class="row">
                                                                <input <c:if test="${fn:contains(containedRequiredFields, 'Personal Info Last Name')}">checked="checked"</c:if> type="checkbox" disabled="disabled" id="editTypeCheck4" />
                                                                <label for="editTypeCheck4">Last Name</label>
                                                            </div>
                                                            <div class="row">
                                                                <input <c:if test="${fn:contains(containedRequiredFields, 'Personal Info First Name')}">checked="checked"</c:if> type="checkbox" disabled="disabled" id="editTypeCheck5" />
                                                                <label for="editTypeCheck5">First Name</label>
                                                            </div>
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck6"/>
                                                                <label for="editTypeCheck6">Middle Name</label>
                                                            </div>
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck7"/>
                                                                <label for="editTypeCheck7">NPI</label>
                                                            </div>
                                                        </div>
                                                        <div class="col">
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck8" />
                                                                <label for="editTypeCheck8">Social Security Number</label>
                                                            </div>
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck9" />
                                                                <label for="editTypeCheck9">Date of Birth</label>
                                                            </div>
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck10" />
                                                                <label for="editTypeCheck10">Effective Date</label>
                                                            </div>
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck11"/>
                                                                <label for="editTypeCheck11">Highest Degree Earned</label>
                                                            </div>
                                                        </div>
                                                        <div class="col">
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck12"/>
                                                                <label for="editTypeCheck12">Date Degree Awarded</label>
                                                            </div>
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck13" />
                                                                <label for="editTypeCheck13">Phone Number</label>
                                                            </div>
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck14" />
                                                                <label for="editTypeCheck14">Fax Number</label>
                                                            </div>
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck15"/>
                                                                <label for="editTypeCheck15">Email Address</label>
                                                            </div>
                                                        </div>
                                                        <div class="col">
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck16" />
                                                                <label for="editTypeCheck16">Contact Name</label>
                                                            </div>
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck17" />
                                                                <label for="editTypeCheck17">Contact Phone Number</label>
                                                            </div>
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck18"/>
                                                                <label for="editTypeCheck18">Contact Fax Number</label>
                                                            </div>
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck19"/>
                                                                <label for="editTypeCheck19">Contact Email Address</label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row borderTop"><h4>License Info</h4></div>
                                                    <div class="row requiredFieldsRightBoxes">
                                                        <div class="col">
                                                            <div class="row">
                                                                <input <c:if test="${fn:contains(containedRequiredFields, 'License Info Specialty')}">checked="checked"</c:if> type="checkbox" disabled="disabled" id="editTypeCheck20" />
                                                                <label for="editTypeCheck20">Specialty</label>
                                                            </div>
                                                            <div class="row">
                                                                <input <c:if test="${fn:contains(containedRequiredFields, 'License Info Type of License/Certification')}">checked="checked"</c:if> type="checkbox" disabled="disabled" id="editTypeCheck21" />
                                                                <label for="editTypeCheck21">Type of License/Certification</label>
                                                            </div>
                                                        </div>
                                                        <div class="col">
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck22" />
                                                                <label for="editTypeCheck22">License/Certification #</label>
                                                            </div>
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck23" />
                                                                <label for="editTypeCheck23">Original Issue Date</label>
                                                            </div>
                                                        </div>
                                                        <div class="col">
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck24"/>
                                                                <label for="editTypeCheck24">Renewal End Date</label>
                                                            </div>
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck25" />
                                                                <label for="editTypeCheck25">Issuing State</label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row borderTop"><h4>Private Practice</h4></div>
                                                    <div class="row requiredFieldsRightBoxes">
                                                        <div class="col">
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck26"/>
                                                                <label for="editTypeCheck26">Private Practice Name</label>
                                                            </div>
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck27" />
                                                                <label for="editTypeCheck27">Group NPI / UMPI</label>
                                                            </div>
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck28" />
                                                                <label for="editTypeCheck28">Practice Address</label>
                                                            </div>
                                                        </div>
                                                        <div class="col">
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck29" />
                                                                <label for="editTypeCheck29">Practice Phone Number</label>
                                                            </div>
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck30"/>
                                                                <label for="editTypeCheck30">Practice Fax Number</label>
                                                            </div>
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck31"/>
                                                                <label for="editTypeCheck31">Billing Address</label>
                                                            </div>
                                                        </div>
                                                        <div class="col">
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck32"/>
                                                                <label for="editTypeCheck32">FEIN</label>
                                                            </div>
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck33" />
                                                                <label for="editTypeCheck33">MN Tax ID</label>
                                                            </div>
                                                        </div>
                                                        <div class="col">
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck35" />
                                                                <label for="editTypeCheck35">EFT Vendor Number</label>
                                                            </div>
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck36" />
                                                                <label for="editTypeCheck36">Remittance Sequence</label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row borderTop"><h4>Group Practice</h4></div>
                                                    <div class="row requiredFieldsRightBoxes">
                                                        <div class="col">
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck37"/>
                                                                <label for="editTypeCheck37">Private Practice Name</label>
                                                            </div>
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck38" />
                                                                <label for="editTypeCheck38">Group NPI / UMPI</label>
                                                            </div>
                                                        </div>
                                                        <div class="col">
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck39" />
                                                                <label for="editTypeCheck39">Practice Address</label>
                                                            </div>
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck40" />
                                                                <label for="editTypeCheck40">Practice Phone Number</label>
                                                            </div>
                                                        </div>
                                                        <div class="col">
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck41"/>
                                                                <label for="editTypeCheck41">Practice Fax Number</label>
                                                            </div>
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck42"/>
                                                                <label for="editTypeCheck42">Reimbursement Address</label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row borderTop"><h4>Additional Practice</h4></div>
                                                    <div class="row requiredFieldsRightBoxes">
                                                        <div class="col">
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck43"/>
                                                                <label for="editTypeCheck43">Group Name</label>
                                                            </div>
                                                        </div>
                                                        <div class="col">
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck44" />
                                                                <label for="editTypeCheck44">Group NPI / UMPI</label>
                                                            </div>
                                                        </div>
                                                        <div class="col">
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck45" />
                                                                <label for="editTypeCheck45">Practice Address</label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row borderTop"><h4>Payment Info</h4></div>
                                                    <div class="row requiredFieldsRightBoxes">
                                                        <div class="col">
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck46" />
                                                                <label for="editTypeCheck46">Credit Card Type</label>
                                                            </div>
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck47" />
                                                                <label for="editTypeCheck47">Name on Credit Card</label>
                                                            </div>
                                                        </div>
                                                        <div class="col">
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck48" />
                                                                <label for="editTypeCheck48">Credit Card Number</label>
                                                            </div>
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck49" />
                                                                <label for="editTypeCheck49">Security Code</label>
                                                            </div>
                                                        </div>
                                                        <div class="col">
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck50" />
                                                                <label for="editTypeCheck50">Valid Until</label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row borderTop"><h4>Provider Statement</h4></div>
                                                    <div class="row requiredFieldsRightBoxes">
                                                        <div class="col">
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck51" />
                                                                <label for="editTypeCheck51">Provider Disclosure</label>
                                                            </div>
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck52" />
                                                                <label for="editTypeCheck52">Provider Name</label>
                                                            </div>
                                                        </div>
                                                        <div class="col">
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck53" />
                                                                <label for="editTypeCheck53">Provider Title</label>
                                                            </div>
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck54" />
                                                                <label for="editTypeCheck54">Provider Signature</label>
                                                            </div>
                                                        </div>
                                                        <div class="col">
                                                            <div class="row">
                                                                <input type="checkbox" disabled="disabled" id="editTypeCheck55" />
                                                                <label for="editTypeCheck55">Signed Date</label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row borderTop"><h4>Agreements</h4></div>
                                                    <div class="row">
                                                        <div class="col2">
                                                            <div class="row">
                                                                <input <c:if test="${providerType.hasAgreement}">checked="checked"</c:if> type="checkbox" id="editTypeCheck56" disabled="disabled" />
                                                                <label for="editTypeCheck56">Provider Agreement</label>
                                                            </div>
                                                            <div class="row">
                                                                <input <c:if test="${providerType.hasAddendum}">checked="checked"</c:if> type="checkbox" id="editTypeCheck57" disabled="disabled" />
                                                                <label for="editTypeCheck57">Provider Agreement Addendum</label>
                                                            </div>
                                                        </div>
                                                        <div class="col3">
                                                            <div class="row">
                                                                <select disabled="disabled">
                                                                    <option>${providerType.agreement.title}</option>
                                                                </select>
                                                            </div>
                                                            <div class="row">
                                                                <select disabled="disabled">
                                                                    <option>${providerType.addendum.title}</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="bl"></div>
                                    <div class="br"></div>
                                </div>
                            </div>
                            <!--/ #viewProviderPanel -->
                        </div>
                    </div>
                </div>
            </div>
            <!-- /#mainContent -->

            <%@ include file="/WEB-INF/pages/includes/footer.jsp" %>
        </div>
        <!-- /#wrapper -->
        <!-- modal -->
        <div id="modalBackground"></div>
        <div id="modal">
            <div class="modal" id="deleteProviderTypesModal">
                <div class="modalHeader">
                    <div class="corner">
                        <div class="cornerR">
                            <div class="cornerM">
                                <a href="javascript:;" class="closeModal">CLOSE</a>
                                <h2>Delete Provider Type</h2>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.modalHeader -->
                <div class="modalBody">
                    <div class="corner">
                        <div class="cornerR">
                            <div class="cornerM">
                                <div class="container">
                                    <p class="modal_title">Are you sure you want to delete the selected provider type?</p>
                                    <div class="buttons">
                                        <a href="javascript:;" rel="${ctx}/admin/deleteProviderTypes?providerTypeIds=${providerType.code}" class="purpleBtn deleteOKBtn"><span class="btR"><span class="btM">Delete</span></span></a>
                                        <a href="javascript:;" class="greyBtn closeModal"><span class="btR"><span class="btM">Cancel</span></span></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.modalBody -->
                <div class="modalFooter">
                    <div class="corner">
                        <div class="cornerR">
                            <div class="cornerM">
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.modalFooter -->
            </div>
        </div>
    </body>
</html>