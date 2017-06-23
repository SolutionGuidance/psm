 <%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: This is the admin provider types create page.
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
                    
                    <c:if test="${not empty requestScope['flash_error']}">
                        <div class="clear"></div>
                        <div class="errorInfo formErrorMarker" style="display: block;">
                            <h3>Please correct the following errors:</h3>
                            <p class="bindingError"><c:out value="${requestScope['flash_error']}"></c:out></p>        
                            <div class="tl"></div>
                            <div class="tr"></div>
                            <div class="bl"></div>
                            <div class="br"></div>
                        </div>
                        <div class="clear"></div>
                    </c:if>
                    <div class="tabSection functionTab" id="enrollmentSection">
                        <c:set var="functions_service_active_menu" value="providerTypes"/>
                        <%@ include file="/WEB-INF/pages/admin/includes/functions_service_nav.jsp" %>
                        
                        
                        <div class="tabContent" id="tabProviderTypes">
                            <form:form id="providerTypeForm" modelAttribute="providerType" action="${ctx}/admin/createProviderType" method="post">
                                <div id="addProviderPanel">
                                    <div class="sideBorder"><h3>Add Provider Type</h3></div>
                                    <%@ include file="/WEB-INF/pages/admin/includes/service_admin_create_edit_provider_type_common.jsp" %>
                                </div>
                            </form:form>
                            <!--/ #addProviderPanel -->
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