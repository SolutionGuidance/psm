<%--
  Copyright 2018 The MITRE Corporation
  
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at
  
      http://www.apache.org/licenses/LICENSE-2.0
  
  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
--%>
<%--
    JSP Fragment for provider type selection form.

 --%>

<%@page import="gov.medicaid.binders.ProviderTypeFormBinder"%>
<%@page import="gov.medicaid.entities.dto.ViewStatics"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:set var="formIdPrefix" value="provider_type"></c:set>

<div class="section">
  <input type="hidden" name="formNames" value="<%= ViewStatics.PROVIDER_TYPE_FORM %>">
  <div class="wholeCol">
    <c:set var="formName" value="_01_providerType"></c:set>
    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
    <label for="${formIdPrefix}_${formName}">
      Provider Type
      <a href="javascript:" class="userHelpLink providerTypeHelpLink">?</a>
    </label>
    <select id="${formIdPrefix}_${formName}" name="${formName}">
      <option value="">Please select</option>
      <c:if test="${empty individualProviderTypes or
                    empty organizationProviderTypes}">
        <%-- no need to group as there is only one group --%>
        <c:if test="${empty individualProviderTypes}">
          <c:forEach var="opt" items="${organizationProviderTypes}">
            <option ${formValue == opt.description ? selectedMarkup : ''}
              value="${opt.description}">
              <c:out value="${opt.description}" />
            </option>
          </c:forEach>
        </c:if>
        <c:if test="${empty organizationProviderTypes}">
          <c:forEach var="opt" items="${individualProviderTypes}">
            <option ${formValue == opt.description ? selectedMarkup : ''}
              value="${opt.description}">
              <c:out value="${opt.description}" />
            </option>
          </c:forEach>
        </c:if>
      </c:if>
      <c:if test="${not empty individualProviderTypes and not
                    empty organizationProviderTypes}">
        <optgroup label="Individual Providers">
          <c:forEach var="opt" items="${individualProviderTypes}">
            <option ${formValue == opt.description ? selectedMarkup : ''}
              value="${opt.description}">
              <c:out value="${opt.description}" />
            </option>
          </c:forEach>
        </optgroup>
        <optgroup label="Organization Providers">
          <c:forEach var="opt" items="${organizationProviderTypes}">
            <option ${formValue == opt.description ? selectedMarkup : ''}
              value="${opt.description}">
              <c:out value="${opt.description}" />
            </option>
          </c:forEach>
        </optgroup>
      </c:if>
    </select>
  </div>
</div>
