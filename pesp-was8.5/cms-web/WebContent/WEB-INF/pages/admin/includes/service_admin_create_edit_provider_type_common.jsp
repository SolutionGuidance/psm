 <%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: This is the admin provider types create/edit common page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<div class="newEnrollmentPanel">
<input id="containedRequiredFields" type="hidden" value="${containedRequiredFields}"/>
    <div class="section">
        <div class="wholeCol">
            <label>Provider Type</label>
            <span class="floatL"><b>:</b></span>
            <form:input path="description" cssClass="text"/>
        </div>
        <div class="tableHeader"><span>Business Rules for Enrollment</span></div>
        <div class="wholeCol">
            <div class="row">
                <label>Provider Info</label>
                <span class="floatL"><b>:</b></span>
                <div class="rightBoxes">
                    <div class="row">
                        <form:checkbox path="hasPrivateOffice" id="addTypeCheck1"/>
                        <label for="addTypeCheck1">Private practice</label>
                    </div>
                    <div class="row">
                        <form:checkbox path="employedAndOrContracted" id="addTypeCheck2"/>
                        <label for="addTypeCheck2">Employed/contracted by group practice</label>
                    </div>
                    <div class="row">
                        <form:checkbox path="hasAdditionalPractice" id="addTypeCheck3"/>
                        <label for="addTypeCheck3">Additional practice</label>
                    </div>
                </div>
            </div>
            <div class="row">
                <label>Payment</label>
                <span class="floatL"><b>:</b></span>
                <div class="rightBoxes">
                    <input type="radio" id="addTypeRadio1" name="addProviderPaymentRadio"/>
                    <label for="addTypeRadio1">Required</label>
                    <input type="radio" id="addTypeRadio2" name="addProviderPaymentRadio"/>
                    <label for="addTypeRadio2">Not Required</label>
                    <form:hidden path="paymentRequired" id="paymentRequiredField"/>
                </div>
            </div>
            <div class="row">
                <label>Required Fields</label>
                <span class="floatL"><b>:</b></span>
                <div class="rightBoxes">
                    <div class="row"><h4>Personal Info</h4></div>
                    <div class="row requiredFieldsRightBoxes">
                        <div class="col">
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck4" />
                                <label for="addTypeCheck4">Last Name</label>
                            </div>
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck5" />
                                <label for="addTypeCheck5">First Name</label>
                            </div>
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck6" />
                                <label for="addTypeCheck6">Middle Name</label>
                            </div>
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck7"/>
                                <label for="addTypeCheck7">NPI</label>
                            </div>
                        </div>
                        <div class="col">
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck8"/>
                                <label for="addTypeCheck8">Social Security Number</label>
                            </div>
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck9"/>
                                <label for="addTypeCheck9">Date of Birth</label>
                            </div>
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck10"/>
                                <label for="addTypeCheck10">Effective Date</label>
                            </div>
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck11"/>
                                <label for="addTypeCheck11">Highest Degree Earned</label>
                            </div>
                        </div>
                        <div class="col">
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck12"/>
                                <label for="addTypeCheck12">Date Degree Awarded</label>
                            </div>
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck13"/>
                                <label for="addTypeCheck13">Phone Number</label>
                            </div>
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck14"/>
                                <label for="addTypeCheck14">Fax Number</label>
                            </div>
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck15"/>
                                <label for="addTypeCheck15">Email Address</label>
                            </div>
                        </div>
                        <div class="col">
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck16"/>
                                <label for="addTypeCheck16">Contact Name</label>
                            </div>
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck17"/>
                                <label for="addTypeCheck17">Contact Phone Number</label>
                            </div>
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck18"/>
                                <label for="addTypeCheck18">Contact Fax Number</label>
                            </div>
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck19"/>
                                <label for="addTypeCheck19">Contact Email Address</label>
                            </div>
                        </div>
                    </div>
                    <div class="row borderTop"><h4>License Info</h4></div>
                    <div class="row requiredFieldsRightBoxes">
                        <div class="col">
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck20" />
                                <label for="addTypeCheck20">Specialty</label>
                            </div>
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck21" />
                                <label for="addTypeCheck21">Type of License/Certification</label>
                            </div>
                        </div>
                        <div class="col">
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck22"/>
                                <label for="addTypeCheck22">License/Certification #</label>
                            </div>
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck23"/>
                                <label for="addTypeCheck23">Original Issue Date</label>
                            </div>
                        </div>
                        <div class="col">
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck24"/>
                                <label for="addTypeCheck24">Renewal End Date</label>
                            </div>
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck25"/>
                                <label for="addTypeCheck25">Issuing State</label>
                            </div>
                        </div>
                    </div>
                    <div class="row borderTop"><h4>Private Practice</h4></div>
                    <div class="row requiredFieldsRightBoxes">
                        <div class="col">
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck26"/>
                                <label for="addTypeCheck26">Private Practice Name</label>
                            </div>
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck27"/>
                                <label for="addTypeCheck27">Group NPI / UMPI</label>
                            </div>
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck28"/>
                                <label for="addTypeCheck28">Practice Address</label>
                            </div>
                        </div>
                        <div class="col">
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck29"/>
                                <label for="addTypeCheck29">Practice Phone Number</label>
                            </div>
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck30"/>
                                <label for="addTypeCheck30">Practice Fax Number</label>
                            </div>
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck31"/>
                                <label for="addTypeCheck31">Billing Address</label>
                            </div>
                        </div>
                        <div class="col">
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck32"/>
                                <label for="addTypeCheck32">FEIN</label>
                            </div>
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck33"/>
                                <label for="addTypeCheck33">MN Tax ID</label>
                            </div>
                        </div>
                        <div class="col">
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck35"/>
                                <label for="addTypeCheck35">EFT Vendor Number</label>
                            </div>
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck36"/>
                                <label for="addTypeCheck36">Remittance Sequence</label>
                            </div>
                        </div>
                    </div>
                    <div class="row borderTop"><h4>Group Practice</h4></div>
                    <div class="row requiredFieldsRightBoxes">
                        <div class="col">
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck37"/>
                                <label for="addTypeCheck37">Private Practice Name</label>
                            </div>
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck38"/>
                                <label for="addTypeCheck38">Group NPI / UMPI</label>
                            </div>
                        </div>
                        <div class="col">
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck39"/>
                                <label for="addTypeCheck39">Practice Address</label>
                            </div>
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck40"/>
                                <label for="addTypeCheck40">Practice Phone Number</label>
                            </div>
                        </div>
                        <div class="col">
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck41"/>
                                <label for="addTypeCheck41">Practice Fax Number</label>
                            </div>
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck42"/>
                                <label for="addTypeCheck42">Reimbursement Address</label>
                            </div>
                        </div>
                    </div>
                    <div class="row borderTop"><h4>Additional Practice</h4></div>
                    <div class="row requiredFieldsRightBoxes">
                        <div class="col">
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck43"/>
                                <label for="addTypeCheck43">Group Name</label>
                            </div>
                        </div>
                        <div class="col">
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck44"/>
                                <label for="addTypeCheck44">Group NPI / UMPI</label>
                            </div>
                        </div>
                        <div class="col">
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck45"/>
                                <label for="addTypeCheck45">Practice Address</label>
                            </div>
                        </div>
                    </div>
                    <div class="row borderTop"><h4>Payment Info</h4></div>
                    <div class="row requiredFieldsRightBoxes">
                        <div class="col">
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck46"/>
                                <label for="addTypeCheck46">Credit Card Type</label>
                            </div>
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck47"/>
                                <label for="addTypeCheck47">Name on Credit Card</label>
                            </div>
                        </div>
                        <div class="col">
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck48"/>
                                <label for="addTypeCheck48">Credit Card Number</label>
                            </div>
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck49"/>
                                <label for="addTypeCheck49">Security Code</label>
                            </div>
                        </div>
                        <div class="col">
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck50"/>
                                <label for="addTypeCheck50">Valid Until</label>
                            </div>
                        </div>
                    </div>
                    <div class="row borderTop"><h4>Provider Statement</h4></div>
                    <div class="row requiredFieldsRightBoxes">
                        <div class="col">
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck51"/>
                                <label for="addTypeCheck51">Provider Disclosure</label>
                            </div>
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck52"/>
                                <label for="addTypeCheck52">Provider Name</label>
                            </div>
                        </div>
                        <div class="col">
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck53"/>
                                <label for="addTypeCheck53">Provider Title</label>
                            </div>
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck54"/>
                                <label for="addTypeCheck54">Provider Signature</label>
                            </div>
                        </div>
                        <div class="col">
                            <div class="row">
                                <input type="checkbox" id="addTypeCheck55"/>
                                <label for="addTypeCheck55">Signed Date</label>
                            </div>
                        </div>
                    </div>
                    <div class="row borderTop"><h4>Agreements</h4></div>
                    <div class="row">
                        <div class="col2">
                            <div class="row">
                                <form:checkbox path="hasAgreement" id="addTypeCheck56"/>
                                <label for="addTypeCheck56">Provider Agreement</label>
                            </div>
                            <div class="row">
                                <form:checkbox path="hasAddendum" id="addTypeCheck57"/>
                                <label for="addTypeCheck57">Provider Agreement Addendum</label>
                            </div>
                        </div>
                        <div class="col3">
                            <div class="row">
                                <form:select path="agreement.id" items="${agreements}" itemLabel="title" itemValue="id">
                                </form:select>
                            </div>
                            <div class="row">
                                <form:select path="addendum.id" items="${addendums}" itemLabel="title" itemValue="id">
                                </form:select>
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
<div class="buttons">
    <a href="${ctx}/admin/viewProviderTypes" class="greyBtn"><span class="btR"><span class="btM">Cancel</span></span></a>
    <a href="javascript:;" class="saveProviderTypeBtn greyBtn"><span class="btR"><span class="btM">Save</span></span></a>
</div>