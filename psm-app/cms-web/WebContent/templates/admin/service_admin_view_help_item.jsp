 <%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: This is the admin help topic view page.
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
                            <div id="viewHelpTopicPanel">
                                <div>
                                    <div class="sideBorder">
                                        <h3><c:out value="${helpItem.title}"/></h3>
                                        <a href="javascript:;" class="deleteHelpTopicBtn greyBtn"><span class="btR"><span class="btM">Delete</span></span></a>
                                        <a href="${ctx}/admin/editHelpItem?helpItemId=${helpItem.id}" class="editHelpTopicBtn purpleBtn"><span class="btR"><span class="btM">Edit</span></span></a>    
                                    </div>
                                    <div class="newEnrollmentPanel">
                                        <div class="section">
                                            <div class="wholeCol">
                                                <c:out value="${helpItem.description}"/>
                                            </div>
                                        </div>
                                        <div class="bl"></div>
                                        <div class="br"></div>
                                    </div>
                                    <div class="buttons">
                                        <a href="${ctx}/admin/searchHelp" class="greyBtn"><span class="btR"><span class="btM">Back</span></span></a>
                                    </div>
                                </div>
                                <!-- /#viewHelpTopicPanel -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /#mainContent -->

            <%@ include file="/WEB-INF/pages/includes/footer.jsp" %>
        </div>
        <!-- /#wrapper -->
        <!-- modal -->
        <div id="modalBackground"></div>
        <div id="modal">
            <div class="modal" id="deleteHelpTopicModal">
                <div class="modalHeader">
                    <div class="corner">
                        <div class="cornerR">
                            <div class="cornerM">
                                <a href="javascript:;" class="closeModal">CLOSE</a>
                                <h2>Delete Help</h2>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.modalHeader -->
                <div class="modalBody">
                    <div class="corner">
                        <div class="cornerR">
                            <div class="cornerM">
                                <div class="container">
                                    <p>Are you sure you want to delete "<c:out value='${helpItem.title}'/>""?</p>
                                    <div class="buttons">
                                        <a href="javascript:;" rel="${ctx}/admin/deleteHelpItem?helpItemId=${helpItem.id}" class="purpleBtn deleteOKBtn"><span class="btR"><span class="btM">Delete</span></span></a>
                                        <a href="javascript:;" class="greyBtn closeModal cancelBtn"><span class="btR"><span class="btM">Cancel</span></span></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.modalBody -->
                <div class="modalFooter">
                    <div class="corner">
                        <div class="cornerR">
                            <div class="cornerM">
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.modalFooter -->
            </div>
        </div>
    </body>
</html>