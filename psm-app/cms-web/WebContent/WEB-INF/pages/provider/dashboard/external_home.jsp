<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <%@include file="/WEB-INF/pages/includes/html_head.jsp" %>
        <title>Welcome</title>
    </head>
    <body>
        <div id="wrapper">
            <%@include file="/WEB-INF/pages/includes/header.jsp" %>
            <!-- /#header -->

            <div id="mainContent">
                <div class="contentWidth">
                    <div class="mainNav">
                        <%@include file="/WEB-INF/pages/includes/logo.jsp" %>
                        <%@include file="/WEB-INF/pages/includes/nav.jsp" %>
                    </div>
					<div class="breadCrumb"></div>
					<h1>Account Setup</h1>
                    <div class="tabSection">
                    	<!-- 
                        <div class="detailPanel">
                            <div class="section" id="updateProfile">
                                <div class="wholeCol">
                                    <div class="row">
                                        <h3>Import Profiles</h3>
                                        <p>
                                            In order to process renewals, you must first import your existing profiles. <br />
                                            Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed
                                            do eiusmod tempor incididunt ut labore et dolore magna aliqua.
                                            Ut enim ad minim veniam, quis nostrud exercitation ullamco
                                            laboris nisi ut aliquip ex ea commodo consequat. Duis aute
                                            irure dolor in reprehenderit in voluptate velit esse cillum
                                            dolore eu fugiat nulla pariatur. Excepteur sint occaecat
                                            cupidatat non proident, sunt in culpa qui officia deserunt
                                            mollit anim id est laborum.
                                        </p>
                                        <div class="">
                                            <a href="<c:url value="/provider/onboarding/list" />" class="purpleBtn"><span class="btR"><span class="btM">Import Profile</span></span></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="tl"></div>
                            <div class="tr"></div>
                            <div class="bl"></div>
                            <div class="br"></div>
                        </div>
                    	-->
                        <div class="detailPanel">
                            <div class="section" id="updateProfile">
                                <div class="wholeCol">
                                    <div class="row">
				                        <h3>Additional Enrollments</h3>
				                        <p>
				                            You also have the option to create new enrollments. <br />
											Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed
											do eiusmod tempor incididunt ut labore et dolore magna aliqua.
											Ut enim ad minim veniam, quis nostrud exercitation ullamco
											laboris nisi ut aliquip ex ea commodo consequat. Duis aute
											irure dolor in reprehenderit in voluptate velit esse cillum
											dolore eu fugiat nulla pariatur. Excepteur sint occaecat
											cupidatat non proident, sunt in culpa qui officia deserunt
											mollit anim id est laborum.
										</p>
				                        <div class="">
				                            <a href="<c:url value="/provider/enrollment/start" />" class="purpleBtn"><span class="btR"><span class="btM">Create New Enrollment</span></span></a>
				                        </div>
				                        
                                    </div>
                                </div>
                            </div>
                            <!-- /.section -->
                            <div class="tl"></div>
                            <div class="tr"></div>
                            <div class="bl"></div>
                            <div class="br"></div>
                        </div>
                    </div>
                    <!-- /.tabSection -->
                </div>
            </div>
            <!-- /#mainContent -->

            <%@include file="/WEB-INF/pages/includes/footer.jsp" %>
            <div class="clear"></div>
        </div>
        <!-- /#wrapper -->
    </body>
</html>