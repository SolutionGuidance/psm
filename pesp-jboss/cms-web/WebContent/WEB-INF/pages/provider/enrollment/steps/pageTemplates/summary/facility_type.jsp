<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:if test="${requestScope['_36_bound'] eq 'Y'}">
<div class="section">
    <div class="leftCol">
	    <div class="row">
	        <label>Facility Type</label>
	        <span class="floatL"><b>:</b></span>
	        <span >${requestScope['_36_facilityType']}</span>
	    </div>
    </div>
    <div class="clearFixed"></div>
</div>
</c:if>