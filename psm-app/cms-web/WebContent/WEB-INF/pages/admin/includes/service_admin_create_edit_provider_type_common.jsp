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
            <label for="createEditProviderTypeProviderType">Provider Type</label>
            <form:input id="createEditProviderTypeProviderType" path="description" cssClass="text"/>
        </div>
        <div class="tableHeader"><span>Agreements and Addendums</span></div>
        <div class="wholeCol">
            <div class="row">
                	<div class="row">
                        <div class="col2">
                            <div class="row">
                                <form:checkbox id="addTypeCheck56" path="hasAgreement"/>
                                <label for="addTypeCheck56">Provider Agreement</label>
                            </div>
                            <div class="row">
                                <form:checkbox id="addTypeCheck57" path="hasAddendum"/>
                                <label for="addTypeCheck57">Provider Agreement Addendum</label>
                            </div>
                        </div>
                        <div class="col3">
                            <div class="row">
                                <form:select title="Agreement" path="agreement.id" items="${agreements}" itemLabel="title" itemValue="id">
                                </form:select>
                            </div>
                            <div class="row">
                                <form:select title="Addendum" path="addendum.id" items="${addendums}" itemLabel="title" itemValue="id">
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
    <a href="${ctx}/admin/viewProviderTypes" class="greyBtn">Cancel</a>
    <button class="saveProviderTypeBtn greyBtn" type="submit">Save</button>
</div>
