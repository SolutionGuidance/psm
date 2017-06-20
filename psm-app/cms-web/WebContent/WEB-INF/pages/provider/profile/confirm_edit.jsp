<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <%@include file="/WEB-INF/pages/includes/html_head.jsp" %>
        <title>Confirm Action</title>
    </head>
    <body>
        <div id="wrapper">
            <%@include file="/WEB-INF/pages/includes/header.jsp" %>
            <!-- /#header -->

            <div id="mainContent" class="detailPage">
                <div class="contentWidth">
                    <div class="mainNav">
                        <%@include file="/WEB-INF/pages/includes/logo.jsp" %>
                        <c:set var="activeTab" value="3" />
                        <%@include file="/WEB-INF/pages/includes/nav.jsp" %>
                    </div>
                    <!-- /.mainNav -->
                    <div class="breadCrumb">
                        <a href="<c:url value="/provider/search/approved?statuses=Approved" />">Enrollments</a>
                        <span>Confirm Edit</span>
                    </div>
                    
                    <div class="head">
                        <h1>Confirm Edit</h1>
                    </div>
                    <div class="clearFixed"></div>
                    
                    <%@include file="/WEB-INF/pages/includes/flash.jsp" %>
                    
                    <div class="dashboardPanel">
                        <div class="tableDataButtons buttonBox">
							<div class="newEnrollmentPanel">
								<p class="confirm">
								   We found an existing ${requestType} draft for this profile. How do you wish to proceed?
								</p>
								<div class="br"></div>
								<div class="tr"></div>
								<div class="tl"></div>
								<div class="bl"></div>
							</div>
                            
                            <c:url var="reuseEditProfileLink" value="/provider/enrollment/view">
                               <c:param name="id" value="${ticketId}"></c:param>
                            </c:url>
                            
                            <c:url var="newEditProfileLink" value="/provider/enrollment/edit">
                               <c:param name="profileId" value="${profileId}"></c:param>
                            </c:url>
                            <c:if test="${requestType eq 'Renewal'}">
	                            <c:url var="newEditProfileLink" value="/provider/enrollment/renew">
	                               <c:param name="profileId" value="${profileId}"></c:param>
	                            </c:url>
                            </c:if>
                            
                            <a href="${reuseEditProfileLink}" class="purpleBtn"><span class="btR"><span class="btM">Continue Editing</span></span></a>
                            <a href="${newEditProfileLink}" class="purpleBtn"><span class="btR"><span class="btM">Start A New Draft</span></span></a>
                            
                           <div class="clearFixed"></div>
                           <div class="tl"></div>
                           <div class="tr"></div>
                        </div>
                    </div>
                    <!-- /.dashboardPanel -->
                </div>
            </div>
            <!-- /#mainContent -->

            <%@include file="/WEB-INF/pages/includes/footer.jsp" %>
            <!-- #footer -->
        </div>
        <!-- /#wrapper -->
    </body>
</html>