<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <%@include file="/WEB-INF/pages/includes/html_head.jsp" %>
        <title>Import Profiles</title>
    </head>
    <body>
        <div id="wrapper">
            <%@include file="/WEB-INF/pages/includes/header.jsp" %>
            <!-- /#header -->

            <div id="mainContent" class="detailPage">
                <div class="contentWidth">
                    <div class="mainNav">
                        <%@include file="/WEB-INF/pages/includes/logo.jsp" %>
                        <%@include file="/WEB-INF/pages/includes/nav.jsp" %>
                    </div>
                    <!-- /.mainNav -->
                    <div class="breadCrumb">
                        <a href="<c:url value="/provider/dashboard/setup" />">Account Setup</a>
                        <span class="text">Import Profiles</span>
                    </div>
                    <div class="head">
                        <h1>Import Profiles</h1>
                    </div>
                    <div class="clearFixed"></div>
                    
                    <%@include file="/WEB-INF/pages/includes/flash.jsp" %>
                    
                    <div class="dashboardPanel">
                        <div class="tableData">
	                        <form id="importProfilesForm" action="<c:url value="/provider/onboarding/list" />" method="post">
                            <div class="tableTitle">
                                <h2>Profiles</h2>
                            </div>
                            <div>
                                <input type="hidden" name="systemId" value="${systemId}"></input>
                                <input type="hidden" name="accountId" value="${accountId}"></input>
                                <input type="hidden" name="hash" value="${hash}"></input>
                            </div>
                            <table cellpadding="0" cellspacing="0" class="generalTable">
                                <thead>
                                    <tr>
                                        <c:if test="${not empty profiles}">
                                            <th class="alignCenter"><span class="sep"></span></th>
                                        </c:if>
                                        <th class="alignCenter">NPI / UMPI<span class="sep"></span></th>
                                        <th class="alignCenter">Provider Type<span class="sep"></span></th>
                                        <th class="alignCenter">Provider Name<span class="sep"></span></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="profile" items="${profiles}">
                                    <tr>
                                        <td class="alignCenter">
                                            <input type="checkbox" name="profileIds" value="${profile.profileId}" />
                                        </td>
                                        <td><c:out value="${profile.entity.npi}" /></td>
                                        <td><c:out value="${profile.entity.providerType.description}" /></td>
                                        <td><c:out value="${profile.entity.name}" /></td>
                                    </tr>
                                    </c:forEach>
                                    <c:if test="${empty profiles}">
                                        <tr>
                                            <td colspan="3">No profiles found.</td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                            <div class="clearFixed"></div>
                            <div class="tl"></div>
                            <div class="tr"></div>
	                        </form>
                        </div>
                        <!-- /.tableData -->
                        <div class="sideBar">
                            <div class="notificationsPanel panel">
                                <div class="panelHeader">
                                    <h2>Help</h2>
                                </div>
                                <div class="panelSection">
                                    <ul>
	                                    <li>
		                                    <p>
			                                    Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed
			                                    do eiusmod tempor incididunt ut labore et dolore magna aliqua.
			                                    Ut enim ad minim veniam, quis nostrud exercitation ullamco
			                                    laboris nisi ut aliquip ex ea commodo consequat. Duis aute
			                                    irure dolor in reprehenderit in voluptate velit esse cillum
			                                    dolore eu fugiat nulla pariatur. Excepteur sint occaecat
			                                    cupidatat non proident, sunt in culpa qui officia deserunt
			                                    mollit anim id est laborum.
		                                    </p>
	                                    </li>
                                    </ul>
                                </div>
                                <div class="tl"></div>
                                <div class="tr"></div>
                            </div>
                        </div>
                        <!-- /.sideBar -->
                        
                        <div class="tableDataButtons buttonBox">
                            <a href="<c:url value="/provider/dashboard/setup" />" class="greyBtn"><span class="btR"><span class="btM">Cancel</span></span></a>
                            <c:if test="${not empty profiles}">
                                <a href="javascript:submitFormById('importProfilesForm');" class="purpleBtn"><span class="btR"><span class="btM">Import Selected</span></span></a>
                            </c:if>
                            <c:if test="${empty profiles}">
                                <a href="<c:url value="/provider/enrollment/start" />" class="purpleBtn"><span class="btR"><span class="btM">Create New Enrollment</span></span></a>
                            </c:if>
                        </div>
                        <!-- /.tableDataButtons -->
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