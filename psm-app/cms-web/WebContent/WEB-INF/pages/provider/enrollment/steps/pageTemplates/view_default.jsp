<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<div id="tabPractice" class="tabContent tabDefault">
    <div class="tableContainer">
        <div class="bottomPanel">
        <c:forEach var="formName" items="${viewModel.currentFormNames}">
            <c:forEach var="entry" items="${summaryViewRegistry}">
                <c:if test="${formName eq entry.key}">
                    <jsp:include page="${entry.value}" />
                </c:if>
            </c:forEach>
        </c:forEach>
        </div>
        <div class="bl"></div>
        <div class="br"></div>
    </div>
</div>
