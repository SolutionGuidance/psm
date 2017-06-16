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
        <div id="wrapper" class="${viewModel.individual ? '' : 'homeHealthAgency'}">
            <%@include file="/WEB-INF/pages/includes/header.jsp" %>
            <!-- /#header -->

            <div id="mainContent" class="detailPage">
                <div class="contentWidth">
                    <div class="mainNav">
                        <%@include file="/WEB-INF/pages/includes/logo.jsp" %>
                        <c:set var="activeTab" value="2"></c:set>
                        <%@include file="/WEB-INF/pages/includes/nav.jsp" %>
                    </div>
                    <!-- /.mainNav -->

                    <c:choose>
                        <c:when test="${isRenewalEnrollment}">
		                    <div class="breadCrumb">
		                        <a href="<c:url value="/provider/dashboard/drafts" />">Enrollments</a>
		                        <span>Enrollment Renewal</span>
		                    </div>
		                    <div class="head">
		                        <h1>Enrollment Renewal</h1>
		                    </div>
                           	<c:if test="${requestScope['_99_legacyInd'] eq 'Y'}">
                            	<div class="legacyInfo">If you enrolled with DHS prior to November 1st 2013, the data fields below may not be correct. 
                            		Please review your information and make the necessary corrections before you submit it.</div>
                           	</c:if>
                        </c:when>
                        <c:otherwise>
                            <div class="breadCrumb">
                                <a href="<c:url value="/provider/dashboard/drafts" />">Enrollments</a>
                                <span>Register New Enrollment</span>
		                    </div>
		                    <div class="head">
			                    <c:choose>
			                        <c:when test="${pageName eq 'Provider Type Page'}">
				                        <h1>Select Provider Type</h1>
			                        </c:when>
			                        <c:otherwise>
				                        <h1><c:out value="${requestScope['_01_providerType']}" /> Enrollment Application</h1>
			                        </c:otherwise>
			                    </c:choose>                    
		                    </div>
                        </c:otherwise>
                    </c:choose>                    

					<c:if test="${not empty requestScope['flash_info']}">
					    <div class="info"><c:out value="${requestScope['flash_info']}"></c:out></div>
					</c:if>
					
                    <c:choose>
                        <c:when test="${pageName eq 'Provider Type Page'}">
		                    <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/select_type.jsp" %>
                        </c:when>
                        <c:when test="${pageName eq 'Summary Information'}">
		                    <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/summary.jsp" %>
                        </c:when>
                        <c:otherwise>
                            <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/default.jsp" %>
                        </c:otherwise>
                    </c:choose>                    
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
        <%@include file="/WEB-INF/pages/provider/enrollment/steps/modal/save_as_draft.jsp" %>
        <%@include file="/WEB-INF/pages/provider/enrollment/steps/modal/practice_lookup.jsp" %>
        <%@include file="/WEB-INF/pages/provider/enrollment/steps/modal/stale_ticket.jsp" %>
        <%@include file="/WEB-INF/pages/provider/enrollment/steps/modal/superseded_ticket.jsp" %>
        <%@include file="/WEB-INF/pages/provider/enrollment/steps/modal/submit_enrollment.jsp" %>
        <%@include file="/WEB-INF/pages/provider/enrollment/steps/modal/print_modal.jsp" %>
        <%@include file="/WEB-INF/pages/provider/enrollment/steps/modal/definitions_modal.jsp" %>
        <!-- /#saveAsDraftModal-->
        </div>
        <c:if test="${not empty requestScope['flash_popup']}">
            <input type="hidden" id="flashPopUp" value="${requestScope['flash_popup']}" /> 
        </c:if>
    </body>
</html>