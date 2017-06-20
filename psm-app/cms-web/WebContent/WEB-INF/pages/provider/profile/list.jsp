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
                        <c:set var="activeTab" value="3" />
                        <%@include file="/WEB-INF/pages/includes/nav.jsp" %>
                    </div>
                    <!-- /.mainNav -->
                    <div class="breadCrumb">
                        <span class="text">My Profile</span>
                    </div>
                    <div class="head">
                        <h1>My Profile</h1>
                    </div>
                    <div class="clearFixed"></div>
                    
                    <%@include file="/WEB-INF/pages/includes/flash.jsp" %>
                    
                    <div class="dashboardPanel">
                        <div class="tableData">
	                        <form id="myProfilesForm" action="" method="get" >
                            <div class="tableTitle">
                                <h2>Profiles</h2>
                            </div>
                            <table cellpadding="0" cellspacing="0" class="generalTable">
                                <thead>
                                    <tr>
                                        <c:if test="${not empty profiles}">
                                            <th class="alignCenter"><span class="sep"></span></th>
                                        </c:if>
                                        <th class="alignCenter">NPI / UMPI<span class="sep"></span></th>
                                        <th class="alignCenter">Provider Type<span class="sep"></span></th>
                                        <th class="alignCenter">Last Modified On<span class="sep"></span></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="profile" items="${profiles}">
							            <c:url var="viewProfileLink" value="/provider/enrollment/profile">
							                <c:param name="id" value="${profile.profileId}" />
							            </c:url>
                                    <tr>
                                        <td class="alignCenter">
                                            <input type="radio" name="profileId" value="${profile.profileId}" />
                                        </td>
                                        <td><a href="${viewProfileLink}"><c:out value="${profile.npi}" /></a></td>
                                        <td><c:out value="${profile.providerType}" /></td>
                                        <td><fmt:formatDate value="${profile.lastModifiedDate}" pattern="MM/dd/yyyy"/></td>
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
                                    <h2>Account Maintenance</h2>
                                </div>
                                <div class="panelSection">
                                    <ul>
                                        <li>
                                            <p>
                                              <a href="<c:url value="/provider/dashboard/setup" />">Account Setup</a>
                                              <br/> Create new or import existing profiles  
                                            </p>
                                        </li>
                                        <c:if test="${isInternalUser}">
                                        <li>
                                            <p>
                                              <a href="<c:url value="/provider/profile/reset" />">Change Password</a>
                                              <br/> Set a new password for your online account
                                            </p>
                                        </li>
                                        </c:if>
                                    </ul>
                                </div>
                                <div class="tl"></div>
                                <div class="tr"></div>
                            </div>
                        </div>
                        <!-- /.sideBar -->
                        
                        <div class="tableDataButtons buttonBox">
                            <c:url var="editProfileLink" value="/provider/profile/edit">
                            </c:url>
                            <c:url var="renewProfileLink" value="/provider/profile/renew">
                            </c:url>
                            <a href="javascript:submitFormById('myProfilesForm', '${renewProfileLink}');" class="purpleBtn"><span class="btR"><span class="btM">Renew Enrollment</span></span></a>
                            <a href="javascript:submitFormById('myProfilesForm', '${editProfileLink}');" class="purpleBtn"><span class="btR"><span class="btM">Edit Profile</span></span></a>
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