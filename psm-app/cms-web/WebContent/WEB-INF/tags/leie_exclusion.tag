<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="h" tagdir="/WEB-INF/tags" %>
<%@ attribute name="exclusion"
              required="true"
              type="gov.medicaid.entities.LeieAutomaticScreeningMatch" %>
<div class="leie-exclusion">
  <c:if test="${not empty exclusion.npi}">
    <div>NPI: ${exclusion.npi}</div>
  </c:if>
  <c:if test="${not empty exclusion.upin}">
    <div>UPIN: ${exclusion.upin}</div>
  </c:if>
  <c:if test="${not empty exclusion.firstName}">
    <div>First name: ${exclusion.firstName}</div>
  </c:if>
  <c:if test="${not empty exclusion.middleName}">
    <div>Middle name: ${exclusion.middleName}</div>
  </c:if>
  <c:if test="${not empty exclusion.lastName}">
    <div>Last name: ${exclusion.lastName}</div>
  </c:if>
  <c:if test="${not empty exclusion.businessName}">
    <div>Business name: ${exclusion.businessName}</div>
  </c:if>
  <div>
    Address:
    <h:address name="exclusion"
        streetAddress="${exclusion.address}"
        city="${exclusion.city}"
        state="${exclusion.state}"
        postalCode="${exclusion.zipCode}" />
  </div>
  <c:if test="${not empty exclusion.dateOfBirth}">
    <div>Date of birth: ${exclusion.dateOfBirth}</div>
  </c:if>
  <div>Excluded: ${exclusion.excludedAt}</div>
  <div>Exclusion type: ${exclusion.exclusionType}</div>
  <div>General: ${exclusion.general}</div>
  <div>Speciality: ${exclusion.speciality}</div>
  <c:if test="${not empty exclusion.reinstantedAt}">
    <div>Reinstated: ${exclusion.reinstantedAt}</div>
  </c:if>
  <c:if test="${not empty exclusion.waivedAt}">
    <div>Waived ${exclusion.waivedAt} in state ${exclusion.waiverState}</div>
  </c:if>
</div>