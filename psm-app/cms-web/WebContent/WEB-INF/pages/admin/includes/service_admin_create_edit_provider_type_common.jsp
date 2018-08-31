<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<form:form id="providerTypeForm" modelAttribute="providerType" action="${editCreateProviderTypeFormAction}" method="post">
  <form:hidden path="code"/>
  <div id="addProviderPanel">
    <div class="newEnrollmentPanel jerrish">
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
                <c:forEach var="doc" items="${selectedAgreements}">
                  <div class="row">
                    <input
                      id="selected_provider_agreement_${doc.id}"
                      type="checkbox"
                      name="providerAgreements"
                      checked="checked"
                      value="${doc.id}"
                    />
                    <label for="selected_provider_agreement_${doc.id}">${doc.title}</label>
                  </div>
                </c:forEach>
                <c:forEach var="doc" items="${remainingAgreements}">
                  <div class="row">
                    <input
                      id="remaining_provider_agreement_${doc.id}"
                      type="checkbox"
                      name="providerAgreements"
                      value="${doc.id}"
                    />
                    <label for="remaining_provider_agreement_${doc.id}">${doc.title}</label>
                  </div>
                </c:forEach>
              </div>
            </div>
          </div>
        </div>
        <div class="tableHeader"><span>Applicable Licenses</span></div>
        <div class="wholeCol">
          <div id="providerTypeLicensesContainer">
            <c:forEach var="selectedLicenseCode" items="${selectedLicenseCodes}">
              <div class="providerTypeLicenseRow">
                <label>
                  <div class="providerTypeLicenseRowLabel">Applicable License</div>
                  <select class="providerTypeLicenses" name="providerLicenses">
                    <c:forEach var="licenseType" items="${allLicenseTypes}">
                      <option
                        value="${licenseType.code}"
                        ${licenseType.code == selectedLicenseCode ? 'selected' : ''}
                      >
                        ${licenseType.description}
                      </option>
                    </c:forEach>
                  </select>
                  <a href="javascript:;" class="remove">REMOVE</a>
                </label>
              </div>
            </c:forEach>
          </div>
          <div class="row">
            <a href="javascript:;" id="addProviderTypeLicense">+ Add Another Applicable License</a>
          </div>
        </div>
        <div class="bl"></div>
        <div class="br"></div>
      </div>
      <div class="buttons">
        <a href="${ctx}/admin/viewProviderTypes" class="greyBtn">Cancel</a>
        <button class="saveProviderTypeBtn greyBtn" type="submit">Save</button>
      </div>
    </div>
  </div><!--/ #addProviderPanel -->
</form:form>
<div id="licenseTemplate" class="providerTypeLicenseRow">
  <label>
    <div class="providerTypeLicenseRowLabel">Applicable License</div>
    <select class="providerTypeLicenses" name="providerLicenses">
      <c:forEach var="licenseType" items="${allLicenseTypes}">
        <option value="${licenseType.code}">${licenseType.description}</option>
      </c:forEach>
    </select>
    <a href="javascript:;" class="remove">REMOVE</a>
  </label>
</div>
