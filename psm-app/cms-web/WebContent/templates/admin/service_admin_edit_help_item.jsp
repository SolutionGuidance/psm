 <%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: This is the admin help topics edit/create page.
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
                        <c:set var="functions_service_active_menu" value="helpTopics"/>
                        <%@ include file="/WEB-INF/pages/admin/includes/functions_service_nav.jsp" %>
                        <div class="tabContent" id="tabHelpTopics">
                            <c:choose>
                                <c:when test="${helpItem.id==0}">
                                    <c:set var="actionPath" value="${ctx}/admin/createHelpItem"/>
                                </c:when>
                                <c:otherwise>
                                    <c:set var="actionPath" value="${ctx}/admin/updateHelpItem"/>
                                </c:otherwise>
                            </c:choose>
                            <form:form modelAttribute="helpItem" action='${actionPath}' id="helpTopicForm" method="post">
                                <form:hidden path="id" />
                                <div id="editHelpTopicPanel">
                                    <div>
                                        <div class="sideBorder"><h3>
                                            <c:choose>
                                                <c:when test="${helpItem.id==0}">Add Help Topic</c:when>
                                                <c:otherwise>Edit Help</c:otherwise>
                                            </c:choose>
                                        </h3></div>
                                        <div class="newEnrollmentPanel">
                                            <div class="section">
                                                <div class="wholeCol">
                                                    <div class="row">
                                                        <label>Topic Title</label>
                                                        <span class="floatL"><b>:</b></span>
                                                        <form:input path="title" cssClass="text longInput"/>
                                                    </div>
                                                    <div class="row">
                                                        <label>Content</label>
                                                        <span class="floatL"><b>:</b></span>
                                                        <form:textarea path="description" rows="20" cols="50" cssClass="longTextArea text"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="bl"></div>
                                            <div class="br"></div>
                                        </div>
                                        <div class="buttons">
                                            <c:choose>
                                                <c:when test="${helpItem.id==0}"><a href="${ctx}/admin/searchHelp" class="greyBtn"><span class="btR"><span class="btM">Cancel</span></span></a></c:when>
                                                <c:otherwise><a href="${ctx}/admin/getHelpItem?helpItemId=${helpItem.id}" class="greyBtn"><span class="btR"><span class="btM">Cancel</span></span></a></c:otherwise>
                                            </c:choose>
                                            <a href="javascript:;" class="saveHelpTopicBtn greyBtn"><span class="btR"><span class="btM">Save</span></span></a>
                                        </div>
                                    </div>
                                </div>
                            </form:form>
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