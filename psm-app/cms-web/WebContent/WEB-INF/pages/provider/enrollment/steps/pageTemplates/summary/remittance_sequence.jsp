<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:if test="${requestScope['_23_bound'] eq 'Y'}">
<div class="section">
    <div class="wholeCol">
        <div class="row">
            <label>Remittance Sequence</label>
            <c:choose>
                <c:when test="${requestScope['_23_remittanceSequenceNumber'] eq 'PATIENT_ACCOUNT_OR_OWN_REFERENCE_ORDER'}">
                    <span>Patient Account or Own Reference Number Order</span>
                </c:when>
                <c:when test="${requestScope['_23_remittanceSequenceNumber'] eq 'DHS_TRANSACTION_CONTROL_ORDER'}">
                    <span>DHS Transaction Control Number Order</span>
                </c:when>
                <c:when test="${requestScope['_23_remittanceSequenceNumber'] eq 'RECIPIENT_MHCP_ID_NUMBER_ORDER'}">
                    <span>Recipient MHCP ID Number Order</span>
                </c:when>
            </c:choose>
        </div>
    <div class="clearFixed"></div>
    </div>
</div>
</c:if>
