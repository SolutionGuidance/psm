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

            <div id="mainContent" class="detailPage">
                <div class="contentWidth">
                    <div class="mainNav">
                        <%@include file="/WEB-INF/pages/includes/logo.jsp" %>
                        <c:set var="activeTab" value="2"></c:set>
                        <%@include file="/WEB-INF/pages/includes/nav.jsp" %>
                    </div>
                    <!-- /.mainNav -->
                    <div class="breadCrumb">
                        <a href="<c:url value="/cms/provider/dashboard/drafts" />">Enrollments</a>
                        <span>Edit Enrollment</span>
                    </div>
                    <div class="head">
                        <h1>Edit Enrollment</h1>
                    </div>
                    
                    <div class="tabSection">
                    
                        <form action="<c:url value="/provider/enrollment/steps/rebind" />" id="changeProviderTypeForm" method="post" enctype="multipart/form-data">
                        <c:if test="${isReopened}">
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
                        
                        </c:if>
                         
					     <div class="detailPanel firstRegistrant" style="width: 940px;">
					     
					         <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/default/provider_type.jsp" %>
					         <!-- /.section -->
					         <div class="tl"></div>
					         <div class="tr"></div>
					         <div class="bl"></div>
					         <div class="br"></div>
					     </div>
					     </form>
					     
                        <!-- /.errorInfo -->
                        <div class="clear"></div>
                        <%@include file="/WEB-INF/pages/provider/enrollment/steps/errors.jsp" %>
					     
                        <!-- /.detailPanel -->
                        <div class="tabHead" style="width: 958px;">
                            <div class="tabR">
                                <div class="tabM">
                                    <c:forEach var="tabName" items="${viewModel.tabNames}" varStatus="status">
                                        <c:if test="${tabName ne 'Summary Information'}">
	                                        <c:set var="tabLabel" value=""></c:set>
	                                        <c:set var="tabActiveCls" value=""></c:set>
	                                        <%@include file="/WEB-INF/pages/provider/enrollment/steps/pageTemplates/common/tab_name_mapping.jsp" %>
	                                        <c:if test="${viewModel.currentTab eq tabName}"><c:set var="tabActiveCls" value="active"></c:set></c:if>
	                                        <c:url var="tabLink" value="/provider/enrollment/jump"><c:param name="page" value="${tabName}"></c:param></c:url>
		                                    <a href="javascript:submitFormById('enrollmentForm', '${tabLink}')" class="tab ${tabActiveCls}"><span class="aR"><span class="aM">${tabLabel}</span></span></a>
                                        </c:if>
                                    </c:forEach>
                                    <%-- always show notes tab on edit --%>
                                    <c:if test="${viewModel.currentTab eq 'Notes'}"><c:set var="tabActiveCls" value="active"></c:set></c:if>
                                    <c:url var="tabLink" value="/provider/enrollment/jump"><c:param name="page" value="Notes"></c:param></c:url>
                                    <a href="javascript:submitFormById('enrollmentForm', '${tabLink}')" class="tab ${tabActiveCls}"><span class="aR"><span class="aM">Notes</span></span></a>
                                </div>
                            </div>
                        </div>
                        
                        <div id="tabPersonal" class="tabContent">
							<div class="requiredInfo">
							    <span class="required">*</span> Indicates Required Fields
							</div>
							<!-- /.requiredInfo -->
							
							<div class="editTabWrapper">
                                <form action="" id="enrollmentForm" method="post" enctype="multipart/form-data">
                                <input type="hidden" name="pageName" value="${pageName}"/>
								<c:choose>
									<c:when test="${viewModel.currentTab eq 'Notes'}">
								        <%@include file="/WEB-INF/pages/provider/notes.jsp" %>
									</c:when>
									<c:otherwise>
										<c:forEach var="formName" items="${viewModel.currentFormNames}">
										    <c:forEach var="entry" items="${viewRegistry}">
										        <c:if test="${formName eq entry.key}">
										            <jsp:include page="${entry.value}" />
										        </c:if>
										    </c:forEach>
										</c:forEach>
									</c:otherwise>
								</c:choose>
								</form>
							    <div class="br"></div>
							    <div class="bl"></div>
							</div>
							
							<c:choose>
							    <c:when test="${viewModel.currentTab eq 'Notes'}">
								    <div class="buttonBox">
                                        <c:url var="cancelUrl" value="/provider/search/pending?statuses=Pending&showFilterPanel=true" />
								        <c:url var="submitUrl" value="/provider/enrollment/saveNote" />
                                        <a class="greyBtn" href="${cancelUrl}"><span class="btR"><span class="btM">Cancel</span></span></a>
								        <a href="javascript:submitFormById('enrollmentForm', '${submitUrl}')" class="purpleBtn"><span class="btR"><span class="btM">Save Note</span></span></a>
								    </div>
							    </c:when>
								<c:when test="${isReopened}">
	                                <div class="buttonBox">
	                                    <c:url var="resubmitUrl" value="/provider/enrollment/resubmitWithChanges" />
	                                    <c:url var="cancelUrl" value="/provider/search/pending?statuses=Pending&showFilterPanel=true" />
	                                    
	                                    <a class="greyBtn" href="${cancelUrl}"><span class="btR"><span class="btM">Cancel</span></span></a>
	                                    <a href="javascript:submitFormById('enrollmentForm', '${resubmitUrl}')" class="purpleBtn"><span class="btR"><span class="btM">Re-Submit Enrollment</span></span></a>
	                                </div>
								</c:when>
								<c:otherwise>
									<div class="buttonBox">
									    <input type="hidden" name="pageName" value="${pageName}"/>
									    <c:url var="saveUrl" value="/provider/enrollment/save" />
									    <c:url var="submitUrl" value="/provider/enrollment/submit" />
									    <c:url var="cancelUrl" value="/provider/dashboard/drafts" />
									    <c:url var="prevPageUrl" value="/provider/enrollment/steps/prev" />
									    
									    <a class="greyBtn" href="${cancelUrl}"><span class="btR"><span class="btM">Cancel</span></span></a>
								        <a href="javascript:submitFormById('enrollmentForm', '${submitUrl}')" class="purpleBtn"><span class="btR"><span class="btM">Submit Enrollment</span></span></a>
									    <a href="javascript:submitFormById('enrollmentForm', '${saveUrl}')" class="greyBtn"><span class="btR"><span class="btM">Save as Draft</span></span></a>
									</div>
								</c:otherwise>
							</c:choose>
							
							<!-- /.buttonBox -->
							</form>
                        </div>
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
        <%@include file="/WEB-INF/pages/provider/enrollment/steps/modal/save_as_draft.jsp" %>
        <%@include file="/WEB-INF/pages/provider/enrollment/steps/modal/practice_lookup.jsp" %>
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