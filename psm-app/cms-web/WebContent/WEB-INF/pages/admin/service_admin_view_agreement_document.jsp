 <%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: This is the admin agreement document view page.
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
                        <c:set var="functions_service_active_menu" value="agreement"/>
                        <%@ include file="/WEB-INF/pages/admin/includes/functions_service_nav.jsp" %>
                        <div class="tabContent" id="tabAgreement">
                            <div id="viewAgreementPanel">
                                <div class="sideBorder">
                                    <h3><c:out value="${agreementDocument.title}"/></h3>
                                    <a href="${ctx}/admin/viewAgreementDocuments" class="closeViewAgreementBtn greyBtn"><span class="btR"><span class="btM">Close</span></span></a>
                                    <a href="javascript:window.print();" class="greyBtn printBtn"><span class="btR"><span class="btM"><img src="${ctx}/i/icon-print.png" alt="" />Print</span></span></a>    
                                </div>
                                <div class="newEnrollmentPanel">
                                    <div class="section">
                                        <div class="wholeCol">
                                            ${agreementDocument.text}
                                        </div>
                                    </div>
                                    <div class="bl"></div>
                                    <div class="br"></div>
                                </div>
                            </div>
                            <!-- /#viewAgreementPanel -->
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