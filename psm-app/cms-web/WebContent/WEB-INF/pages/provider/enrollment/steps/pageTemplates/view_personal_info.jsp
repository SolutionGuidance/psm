<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<div id="tabPersonal" class="tabContent">
    <div class="topPanel">
        <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/common/person_info.jsp" %>
    </div>
    <!-- /.topPanel -->
    <c:choose>
        <c:when test="${'Y' != requestScope['_02_useProviderAsContact']}">
            <div class="tableHeader">
                <span>Contact Info</span>
            </div>
            <!-- /.tableHeader -->
            <div class="bottomPanel">
                <div class="leftCol">
                    <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/common/contact_info.jsp" %>
                </div>
                <div class="bl"></div>
                <div class="br"></div>
            </div>
            <!-- /.bottomPanel -->
        </c:when>
        <c:otherwise>
            <div class="bottomPanel"></div>
        </c:otherwise>
    </c:choose>
</div>
<!-- /#tabPersonal -->
