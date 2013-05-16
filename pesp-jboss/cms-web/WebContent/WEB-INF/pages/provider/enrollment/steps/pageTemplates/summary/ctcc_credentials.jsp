<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:if test="${requestScope['_30_bound'] eq 'Y'}">
<div class="section">
    <div class="leftCol">
        <div class="row">
            <label>This clinic is a Community Health Board</label>
            <span class="floatL"><b>:</b></span>
            <span >${requestScope['_30_chbIndicator']}</span>
        </div>
    </div>
    <div class="clearFixed"></div>
</div>
</c:if>