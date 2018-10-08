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
