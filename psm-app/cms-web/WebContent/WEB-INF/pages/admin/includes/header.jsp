<%--
 Copyright (C) 2012 TopCoder Inc., All Rights Reserved.

 @author TCSASSEMBLER
 @version 1.0

 The common header for all the jsps of the application.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" lang="en" />
        <title>${title}</title>
        <link rel="stylesheet" href="<c:url value='/css/reset.css' />" type="text/css" media="all"/>
        <link rel="stylesheet" href="<c:url value='/css/style.css' />" type="text/css" media="all"/>
        <link rel="stylesheet" href="<c:url value='/css/jquery.ui.css' />" type="text/css" media="all"/>
		<link rel="stylesheet" href="<c:url value='/js/chosen/chosen.css' />" type="text/css" media="all"/>
		
        <!--[if IE 7]>
        <link rel="stylesheet" href="<c:url value='/css/style-ie7.css' />" type="text/css" />
        <![endif]-->
        <script src="<c:url value='/js/jquery-1.7.1.min.js' />" type="text/javascript"></script>
        <script src="<c:url value='/js/jquery.tablesorter.min.js' />" type="text/javascript"></script>
        <script src="<c:url value='/js/jquery.tablesorter.widgets.js' />" type="text/javascript"></script>
        <script src="<c:url value='/js/jquery.ui.core.js' />" type="text/javascript"></script>
        <script src="<c:url value='/js/jquery.ui.widget.js' />" type="text/javascript"></script>
        <script src="<c:url value='/js/jquery.ui.datepicker.js' />" type="text/javascript"></script>
        <script src="<c:url value='/js/chosen/chosen.jquery.min.js' />" type="text/javascript"></script>
        <script src="<c:url value='/js/system/script.js' />" type="text/javascript"></script>
    </head>
    <body>
        <div id="wrapper">
            <div id="header">
			    <div class="contentWidth">
			        <div class="userSection">
			            Welcome, <strong><sec:authentication property="principal.username" /></strong> | <a href="<c:url value='/system/help-system-admin' />">Help</a> | <a href="<spring:url value="/j_spring_security_logout" />">Logout</a>
			        </div>
			        <!-- /.userSection -->
			        <div class="mastHead">
			            <sec:authentication property="principal.loginDate" var="loginDate"/>
			            Last login: <fmt:formatDate value="${loginDate}" pattern="EEEE, d MMMM yyyy hh:mm:ss a zzz"/> 
			        </div>
			        <!-- /.mastHead -->
			    </div>
            </div>
            <!-- /#header -->

            <div id="mainContent" <c:if test='${isUpdateUser}'>class="detailPage"</c:if>>
                <div class="contentWidth">
                    <div class="mainNav">
                        <%@include file="/WEB-INF/pages/includes/logo.jsp" %>
                        <div class="nav">
                            <div class="navR">
                                <div class="navM">
                                    <ul>
                                        <li class="active">
                                            <a href="<c:url value='/system/user/list' />">USER ACCOUNTS</a>
                                            <c:if test="${hasArrow}"><span class="arrow"></span></c:if>
                                            
                                        </li>
                                    </ul>
                                    <div class="searchWidget">
                                        <a href="<c:url value='/system/advanced-search-system-admin' />">Advanced Search</a>
                                        <form id="searchBoxForm" class="inputContainer" action="<c:url value='/system/user/search?role=Provider' />"  method="post">
                                            <a href="javascript:;" class="search searchBox"></a>
                                            <input type="text" class="hint" value="Search Keyword" title="Search Keyword" name="firstName" id="searchBoxFirstName"/>
                                            <input type="hidden" name="lastName" id="searchBoxLastName" />
                                            <input type="hidden" name="and" value="false" />
                                            <input type="hidden" name="searchBox" value="true" />
                                            <input type="hidden" name="initSearchBox" value="true" />
                                            <input type="hidden" name="roles" value="Provider"/>
                                            <input type="hidden" name="roles" value="Service Agent"/>
                                            <input type="hidden" name="roles" value="Service Administrator"/>
                                            <input type="hidden" name="roles" value="System Administrator"/>
                                        </form>
                                    </div>
                                    <!-- /.searchWidget -->
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /.mainNav -->