<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <%@include file="/WEB-INF/pages/includes/html_head.jsp" %>
        <title><c:out value="${pageTitle}" /></title>
        
    </head>
    <c:set var="selectedMarkup" value='selected="selected"' />
    <body>
        <div id="wrapper">
            <%@include file="/WEB-INF/pages/includes/header.jsp" %>
            <!-- /#header -->

            <div id="mainContent" class="detailPage providerReadOnly">
                <div class="contentWidth">
                    <div class="mainNav">
                        <%@include file="/WEB-INF/pages/includes/logo.jsp" %>
                        <c:set var="activeTab" value="2"></c:set>
                        <%@include file="/WEB-INF/pages/includes/nav.jsp" %>
                    </div>
                    <!-- /.mainNav -->
                    <div class="breadCrumb">
                        <a href="<c:url value="/provider/dashboard/list" />">Enrollments</a>
                        <span>View Enrollment Details</span>
                    </div>
                    
                    <div class="head">
                        <h1>View Enrollment Details</h1>
                        <a class="greyBtn" href="<c:url value="/provider/enrollment/export" />"><span class="btR"><span class="btM"><img alt="" src="<c:url value="/i/icon-pdf.png" />" />Export to PDF</span></span></a>
                        <a class="greyBtn printModalBtn" href="javascript:printThis();"><span class="btR"><span class="btM"><img alt="" src="<c:url value="/i/icon-print.png" />" />Print</span></span></a>
                    </div>
                   	<c:if test="${requestScope['_99_legacyInd'] eq 'Y'}">
                      	<div class="legacyInfo">If you enrolled with DHS prior to November 1st 2013, the data fields below may not be correct. 
                     		Please review your information and make the necessary corrections before you submit it.</div>
                   	</c:if>
                    
                    <div class="tabSection">
                        <div class="detailPanel" style="width: 940px;">
                            <div class="section">
                                <div class="col1">
                                    <div class="row">
                                        <label>Request Type</label>
                                        <span class="floatL"><b>:</b></span>
                                        <span>${requestScope['_99_requestType']}</span>
                                    </div>
                                    <div class="row">
                                        <label>Status</label>
                                        <span class="floatL"><b>:</b></span>
                                        <span>${requestScope['_99_requestStatus'] eq 'Rejected' ? 'Denied' : requestScope['_99_requestStatus']}</span>
                                    </div>
                                </div>
                                <div class="col2">
                                    <div class="row">
                                        <label>Submitted On</label>
                                        <span class="floatL"><b>:</b></span>
                                        <span>${requestScope['_99_submittedOn']}</span>
                                    </div>
                                    <div class="row">
                                        <label>Status Date</label>
                                        <span class="floatL"><b>:</b></span>
                                        <span>${requestScope['_99_statusDate']}</span>
                                    </div>
                                </div>
                                <div class="col3">
                                    <div class="row">
                                        <label>Risk Level &nbsp;&nbsp;&nbsp;&nbsp;:</label>
                                        <span>${requestScope['_99_riskLevel']}</span>
                                    </div>
                                </div>
                            </div>
                            <!-- /.section -->
                            <div class="tl"></div>
                            <div class="tr"></div>
                            <div class="bl"></div>
                            <div class="br"></div>
                        </div>
                        
                        <!-- /.detailPanel -->
                        <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/common/readonly_profile.jsp" %>

                    </div>                    
                </div>
            </div>
            <!-- /#mainContent -->

            <%@include file="/WEB-INF/pages/includes/footer.jsp" %>
            <!-- #footer -->
            <div class="clear"></div>
        </div>
        <!-- /#wrapper -->
        
        <!-- /#modalBackground-->
        <div id="modalBackground"></div>
        <div id="new-modal">
        <%@include file="/WEB-INF/pages/provider/enrollment/steps/modal/print_modal.jsp" %>
        <%@include file="/WEB-INF/pages/provider/enrollment/steps/modal/stale_ticket.jsp" %>
        <%@include file="/WEB-INF/pages/provider/enrollment/steps/modal/superseded_ticket.jsp" %>
        <%@include file="/WEB-INF/pages/provider/enrollment/steps/modal/submit_enrollment.jsp" %>
        <!-- /#saveAsDraftModal-->
        </div>
        <c:if test="${not empty requestScope['flash_popup']}">
            <input type="hidden" id="flashPopUp" value="${requestScope['flash_popup']}" /> 
        </c:if>
    </body>
</html>