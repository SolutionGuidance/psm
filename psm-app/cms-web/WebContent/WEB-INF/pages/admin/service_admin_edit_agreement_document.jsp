 <%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: This is the admin agreement document edit/create page.
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
                            <c:choose>
                                <c:when test="${agreementDocument.id==0}">
                                    <c:set var="actionPath" value="${ctx}/admin/createAgreementDocument"/>
                                </c:when>
                                <c:otherwise>
                                    <c:set var="actionPath" value="${ctx}/admin/updateAgreementDocument"/>
                                </c:otherwise>
                            </c:choose>
                            <form:form modelAttribute="agreementDocument" action='${actionPath}' id="agreementDocumentForm" method="post">
                                <form:hidden path="id" />
                                <form:hidden path="type" />
                                <div id="addAgreementPanel">
                                    <div class="sideBorder">
                                        <c:choose>
                                            <c:when test="${agreementDocument.id==0}"><h3>Add Agreement Document</h3></c:when>
                                            <c:otherwise><h3>Edit Agreement Document</h3></c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="newEnrollmentPanel">
                                        <div class="section">
                                            <div class="wholeCol">
                                                <div class="row">
                                                    <label>Agreement Title</label>
                                                    <span class="floatL"><b>:</b></span>
                                                    <form:input path="title" cssClass="text longInput"/>
                                                </div>
                                                <div class="row">
                                                    <label>Content</label>
                                                    <span class="floatL"><b>:</b></span>
                                                    <form:textarea path="text" rows="20" cols="50" cssClass="longTextArea text"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="bl"></div>
                                        <div class="br"></div>
                                    </div>
                                    <div class="buttons">
                                        <a href="${ctx}/admin/viewAgreementDocuments" class="cancelAddAgreementBtn greyBtn"><span class="btR"><span class="btM">Cancel</span></span></a>
                                        <a href="javascript:;" class="saveAgreementDocumentBtn greyBtn"><span class="btR"><span class="btM">Save</span></span></a>
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
        <script type="text/javascript">
			(function($) {
				$(document).ready(function() {
					$('#text').wysiwyg();
				});
			})(jQuery);
		</script>
    </body>
</html>