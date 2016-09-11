 <%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: This is the admin provider types create/edit common page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<div class="newEnrollmentPanel">
    <div class="section">
        <div class="wholeCol">
            <label>Provider Type</label>
            <span class="floatL"><b>:</b></span>
            <form:input path="description" cssClass="text"/>
        </div>
        <div class="tableHeader"><span>Agreements and Addendums</span></div>
        <div class="wholeCol">
            <div class="row">
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
    <div class="bl"></div>
    <div class="br"></div>
</div>
<div class="buttons">
    <a href="${ctx}/admin/viewProviderTypes" class="greyBtn"><span class="btR"><span class="btM">Cancel</span></span></a>
    <a href="javascript:;" class="saveProviderTypeBtn greyBtn"><span class="btR"><span class="btM">Save</span></span></a>
</div>