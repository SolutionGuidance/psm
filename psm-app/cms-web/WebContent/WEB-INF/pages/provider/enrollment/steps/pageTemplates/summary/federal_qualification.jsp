<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:if test="${requestScope['_37_bound'] eq 'Y'}">
<div class="section">
    <div class="leftCol">
        <div class="row">
            <label>Facility Qualification</label>
            <span class="floatL"><b>:</b></span>
            <span >${requestScope['_37_qualificationType']}</span>
        </div>
    </div>
    <div class="clearFixed"></div>
</div>
</c:if>
