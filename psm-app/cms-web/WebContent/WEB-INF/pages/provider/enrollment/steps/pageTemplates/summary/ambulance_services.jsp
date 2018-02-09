<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:if test="${requestScope['_39_bound'] eq 'Y'}">
<div class="section">
    <div class="">
        <div class="row">
            <label>Ambulance Services</label>
            <span class="floatL"><b>:</b></span>
            <span>
                <c:if test="${requestScope['_39_basicServicesInd'] eq 'Y'}">
                    (Basic Service)
                </c:if>
                <c:if test="${requestScope['_39_advancedLifeSupportIndicator'] eq 'Y'}">
                    (Advanced Life Support)
                </c:if>
                <c:if test="${requestScope['_39_airTransportIndicator'] eq 'Y'}">
                    (Air Transport with FAA Air Worthiness Certificate)
                </c:if>
            </span>
        </div>
    </div>
    <div class="clearFixed"></div>
</div>
</c:if>
