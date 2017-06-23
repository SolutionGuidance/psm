 <%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: This is the admin service agents edit/create page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <c:set var="title" value="Functions (Service Admin)"/>
    <%@ include file="/WEB-INF/pages/admin/includes/html_head.jsp" %>
    <body>
        <div id="wrapper">
            <%@ include file="/WEB-INF/pages/includes/header.jsp" %>
            <div id="mainContent">
                <div class="contentWidth">
                    <div class="mainNav">
                        <%@include file="/WEB-INF/pages/includes/logo.jsp" %>
                        <c:set var="activeTab" value="4"></c:set>
                        <%@include file="/WEB-INF/pages/includes/nav.jsp" %>
                    </div>
                    <div class="breadCrumb">
                        Functions
                    </div>
                    <h1>Functions</h1>
                    <div class="tabSection functionTab" id="enrollmentSection">
                        <c:set var="functions_service_active_menu" value="serviceAgents"/>
                        <%@ include file="/WEB-INF/pages/admin/includes/functions_service_nav.jsp" %>
                        <div class="tabContent" id="tabServiceAgents">
                            <c:choose>
                                <c:when test="${empty user.userId}">
                                    <c:set var="actionPath" value="${ctx}/admin/createAgent"/>
                                </c:when>
                                <c:otherwise>
                                    <c:set var="actionPath" value="${ctx}/admin/updateAgent"/>
                                </c:otherwise>
                            </c:choose>
                            <form:form modelAttribute="user" action='${actionPath}' id="userForm" method="post">
                                    <div id="addAgentPanel">
                                        <div class="sideBorder">
                                            <c:choose>
                                                <c:when test="${empty user.userId}"><h3>Add Service Agent</h3></c:when>
                                                <c:otherwise><h3>Edit Service Agent</h3></c:otherwise>
                                            </c:choose>
                                            
                                        </div>
                                        <div class="detailPanel">
                                            <form:hidden path="userId" />
                                            <div class="section">
                                                <div class="wholeCol">
                                                    <div class="row">
                                                        <label>Username</label>
                                                        <span class="floatL"><b>:</b></span>
                                                        <c:choose>
                                                            <c:when test="${empty user.userId}">
		                                                        <form:input path="username" cssClass="normalInput"/>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span><c:out value="${user.username}"/></span>
		                                                        <form:hidden path="username" />
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <div class="row">
                                                        <label>Last Name</label>
                                                        <span class="floatL"><b>:</b></span>
                                                        <form:input path="lastName" cssClass="normalInput"/>
                                                    </div>
                                                    <div class="row">
                                                        <label>First Name</label>
                                                        <span class="floatL"><b>:</b></span>
                                                        <form:input path="firstName" cssClass="normalInput"/>
                                                    </div>
                                                    <div class="row">
                                                        <label>Business Phone</label>
                                                        <span class="floatL"><b>:</b></span>
                                                        <form:input path="businessPhonePart1" cssClass="smallInput"/>
                                                        <span class="sep">-</span>
                                                        <form:input path="businessPhonePart2" cssClass="smallInput"/>
                                                        <span class="sep">-</span>
                                                        <form:input path="businessPhonePart3" cssClass="smallInputP"/>
                                                        <span class="sep"><strong>ext.</strong></span>
                                                        <form:input path="businessPhoneExt" cssClass="smallInput"/>
                                                    </div>
                                                    <div class="row">
                                                        <label>Email</label>
                                                        <span class="floatL"><b>:</b></span>
                                                        <form:input path="email" cssClass="normalInput"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- /.section -->
                                            <div class="bl"></div>
                                            <div class="br"></div>
                                        </div>
                                        <div class="buttons">
                                            <a href="${ctx}/admin/viewAgents" class="greyBtn cancelEditAgentBtn"><span class="btR"><span class="btM">Cancel</span></span></a>
                                            <a id="saveUserBtn" href="javascript:;" class="greyBtn"><span class="btR"><span class="btM">Save</span></span></a>
                                        </div>
                                    </div>
                            </form:form>
                            <!-- /#addAgentPanel -->
                        </div>
                    </div>
                </div>
            </div>
            <!-- /#mainContent -->

            <%@ include file="/WEB-INF/pages/includes/footer.jsp" %>
        </div>
        <!-- /#wrapper -->
    </body>
</html>