<%--
    JSP Fragment for provider type selection form.

    @author j3_guile
    @version 1.0
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
    <label for="${formIdPrefix}_${formName}">Provider Type</label>
    <span class="floatL">
      <b>:</b>
    </span>
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
