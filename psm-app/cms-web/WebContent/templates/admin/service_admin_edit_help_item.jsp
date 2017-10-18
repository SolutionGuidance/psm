<%-- This is the admin help topics edit/create page. --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    {{> admin/includes/html_head title="Functions (Service Admin)" }}
    <body>
        <div id="wrapper">
            {{> includes/header }}
            <div id="mainContent">
                <div class="contentWidth">
                    <div class="mainNav">
                        {{> includes/logo }}
                        {{> includes/nav activeTab4=1 }}
                    </div>
                    <div class="breadCrumb">
                        Functions
                    </div>
                    <h1>Functions</h1>
                    <div class="tabSection functionTab" id="enrollmentSection">
                        {{> admin/includes/functions_service_nav functionsServiceActiveMenuHelpTopics=1 }}
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
                                                <c:when test="${helpItem.id==0}"><a href="{{ctx}}/admin/searchHelp" class="greyBtn"><span class="btR"><span class="btM">Cancel</span></span></a></c:when>
                                                <c:otherwise><a href="{{ctx}}/admin/getHelpItem?helpItemId=${helpItem.id}" class="greyBtn"><span class="btR"><span class="btM">Cancel</span></span></a></c:otherwise>
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
            {{> includes/footer }}
        </div>
        <!-- /#wrapper -->
    </body>
</html>
