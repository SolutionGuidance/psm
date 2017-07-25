<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:if test="${requestScope['_26_bound'] eq 'Y'}">
<div class="section">
    <div class="leftCol">
        <c:if test="${requestScope['_26_countyIndicator'] eq 'Y'}">
            <div class="row">
                <label>County</label>
                <span class="floatL"><b>:</b></span>
                <span >${requestScope['_26_countyName']}</span>
            </div>
        </c:if>
        <c:if test="${requestScope['_26_countyIndicator'] eq 'N'}">
            <div class="row">
                <label>Have a contract with a county</label>
                <span class="floatL"><b>:</b></span>
                <span >Y</span>
            </div>
        </c:if>
    </div>
    <div class="clearFixed"></div>
</div>
</c:if>