<div class="row">
    <label>Contact Name</label>
    <span class="floatL"><b>:</b></span>
    <span id="contactName">${requestScope['_02_contactName']}</span>
</div>

<div class="row">
    <label>Contact Email Address</label>
    <span class="floatL"><b>:</b></span>
    <span id="contactEmail">${requestScope['_02_contactEmail']}</span>
</div>

<div class="row">
    <label>Contact Phone Number</label>
    <span class="floatL"><b>:</b></span>
    <span>
        ${requestScope['_02_contactPhone1']}
        <c:if test="${requestScope['_02_contactPhone2'] ne ''}"> - </c:if>
        ${requestScope['_02_contactPhone2']}
        <c:if test="${requestScope['_02_contactPhone3'] ne ''}"> - </c:if>
        ${requestScope['_02_contactPhone3']}
        <c:if test="${requestScope['_02_contactPhone4'] ne ''}"> ext. </c:if>
        ${requestScope['_02_contactPhone4']}
    </span>
</div>
